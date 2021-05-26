#!/bin/sh
echo 'ソースコードを差分アップロードします。'

rsync -auvz ../app amaraimusi@amaraimusi.sakura.ne.jp:www/cake_demo
rsync -auvz ../amaraimusi/crud_base_config.php amaraimusi@amaraimusi.sakura.ne.jp:www/cake_demo

echo "------------ 送信完了"
#cmd /k