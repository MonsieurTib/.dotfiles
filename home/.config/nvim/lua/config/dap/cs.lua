local dap = require("dap")
local rpc = require("dap.rpc")

local function send_payload(client, payload)
	vim.notify("sendPayload called", vim.log.levels.DEBUG)
	local msg = rpc.msg_with_content_length(vim.json.encode(payload))
	client.write(msg)
end

function RunHandshake(self, request_payload)
	vim.notify("RunHandshake called", vim.log.levels.DEBUG)
	local cmd = "node ~/.config/nvim/sign.js " .. request_payload.arguments.value
	local signResult = io.popen(cmd)
	if not signResult then
		vim.notify("error while signing handshake", vim.log.levels.DEBUG)
		return
	end
	local signature = signResult:read("*a")
	signResult:close()
	signature = string.gsub(signature, "\n", "")

	local response = {
		type = "response",
		seq = 0,
		command = "handshake",
		request_seq = request_payload.seq,
		success = true,
		body = { signature = signature },
	}
	send_payload(self.client, response)
end

-- Resolve whichever C# extension version is installed instead of pinning one.
-- glob() with a list result avoids expand()'s newline-joined string when
-- several versions coexist; the last entry is the highest version.
local vsdbg = vim.fn.glob(
	vim.fn.expand("~/.vscode/extensions/ms-dotnettools.csharp-*/.debugger/arm64/vsdbg-ui"),
	false,
	true
)
if #vsdbg == 0 then
	vim.notify("vsdbg not found: install the VS Code C# extension", vim.log.levels.WARN)
end

dap.adapters.coreclr = {
	id = "coreclr",
	type = "executable",
	command = vsdbg[#vsdbg],
	args = { "--interpreter=vscode" },
	options = {
		externalTerminal = true,
	},
	runInTerminal = true,
	reverse_request_handlers = {
		handshake = RunHandshake,
	},
}

dap.configurations.cs = {
	{
		name = "Debug .NET",
		type = "coreclr",
		request = "launch",
		program = function()
			local result = vim.fn.system("dotnet build")
			if vim.v.shell_error ~= 0 then
				print("Build failed: " .. result)
				return nil
			end

			-- Parse output path from build result (e.g., "MyProject -> /path/to/bin/Debug/net9.0/MyProject.dll")
			local dll_path = result:match("->%s*(.+%.dll)")
			if dll_path then
				dll_path = vim.trim(dll_path)
			else
				-- Fallback: find DLL in bin/Debug
				local workspace_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
				local glob_pattern = vim.fn.getcwd() .. "/bin/Debug/*/" .. workspace_name .. ".dll"
				local found = vim.fn.glob(glob_pattern, false, true)
				dll_path = found[1] or (vim.fn.getcwd() .. "/bin/Debug/net9.0/" .. workspace_name .. ".dll")
			end

			return vim.fn.input("Path: ", dll_path, "file")
		end,
		cwd = "${workspaceFolder}",
		clientID = "vscode",
		clientName = "Visual Studio Code",
		externalTerminal = true,
		columnsStartAt1 = true,
		linesStartAt1 = true,
		locale = "en",
		pathFormat = "path",
		externalConsole = true,
	},
}
