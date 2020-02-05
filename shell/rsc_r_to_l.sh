#!/bin/sh
echo 'マーカーピン画像などのリソースを本番環境からローカル環境にコピーします。'

#scp -r amaraimusi@amaraimusi.sakura.ne.jp:www/cake_demo2/cake_demo/app/webroot/rsc ../app/webroot
scp -r amaraimusi@amaraimusi.sakura.ne.jp:www/cake_demo/app/webroot/rsc ../app/webroot

echo "------------ コピー完了"
cmd /k