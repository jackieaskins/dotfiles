#!/usr/bin/env bash

JDT_LS_ROOT="$HOME/.local/share/nvim/lsp-servers/eclipse.jdt.ls"
OS="linux"
case "$OSTYPE" in
  darwin*)  OS=mac ;;
  msys*)    OS=win ;;
esac

JAR="$JDT_LS_ROOT/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME="$(which gradle)" "$(which java)" \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -javaagent:"$JDT_LS_ROOT/plugins/lombok.jar" \
  -Xmx1g \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED \
  -jar $(echo "$JAR") \
  -configuration "$JDT_LS_ROOT/config_$OS" \
  -data "${1:-$HOME/workspace}"
