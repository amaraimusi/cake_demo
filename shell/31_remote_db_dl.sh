#!/bin/sh

echo 'バックアップファイルをダウンロードします。(sqlファイルのダウンロード）'
scp amaraimusi@amaraimusi.sakura.ne.jp:www/cake_demo/shell/cake_demo.sql cake_demo.sql

echo "処理終了"
cmd /k