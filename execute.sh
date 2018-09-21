#!/bin/sh
root_url="https://wikiwiki.jp"
sh curl_chara_index.sh
sh generate_chara_index.sh

echo "名前,ロール,武器種,ラッシュ名,ラッシュバフ,ラッシュ換算PRM,ラッシュ威力,ラッシュヒット数,ラッシュ属性,HP,ATK,INT,DEF,HIT,GRD" > chara_parameter.csv
for line in `cat chara_index.csv | cut -d ',' -f 3`
do
  sleep 1
  echo_str=`$line | nkf --url-input`
  echo ${echo_str}
  sh generate_chara_detail.sh ${root_url}${line}
done
nkf -s --overwrite chara_parameter.csv
