c:\windows\system32\wsl.exe -d Ubuntu --cd $(wslpath '%1') -e /usr/bin/zsh5 -c "nvim $(wslpath '%1')"
