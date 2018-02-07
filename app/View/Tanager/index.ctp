<?php
$this->CrudBase->setModelName('Tanager');

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
		'AjaxCRUD',						// AjaxによるCRUD
		'livipage',						// ページ内リンク先プレビュー
		'ProcessWithMultiSelection',	// 一覧のチェックボックス複数選択による一括処理
		'CrudBase/ImportFu.js',			// インポート・ファイルアップロードクラス
		'CrudBase/index',				// CRUD indexページ共通
		'Tanager/index'					// 当画面専用JavaScript
),array('charset'=>'utf-8')));
	
	
?>




<h2>タナガー</h2>

タナガーの検索閲覧および編集する画面です。<br>
<br>

<?php
	$this->Html->addCrumb("トップ",'/');
	$this->Html->addCrumb("タナガー");
	echo $this->Html->getCrumbs(" > ");
?>

<?php echo $this->element('CrudBase/crud_base_new_page_version');?>
<div id="err" class="text-danger"><?php echo $errMsg;?></div>


<!-- 検索条件入力フォーム -->
<div style="margin-top:5px">
	<?php 
		echo $this->Form->create('Tanager', array('url' => true ));
	?>

	
	<div style="clear:both"></div>
	
	<div id="detail_div" style="display:none">
		
		<?php 
		
		// --- Start kj_input
		$this->CrudBase->inputKjText($kjs,'kj_tanager_name','タナガー名前',300);
		$this->CrudBase->inputKjNengetu($kjs,'kj_tanager_date','タナガー日付');
		$this->CrudBase->inputKjId($kjs); 
		$this->CrudBase->inputKjNouislider($kjs,'tanager_val','タナガー数値'); 
		$this->CrudBase->inputKjSelect($kjs,'kj_tanager_group','タナガー種別',$tanagerGroupList); 
		$this->CrudBase->inputKjText($kjs,'kj_tanager_dt','タナガー日時',150); 
		$this->CrudBase->inputKjText($kjs,'kj_note','備考',200,'部分一致検索'); 
		$this->CrudBase->inputKjDeleteFlg($kjs);
		echo "<div style='clear:both'></div>";
		$this->CrudBase->inputKjText($kjs,'kj_update_user','更新者',150);
		$this->CrudBase->inputKjText($kjs,'kj_ip_addr','更新IPアドレス',200);
		$this->CrudBase->inputKjCreated($kjs);
		$this->CrudBase->inputKjModified($kjs);
		echo "<div style='clear:both'></div>";
		$this->CrudBase->inputKjLimit($kjs);
		// --- End kj_input
		echo $this->Form->submit('検索', array('name' => 'search','class'=>'btn btn-success','div'=>false,));
		
		echo $this->element('CrudBase/crud_base_index');
		
		$csv_dl_url = $this->html->webroot . 'tanager/csv_download';
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

