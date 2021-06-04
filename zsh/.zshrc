###############################################################################################################################
#                                                             Initialization                                                  #
###############################################################################################################################
#Check if zplug is installed, if not, clone it and install it.
if [[ ! -d ~/.zplug ]]; then
        git clone https://github.com/zplug/zplug ~/.zplug
        source ~/.zplug/init.zsh && zplug update --self
fi

#source external files 
source ~/.zplug/init.zsh	#Zplug plugin manager initialization
source ~/.aliases		#Source aliases
#expose colors to other applications
autoload -U colors
colors
###############################################################################################################################
#                                                          History Settings                                                   #
###############################################################################################################################
HISTFILE=~/.zsh_history		#History file - zsh in name, to differentiate, idk
HISTSIZE=1000010000		#1B history entries - storage space is cheap :)
SAVEHIST=1000000000		#A margin to store some duplicates
setopt INC_APPEND_HISTORY_TIME	#Black magic, honestly - history nonblockingly gets written to histfile, but separate sessions keep their separate histories
setopt HIST_VERIFY		#Forces user to confirm banging commands from history (!! pastes previous command to prompt)
setopt HIST_IGNORE_DUPS		#Ignores duplicates of commands directly before
setopt HIST_EXPIRE_DUPS_FIRST	#Pretty self-explanatory, really
setopt HIST_IGNORE_SPACE	#Ignores commands with preceding space
setopt EXTENDED_HISTORY		#Appends timestamps and run duration to the history file

# Make sure that the terminal is in application mode when zle is active, since only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
        function zle-line-init() {
                echoti smkx
        }
        function zle-line-finish() {
                echoti rmkx
        }
        zle -N zle-line-init
        zle -N zle-line-finish
fi

#bash-like word character detection (alphanumeric only)
autoload -U select-word-style
select-word-style bash

#GIANT KEYBOARD CONFIG BLOCK (From oh-my-zsh)(with further changes)
bindkey '\ew' kill-region                             # [Esc-w] - Remove chars from the cursor to the mark
bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
if [[ "${terminfo[kpp]}" != "" ]]; then
	  bindkey "${terminfo[kpp]}" up-line-or-history       # [PageUp] - Up a line of history
fi
if [[ "${terminfo[knp]}" != "" ]]; then
	  bindkey "${terminfo[knp]}" down-line-or-history     # [PageDown] - Down a line of history
fi

if [[ "${terminfo[kcuu1]}" != "" ]]; then
	  bindkey "${terminfo[kcuu1]}" up-line-or-search      # start typing + [Up-Arrow] - fuzzy find history forward
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
	  bindkey "${terminfo[kcud1]}" down-line-or-search    # start typing + [Down-Arrow] - fuzzy find history backward
fi

if [[ "${terminfo[khome]}" != "" ]]; then
	  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
	  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi

bindkey ' ' magic-space                               # [Space] - do history expansion - !![space] pastes previous command, ![num][space] jumps to history entry

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

if [[ "${terminfo[kcbt]}" != "" ]]; then
	  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
	bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
	bindkey "^[[3~" delete-char
	bindkey "^[3;5~" delete-char
	bindkey "\e[3~" delete-char
fi

case "${TERM}" in
    cons25*|linux) # plain BSD/Linux console
        bindkey '\e[H'    beginning-of-line   # home
        bindkey '\e[F'    end-of-line         # end
        bindkey '\e[5~'   delete-char         # delete
        bindkey '[D'      emacs-backward-word # esc left
        bindkey '[C'      emacs-forward-word  # esc right
        ;;
    *rxvt*) # rxvt derivatives
        bindkey '\eOc'    forward-word        # ctrl right
        bindkey '\eOd'    backward-word       # ctrl left
        bindkey '\e\e[D'  backward-word     ### Alt left
        bindkey '\e\e[C'  forward-word      ### Alt right
        # workaround for screen + urxvt
        bindkey '\e[7~'   beginning-of-line   # home
        bindkey '\e[8~'   end-of-line         # end
        bindkey '^[[1~'   beginning-of-line   # home
        bindkey '^[[4~'   end-of-line         # end
        ;;
    *xterm*) # xterm derivatives
        bindkey '\e[H'    beginning-of-line   # home
        bindkey '\e[F'    end-of-line         # end
        bindkey '\e[3~'   delete-char         # delete
        bindkey '^[[C'    forward-word        # ctrl right
        bindkey '^[[D'    backward-word       # ctrl left
        bindkey '\eOC'    forward-word        # ctrl right
        bindkey '\eOD'    backward-word       # ctrl left
        bindkey '^[[1;3C' forward-word        # alt right
        bindkey '^[[1;3D' backward-word       # alt left
        # workaround for screen + xterm
        bindkey '\e[1~'   beginning-of-line   # home
        bindkey '\e[4~'   end-of-line         # end
        ;;
    screen)
        bindkey '^[[1~'   beginning-of-line   # home
        bindkey '^[[4~'   end-of-line         # end
        bindkey '\e[3~'   delete-char         # delete
        bindkey '\eOc'    forward-word        # ctrl right
        bindkey '\eOd'    backward-word       # ctrl left
        bindkey '^[[1;5C' forward-word        # ctrl right
        bindkey '^[[1;5D' backward-word       # ctrl left
        ;;
esac












setopt completealiases
setopt interactivecomments








zplug "plugins/emoji",			from:oh-my-zsh
zplug "plugins/virtualenv",	from:oh-my-zsh
zplug "plugins/pip",			from:oh-my-zsh
zplug "plugins/nmap",			from:oh-my-zsh
zplug "plugins/ipfs",			from:oh-my-zsh
zplug "plugins/gpg-agent",		from:oh-my-zsh
zplug "plugins/rsync",			from:oh-my-zsh
zplug "plugins/rust",			from:oh-my-zsh
zplug "plugins/arch",			from:oh-my-zsh
zplug "plugins/rustup",			from:oh-my-zsh
zplug "plugins/cargo",			from:oh-my-zsh
zplug "plugins/git",                    from:oh-my-zsh
zplug "plugins/colored-man-pages",      from:oh-my-zsh
zplug "plugins/command-not-found",      from:oh-my-zsh
zplug "plugins/tmux",                   from:oh-my-zsh
zplug "plugins/urltools",               from:oh-my-zsh
zplug "plugins/thefuck",                from:oh-my-zsh		#Used interchangably with
#setopt correct							#<-This option
# Load completion library for those sweet [tab] squares
zplug "lib/completion",                 from:oh-my-zsh
zplug "mollifier/anyframe",             from:github
# Misc. visual tweaks
zplug "oldratlee/hacker-quotes"
zplug "modules/prompt",			from:prezto
zplug "Tarrasch/zsh-autoenv"
zplug "zpm-zsh/colors"
zplug "MichaelAquilina/zsh-autoswitch-virtualenv"
# Syntax highlighting for commands, load last
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
zplug "zsh-users/zsh-autosuggestions", defer:3
zplug "RobSis/zsh-completion-generator", defer:3
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

PATH="$PATH:/home/vectorkappa/.cargo/bin:/home/vectorkappa/.local/bin"

prompt pure
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
