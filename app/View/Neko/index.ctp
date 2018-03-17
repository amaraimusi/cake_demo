<?php
$this->CrudBase->setModelName('Neko');

$this->assign('css', $this->Html->css(array(
	'clm_show_hide',				// 列表示切替
	'ympicker_rap',					// 年月ダイアログ
	'nouislider.min',				// 数値範囲入力スライダー・noUiSlider
	'NoUiSliderRap',				// noUiSliderのラップ
	'CrudBase/index'				// CRUD indexページ共通
)));

$this->assign('script', $this->Html->script(array(
	'clm_show_hide',				// 列表示切替
	'date_ex',						// 日付関連関数集
	'jquery.ui.ympicker',			// 年月選択ダイアログ
	'ympicker_rap',					// 年月選択ダイアログのラップ
	'nouislider.min',				// 数値範囲入力スライダー・noUiSlider
    'NoUiSliderRap',				// noUiSliderのラップ
//    'ExchangeTr.js?ver=1.1',         // 行入替機能■■■□□□■■■□□□■■■□□□■■■
    'CrudBase/CrudBaseBase.js?ver=1.0',
    'CrudBase/CrudBaseAutoSave.js?ver=1.0',
    'CrudBase/CrudBaseRowExchange.js?ver=1.2',
    'CrudBase/CrudBase.js?ver=2.0',
	'livipage',						// ページ内リンク先プレビュー
	'ProcessWithMultiSelection',	// 一覧のチェックボックス複数選択による一括処理
	'CrudBase/ImportFu.js',			// インポート・ファイルアップロードクラス
	'CrudBase/index',				// CRUD indexページ共通
	'Neko/index'					// 当画面専用JavaScript
),array('charset'=>'utf-8')));
	

?>




<h2>ネコ</h2>

ネコの検索閲覧および編集する画面です。<br>
<br>

<?php
	$this->Html->addCrumb("トップ",'/');
	$this->Html->addCrumb("ネコ");
	echo $this->Html->getCrumbs(" > ");
?>

<?php echo $this->element('CrudBase/crud_base_new_page_version');?>
<div id="err" class="text-danger"><?php echo $errMsg;?></div>


<!-- 検索条件入力フォーム -->
<div style="margin-top:5px">
	<?php 
		echo $this->Form->create('Neko', array('url' => true ));
	?>

	
	<div style="clear:both"></div>
	
	<div id="detail_div" style="display:none">
		
		<?php 
		
		// --- Start kj_input
		$this->CrudBase->inputKjText($kjs,'kj_neko_name','ネコ名前',300);
		$this->CrudBase->inputKjNengetu($kjs,'kj_neko_date','ネコ日付');
		$this->CrudBase->inputKjId($kjs); 
		$this->CrudBase->inputKjNouislider($kjs,'neko_val','ネコ数値'); 
		$this->CrudBase->inputKjSelect($kjs,'kj_neko_group','ネコ種別',$nekoGroupList); 
		$this->CrudBase->inputKjText($kjs,'kj_neko_dt','ネコ日時',150); 
		$this->CrudBase->inputKjText($kjs,'kj_note','備考',200,'部分一致検索'); 
		$this->CrudBase->inputKjHidden($kjs,'kj_sort_no');
		$this->CrudBase->inputKjDeleteFlg($kjs);
		echo "<div style='clear:both'></div>";
		$this->CrudBase->inputKjText($kjs,'kj_update_user','更新者',150);
		$this->CrudBase->inputKjText($kjs,'kj_ip_addr','更新IPアドレス',200);
		$this->CrudBase->inputKjCreated($kjs);
		$this->CrudBase->inputKjModified($kjs);
		echo "<div style='clear:both'></div>";
		$this->CrudBase->inputKjLimit($kjs);
		// --- End kj_input
		
		echo $this->element('CrudBase/crud_base_cmn_inp');
		
		?>

		
		
		<?php 
		
		echo $this->Form->submit('検索', array('name' => 'search','class'=>'btn btn-success','div'=>false,));
		
		echo $this->element('CrudBase/crud_base_index');
		
		$csv_dl_url = $this->html->webroot . 'neko/csv_download';
		$this->CrudBase->makeCsvBtns($csv_dl_url);
		?>
	

	<div style="margin-top:40px">
		
	</div>

	</div><!-- detail_div -->

	<div id="func_btns" >
		
			<div class="line-left">
				<button type="button" onclick="$('#detail_div').toggle(300);" class="btn btn-default btn-sm">
					<span class="glyphicon glyphicon-cog"></span>
				</button>

			</div>
			
			<div class="line-middle"></div>
			
			<div class="line-right">
				<a href="<?php echo $home_url; ?>" class="btn btn-info" title="この画面を最初に表示したときの状態に戻します。（検索状態、列並べの状態を初期状態に戻します。）">
					<span class="glyphicon glyphicon-certificate"  ></span></a>
				<?php 
					// 新規入力ボタンを作成
					$newBtnOption = array(
							'scene'=>'<span class="glyphicon glyphicon-plus"></span>追加'
					);
					$this->CrudBase->newBtn($newBtnOption);
				?>

			</div>



	</div>
	<div style="clear:both"></div>
	<?php echo $this->Form->end()?>

	
