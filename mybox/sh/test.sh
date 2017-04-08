#!/bin/sh

if [ $# -lt 1 ]; then
  echo "warn: need a url"
  exit 1
fi

##seqを使えば一定回数のforができる
#if [ $# -gt 1 ]; then
#  for i in `seq 2 $#`
#    do
#      echo "$($i)" #あかんわ...
#    done
#fi

#２番目以降を取得
echo ${@:2}

#$@は引数全体を""でくくる
echo $# ":" $@

#shift `expr $# - 1`
#echo $# ":" $@


#正体はただのaliasでした！
#wget -nH -r -np $1

