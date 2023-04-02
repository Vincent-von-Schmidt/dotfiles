c:\windows\system32\wsl.exe -d Ubuntu --cd /mnt/c/Users/Vincent/ -e /usr/bin/zsh5 -c "tmux | nvim $(wslpath '%1')"
