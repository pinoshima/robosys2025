#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 Kaito Shima
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "${1}行目が違うよ" >&2
    res=1
}

res=0

out=$(printf "1 6\n" | ./select_song)
[ "$?" = 0 ] || ng "$LINENO"

lines=$(echo "$out" | wc -l)
[ "$lines" = 1 ] || ng "$LINENO"

artist=$(echo "$out" | awk '{print $1}')
song=$(echo "$out" | awk '{print $2}')

echo "$artist" | grep -qE "Mr.Children|back number|嵐|あいみょん|サカナクション" \
    || ng "$LINENO"

echo "$song" | grep -qE "靴ひも|himawari|UFO|羊、吠える|深海|東京の夕焼け|one room|あやしいひかり|こわいはなし|風の強い日|エナジーソング|果てない空|Sakura|シリウス|truth|姿|森のくまさん|ジェニファー|ビーナスベルト|MIO|アルクアラウンド|プラトー|陽炎|ユリイカ|多分、風" \
    || ng "$LINENO"

out=$(printf "1 6\n" | ./select_song)
[ "$?" = 0 ] || ng "$LINENO"

printf "1 6\n" | ./select_song >/dev/null
[ "$?" = 0 ] || ng "$LINENO"

[ "$res" = 0 ] && echo OK
exit $res
