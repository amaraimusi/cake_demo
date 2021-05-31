#!/bin/sh
echo 'ソースコードを差分アップロードします。'

rsync -auvz --exclude='database.php' ../app amaraimusi@amaraimusi.sakura.ne.jp:www/cake_demo/

echo "------------ 送信完了"
cmd /k