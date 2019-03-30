# Based off of the zshrc of Josh Hartwell, with many additions, deletions, and changes from across the outside community.
#Copyright 2018 TheToric
#
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
#
local ZSH_CONF=$HOME/.config/zsh                      # Define the place I store all my zsh config stuff
local ZSH_CACHE=$ZSH_CONF/cache                # for storing files like history and zcompdump 
local LOCAL_ZSHRC=$HOME/.config/zshlocal       # Allow the local machine to have its own overriding zshrc if it wants it

# Load external config files and tools

	# Load misc functions. Done in a seperate file to keep this from getting too long and ugly
	source $ZSH_CONF/functions.zsh
	#Load prompt file. Also done to keep it more tidy.
	source $ZSH_CONF/prompt.zsh

# Set important shell variables
	 export EDITOR=nvim                           # Set default editor
	 export VISUAL=nvim
	 export PAGER=less                           # Set default pager
	 export LESS="-R"                            # Set the default options for less 
	 export LESSHISTFILE="/dev/null"                    # Prevent the less hist file from being made, I dont want it
 
# Misc
	# Enable the ZLE line editor, which is default behavior, but to be sure
	setopt ZLE
	#Enable vi mode for the ZLE. it should be set by default due to our EDITOR and VISUAL, but this is just to be safe.
	bindkey -v
	# prevent duplicate entries in path
	declare -U path
	# Uses custom colors for LS, as outlined in dircolors
	eval $(dircolors $ZSH_CONF/dircolors)
	# Sends cd commands without the need for 'cd'
	setopt AUTO_CD
	# Can pipe to mulitple outputs
	setopt MULTI_OS
	# Kill all child processes when we exit, dont leave them running
	unsetopt NO_HUP
	#Allows comments in interactive shell.
	setopt INTERACTIVE_COMMENTS
	# Abc{$cool}efg where $cool is an array surrounds all array variables individually
	setopt RC_EXPAND_PARAM
	# Ctrl+S and Ctrl+Q usually disable/enable tty input. This disables those inputs
	unsetopt FLOW_CONTROL
	# List jobs in the long format by default. (I dont know what this does but it sounds good)
	setopt LONG_LIST_JOBS

# ZSH History 
	HISTFILE=$ZSH_CACHE/history                 # Keep our home directory neat by keeping the histfile somewhere else
	SAVEHIST=10000                              # Big history
	HISTSIZE=10000                              # Big history
	setopt EXTENDED_HISTORY                     # Include more information about when the command was executed, etc
	setopt APPEND_HISTORY                       # Allow multiple terminal sessions to all append to one zsh command history
	setopt HIST_FIND_NO_DUPS                    # When searching history dont display results already cycled through twice
	setopt HIST_EXPIRE_DUPS_FIRST               # When duplicates are entered, get rid of the duplicates first when we hit $HISTSIZE 
	setopt HIST_VERIFY                          # makes history substitution commands a bit nicer. I dont fully understand
	setopt SHARE_HISTORY                        # Shares history across multiple zsh sessions, in real time
	setopt HIST_IGNORE_DUPS                     # Do not write events to history that are duplicates of the immediately previous event
	setopt INC_APPEND_HISTORY                   # Add commands to history as they are typed, dont wait until shell exit
	setopt HIST_REDUCE_BLANKS                   # Remove extra blanks from each command line being added to history

# ZSH Auto Completion
	   SHORT_HOST=${HOST/.*/}
	#the auto complete dump is a cache file where ZSH stores its auto complete data, for faster load times
	local ZSH_COMPDUMP="$ZSH_CACHE/acdump-${SHORT_HOST}-${ZSH_VERSION}"  #where to store autocomplete data
	autoload -Uz compinit
	compinit -i -d "${ZSH_COMPDUMP}"                        # Init auto completion; tell where to store autocomplete dump
	zstyle ':completion:*' menu select                      # Have the menu highlight as we cycle through options
	zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'     # Case-insensitive (uppercase from lowercase) completion
	setopt COMPLETE_IN_WORD                                 # Allow completion from within a word/phrase
	setopt ALWAYS_TO_END                                    # When completing from the middle of a word, move cursor to end of word
	setopt MENU_COMPLETE                                    # When using auto-complete, put the first option on the line immediately
	setopt COMPLETE_ALIASES                                 # Turn on completion for aliases as well
	setopt LIST_ROWS_FIRST                                  # Cycle through menus horizontally instead of vertically

# Globbing
	setopt NO_CASE_GLOB                         # Case insensitive globbing
	setopt EXTENDED_GLOB                        # Allow the powerful zsh globbing features, see link:
	# http://www.refining-linux.org/archives/37/ZSH-Gem-2-Extended-globbing-and-expansion/
	setopt NUMERIC_GLOB_SORT                    # Sort globs that expand to numbers numerically, not by letter (i.e. 01 2 03)
   
# Aliases
	alias vim="nvim"
	alias vimdiff="nvim -d"
	alias mutt="neomutt"
	alias fuck='sudo $(fc -ln -1)'
	#i3sleep locks the screen and puts the system to sleep
	alias i3sleep="systemctl suspend && i3lock"

	#alias -g ...='../..'
	#alias -g ....='../../..'
	#alias -g .....='../../../..'
	#alias -g ......='../../../../..'
	#alias -g .......='../../../../../..'
	#alias -g ........='../../../../../../..'

	alias ls="ls -h --color='auto'"
	alias lsa='ls -A'
	alias ll='ls -l'
	alias la='ls -lA'
	alias lx='ls -lXB'    #Sort by extension
	alias lt='ls -ltr'
	alias lk='ls -lSr'
	alias cdl=changeDirectory; function changeDirectory { cd $1 ; la }

	alias md='mkdir -p'
	alias rd='rmdir'

	# Copy with a progress bar
	alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --" 

	alias d='dirs -v | head -10'                      # List the last ten directories we've been to this session, no duplicates

	alias ddg='web_search ddg'
	alias github='web_search github'
	alias wiki='web_search ddg \!w'
	alias news='web_search ddg \!n'
	alias youtube='web_search ddg \!yt'
	alias map='web_search ddg \!m'
	alias image='web_search ddg \!i'

# Setup grep to be a bit more nice
	# check if 'x' grep argument available
	grep-flag-available() {
		  echo | grep $1 "" >/dev/null 2>&1
	}

	local GREP_OPTIONS=""

	# color grep results
	if grep-flag-available --color=auto; then
		  GREP_OPTIONS+=" --color=auto"
	fi

	# ignore VCS folders (if the necessary grep flags are available)
	local VCS_FOLDERS="{.bzr,CVS,.git,.hg,.svn}"

	if grep-flag-available --exclude-dir=.cvs; then
		  GREP_OPTIONS+=" --exclude-dir=$VCS_FOLDERS"
	elif grep-flag-available --exclude=.cvs; then
		  GREP_OPTIONS+=" --exclude=$VCS_FOLDERS"
	fi

	# export grep settings
	alias grep="grep $GREP_OPTIONS"

	# clean up
	unfunction grep-flag-available

# Allow local zsh settings (superseding anything in here) in case I want something specific for certain machines
  if [[ -r $LOCAL_ZSHRC ]]; then
    source $LOCAL_ZSHRC
  fi
