function update_neovim
    cd "$HOME/neovim"
    git pull
    sudo rm -rf build
    install_neovim
    cd -
end
