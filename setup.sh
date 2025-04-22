#!/bin/sh

OS_TYPE="$OSTYPE"
LINUX_MINT="linux-gnu"
MACOS="darwin"

NVIM_VERSION=v0.11.0

if [[ $OS_TYPE == $LINUX_MINT* ]]; then
    INSTALLATION_CMD="sudo apt install"
elif [[ $OS_TYPE == $MACOS* ]]; then
    INSTALLATION_CMD="brew install"
fi

installNeovim() {
    echo "Installing neovim"

    sudo rm /usr/local/bin/nvim
    sudo rm -r /usr/local/share/nvim/

    cd ./neovim/
    rm -rf build/
    sudo rm -rf .deps/
    sudo cmake --build build/ --target uninstall

    git fetch
    git checkout $NVIM_VERSION
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    cd ..
}

setupLua() {
    echo "Set up lua"

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get install libreadline-dev
    fi

    echo "Installing luaver"
    curl -fsSL https://raw.githubusercontent.com/dhavalkapil/luaver/master/install.sh | sh -s - -r v1.1.0

    [ -s ~/.luaver/luaver ] && . ~/.luaver/luaver

    luaver install 5.1
    luaver set-default 5.1
    luaver install-luarocks 2.3.0
    luaver set-default-luarocks 2.3.0

    cd cluautils
        luarocks make
    cd ..
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

while [[ $# -gt 0 ]]; do
    case "$1" in
        -all)
            echo "all"
            installNeovim
            setupLua
            setupDependencies
            setupLSP
            setupColorScheme
            break
            ;;
        -in | --install-nvim)
            installNeovim
            shift 1
            ;;
        -sl | --setup-lua)
            setupLua
            shift 1
            ;;
        -lsp | --setup-lsp)
            setupLSP
            shift 1
            ;;
        -cs | --setup-colorscheme)
            setupColorScheme
            shift 1
            ;;
        * | h | --help) shift;
            echo "Usage: ./setup.sh -all"
            break;
            ;;
    esac
done


