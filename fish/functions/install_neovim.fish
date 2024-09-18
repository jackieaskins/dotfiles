function install_neovim
    make CMAKE_BUILD_TYPE="RelWithDebInfo"
    sudo make install
end
