#!/bin/sh
echo '他のプロジェクトへCrudBase関連のソースコードを差分アップロードします。'
echo '更新日付が新しいファイルだけ上書きします。'

rsync -auvz ../app/Controller/CrudBaseController.php ../../cake_demo/app/Controller
rsync -auvz ../app/Model/CrudBase.php ../../cake_demo/app/Model
rsync -auvz ../app/Vendor/CrudBase ../../cake_demo/app/Vendor

rsync -auvz ../app/View/Elements/CrudBase ../../cake_demo/app/View/Elements
rsync -auvz ../app/View/Helper/CrudBaseComponent ../../cake_demo/app/View/Helper
rsync -auvz ../app/View/Helper/CrudBaseHelper.php ../../cake_demo/app/View/Helper

rsync -auvz ../app/webroot/css/CrudBase ../../cake_demo/app/webroot/css
rsync -auvz ../app/webroot/js/CrudBase ../../cake_demo/app/webroot/js

echo "------------ 送信完了"
cmd /k