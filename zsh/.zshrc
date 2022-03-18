# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit promptinit
compinit -d ${XDG_CACHE_HOME}/.zcompdump
promptinit
autoload -U select-word-style
select-word-style bash

bindkey -e

zstyle ':completion:*' list-colors “${(s.:.)LS_COLORS}”

export ZDOTDIR=/home/vomidug/.config/zsh/
export TERM=xterm-256color
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_AUTOQUIT=true
export ZSH_TMUX_CONFIG=$HOME/.config/tmux/tmux.conf
export LANG=en_US.UTF-8
export EDITOR='vim'
export LS_COLORS='no=0;37:di=1;38;5;39:fi=37:*.gz=01;31:ex=1;32:ln=01;93'
export AWS_CONFIG_FILE=$HOME/.config/aws/config
HISTFILE=${XDG_STATE_HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
CASE_SENSITIVE=true

export MCFLY_DISABLE_MENU=TRUE
export MCFLY_RESULTS=50
export MCFLY_INTERFACE_VIEW=BOTTOM
export MCFLY_RESULTS_SORT=LAST_RUN

source /home/vomidug/.config/zsh/.p10k.zsh
source /home/vomidug/.config/zsh/plugins/web-search.plugin.zsh
source /home/vomidug/.config/zsh/plugins/sudo.plugin.zsh
source /home/vomidug/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source /home/vomidug/.config/zsh/plugins/git.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

source /home/vomidug/.config/zsh/.secret

ZSH_WEB_SEARCH_ENGINES=(
	jira $JOBURL 
)
alias jira="web_search jira"

function ticket() {
	branch=$(git branch --show-current 2>/dev/null)
	if [[ -z $branch ]]; then
		echo "not a repo"
	else;
		jira $(git branch --show-current)
	fi;
}

source $ZDOTDIR/.zsh_aliases

eval "$(mcfly init zsh)"
setopt appendhistory

if [[ -z "$TMUX" && -z "$VIM" ]]; then
	if [[ -z $(tmux list-session 2>/dev/null) ]]
	then
		tmux;
	else
		tmux attach;
	fi
fi

if [ $(tmux list-windows | grep -i active | cut -d '*' -f1 | cut -d ' ' -f2) = "prod" ]; then
	ssh prod
fi

PATH=${PATH}:/home/vomidug/.local/bin
