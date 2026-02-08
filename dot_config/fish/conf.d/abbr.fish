
# My own abbreviations

abbr -a m micro    
abbr -a cl clear    
abbr -a p paru 
abbr -a e exit 
abbr -a cd z 
abbr -a sl ls
abbr -a cp cp -v
abbr -a mv mv -v
abbr -a mkdir mkdir -p 
abbr -a tree lt
  

# Git abbreviations
abbr -a gco git checkout
abbr -a gad git add
abbr -a gst git status

# General commands
abbr -a la 'ls -la'
abbr -a ll 'ls -l'
abbr -a nv nvim
abbr -a ghb 'gh browse' # Example using gh CLI


# My own aliases

alias z="cd"    
alias cat="bat --theme=base16 --color=always --paging=never --tabs=2 --wrap=never --plain"
alias bat="bat --theme=base16 --color=always --paging=never --tabs=2 --wrap=never --plain"
alias up="paru -Syu && flatpak update"   
alias lsgrep="ls | grep" 

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias tree='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'"  

# cat with bat 
alias cat="bat --theme=base16 --color=always --paging=never --tabs=2 --wrap=never --plain"

 
## FROM CACHYOS FISH CONFIG

# Common use
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'          # List amount of -git packages


# Get fastest mirrors
alias mirror="sudo cachyos-rate-mirrors"

# Cleanup orphaned packages
alias cleanup="sudo pacman -Rns (pacman -Qtdq)"

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