<!-- 一覧テーブル -->
<table id="tanager_tbl" border="1"  class="table table-striped table-bordered table-condensed">

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
	$this->CrudBase->tdMoney($ent,'tanager_val');
	$this->CrudBase->tdStr($ent,'tanager_name');
	$this->CrudBase->tdList($ent,'tanager_group',$tanagerGroupList);
	$this->CrudBase->tdPlain($ent,'tanager_date');
	$this->CrudBase->tdPlain($ent,'tanager_dt');
	$this->CrudBase->tdNote($ent,'note');
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
	$this->CrudBase->rowEditBtn($id);
	$this->CrudBase->rowPreviewBtn($id);
	$this->CrudBase->rowDeleteBtn($id);
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
			<button type="button" class="btn btn-primary btn-sm" onclick="ajaxCrud.closeForm('new_inp')"><span class="glyphicon glyphicon-remove"></span></button>
		</div>
	</div>
	<div class="panel-body">
	<div class="err text-danger"></div>
	<table><tbody>

		<!-- Start ajax_form_new_start -->
		<tr><td>タナガー数値: </td><td>
			<input type="text" name="tanager_val" class="valid" value=""  pattern="^[0-9]+$" maxlength="11" title="数値を入力してください" />
			<label class="text-danger" for="tanager_val"></label>
		</td></tr>

		<tr><td>タナガー名: </td><td>
			<input type="text" name="tanager_name" class="valid" value=""  maxlength="255" title="255文字以内で入力してください" />
			<label class="text-danger" for="tanager_name"></label>
		</td></tr>

		<tr><td>タナガー日付: </td><td>
			<input type="text" name="tanager_date" class="valid" value=""  pattern="\d{4}-\d{2}-\d{2}" title="日付形式（Y-m-d）で入力してください(例：2012-12-12)" />
			<label class="text-danger" for="tanager_date"></label>
		</td></tr>

		<tr><td>タナガーグループ: </td><td>
			<select name="tanager_group" required title="必須入力です">
				<option value="">-- タナガー種別 --</option>
				<option value="1">ペルシャ</option>
				<option value="2">ボンベイ</option>
				<option value="3">三毛</option>
				<option value="4">シャム</option>
				<option value="5">雉トラ</option>
				<option value="6">スフィンクス</option>
			</select>
			<label class="text-danger" for="tanager_group"></label>
		</td></tr>

		<tr><td>タナガー日時: </td><td>
			<input type="text" name="tanager_dt" class="valid" value=""  pattern="\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}" title="日時形式（Y-m-d H:i:s）で入力してください(例：2012-12-12 12:12:12)" />
			<label class="text-danger" for="tanager_dt"></label>
		</td></tr>

		<tr><td>備考： </td><td>
			<textarea name="note"  cols="30" rows="4" maxlength="1000" title="1000文字以内で入力してください"></textarea>
			<label class="text-danger" for="note"></label>
		</td></tr>
		<!-- Start ajax_form_new_end -->
	</tbody></table>
	

	<button type="button" onclick="newInpRegRap();" class="btn btn-success">
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
			<button type="button" class="btn btn-primary btn-sm" onclick="ajaxCrud.closeForm('edit')"><span class="glyphicon glyphicon-remove"></span></button>
		</div>
	</div>
	<div class="panel-body">
	<div class="err text-danger"></div>
	<table><tbody>

		<!-- Start ajax_form_edit_start -->
		<tr><td>ID: </td><td>
			<span class="id"></span>
		</td></tr>
		
		<tr><td>タナガー数値: </td><td>
			<input type="text" name="tanager_val" class="valid" value=""  pattern="^[0-9]+$" maxlength="11" title="数値を入力してください" />
			<label class="text-danger" for="tanager_val"></label>
		</td></tr>

		<tr><td>タナガー名: </td><td>
			<input type="text" name="tanager_name" class="valid" value=""  maxlength="255" title="255文字以内で入力してください" />
			<label class="text-danger" for="tanager_name"></label>
		</td></tr>

		<tr><td>タナガー日付: </td><td>
			<input type="text" name="tanager_date" class="valid" value=""  pattern="\d{4}-\d{2}-\d{2}" title="日付形式（Y-m-d）で入力してください(例：2012-12-12)" />
			<label class="text-danger" for="tanager_date"></label>
		</td></tr>

		<tr><td>タナガーグループ: </td><td>
			<div>
				<label><input type="radio" name="tanager_group" value="1" />ペルシャ</label>
				<label><input type="radio" name="tanager_group" value="2" />ボンベイ</label>
				<label><input type="radio" name="tanager_group" value="3" />三毛</label>
				<label><input type="radio" name="tanager_group" value="4" />シャム</label>
				<label><input type="radio" name="tanager_group" value="5" />雉トラ</label>
				<label><input type="radio" name="tanager_group" value="6" />スフィンクス</label>
				<label for="tanager_group" ></label>
			</div>
		</td></tr>

		<tr><td>タナガー日時: </td><td>
			<input type="text" name="tanager_dt" class="valid" value=""  pattern="\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}" title="日時形式（Y-m-d H:i:s）で入力してください(例：2012-12-12 12:12:12)" />
			<label class="text-danger" for="tanager_dt"></label>
		</td></tr>

		<tr><td>備考： </td><td>
			<textarea name="note"  cols="30" rows="4" maxlength="1000" title="1000文字以内で入力してください"></textarea>
			<label class="text-danger" for="note"></label>
		</td></tr>

		<tr><td>無効： </td><td>
			<input type="checkbox" name="delete_flg" class="valid"  />
		</td></tr>
		<!-- Start ajax_form_edit_end -->
	</tbody></table>
	
	

	<button type="button"  onclick="editRegRap();" class="btn btn-success">
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
			<button type="button" class="btn btn-default btn-sm" onclick="ajaxCrud.closeForm('delete')"><span class="glyphicon glyphicon-remove"></span></button>
		</div>
	</div>
	
	<div class="panel-body" style="min-width:300px">
	<table><tbody>

		<!-- Start ajax_form_new -->
		<tr><td>ID: </td><td>
			<span class="id"></span>
		</td></tr>
		

		<tr><td>タナガー名: </td><td>
			<span class="tanager_name"></span>
		</td></tr>


		<!-- Start ajax_form_end -->
	</tbody></table>
	<br>
	

	<button type="button"  onclick="ajaxCrud.deleteReg();" class="btn btn-danger">
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





<!-- ヘルプ用  -->
<input type="button" class="btn btn-info btn-sm" onclick="$('#help_x').toggle()" value="ヘルプ" />
<div id="help_x" class="help_x" style="display:none">
	<h2>ヘルプ</h2>

	<?php echo $this->element('CrudBase/crud_base_help');?>


</div>























