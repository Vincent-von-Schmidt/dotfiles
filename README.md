# dotfiles
## install neovim
First make sure you have installed the necessary packages and the right version of neovim.
````sh
add-apt-repository ppa:neovim-ppa/unstable
apt-get update
apt-get install -y neovim npm unzip make gcc curl openssh sshfs
````
Then just copy the neovim config files to the ~/.config/nvim directory.
