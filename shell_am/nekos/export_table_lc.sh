#!/bin/sh

echo 'nekosテーブルをエクスポートします【ローカル】。'
mysqldump --default-character-set=utf8 -u root -pneko joberch nekos >nekos.sql
echo 'nekosテーブルをエクスポートしました。'


echo "------------ 終わり"
cmd /k