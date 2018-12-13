#!/bin/sh


echo '作業ディレクトリ'
pwd

#echo "ローカルDBのパスワードを入力してください"
#read pw
pw="neko"


xxx=`date +"%Y%m%d"`

echo 'SQLをエクスポートします。'
mysqldump -uroot -p$pw cake_demo yagis --add-drop-table > yagis$xxx.sql


echo "------------ 終わり"
cmd /k