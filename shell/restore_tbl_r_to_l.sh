#!/bin/bash
#read pw
pw="aka3siro3"
echo "A1"
test1="hello_world"

ssh -l amaraimusi amaraimusi.sakura.ne.jp "
	sh www/cake_demo/shell/server/test.sh aka3siro3;
	"

echo "出力完了"
cmd /k