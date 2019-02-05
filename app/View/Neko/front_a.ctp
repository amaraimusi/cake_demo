<?php
echo $this->element('CrudBase/crud_base_helper_init');
$cbh = $this->CrudBase;
$frontA = $cbh->getFrontAHelper();


// CSSファイルのインクルード
$cssList = array(
		'bootstrap.min',
		'bootstrap-theme.min',
		'CrudBase/common.css?v=1.0.0',
		'Neko/front_a'// 当画面専用CSS
);
$this->assign('css', $this->Html->css($cssList));

// JSファイルのインクルード
$jsList = array(
		'jquery-2.1.4.min',
		'bootstrap.min',
		'CrudBase/dist/CrudBase.min.js',
		'Neko/front_a.js',
);
$this->assign('script', $this->Html->script($jsList,array('charset'=>'utf-8')));

?>
<h1><?php echo $title_for_layout; ?></h1>

<div id="err" style="color:red"></div>
<div class="cb_kj_main">
	<!-- 検索条件入力フォーム -->
	<?php echo $this->Form->create('Bukken', array('url' => true , 'class' => 'form_kjs')); ?>
	<?php $cbh->inputKjMain($kjs,'kj_main','',null,'複数の項目から検索します。');?>
	<input type='button' value='検索' onclick='searchKjs()' class='search_kjs_btn btn btn-success' />
	<div class="btn-group">
		<a href="" class="ini_rtn btn btn-info btn-xs" title="この画面を最初に表示したときの状態に戻します。（検索状態を初期状態に戻します。）">
			<span class="glyphicon glyphicon-certificate"  ></span></a>
		<button type="button" class="btn btn-default btn-xs" title="詳細検索項目を表示する" onclick="jQuery('.cb_kj_detail').toggle(300)">詳細</button>
	</div>
	
	<div class="cb_kj_detail" style="display:none">
	<?php 
	
	// --- CBBXS-1004

	$cbh->inputKjText($kjs,'kj_neko_name','ネコ名前');
	$cbh->inputKjMoDateRng($kjs,'kj_neko_date','ネコ日付');
	$cbh->inputKjNumRange($kjs,'neko_val','ネコ数値');
	$cbh->inputKjSelect($kjs,'kj_neko_group','ネコ種別',$nekoGroupList);
	//$cbh->inputKjDateTime($kjs,'kj_neko_dt','ネコ日時',150);
	$cbh->inputKjText($kjs,'kj_neko_dt','ネコ日時',150);
	$cbh->inputKjFlg($kjs,'kj_neko_flg','ネコフラグ');
	$cbh->inputKjText($kjs,'kj_img_fn','ネコ名前',200);
	$cbh->inputKjText($kjs,'kj_note','備考',200,'部分一致検索');
	$cbh->inputKjId($kjs);
	$cbh->inputKjHidden($kjs,'kj_sort_no');
	$cbh->inputKjDeleteFlg($kjs);
	$cbh->inputKjText($kjs,'kj_update_user','更新者',150);
	$cbh->inputKjText($kjs,'kj_ip_addr','更新IPアドレス',200);
	$cbh->inputKjCreated($kjs);
	$cbh->inputKjModified($kjs);

	// --- CBBXE
	
	$cbh->inputKjLimit($kjs);
	echo "<input type='button' value='検索' onclick='searchKjs()' class='search_kjs_btn btn btn-success' />";
	echo $this->element('CrudBase/crud_base_cmn_inp');
	

	?>
		<div class="kj_div" style="margin-top:5px">
			<input type="button" value="リセット" title="検索入力を初期に戻します" onclick="resetKjs()" class="btn btn-primary btn-xs" />
		</div>
	</div>
	<?php echo $this->Form->end()?>
</div><!-- cb_kj_main -->




<div style="margin-top:8px;margin-bottom:8px;">
	<?php 
	echo $frontA->topLinkBtn($pages);
	echo $frontA->prevLinkBtn($pages);
	echo $frontA->nextLinkBtn($pages); 
	?>
	<div style="display:inline-block"><?php echo $pages['page_index_html']; ?></div>
	<div style="display:inline-block">件数:<?php echo $data_count ?></div>
</div>

<!-- 一覧テーブル -->
<table id="neko_tbl" border="1"  class="table_transform">

<thead>
<tr>
	<!-- CBBXS-1050 -->
	<th>画像</th>
	<th>説明</th>
	<th>ID</th>
	<th>ネコ名</th>
	<th>ネコ日付</th>
	<th>ネコ日時</th>
	<th>更新日</th>
	<th>ネコ数値</th>
	<!-- CBBXE -->
</tr>
</thead>
<tbody>
<?php

// td要素出力を列並モードに対応させる
$this->CrudBase->startClmSortMode($field_data);

foreach($data as $i=>$ent){

	echo "<tr id='ent{$ent['id']}'>";
	
	// CBBXS-1051
	$frontA->tdImage($ent,'img_fn','td_image');
	$frontA->tdNote($ent,'note','td_note');
	$frontA->tdPlain($ent,'id');
	$frontA->tdStr($ent,'neko_name');
	$frontA->tdPlain($ent,'neko_date');
	$frontA->tdPlain($ent,'neko_dt');
	$frontA->tdPlain($ent,'modified');
	$frontA->tdPlain($ent,'neko_val');
	// CBBXE
	
	echo "</tr>";
}

?>
</tbody>
</table>

<div style="margin-top:8px;margin-bottom:8px;">
	<?php 
	echo $frontA->topLinkBtn($pages);
	echo $frontA->prevLinkBtn($pages);
	echo $frontA->nextLinkBtn($pages); 
	?>
	<div style="display:inline-block"><?php echo $pages['page_index_html']; ?></div>
	<div style="display:inline-block">件数:<?php echo $data_count ?></div>
</div>

























