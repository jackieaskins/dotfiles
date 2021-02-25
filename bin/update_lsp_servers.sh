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
  echo -e "Updating all language servers...\n"
else
  echo -e "Only updating ${SERVER_TO_INSTALL} language server\n"
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

# Custom install functions {{{
install_jdtls() {
  zip_file=jdt-language-server-latest.tar.gz
  dest_dir=$DOTFILES_DIR/jdt-language-server-latest

  [ -d $dest_dir ] || mkdir $dest_dir
  rm -rf $dest_dir/*

  wget http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
  tar -xf $zip_file -C $dest_dir

  rm $zip_file
}
# }}}

# Language server installation {{{
language_servers=(
  'diagnostic-languageserver'
  'jdt-language-server'
  'solargraph'
  'typescript-language-server'
  'vim-language-server'
)

language_server_aliases=(
  'diagnostic-languageserver|diagnosticls'
  'jdt-language-server|jdtls|eclipse.jdt.ls'
  'solargraph'
  'tsserver|typescript-language-server'
  'vimls|vim-language-server'
)

language_server_cmds=(
  'npm install -g diagnostic-languageserver eslint_d'
  'install_jdtls'
  'gem install --user-install solargraph'
  'npm install -g typescript typescript-language-server'
  'npm install -g vim-language-server'
)

for i in "${!language_servers[@]}"; do
  server=${language_servers[$i]}
  aliases=${language_server_aliases[$i]}
  cmd=${language_server_cmds[$i]}

  if should_install "^${aliases}$"; then
    echo -e "Updating ${server}..."
    $cmd
    echo -e "${GREEN}Successfully updated ${server}\n${NC}"
  fi
done
# }}}

# Cleanup {{{
echo -e "${GREEN}Done updating servers\n${NC}"
# }}}
