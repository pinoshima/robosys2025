#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 Kaito Shima
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "${1}行目が違うよ"
    res=1
}

res=0

### EXECUTION TEST ###
# テスト用の入力（例：1 6）
out=$(printf "1 6\n" | ./select_song)
[ "$?" = 0 ] || ng "$LINENO"

### LINE COUNT TEST ###
lines=$(echo "$out" | wc -l)
[ "$lines" = 1 ] || ng "$LINENO"  # Pythonスクリプトは1行出力

### CONTENT TEST ###
# 出力をアーティストと曲名に分割
artist=$(echo "$out" | awk '{print $1}')
song=$(echo "$out" | awk '{print $2}')

# アーティスト名チェック
echo "$artist" | grep -qE "Mr.Children|back number|嵐|あいみょん|サカナクション" \
    || ng "$LINENO"

# 曲名チェック
echo "$song" | grep -qE "靴ひも|himawari|UFO|羊、吠える|深海|東京の夕焼け|one room|あやしいひかり|こわいはなし|風の強い日|エナジーソング|果てない空|Sakura|シリウス|truth|姿|森のくまさん|ジェニファー|ビーナスベルト|MIO|アルクアラウンド|プラトー|陽炎|ユリイカ|多分、風" \
    || ng "$LINENO"

[ "$res" = 0 ] && echo OK
exit $res
