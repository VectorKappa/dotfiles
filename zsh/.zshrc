source ~/.zplug/init.zsh
source ~/.aliases
# Supports oh-my-zsh plugins and the like
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/urltools", from:oh-my-zsh

zplug "oldratlee/hacker-quotes"

zplug "plugins/thefuck", from:oh-my-zsh

zplug "modules/prompt", from:prezto
# Load completion library for those sweet [tab] squares
zplug "lib/completion", from:oh-my-zsh

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