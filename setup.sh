#!/bin/bash

OS_TYPE="$OSTYPE"
LINUX_MINT="linux-gnu"
MACOS="darwin"

if [[ $OS_TYPE == $LINUX_MINT* ]]; then
    INSTALLATION_CMD="sudo apt install"
elif [[ $OS_TYPE == $MACOS* ]]; then
    INSTALLATION_CMD="brew install"
fi

installNeovim() {
    echo "Installing neovim"

    if [[ $OS_TYPE == $LINUX_MINT* ]]; then
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
        sudo rm -rf /opt/nvim
        sudo tar -C /opt -xzf nvim-linux64.tar.gz

        echo "export PATH=\"$PATH:/opt/nvim-linux64/bin\"" >> ~/.bashrc
        source ~/.bashrc

    elif [[ $OS_TYPE == $MACOS* ]]; then
        curl -LO https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-macos-arm64.tar.gz
        tar xzf nvim-macos-arm64.tar.gz

        sudo cp -R nvim-macos-arm64/bin/* /usr/local/bin/
        sudo cp -R nvim-macos-arm64/lib/* /usr/local/lib/
        sudo cp -R nvim-macos-arm64/share/* /usr/local/share/
    fi
}

setupLua() {
    echo "Set up lua"

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get install libreadline-dev
    fi

    if which luaver >/dev/null; then
        echo "Installing luaver"
        curl -fsSL https://raw.githubusercontent.com/dhavalkapil/luaver/master/install.sh | sh -s - -r v1.1.0
    fi

    [ -s ~/.luaver/luaver ] && . ~/.luaver/luaver

    luaver install 5.1
    luaver install-luarocks 2.3.0
    luaver use-luarocks 2.3.0
}

setupDependencies() {
    echo "Set up Dependencies"

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    nvm install 22
    npm install --global yarn
}

setupLSP() {
    echo "Set up LSPs"
    # brew install lua-language-server
    # brew install kotlin-language-server
}

setupColorScheme() {
    git clone https://github.com/castlele/castlelecsscheme.git ~/.config/castlelecsscheme
}

echo "Setup Neovim"
installNeovim
# setupLua
# setupDependencies
# setupLSP
# setupColorScheme
