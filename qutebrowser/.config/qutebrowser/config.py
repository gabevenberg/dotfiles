#Customized qutebrowser config
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

#turn on spellchecking. may need to download and install dictionairies first.
c.spellcheck.languages = ["en-US"]
#will only ask for confirmation to quit if there is an uncompleted download
c.confirm_quit = ["downloads"]
#block 3rd party cookies
c.content.cookies.accept = "no-3rdparty"
#remove finished downloads after 5 seconds
c.downloads.remove_finished = 5000
#open neovin in a urxvt terminal window when calling for an internal editor
c.editor.command = ["urxvt", "-e", "nvim", "-f", "{file}", "-c", "normal {line}G{column0}l"]
#appearance
#fonts settings (monospace everywhere!)
c.fonts.prompts = "10pt monospace"
c.fonts.web.size.minimum = 6
#tabs
c.tabs.position = "left"
c.tabs.width = "10%"
