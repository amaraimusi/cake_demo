<div style="margin-top:10px;margin-bottom:10px">
	<label for="pwms_all_select">すべてチェックする <input type="checkbox" name="pwms_all_select" onclick="pwms.switchAllSelection(this);" /></label>
	<button type="button" onclick="pwms.action(10)" class="btn btn-success btn-xs">有効</button>
	<button type="button" onclick="pwms.action(11)" class="btn btn-danger btn-xs">削除</button>
	<aside>
		※ID列の左側にあるチェックボックスにチェックを入れてから「削除」ボタンを押すと、まとめて削除されます。<br>
		削除の復元は画面下側のヘルプボタンを参照してください。<br>
	</aside>
</div>