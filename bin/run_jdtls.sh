#!/usr/bin/env bash

OS='linux'
case "$OSTYPE" in
  darwin*)  OS=mac ;;
  msys*)    OS=win ;;
esac

JAR="$HOME/dotfiles/jdt-language-server-latest/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME="$(which gradle)" "$(which java)" \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -jar $(echo "$JAR") \
  -configuration "$HOME/dotfiles/jdt-language-server-latest/config_$OS" \
  -data "${1:-$HOME/workspace}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
