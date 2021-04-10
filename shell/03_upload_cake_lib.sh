#!/bin/sh
echo 'CakePHPのlibをアップロード'

rsync -auvz ../lib amaraimusi@amaraimusi.sakura.ne.jp:www/cake_demo

echo "------------ 送信完了"
#cmd /k