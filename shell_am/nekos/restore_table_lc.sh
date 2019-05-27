#!/bin/bash



echo 'nekosテーブルをリストアします【ローカル】。'
mysql drop table nekos
mysql -uroot -pneko joberch < nekos.sql

echo "出力完了"