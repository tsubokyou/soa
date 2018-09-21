#!/bin/sh
root_url="http://wikiwiki.jp/soanamnesis"

cat index_base.html | grep "キャラクター名" > chara_index.txt
cat chara_index.txt | perl -pe "s/<\/td>/<\/td>\n/g;" | perl -pe "s/<a href/\n<a href/g" > chara_index.1.txt
cat chara_index.1.txt | \
  grep "<a href" | \
  perl -pe "s/^(.*?)a href=\"(.*?)\" title=\"(.*?)\"(.*?)\n/\nsoa_character,\3,\2\n/g;" > chara_index.2.txt 
cat chara_index.2.txt | grep "^soa_character" > chara_index.csv
rm *.txt
