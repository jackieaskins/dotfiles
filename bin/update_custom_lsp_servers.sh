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
  'jdt-language-server'
)

language_server_aliases=(
  'jdt-language-server|jdtls|eclipse.jdt.ls'
)

language_server_cmds=(
  'install_jdtls'
)

should_install() {
  [[ $SERVER_TO_INSTALL == 'all' ]] || [[ $SERVER_TO_INSTALL =~ $1 ]]
}

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
