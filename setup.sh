#!/bin/bash

OS_TYPE="$OSTYPE"
LINUX_MINT="linux-gnu"
MACOS="darwin"

NVIM_VERSION=v0.12.4

installNeovim() {
    echo "Installing neovim"

    if [[ $OS_TYPE == $LINUX_MINT* ]]; then
        sudo apt-get install ninja-build gettext cmake curl build-essential
    elif [[ $OS_TYPE == $MACOS* ]]; then
        brew install ninja cmake gettext curl git
    fi

    NVIM_HOME="$HOME/.local/neovim"

    sudo rm $NVIM_HOME/bin/nvim
    sudo rm -r $NVIM_HOME/share/nvim/

    cd ./neovim/
    rm -rf build/
    sudo rm -rf .deps/

    git fetch
    git checkout $NVIM_VERSION
    sudo make CMAKE_BUILD_TYPE=Release
    sudo make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NVIM_HOME" install
    cd ..
}

setupLua() {
    echo "Set up lua"

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get install libreadline-dev
    fi

    echo "Installing luaver"
    curl -fsSL https://raw.githubusercontent.com/dhavalkapil/luaver/master/install.sh | sh -s - -r v1.1.0

    source ~/.zshrc

    luaver install 5.1
    luaver set-default 5.1
    luaver install-luarocks 2.3.0
    luaver set-default-luarocks 2.3.0

    luarocks install cluautils
}

setupDependencies() {
    echo "Set up Dependencies"

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    nvm install 22
    npm install --global yarn

    cargo install --locked tree-sitter-cli
}

setupAI() {
    echo "Set up AI (Ollama)"

    if [[ $OS_TYPE == $LINUX_MINT* ]]; then
        curl -fsSL https://ollama.com/install.sh | sh
    elif [[ $OS_TYPE == $MACOS* ]]; then
        brew install ollama
    fi

    ollama pull qwen2.5-coder:7b
}

echo "Setup Neovim"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -all)
            echo "all"
            #installNeovim
            setupLua
            setupDependencies
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
        -ai | --setup-ai)
            setupAI
            shift 1
            ;;
        * | h | --help) shift;
            echo "Usage: ./setup.sh -all"
            break;
            ;;
    esac
done
