#This file is to set up the ZSH prompt. This is a customized prompt, and, as will all my zsh things, does not rely on an outside plugin.
#Also like most of my stuff, mutch of this code is taken from another source. in this case, I used the GRML zshrc as a base.
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

#this is a WIP.
#TODO: make this a proper prompt theme file instead of just a sourced file... maybye.

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

#the precmd function, called just before printing the prompt. TODO: use this to set our prompt variable as different evey time, in order to get a right aligned portion in the top line.
function precmd() {
	precmd_vcs
}

#on the top line, show a whole bunch of info. botton line should be as minimal as possilbe (just a single char to  input next to...)
PROMPT='%F{cyan}[%m@%n]%f%F{red}├────┤%f${vcs_info_msg_0_}
»'

#Make the right prompt blank, just to be sure.
RPROMPT=

