#!/bin/sh
echo 'CrudBaseプロジェクトのCrudBaseを上書きする'

rsync -auvz ~/git/CrudBase/dist/CrudBase/css/CrudBase ../app/webroot/css
rsync -auvz ~/git/CrudBase/dist/CrudBase/js/CrudBase ../app/webroot/js
rsync -auvz ~/git/CrudBase/dist/CrudBase/php/CrudBase ../app/Vendor

echo "------------ CrudBaseアップデート完了"
cmd /k