#!/bin/sh
echo 'libを本番環境からローカル環境にコピーします。'


scp -r amaraimusi@amaraimusi.sakura.ne.jp:www/cake_demo2/cake_demo/lib ../
echo "------------ コピー完了"
cmd /k