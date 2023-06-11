# Make directory and cd into it
function mk() {
  mkdir -p $1 && cd $1
}

# Copy single file to multiple directories
function cp2m() {
  xargs -n 1 cp -v $1 <<< "${@:2}"
}
