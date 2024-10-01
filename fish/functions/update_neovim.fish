function update_neovim
    cd "$HOME/neovim"
    git pull
    sudo make distclean
    install_neovim
    cd -
end
