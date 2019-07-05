#!/bin/sh

echo 'ミラーDB作成シェル'
echo '@date 2019-7-5 @version 1.0'
pwd

user='root'
pw='neko'
db_name1='animal_park' #元DB名
db_name2='animal_park2' #作成DB名

echo "$db_name1をエクスポートします。"
mysqldump -u$user -p$pw $db_name1 > $db_name1.sql
echo "$db_name1.sqlとしてエクスポートしました。"

mysql -u$user -p$pw -e "
	CREATE DATABASE IF NOT EXISTS $db_name2 COLLATE utf8mb4_general_ci
	"
echo "データベース$db_name2を作成しました。"

mysql -u $user -p$pw -B $db_name2 < $db_name1.sql
echo "$db_name1.sqlを$db_name2へインポートしました。";

echo "すべての作業が完了しました。"
cmd /k