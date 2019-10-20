#!/bin/sh

echo "ローカルDBのパスワードを入力してください"
read pw


echo 'ローカル側DBにバックアップsqlファイルをインポートします。'
mysql -u root -p$pw cake_demo < cake_demo.sql
echo "処理終了"
cmd /k