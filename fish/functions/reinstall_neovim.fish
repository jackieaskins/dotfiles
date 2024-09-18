function reinstall_neovim
    cd "$HOME/neovim"
    sudo make distclean
    install_neovim
    cd -
end
