#!/usr/bin/env bash

# Tsserver {{{
echo "Updating typescript-language-server"
npm install -g typescript-language-server
echo "Finished updating typescript-language-server"
echo ""
# }}}

# Diagnostic LS {{{
echo "Updating diagnostic-languageserver"
npm install -g diagnostic-languageserver
echo "Finished updating diagnostic-languageserver"
echo ""
# }}}

# JDT LS {{{
echo "Updating JDTLS"
ZIP=jdt-language-server-latest.tar.gz
DIR=$HOME/dotfiles/jdt-language-server-latest

[ -d $DIR ] || mkdir $DIR
rm -rf $DIR/*

wget http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
tar -xf $ZIP -C $DIR

rm $ZIP
echo "Finished updating JDTLS"
# }}}
