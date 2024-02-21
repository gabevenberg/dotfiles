#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.


#set important shell variables
	#set default editor and pager.
	export EDITOR=nvim
	export VISUAL=nvim
	export PAGER=less
	#default options for less
	export LESS="-R"
	export LESSHISTFILE="/dev/null"
	#set the w3m homepage
	export WWW_HOME="duckduckgo.com/lite/"
	#set ssh-agent to play nice with systemd.
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
	export TIMEFMT="%J  %*U user %*S system %P cpu %*E total"
	export PIPENV_VENV_IN_PROJECT=true
	export POETRY_VIRTUALENVS_IN_PROJECT=true
    #test that these nonstandard paths exist before adding to PATH.
    testPath="$HOME/.local/bin"
    [ -d "$testPath" ] && export PATH="$PATH:$testPath"
    export PATH="$PATH:/opt"
    testPath="$HOME/.cargo/bin"
    [ -d "$testPath" ] && export PATH="$PATH:$testPath"
    export PATH="$PATH:/opt"

#prompt
	autoload -U promptinit
	promptinit
	autoload -U colors
	colors

	#stuff to show git things.
		autoload -Uz vcs_info

		setopt prompt_subst

		precmd_vcs() {vcs_info}

		#when not in a repo, show full path to current directory. when in one, show path from base direcory of the repo.
		zstyle ':vcs_info:*' nvcsformats '%~'
		zstyle ':vcs_info:*' formats '%r/%S %F{green}[%b]%f'

	#the precmd function, called just before printing the prompt. 
	function precmd() {
		precmd_vcs
	}

	#Make the right prompt blank, just to be sure.
	RPROMPT=

	#on the top line, show a whole bunch of info. botton line should be as minimal as possilbe (just a single char to  input next to...)
	PROMPT=$'%F{cyan}[%n@%m]%f%F{red}├────┤%f${vcs_info_msg_0_}\n»'

#show dots while waiting for tab-completion
	expand-or-complete-with-dots() {
		# toggle line-wrapping off and back on again
		[[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
		print -Pn "%{%F{red}......%f%}"
		[[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam

		zle expand-or-complete
		zle redisplay
	}
	zle -N expand-or-complete-with-dots
	bindkey "^I" expand-or-complete-with-dots

#misc
	# Enable the ZLE line editor, which is default behavior, but to be sure
	setopt ZLE
	#Enable vi mode for the ZLE. it should be set by default due to our EDITOR and VISUAL, but this is just to be safe.
	bindkey -v
	# Sends cd commands without the need for 'cd'
	setopt AUTO_CD
	# Kill all child processes when we exit, dont leave them running
	unsetopt NO_HUP
	#Allows comments in interactive shell.
	setopt INTERACTIVE_COMMENTS
	# Ctrl+S and Ctrl+Q usually disable/enable tty input. This disables those inputs
	unsetopt FLOW_CONTROL
	mkdir -p ~/.cache/zsh
	local zshCache=~/.cache/zsh

#ZSH history
	#make a history file outside our home directory
	HISTFILE=$zshCache/history
	#save a lot of history
	SAVEHIST=1000
	HISTSIZE=1000
	#save more information in history
	setopt EXTENDED_HISTORY
	#share history among zsh sessions
	setopt APPEND_HISTORY
	setopt SHARE_HISTORY
	#skip dupes when going through history
	setopt HIST_FIND_NO_DUPS
	#delete dupes first when histsize becomes full
	setopt HIST_EXPIRE_DUPS_FIRST
	#dont write dupes of the last command to histfile
	setopt HIST_IGNORE_DUPS
	#write history file as we type
	setopt INC_APPEND_HISTORY
	#remove extra whitespace from history
	setopt HIST_REDUCE_BLANKS

#autocomplete
	autoload -Uz compinit
	compinit
	#have the menu highlight while we cycle through options
	zstyle ':completion:*' menu select
	#case insensitive completion
	zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
	#allow completion from midword
	setopt COMPLETE_IN_WORD
	#move cursor to end of word after completing
	setopt ALWAYS_TO_END
	#complete aliases as well
	setopt COMPLETE_ALIASES
	#select first item when you press tab the first time.
	setopt MENU_COMPLETE

#globbing
	#case insensitive globbing
	setopt NO_CASE_GLOB
	#sort globs that expand to numbers by number rather than alphabeticly
	setopt NUMERIC_GLOB_SORT
	#allows for some neat globbing.
	setopt EXTENDED_GLOB

#aliases
	alias vim="nvim"
	alias vimdiff="nvim -d"
	alias mutt="neomutt"
	alias please='sudo $(fc -ln -1)'
	alias la='ls -la'
	alias ll='ls -l'
	alias say='espeak -p 10 -s 150 -a 200 2> /dev/null'
	alias tmux='tmux -u'
	alias pdfmk='latexmk -lualatex -pvc'
	# needs to have a number immediately after it.
	alias slideshow='feh --full-screen --randomize --auto-zoom --recursive --slideshow-delay'
	# converts all .doc and .docx files in the local directory to pdfs using libreoffice
	alias doc2pdf='loffice --convert-to pdf --headless *.docx#'
	#common options for sshfs
	alias sshmnt='sshfs -o idmap=user,compression=no,reconnect,follow_symlinks,dir_cache=yes,ServerAliveInterval=15'
	alias pyactivate='source ./.venv/bin/activate'

#setup grep to be a bit more nice
	local GREP_OPTIONS=""

	# color grep results
	GREP_OPTIONS+=" --color=auto"

	# ignore VCS folders (if the necessary grep flags are available)
	local VCS_FOLDERS="{.bzr,CVS,.git,.hg,.svn}"

	GREP_OPTIONS+=" --exclude-dir=$VCS_FOLDERS"
	GREP_OPTIONS+=" --exclude=$VCS_FOLDERS"

	# export grep settings
	alias grep="grep $GREP_OPTIONS"

#fzf stuff
	#zsh key bindings (different distros put these in different places.)
	testPath=$(find /usr/share -path '*fzf/*key-bindings.zsh' -print -quit 2> /dev/null)
	[ -f "$testPath" ] && source $testPath
	#zsh completions, if it exists.
	testPath=$(find /usr/share -path '*fzf/*completion.zsh' -print -quit 2> /dev/null)
	[ -f "$testPath" ] && source $testPath
	#if it was installed using git, can just source the one file:
	testPath="$HOME/.fzf.zsh"
	[ -f "$testPath" ] && source $testPath

#starship
eval "$(starship init zsh)"

#check for existence of pyenv before setting it up.
    if (($+commands[pyenv])); then
        export PYENV_ROOT="$HOME/.pyenv"
        [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
    fi

#fancy way of testing if a command exists
ruby --version &>/dev/null && export PATH="$PATH:$(ruby -e 'puts Gem.user_dir' 2> /dev/null)/bin/"
