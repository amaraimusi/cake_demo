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

























