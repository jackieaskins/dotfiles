#!/bin/bash

FORMATTERS_DIR="$HOME/dotfiles/formatters"

# Java Google Formatter {{{
echo -e "Updating Java Google Formatter..."

dest_dir="$FORMATTERS_DIR/google-java-format"

latest_release_url=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/google/google-java-format/releases/latest")
java_formatter="${latest_release_url##*/}"
version="${java_formatter##*-}"
download_url="${latest_release_url/tag/download}/$java_formatter-all-deps.jar"
version_file=$dest_dir/VERSION

if [ -f $version_file ]; then
  read -r old_version < $version_file
else
  old_version='0'
fi

if [ $old_version = $version ]; then
  echo -e "${GREEN}Latest version ($version) already installed, nothing to update${NC}"
else
  [ -d $dest_dir ] || mkdir $dest_dir
  wget -O "$dest_dir/google-java-format.jar" "$download_url"
  echo "$version" > $version_file
  echo -e "${GREEN}Successfully updated $repo_name${NC}"
fi
# }}}
