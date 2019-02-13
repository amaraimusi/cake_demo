#!/bin/bash

echo "DBパスワードを入力してください"
mysqldump -Q -h mysql716.db.sakura.ne.jp -u amaraimusi -p amaraimusi_cake_demo nekos > www/cake_demo/shell/nekos.sql 2> www/cake_demo/shell/dump.error.txt

echo "出力完了"