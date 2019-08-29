<!-- CrudBase共通ヘルプ -->
<div id="help_csh" >
<div class="help_x">

	当ヘルプは各画面で共通する機能のヘルプです。<br>
	画面によっては存在しない機能もあります。<br>
	<br>
	
	<div id="help_x_div1">
		<a href="#crudbase_help2" class="livipage btn btn-info btn-xs">追加/編集/複製/削除/抹消</a>
		<a href="#crudbase_help3" class="livipage btn btn-info btn-xs">検索/詳細検索</a>
		<a href="#crudbase_help4" class="livipage btn btn-info btn-xs">初期戻し機能</a>
		<a href="#crudbase_help5" class="livipage btn btn-info btn-xs">列表示切替機能</a>
		<a href="#crudbase_help6" class="livipage btn btn-info btn-xs">セッションクリア機能</a>
		<a href="#crudbase_help7" class="livipage btn btn-info btn-xs">スマホ用一覧</a>
		<a href="#crudbase_help8" class="livipage btn btn-info btn-xs">ページネーション</a>
		<a href="#crudbase_help9" class="livipage btn btn-info btn-xs">まとめて削除</a>
		<a href="#crudbase_help9_2" class="livipage btn btn-info btn-xs">まとめて削除</a>
		<a href="#crudbase_help9_3" class="livipage btn btn-info btn-xs">DBからも完全削除（抹消）</a>
		<a href="#crudbase_help10" class="livipage btn btn-info btn-xs">ソート機能</a>
		<a href="#crudbase_help11" class="livipage btn btn-info btn-xs">行入替機能</a>
		<a href="#crudbase_help13" class="livipage btn btn-info btn-xs">CSVエスポート機能</a>
		<a href="#crudbase_help_err" class="livipage btn btn-info btn-xs">よくあるエラー対処法</a>
		<a href="#crudbase_help_version" class="livipage btn btn-info btn-xs">バージョン</a>
		
	</div>
	<hr>

	<div id="crudbase_help2">
	<h4>追加/編集/複製/削除/抹消</h4>
	一覧の基本操作として新規追加、編集、複製、削除、抹消があります。<br>
	各行の最右側にこれらのボタンは表示されています。<br> 
	<br> 
	
	「ボタン設定」からボタンのサイズや表示を切り替えることができます。<br> 
	「ボタン設定」はツールボックス内の「設定」からアクセスできます。<br> 
	<br> 
	
	「追加」、「編集」、「削除」は基本的なCRUD機能です。<br>
	ただ「削除」は削除フラグをONにするだけで実際にDBから消去するわけではありません。<br>
	「抹消」はデータそのものをデータベースから消去します。 削除フラグがONのデータのみ抹消できます。（一度削除してから抹消という流れ）<br>
	「複製」機能は文字通りその行を複製する機能です。<br>
	</div>
	
	<div id="crudbase_help3">
	<h4>検索/詳細検索</h4>
	検索機能は2種類あり、メインの検索と詳細検索から構成されています。<br>
	メイン検索は複数の特定列（主に文字系）を検索対象にしています。
	詳細検索は各列ごとに細かい検索指定ができます。<br>
	</div>
	
	<div id="crudbase_help4">
	<h4>初期戻し機能</h4>
	最初にページを開いた時の状態に戻す機能です。<br>
	上部メニューに存在する
	<span class="btn btn-info btn-xs"><span class="glyphicon glyphicon-certificate"></span></span>
	ボタンを押すと、検索されている状態や、一覧ソートされている状態をリセットして初期状態に戻すことができます。<br>
	</div>
		
	
	<div id="crudbase_help5">	
	<h4>列表示切替機能について</h4>
	列名チェックボックスから一覧の列を表示したり非表示にしたり切り替えることができます。<br>
	列並替ボタンからは、列の並び替えができます。<br>
	一覧の行を500件を超えて表示させると、表示速度の都合で当機能は使えなくなります。<br>

	<p>「列表示を保存」ボタン</p>
	現在の列表示状態を保存します。<br>
	画面を閉じても列表示状態は保持されます。<br>
	「初期に戻す」ボタンを押すと保存状態はクリアされます。<br>

	<p>「すべてチェック」ボタン</p>
	すべての列を表示します。<br>

	<p>「初期に戻す」ボタン</p>
	列表示を初期に戻します。<br>
	また「列表示を保存」ボタンによる保存状態も解除します。<br>
	<br>
	
	</div>
	
	<div id="crudbase_help6">
	<h4>セッションクリアボタン</h4>
	デバッグモードの場合のみ表示されます。<br>
	この画面に関係するセッションをすべてクリアします。<br>
	当システムのバージョンアップによる不具合が生じたときに押します。<br>
	</div>
		
		
	<div id="crudbase_help7">
		<h4>スマホ用一覧</h4>
		一覧表示は2タイプあり、行列型と縦型が存在します。<br>
		行列型はPC向けであり、一般的な列と行からなるテーブル構造です。
		縦型はスマホ向けであり各項目を縦に並べます。スマホで画面を開くと縦型になります。<br>
		上部メニューの<span class="btn btn-default btn-xs"><span class="glyphicon glyphicon-th-large" title="一覧の変形・区分モード"></span></span>
		ボタンを押すことで切替ができます。<br>
	</div>		
		
		
	<div id="crudbase_help8">
		<h4>ページネーション</h4>
		一度に表示する行は制限されています。<br>
		そのため検索結果数が多い場合、ページ分割されると共にページ目次が表示されます。<br>
		なお、表示する行数は検索項目で指定できます。<br>
	</div>		
		
		
	<div id="crudbase_help9">
		<h4>まとめて削除</h4>
		一覧の行をまとめて削除する機能です。<br>
		ID列左側に存在するチェックボックスにチェックを入れ、一覧の下にある「削除」ボタンを押します。<br>
		※となりにある「有効」ボタンは削除したデータをまとめて復元するときに使用します。<br>
	</div>	
		
		
	<div id="crudbase_help9_2">
		<h4>まとめて復元（有効）</h4>
		削除したデータをまとめて復元する機能です。<br>
		まずは、削除状態にある行を一覧表示させる必要があります。<br>
		削除状態の行を表示させるには、詳細検索から「有効」となっている箇所を「削除」に切り替えて検索します。<br>
		<br>
		削除状態の行が一覧表示されましたら、ID列左側に存在するチェックボックスにチェックを入れます。<br>
		そして一覧の下にある「有効」ボタンを押すると削除状態の行が有効化、つまり復元されます。<br>
	</div>
	
	<div id="crudbase_help9_3">
		<h4>DBから完全削除（抹消）</h4>	
		通常の「削除」ボタンは、削除状態にするだけであり、DBから完全に削除されるわけではありません。<br>
		DBから完全に抹消するには以下のようにします。<br>
		<br>
		
		まずは、削除状態にある行を一覧表示させる必要があります。<br>
		削除状態の行を表示させるには、詳細検索から「有効」となっている箇所を「削除」に切り替えて検索します。<br>
		すると行の最右側に「抹消」ボタンが表示されます。このボタンを押すとDBからも完全に消えます。<br>
		<br>
	</div>
	
	
	
		
		
	<div id="crudbase_help10">
		<h4>ソート機能</h4>
		一覧の列名リンクをクリックするとその列のデータで昇順並べ替えを行えます。<br>
		もう一度クリックすると降順並べ替えになります。<br>
		並べ替え状態は「初期戻し機能」で解除することができます。<br>
	</div>		
		
		
	<div id="crudbase_help11">
		<h4>行入替機能</h4>
		一覧の左側に存在する<span class="btn btn-info btn-xs">↑↓</span>ボタンをクリックを押すと、
		行入替フォームが現れ、行を上下に移動させたり、指定位置にジャンプさせたりできます。<br>
	</div>		
		
		
	<div id="crudbase_help13">
		<h4>CSVエスポート機能</h4>
		検索結果をCSV形式でダウンロードできます。<br>
		画面内の一覧は検索結果数が多いと行数制限をかけ、すべての行を表示しないようにしていますが、
		CSVダウンロードはすべての行を出力します。<br>
		<br>
		当機能は画面によっては存在しないこともあります。
	</div>		
	

</div>
</div>

<br>
<hr>

<div id="crudbase_help_err">
<h4 style="color:#de5347">エラー対処法</h4>

<p>よく起こるエラー：ログイン切れ</p>
今まで正常であったのに突然、ボタンを押しても反応しなかったり、エラーが表示されたりする場合、ログインが切れている可能性があります。<br>
再度ログインしなおしてください。<br>
<br>

<p>バージョンアップ直後のバグ</p>
当システムのバージョンアップ直後は、ブラウザに保存されている古いデータのためエラーが起きることがあります。<br>
列表示切替機能の「初期に戻す」ボタンおよび「セッションクリア」ボタンを押したのち、ブラウザをリロードしてください。<br>
ブラウザのCookie消去でも解決します。<br>
<br>
</div>

<div id="crudbase_help_version">
<p>バージョン情報</p>
ヘルプの更新日: 2019年8月<br>
システムバージョン: <?php echo $version; ?><br>
PHP:<?php echo phpversion() ?><br>
CakePHP: <?php echo Configure::version(); ?><br>
<br>
</div>


