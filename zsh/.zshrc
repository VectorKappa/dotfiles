# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###############################################################################################################################
#                                                             Initialization                                                  #
###############################################################################################################################


# Setting up Zinit, if not installed then clone it in.
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit!
source "${ZINIT_HOME}/zinit.zsh"

#source external files
test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)
source ~/.aliases
autoload -U colors
colors
autoload zcalc
autoload zmv
autoload zed
###############################################################################################################################
#                                                          History Settings                                                   #
###############################################################################################################################

HISTFILE=~/.zsh_history   #History file - zsh in name, to differentiate, idk
HISTSIZE=1000010000   #1B history entries - storage space is cheap :)
SAVEHIST=1000000000   #A margin to store some duplicates
setopt INC_APPEND_HISTORY_TIME  #Black magic, honestly - history nonblockingly gets written to histfile, but separate sessions keep their separate histories
setopt HIST_VERIFY    #Forces user to confirm banging commands from history (!! pastes previous command to prompt)
setopt HIST_IGNORE_DUPS   #Ignores duplicates of commands directly before
setopt HIST_EXPIRE_DUPS_FIRST #Pretty self-explanatory, really
setopt HIST_IGNORE_SPACE  #Ignores commands with preceding space
setopt EXTENDED_HISTORY   #Appends timestamps and run duration to the history file


###############################################################################################################################
#                                                          Keybinds                                                   #
###############################################################################################################################


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

bindkey '\ew' kill-region                             # [Esc-w] - Remove chars from the cursor to the mark
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


PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'


setopt completealiases
setopt interactivecomments

#bash-like word character detection (alphanumeric only)
autoload -U select-word-style
select-word-style bash

# Load powerlevel10k theme
zinit ice depth"1"                   ##git clone depth
zinit light romkatv/powerlevel10k

#zplug <repo/plugin>, tag1:<option1>, tag2:<option2>

#zi ice tag1"<option1>" tag2"<option2>"
#zi load <repo/plugin>


zinit light zdharma-continuum/zinit-annex-patch-dl


zinit ice wait lucid
zinit light MichaelAquilina/zsh-you-should-use

zinit ice wait lucid
zinit light MichaelAquilina/zsh-autoswitch-virtualenv

zinit ice wait lucid
zinit light laggardkernel/zsh-thefuck

# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

# forgit
zinit ice wait lucid
zinit load 'wfxr/forgit'

# Vi mode :)
#zinit ice depth=1
#zinit light jeffreytse/zsh-vi-mode

#zplug "plugins/virtualenv",	from:oh-my-zsh
##zplug "plugins/gpg-agent",		from:oh-my-zsh
#zplug "plugins/git",                    from:oh-my-zsh
#zplug "plugins/command-not-found",      from:oh-my-zsh
##zplug "plugins/tmux",                   from:oh-my-zsh
#zplug "plugins/urltools",               from:oh-my-zsh
##zplug "plugins/thefuck",                from:oh-my-zsh		#Used interchangably with
##setopt correct							#<-This option
## Load completion library for those sweet [tab] squares
##zplug "mollifier/anyframe",             from:github
## Misc. visual tweaks
## zplug "modules/prompt",			from:prezto
#zplug "Tarrasch/zsh-autoenv"
#zplug "zpm-zsh/colors"
#zplug "Mellbourn/zabb", from:github
## zplug "MichaelAquilina/zsh-autoswitch-virtualenv"
## Syntax highlighting for commands, load last
#zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
#zplug "Aloxaf/gencomp", defer:3
zinit snippet OMZP::pip
#zinit snippet OMZP::adb
zinit snippet OMZP::aliases
zinit snippet OMZP::encode64
#zinit snippet OMZP::fd
#zinit snippet OMZP::ripgrep
zinit snippet OMZP::nmap
#zinit snippet OMZP::ipfs
zinit snippet OMZP::rsync
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::rust
zinit snippet OMZP::zoxide
zinit snippet OMZL::completion.zsh
zinit snippet https://github.com/hyprwm/Hyprland/blob/main/hyprctl/hyprctl.zsh

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
zinit pack"binary" for fzf


# GPG-SSH INTEGRATION
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null


[ "$TERM" = "xterm-kitty" ] && (alias ssh="command kitten ssh";)
[ "$TERMUX_APK_RELEASE" = "F_DROID" ] && (eval `okc-ssh-agent`)



preexec() { print -Pn "\e]0;$1\a" }







# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
