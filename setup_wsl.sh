
# init ----------------------------------------------------------

echo "[boot]" >> /etc/wsl.conf
echo "systemd=true" >> /etc/wsl.conf

# apt init ------------------------------------------------------
sudo apt-get update
sudo apt-get upgrade -y


# python3 -------------------------------------------------------
# sudo add-apt-repository ppa:deadsnakes/ppa
# sudo apt-get update


# neovim / editor -----------------------------------------------

# remove nano
sudo apt-get remove nano -y

# add the latest neovim repo
sudo add-apt-repository ppa:neovim-ppa/unstable

# install nodejs, neovim, ripgrep, fd
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - &&\
sudo apt-get install -y nodejs neovim ripgrep fd_find

# universal ctags
sudo snap install universal-ctags

# install packer
# git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 # ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# reset of .config
# sudo rm $HOME/.config -r
mkdir $HOME/.config

# copying config files
cp ./editor/neovim/nvim $HOME/.config/nvim -r


# docker --------------------------------------------------------

# repo setup
sudo apt-get install ca-certificates curl gnupg lsb-release -y

# add repo key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# setup
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# install docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y


# shell ---------------------------------------------------------

# install zsh
sudo apt-get install zsh -y

# install starship
curl -sS https://starship.rs/install.sh | sh

# config files
cp ./cmd/.zshrc $HOME/.zshrc
cp ./cmd/.bashrc $HOME/.bashrc
cp ./cmd/starship.toml $HOME/.config/starship.toml

