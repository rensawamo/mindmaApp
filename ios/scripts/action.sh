#!/bin/bash

# GitHub Actionsでは $GITHUB_WORKSPACE 
SRCROOT="$GITHUB_WORKSPACE/ios"

# Flutter/DartDefine.xcconfig へのパス
CONFIG_PATH="$SRCROOT/Flutter/DartDefine.xcconfig"

# ディレクトリが存在するかどうかを確認し、必要なら作成
mkdir -p $(dirname "$CONFIG_PATH")

# DART_DEFINEを解析して必要な設定をファイルに書き込む
echo $DART_DEFINE | tr ',' '\n' | while read line; do
  echo $line | base64 -d | tr ',' '\n' | xargs -I@ bash -c "echo @ | grep 'FLAVOR' | sed 's/.*=//'"
done | {
  read flavor
  echo "#include \"$flavor.xcconfig\"" > "$CONFIG_PATH"
}
