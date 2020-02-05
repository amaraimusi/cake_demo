#!/bin/sh

echo '作業ディレクトリ'
pwd

echo "ローカルDBのパスワードを入力してください"
read pw

	date1=`date "+%Y%m%d-%H%M%S"`
	echo 現在日付→${date1}

echo 'SQLをエクスポートします。'
mysqldump -uroot -p$pw cake_demo > cake_demo${date1}.sql
echo 'エクスポートしました。'

#echo 'SQLファイルをサーバーに転送します。'
#scp cake_demo${date1}.sql amaraimusi@amaraimusi.sakura.ne.jp:www/cake_demo/shell
#echo '転送しました。'

echo "------------ 終わり"
cmd /k