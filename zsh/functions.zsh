# Make directory and cd into it
function mk() {
  mkdir -p "$1" && cd "$1"
}

# Copy single file to multiple directories
function cp2m() {
  xargs -n 1 cp -v "$1" <<< "${@:2}"
}

function install_neovim() {
  git pull
  make CMAKE_BUILD_TYPE="${1:-RelWithDebInfo}"
  sudo make install
}

# Update Neovim installed from source
function update_neovim() {
  cd $HOME/neovim
  sudo rm -rf build
  install_neovim "$1"
  cd -
}

# In the event that Neovim fails to update, this will do a full clean first
function reinstall_neovim() {
  cd $HOME/neovim
  sudo git clean -xdf
  install_neovim "$1"
  cd -
}
