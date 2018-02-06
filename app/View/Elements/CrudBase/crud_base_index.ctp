<?php 
	// CrudBaseヘルパーへ各種パラメータをセットする。
	$this->CrudBase->setParam(array(
		'iniFlg'=>$iniFlg,
		'crudType'=>$crudType,
		'bigDataFlg'=>$bigDataFlg,
		'debug_mode'=>$debug_mode,
	));
	
	$model_name_s = $this->CrudBase->getModelNameSnk();//スネーク記法モデル名
?>
<!-- CrudBase共通 -->
<input id="iniFlg" type="hidden" value="<?php echo $iniFlg ?>" />
<input id="crudType" type="hidden" value="<?php echo $crudType ?>" />
<input id="webroot" type="hidden" value="<?php echo $this->Html->webroot ?>" />
<input id="csh_json" type="hidden" value="<?php echo $csh_json ?>" />
<input id="bigDataFlg" type="hidden" value="<?php echo $bigDataFlg ?>" />
<div id="defKjsJson" style="display:none"><?php echo $defKjsJson ?></div>
<input id="debug_mode" type="hidden" value="<?php echo $debug_mode ?>" />


 <div class="kj_div" style="margin-top:4px;">
	<?php
	echo $this->Form->input("saveKjFlg",array(
		'type'=>'checkbox',
		'value' => 1,
		'checked'=>$saveKjFlg,
		'label'=>'検索入力保存',
		'div'=>false,
	));
	?>
</div>

<div class="kj_div" style="margin-top:5px">
	<input type="button" value="リセット" title="検索入力を初期に戻します" onclick="resetKjs()" class="btn btn-primary btn-xs" />
</div>


<div style="width:1px;height:20px;clear:both"></div>


<input type="button" value="列表示切替" class="btn btn-default btn-sm" onclick="$('#clm_cbs_detail').toggle(300)" />
<div id="clm_cbs_detail" style="display:none;margin-top:5px">
<div id="clm_cbs_rap">
	<p>列表示切替</p>
	<div id="clm_cbs"></div>

	<?php if($iniFlg==0 && $bigDataFlg==0){?>
		<input type="button" class="btn btn-warning btn-xs" value="列並替" onclick="moveClmSorter()" />
	<?php } ?>
	
	<?php if($debug_mode==2 && $bigDataFlg==0){?>
		<a href="?ini=1&sc=1" class="btn btn-danger btn-xs">セッションクリア</a>
	<?php } ?>
	
	<a href="#help_csh" class="livipage btn btn-info btn-xs" title="ヘルプ"><span class="glyphicon glyphicon-question-sign"></span></a>
</div>
<hr class="hr_purple">
</div>
<a href="<?php echo $this->html->webroot.$model_name_s ?>/csv_download" class="btn btn-default btn-sm" title="データベース型フォーマットのCSVファイル">CSV</a>




<div style="width:1px;height:20px"></div>
<!-- CrudBase共通 ・ここまで -->