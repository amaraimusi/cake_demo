#!/bin/sh

echo 'サーバー先でimgを圧縮します。'
ssh -l amaraimusi amaraimusi.sakura.ne.jp "
	cd www/cake_demo/app/webroot;
	pwd;
	tar cvzf img.tar.gz img
	exit;
	"

echo "------------ 解凍完了"

scp amaraimusi@amaraimusi.sakura.ne.jp:www/cake_demo/app/webroot/img.tar.gz img.tar.gz

echo "------------ ダウンロード完了"

cmd /k