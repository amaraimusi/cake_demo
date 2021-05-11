<?php

extract($crudBaseData, EXTR_REFS);

require_once $crud_base_path . 'CrudBaseHelper.php';
$this->CrudBase = new CrudBaseHelper($crudBaseData);
$ver_str = '?v=' . $version; // キャッシュ回避のためのバージョン文字列

// CSSファイルのインクルード
$cssList = CrudBaseU::getCssList();
$cssList[] = 'MsgBoard/index.css' . $ver_str; // 当画面専用CSS
$this->assign('css', $this->Html->css($cssList));

// JSファイルのインクルード
$jsList = CrudBaseU::getJsList();
$jsList[] = 'MsgBoard/MsgBoard.js' . $ver_str; // メッセージボードクラス
$jsList[] = 'MsgBoard/index.js' . $ver_str; // 当画面専用JavaScript
$this->assign('script', $this->Html->script($jsList,['charset'=>'utf-8']));

?>

<div id="err" class="text-danger"></div>

<div id="add_msg_div">
	<div class="row" style="margin-top:40px">
		<div class="col-12 col-md-2"></div>
		<div class="col-12 col-md-8">
			<div class="form-group row">
				<div class="col-12 col-md-9">
					<textarea class="form-control" id="ni_message" style="width:100%;height:40px" placeholder="-- メッセージ --"></textarea>
					
				</div>
				<div class="btn-group col-12 col-md-3">
					<div class="form-group btn-group">
						<button type="button" class="btn btn-outline-secondary" onclick="jQuery('#ni_option_menu').toggle(300);">
							<span class="oi" data-glyph="menu"></span>
						</button>
						
						<button type="button" class="btn btn-primary" onclick="addMsg();"><span class="oi" data-glyph="check">送信</span></button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-12 col-md-2"></div>
	</div>
	<div id="ni_option_menu" class="row" style="display:none">
		<div class="col-12 col-md-2"></div>
		<div class="col-12 col-md-3 " style="width:100%;height:auto">
			<label for="attach_fn" class="fuk_label" >
				<input type="file" id="attach_fn" style="display:none"  />
				<span class='fuk_msg' style="margin-top:20px;font-size:0.8em">ファイルアップロード</span>
			</label>
		</div><!-- col -->
		<div class="col-12 col-md-5">
			<div class="form-group form-check">
				<input type="checkbox" class="form-check-input" id="send_mail_flg">
				<label class="form-check-label" for="send_mail_flg">Eメールも送信します。</label>
			</div>
		</div>
		<div class="col-12 col-md-2"></div>
	</div>
</div>

<!-- メッセージ一覧 -->
<div id="msg_board_list" style="margin-top:60px">
<?php foreach($data as $ent){ ?>
<div class="row entity" data-id="<?php echo $ent['id']; ?>" style="margin-top:24px">
	<div class="col-12 col-md-2"></div>
	<div class="col-12 col-md-8 entity_box1" >
		<div class="text-secondary nickname"><?php echo h($ent['nickname']);?></div>
		<div class="text-md-left message_div"><?php echo h($ent['message']);?></div>
		<div style="width:320px;height:auto;">
		<?php echo $this->CrudBase->filePreviewA($ent['attach_fn']); ?>
		</div>
		<div class="row">
			<div class="col-6">
				<span class="oi" data-glyph="thumb-up" title="いいね"></span>
			</div>
			<div class="col-6 text-right" >
				<button type="button" class="btn btn-outline-secondary btn-sm menu_btn" onclick="showMenu(this)" style="<?php echo $ent['menu_btn']; ?>"><span class="oi" data-glyph="menu"></span></button>
				<div class="menu_div" style="margin-top:4px;display:none">
					
					<button type="button" class="btn btn-outline-dark btn-sm edit_btn" onclick="showEditDiv(this)" style="<?php echo $ent['edit_btn']; ?>" >
						<span class="oi" data-glyph="pencil"></span>編集
					</button>
					<button type="button" class="btn btn-danger btn-sm delete_btn" title="削除" onclick="deleteAction(this)" style="<?php echo $ent['delete_btn']; ?>" >
						<span class="oi" data-glyph="trash"></span>
					</button>
					<span class="oi oi-trash"></span>
					
				</div>
			</div>
		</div>
		<div class="edit_div" class="row" style="display:none">
			<div class="form-group col-12 col-md-9" >
				<textarea class="form-control message_edit_ta" style="width:100%;height:auto;"><?php echo h($ent['message']);?></textarea>
			</div>
			<div class="form-group col-12 col-md-3">
				<button type="button" class="btn btn-warning btn-sm">変更</button>
				<button type="button" class="btn btn-outline-secondary btn-sm" onclick="returnEdit(this)">戻る</button>
			</div>
		</div>
	<div class="col-12 col-md-2"></div>
	</div>
</div>
<?php } ?>

</div>

<input id="crud_base_json" type="hidden" value='<?php echo $crud_base_json; ?>' />
<div class="yohaku"></div>
