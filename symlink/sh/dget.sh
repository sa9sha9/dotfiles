#!/bin/sh

#basenameはパスなどを除去するコマンド(純粋なコマンドネームを取得)
CMDNAME=`basename $0` 

### 
# 第一引数がない時、使用方法を表示
# 1>^2 標準出力を標準出力エラーと同じ出力に送る
if [ $# -lt 1 ]; then
  echo "Usage: $CMDNAME url [wget options..]" 1>&2
  exit 1
fi


if [ $# -eq 0 ]; then
  echo "warn: need a url"
  exit 1
fi

wget -nH -r -np $1 ${@:2}