</div>


<br />

<div id="total_div">
	<table><tr>
		<td>件数:<?php echo $data_count ?></td>
		<td><a href="#help_lists" class="livipage btn btn-info btn-xs" title="ヘルプ"><span class="glyphicon glyphicon-question-sign"></span></a></td>
	</tr></table>
</div>


<div style="margin-bottom:5px">
	<?php echo $pages['page_index_html'];//ページ目次 ?>
</div>



<div id="crud_base_auto_save_msg" style="height:20px;" class="text-success"></div>
<!-- 一覧テーブル -->
<table id="neko_tbl" border="1"  class="table table-striped table-bordered table-condensed">

<thead>
<tr>
	<?php
	foreach($field_data as $ent){
		$row_order=$ent['row_order'];
		echo "<th class='{$ent['id']}'>{$pages['sorts'][$row_order]}</th>";
	}
	?>
	<th></th>
</tr>
</thead>
<tbody>
<?php

// td要素出力を列並モードに対応させる
$this->CrudBase->startClmSortMode($field_data);

foreach($data as $i=>$ent){

	echo "<tr id=i{$ent['id']}>";
	// --- Start field_table
	$this->CrudBase->tdId($ent,'id',array('checkbox_name'=>'pwms'));
	$this->CrudBase->tdMoney($ent,'neko_val');
	$this->CrudBase->tdStr($ent,'neko_name');
	$this->CrudBase->tdList($ent,'neko_group',$nekoGroupList);
	$this->CrudBase->tdPlain($ent,'neko_date');
	$this->CrudBase->tdPlain($ent,'neko_dt');
	$this->CrudBase->tdNote($ent,'note');
	$this->CrudBase->tdPlain($ent,'sort_no');
	$this->CrudBase->tdDeleteFlg($ent,'delete_flg');
	$this->CrudBase->tdPlain($ent,'update_user');
	$this->CrudBase->tdPlain($ent,'ip_addr');
	$this->CrudBase->tdPlain($ent,'created');
	$this->CrudBase->tdPlain($ent,'modified');
	// --- End field_table
	
	$this->CrudBase->tdsEchoForClmSort();// 列並に合わせてTD要素群を出力する
	
	// 行のボタン類
	echo "<td><div class='btn-group'>";
	$id = $ent['id'];
	echo  "<input type='button' value='↑↓' onclick='rowExchangeShowForm(this)' class='row_exc_btn btn btn-info btn-xs' />";
	$this->CrudBase->rowEditBtn($id);
	$this->CrudBase->rowPreviewBtn($id);
	$this->CrudBase->rowCopyBtn($id);
	$this->CrudBase->rowDeleteBtn($id);
	$this->CrudBase->rowEliminateBtn($id);// 抹消ボタン
	echo "</div></td>";
	
	echo "</tr>";
}

?>
</tbody>
</table>

<?php echo $this->element('CrudBase/crud_base_pwms'); // 複数選択による一括処理 ?>

