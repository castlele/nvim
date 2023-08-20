#! /bin/sh

mkdir ~/.config/tmux
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/tpm

curl -fsSL https://raw.githubusercontent.com/dhavalkapil/luaver/master/install.sh | sh -s - -r v1.1.0
luaver install 5.1
luaver install-luarocks 2.3.0
luaver use-luarocks 2.3.0

brew install node
brew install yarn
brew install lua-language-server
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
