apt-get update
apt-get install -y software-properties-common make git gcc curl

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

add-apt-repository ppa:neovim-ppa/unstable
apt-get update
apt-get install -y neovim

cp ./.config/nvim ~/.config -r
