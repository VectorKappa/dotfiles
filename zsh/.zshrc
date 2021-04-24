source ~/.zplug/init.zsh
source ~/.aliases

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY_TIME

zplug "plugins/git",                    from:oh-my-zsh
zplug "plugins/colored-man-pages",      from:oh-my-zsh
zplug "plugins/command-not-found",      from:oh-my-zsh
zplug "plugins/web-search",             from:oh-my-zsh
zplug "plugins/tmux",                   from:oh-my-zsh
zplug "plugins/urltools",               from:oh-my-zsh
zplug "plugins/thefuck",                from:oh-my-zsh
# Load completion library for those sweet [tab] squares
zplug "lib/completion",                 from:oh-my-zsh

# Misc. visual tweaks
zplug "oldratlee/hacker-quotes"
zplug "modules/prompt", from:prezto

# Syntax highlighting for commands, load last
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
zplug "zsh-users/zsh-autosuggestions", defer:3

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

prompt pure