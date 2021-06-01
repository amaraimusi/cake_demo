#!/bin/sh
echo 'CrudBaseプロジェクトのCrudBaseを上書きする'

rsync -auvz ../app/webroot/css/CrudBase ~/git/CrudBase/dist/CrudBase/css
rsync -auvz ../app/webroot/js/CrudBase ~/git/CrudBase/dist/CrudBase/js
rsync -auvz ../app/Vendor/CrudBase ~/git/CrudBase/dist/CrudBase/php

echo "------------ CrudBaseアップデート完了"
cmd /k