<!-- 新規入力フォーム -->
<div id="ajax_crud_new_inp_form" class="panel panel-primary">

	<div class="panel-heading">
		<div class="pnl_head1">新規入力</div>
		<div class="pnl_head2"></div>
		<div class="pnl_head3">
			<button type="button" class="btn btn-primary btn-sm" onclick="closeForm('new_inp')"><span class="glyphicon glyphicon-remove"></span></button>
		</div>
	</div>
	<div class="panel-body">
	<div class="err text-danger"></div>
	
	<div style="display:none">
    	<input type="hidden" name="form_type">
    	<input type="hidden" name="row_index">
    	<input type="hidden" name="sort_no">
	</div>
	<table><tbody>

		<!-- Start ajax_form_new_start -->
		<tr><td>ネコ数値: </td><td>
			<input type="text" name="neko_val" class="valid" value=""  pattern="^[0-9]+$" maxlength="11" title="数値を入力してください" />
			<label class="text-danger" for="neko_val"></label>
		</td></tr>

		<tr><td>ネコ名: </td><td>
			<input type="text" name="neko_name" class="valid" value=""  maxlength="255" title="255文字以内で入力してください" />
			<label class="text-danger" for="neko_name"></label>
		</td></tr>

		<tr><td>ネコ日付: </td><td>
			<input type="text" name="neko_date" class="valid" value=""  pattern="([0-9]{4})(\/|-)([0-9]{1,2})(\/|-)([0-9]{1,2})" title="日付形式（Y-m-d）で入力してください(例：2012-12-12)" />
			<label class="text-danger" for="neko_date"></label>
		</td></tr>

		<tr><td>ネコグループ: </td><td>
			<select name="neko_group" required title="必須入力です">
				<option value="">-- ネコ種別 --</option>
				<option value="1">ペルシャ</option>
				<option value="2">ボンベイ</option>
				<option value="3">三毛</option>
				<option value="4">シャム</option>
				<option value="5">雉トラ</option>
				<option value="6">スフィンクス</option>
			</select>
			<label class="text-danger" for="neko_group"></label>
		</td></tr>

		<tr><td>ネコ日時: </td><td>
			<input type="text" name="neko_dt" class="valid" value=""  pattern="([0-9]{4})(\/|-)([0-9]{1,2})(\/|-)([0-9]{1,2}) \d{2}:\d{2}:\d{2}" title="日時形式（Y-m-d H:i:s）で入力してください(例：2012-12-12 12:12:12)" />
			<label class="text-danger" for="neko_dt"></label>
		</td></tr>

		<tr><td>備考： </td><td>
			<textarea name="note"  cols="30" rows="4" maxlength="1000" title="1000文字以内で入力してください"></textarea>
			<label class="text-danger" for="note"></label>
		</td></tr>
		<!-- Start ajax_form_new_end -->
	</tbody></table>
	

	<button type="button" onclick="newInpReg();" class="btn btn-success">
		<span class="glyphicon glyphicon-ok"></span>
	</button>

	</div><!-- panel-body -->
</div>



