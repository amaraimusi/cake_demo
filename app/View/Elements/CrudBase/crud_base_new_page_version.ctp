<?php 
if(!empty($new_version_flg)){
?>
<div style="padding:10px;background-color:#fac9cc">
	<div>新バージョン：<?php echo $this_page_version ?></div>
	<div class="text-danger">当画面は新しいバージョンに変更されています。
	セッションクリアボタンを押してください。</div>
	<input type="button" class="btn btn-danger btn-xs" value="セッションクリア" onclick="sessionClear()" >
</div>
<?php 
}
?>