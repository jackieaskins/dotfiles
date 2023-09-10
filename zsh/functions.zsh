# Make directory and cd into it
function mk() {
  mkdir -p $1 && cd $1
}

# Copy single file to multiple directories
function cp2m() {
  xargs -n 1 cp -v $1 <<< "${@:2}"
}

# Update Neovim installed from source
function update_neovim() {
  cd $HOME/neovim
  git pull
  rm -rf build
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd -
}
