#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 Kaito Shima
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "${1}行目が違うよ"
    res=1
}

res=0

### EXECUTION TEST ###
out=$(./homework)
[ "$?" = 0 ] || ng "$LINENO"

### LINE COUNT TEST ###
lines=$(echo "$out" | wc -l)
[ "$lines" = 2 ] || ng "$LINENO"

### CONTENT TEST ###
echo "$out" | grep -q "今日のおすすめのアーティストは" || ng "$LINENO"
echo "$out" | grep -q "おすすめの曲は" || ng "$LINENO"

### ARTIST VALIDATION ###
# 1行目から「今日のおすすめのアーティストは 」の部分を削除
artist=$(echo "$out" | head -n 1 | sed 's/今日のおすすめのアーティストは //')

case "$artist" in
    "Mr.Children"|"back number"|"YOASOBI") ;;
    *) ng "$LINENO" ;;
esac

### SONG VALIDATION ###
# 2行目から「おすすめの曲は 」の部分を削除
song=$(echo "$out" | tail -n 1 | sed 's/おすすめの曲は //')

case "$song" in
    "HANABI"|"Sign"|"しるし"|"fish"|"ハッピーエンド"|"幸せ"|"夜に駆ける"|"モノトーン"|"海のまにまに") ;;
    *) ng "$LINENO" ;;
esac

[ "$res" = 0 ] && echo OK
exit $res
