#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 Kaito Shima
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "${1}行目が違うよ"
    res=1
}

res=0

### EXECUTION TEST ###
out=$(printf "1\n6\n" | ./homework)
[ "$?" = 0 ] || ng "$LINENO"

### LINE COUNT TEST ###
lines=$(echo "$out" | wc -l)
[ "$lines" = 2 ] || ng "$LINENO"

### CONTENT TEST ###
# 1行目チェック
echo "$out" | head -n 1 | grep -q "整数の1~5を入力してください:" || ng "$LINENO"

# 2行目チェック
echo "$out" | tail -n 1 | grep -q "整数の6~10を入力してください:" || ng "$LINENO"

### ARTIST VALIDATION ###
artist=$(echo "$out" | head -n 1 | sed 's/整数の1~5を入力してください://')

case "$artist" in
    "Mr.Children"|"back number"|"嵐"|"あいみょん"|"サカナクション") ;;
    *) ng "$LINENO" ;;
esac

### SONG VALIDATION ###
song=$(echo "$out" | tail -n 1 | sed 's/整数の6~10を入力してください://')

case "$song" in
    "Any"|"himawari"|"UFO"|"羊、吠える"|"深海"|\
    "fish"|"ハッピーエンド"|"瞬き"|"ブルーアンバー"|"幸せ"|\
    "エナジーソング"|"果てない空"|"サーカス"|"シリウス"|"春風スニーカー"|\
    "姿"|"森のくまさん"|"ジェニファー"|"ビーナスベルト"|"MIO"|\
    "アルクアラウンド"|"ミュージック"|"陽炎"|"モス"|"多分、風") ;;
    *) ng "$LINENO" ;;
esac

[ "$res" = 0 ] && echo OK
exit $res