<!-- 編集フォーム -->
<div id="ajax_crud_edit_form" class="panel panel-primary">

	<div class="panel-heading">
		<div class="pnl_head1">編集</div>
		<div class="pnl_head2"></div>
		<div class="pnl_head3">
			<button type="button" class="btn btn-primary btn-sm" onclick="closeForm('edit')"><span class="glyphicon glyphicon-remove"></span></button>
		</div>
	</div>
	<div style="display:none">
    	<input type="hidden" name="sort_no">
	</div>
	<div class="panel-body">
	<div class="err text-danger"></div>
	<table><tbody>

		<!-- Start ajax_form_edit_start -->
		<tr><td>ID: </td><td>
			<span class="id"></span>
		</td></tr>
		
		<tr><td>ネコ数値: </td><td>
			<input type="text" name="neko_val" class="valid" value=""  pattern="^[0-9]+$" maxlength="11" title="数値を入力してください" />
			<label class="text-danger" for="neko_val"></label>
		</td></tr>

		<tr><td>ネコ名: </td><td>
			<input type="text" name="neko_name" class="valid" value=""  maxlength="255" title="255文字以内で入力してください" />
			<label class="text-danger" for="neko_name"></label>
		</td></tr>

		<tr><td>ネコ日付: </td><td>
			<input type="text" name="neko_date" class="valid" value=""  pattern="([0-9]{4})(\/|-)([0-9]{1,2})(\/|-)([0-9]{1,2})" title="日付形式（Y-m-d）で入力してください(例：2012-12-12)" />
			<label class="text-danger" for="neko_date"></label>
		</td></tr>

		<tr><td>ネコグループ: </td><td>
			<div>
				<label><input type="radio" name="neko_group" value="1" />ペルシャ</label>
				<label><input type="radio" name="neko_group" value="2" />ボンベイ</label>
				<label><input type="radio" name="neko_group" value="3" />三毛</label>
				<label><input type="radio" name="neko_group" value="4" />シャム</label>
				<label><input type="radio" name="neko_group" value="5" />雉トラ</label>
				<label><input type="radio" name="neko_group" value="6" />スフィンクス</label>
				<label for="neko_group" ></label>
			</div>
		</td></tr>

		<tr><td>ネコ日時: </td><td>
			<input type="text" name="neko_dt" class="valid" value=""  pattern="([0-9]{4})(\/|-)([0-9]{1,2})(\/|-)([0-9]{1,2}) \d{2}:\d{2}:\d{2}" title="日時形式（Y-m-d H:i:s）で入力してください(例：2012-12-12 12:12:12)" />
			<label class="text-danger" for="neko_dt"></label>
		</td></tr>

		<tr><td>備考： </td><td>
			<textarea name="note"  cols="30" rows="4" maxlength="1000" title="1000文字以内で入力してください"></textarea>
			<label class="text-danger" for="note"></label>
		</td></tr>

		<tr><td>削除： </td><td>
			<input type="checkbox" name="delete_flg" class="valid"  />
		</td></tr>
		<!-- Start ajax_form_edit_end -->
	</tbody></table>
	
	

	<button type="button"  onclick="editReg();" class="btn btn-success">
		<span class="glyphicon glyphicon-ok"></span>
	</button>
	<hr>
	
	<input type="button" value="更新情報" class="btn btn-default btn-xs" onclick="$('#ajax_crud_edit_form_update').toggle(300)" /><br>
	<aside id="ajax_crud_edit_form_update" style="display:none">
		更新日時: <span class="modified"></span><br>
		生成日時: <span class="created"></span><br>
		ユーザー名: <span class="update_user"></span><br>
		IPアドレス: <span class="ip_addr"></span><br>
		ユーザーエージェント: <span class="user_agent"></span><br>
	</aside>
	

	</div><!-- panel-body -->
</div>



<!-- 削除フォーム -->
<div id="ajax_crud_delete_form" class="panel panel-danger">

	<div class="panel-heading">
		<div class="pnl_head1">削除</div>
		<div class="pnl_head2"></div>
		<div class="pnl_head3">
			<button type="button" class="btn btn-default btn-sm" onclick="closeForm('del')"><span class="glyphicon glyphicon-remove"></span></button>
		</div>
	</div>
	
	<div class="panel-body" style="min-width:300px">
	<table><tbody>

		<!-- Start ajax_form_new -->
		<tr><td>ID: </td><td>
			<span class="id"></span>
		</td></tr>
		

		<tr><td>ネコ名: </td><td>
			<span class="neko_name"></span>
		</td></tr>


		<!-- Start ajax_form_end -->
	</tbody></table>
	<br>
	

	<button type="button"  onclick="deleteReg();" class="btn btn-danger">
		<span class="glyphicon glyphicon-remove"></span>　削除する
	</button>
	<hr>
	
	<input type="button" value="更新情報" class="btn btn-default btn-xs" onclick="$('#ajax_crud_delete_form_update').toggle(300)" /><br>
	<aside id="ajax_crud_delete_form_update" style="display:none">
		更新日時: <span class="modified"></span><br>
		生成日時: <span class="created"></span><br>
		ユーザー名: <span class="update_user"></span><br>
		IPアドレス: <span class="ip_addr"></span><br>
		ユーザーエージェント: <span class="user_agent"></span><br>
	</aside>
	

	</div><!-- panel-body -->
</div>


<br />

<!-- 埋め込みJSON -->
<div style="display:none">
	<input id="neko_group_json" type="hidden" value='<?php echo $neko_group_json; ?>' />
</div>



<!-- ヘルプ用  -->
<input type="button" class="btn btn-info btn-sm" onclick="$('#help_x').toggle()" value="ヘルプ" />
<div id="help_x" class="help_x" style="display:none">
	<h2>ヘルプ</h2>

	<?php echo $this->element('CrudBase/crud_base_help');?>


</div>























