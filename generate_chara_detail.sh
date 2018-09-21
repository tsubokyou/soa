#!/bin/sh
url=$1

# ラッシュ威力、パラメータ取得
curl ${url}  | grep "ラッシュコンボ" | perl -pe "s/<\/td>/<\/td>\n/g" | perl -pe "s/最大ヒット数：/\n最大ヒット数：/g" | grep -v "^<div class" > chara_detail.txt
cat chara_detail.txt | \
  perl -pe "s/,//g" | \
  perl -pe "s/　//g" | \
  perl -pe "s/^(.*?)>【(.*?)】\((.*?)\)<\/td>(.*?)/\2,\3,/g" > chara_detail.2.txt

cat chara_detail.2.txt | perl -pe "s/^(.*?)>武器種：(.*?)<\/td>(.*?)/\2,/g" | \
  #perl -pe "s/^(.*?)>ラッシュコンボ「(.*?)」<(.*?)\/>(.*?)<(.*?)威力：(.*?)／(.*?)最大ヒット数：(.*?)／(.*?)属性<(.*?)\/>(.*?)/\2,\4,\6,\7,\8,\9/g" | \
  perl -pe "s/^(.*?)>ラッシュコンボ「(.*?)」<(.*?)\/>(.*?)<(.*?)威力：(.*?)／(.*?)/\2,\4,\6,/g" | \
  perl -pe "s/^最大ヒット数：(.*?)／(.*?)属性(.*?)/\1,\2,/g" | \
  perl -pe "s/^(.*?)HP：(.*?)<(.*?)ATK：(.*?)<(.*?)INT：(.*?)<(.*?)DEF：(.*?)<(.*?)\/>/\2,\4,\6,\8/g" | \
  perl -pe "s/^(.*?)HIT：(.*?)<(.*?)GRD：(.*?)<(.*?)/\1,\2,\4\n>>cut\n/g" > result
cut_line_num=`cat result | grep -e ">>cut" -n | sed -e 's/:.*//g'`
sed -e "${cut_line_num},\$d" result | \
  perl -pe "s/\n//g"  | \
  perl -pe "s/$/\n/g" | \
  perl -pe "s/<span class=\"wikicolor\" style=\"color:Blue\">(.*?)<\/span><br class=\"spacer\" \/>//g" | \
  perl -pe "s/(.*?)ｘ(.*?)%/\1,\2/g" >> chara_parameter.csv

#weapon_type=`cat chara_detail.txt | perl -pe "s/^(.*?)>武器種：(.*?)<\/td>(.*?)/\2/g"`
#echo "weapon_type:${weapon_type}"

#echo "名前,ロール,ラッシュ名,ラッシュバフ,ラッシュ威力,ラッシュヒット数,ラッシュ属性,HP,ATK,INT,DEF,HIT,GRD"
#echo "名前,タレント1,タレント2,タレント3,タレント4,タレント5,タレント6,タレント7,タレント8"
#cat hoge | grep "バトルスキル詳細"
