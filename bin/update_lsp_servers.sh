#!/bin/bash


# Initialization {{{
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
SERVER_TO_INSTALL="${1:-all}"
DOTFILES_DIR=$HOME/dotfiles

shopt -s dotglob # Include hidden files when globbing
cd $DOTFILES_DIR

if [[ $SERVER_TO_INSTALL == 'all' ]]; then
  echo -e "Updating all language servers..."
else
  echo -e "Only updating ${SERVER_TO_INSTALL} language server"
fi
# }}}

# Helper functions {{{
should_install() {
  [[ $SERVER_TO_INSTALL == 'all' ]] || [[ $SERVER_TO_INSTALL =~ $1 ]]
}

download_microsoft_version() {
  local repo_name=$1

  if should_install "$repo_name"; then
    echo -e "Updating $repo_name..."

    local dest_dir="$DOTFILES_DIR/$repo_name-latest"
    local latest_release_url=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/microsoft/$repo_name/releases/latest")
    local download_url="${latest_release_url/releases\/tag/archive}.tar.gz"
    local version="${latest_release_url##*/}"
    local zip_file="$version.tar.gz"
    local version_file=$dest_dir/VERSION

    if [ -f $version_file ]; then
      read -r old_version < $version_file
    else
      old_version='0'
    fi

    if [ $old_version = $version ]; then
      echo -e "${GREEN}Latest version already installed, nothing to update\n${NC}"
    else
      [ -d $dest_dir ] || mkdir $dest_dir
      rm -rf $dest_dir/*

      wget $download_url
      tar -xf $zip_file -C $dest_dir

      mv $dest_dir/$repo_name-$version/* $dest_dir
      rm -r $dest_dir/$repo_name-$version

      rm $zip_file
      echo "$version" > $version_file

      cd $dest_dir
      $2
      cd - > /dev/null

      echo -e "${GREEN}Successfully updated $repo_name\n${NC}"
    fi
  fi
}
# }}}

# tsserver {{{
if should_install "^(tsserver|typescript-language-server)$"; then
  echo -e "Updating typescript-language-server..."
  npm install -g typescript-language-server
  echo -e "${GREEN}Finished updating typescript-language-server\n${NC}"
fi
# }}}

# diagnosticls {{{
if should_install "^(diagnosticls|diagnostic-languageserver)$"; then
  echo -e "Updating diagnostic-languageserver..."
  npm install -g diagnostic-languageserver
  echo -e "${GREEN}Successfully updated diagnostic-languageserver\n${NC}"
fi
# }}}

# java {{{
# jdtls {{{
if should_install "^(jdtls|jdt-language-server|eclipse.jdt.ls)$"; then
  echo -e "Updating jdtls..."
  zip_file=jdt-language-server-latest.tar.gz
  dest_dir=$DOTFILES_DIR/jdt-language-server-latest

  [ -d $dest_dir ] || mkdir $dest_dir
  rm -rf $dest_dir/*

  wget http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
  tar -xf $zip_file -C $dest_dir

  rm $zip_file
  echo -e "${GREEN}Successfully updated jdtls\n${NC}"
fi
# }}}

# java-debug {{{
install_java_debug() {
  ./mvnw clean install
}

download_microsoft_version "java-debug" "install_java_debug"
# }}}

# vscode-java-test {{{
install_vscode_java_test() {
  npm install
  npm run build-plugin
}

download_microsoft_version "vscode-java-test" "install_vscode_java_test"
# }}}
# }}}

# Cleanup {{{
echo -e "${GREEN}Done updating servers\n${NC}"
# }}}
