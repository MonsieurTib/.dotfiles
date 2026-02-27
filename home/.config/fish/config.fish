if test -d /opt/homebrew/bin
    set -gx PATH /opt/homebrew/bin $PATH
end
if status is-interactive
    # Add all SSH private keys to keychain
    for key in ~/.ssh/id_*
        if test -f $key && not string match -q "*.pub" $key
            ssh-add --apple-use-keychain $key 2>/dev/null
        end
    end
end
# Initialize Starship
starship init fish | source
set -gx PATH $PATH ~/google-cloud-sdk/bin
set -gx PATH /usr/bin /usr/local/bin $PATH
alias csharpier='~/.dotnet/tools/csharpier'
# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

