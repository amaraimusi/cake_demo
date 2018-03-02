/**
 * CrudBase 自動保存機能
 * @version 1.0
 * @date 2018-3-2
 */
class CrudBaseAutoSave{
	
	
	/**
	 * コンストラクタ
	 * @param crudBase CrudBaseオブジェクト
	 */
	constructor(crudBase){
		console.log('CrudBaseAutoSave２');//■■■□□□■■■□□□■■■□□□■■■)

		this.crudBase = crudBase; // Htmlテーブルからデータを取得する関数
		this.fieldData = crudBase.fieldData;
		this.tbl = crudBase.tbl;
		this.save_status = 0; // 保存状態フラグ 0:待機 , 1:保存中 ,2:依頼
		this.msgElm = jQuery('#crud_base_auto_save_msg'); // 自動保存メッセージ要素

	}
	
	/**
	 * 保存依頼
	 * 
	 * @note
	 * HTMLテーブルのデータをバックグランドで自動保存する。
	 */
	saveRequest(){
		
		// 保存中であるなら、保存状態フラグを「依頼」にして処理抜け。
		if(this.save_status == 1){
			this.save_status = 2;
			return;
		}
		
		// 保存状態フラグが依頼であるなら、すでに次の保存処理を行う予定になっているので処理抜け。
		else if(this.save_status == 2){
			return;
		}
		
		// バックグラウンドで自動保存を実行する。(数秒後の遊びを設ける）
		window.setTimeout(()=>{
			this._autoSave();
		}, 1);// ■■■□□□■■■□□□■■■□□□■■■後程3000に変更
		
		
		
	}
	
	/**
	 * 自動保存処理
	 */
	_autoSave(){
	
		this.msgElm.html('保存中...');
		var data = this.crudBase.getDataHTbl();// Htmlテーブルからデータを取得
		data = this.crudBase.escapeForAjax(data); // Ajax送信データ用エスケープ。実体参照（&lt; &gt; &amp; &）を記号に戻す。
		var json_str = JSON.stringify(data);//データをJSON文字列にする。
		var url = this.crudBase.param.auto_save_url; // 自動保存サーバーURL
		
		// AJAX
		jQuery.ajax({
			type: "POST",
			url: url,
			data: "key1="+json_str,
			cache: false,
			dataType: "text",
		})
		.done((str_json, type) => {
			var res;
			try{
				res =jQuery.parseJSON(str_json);
				this.msgElm.html('');
			}catch(e){
				this.msgElm.html('自動保存のエラー1');
				jQuery("#err").html(str_json);
				return;
			}
		})
		.fail((jqXHR, statusText, errorThrown) => {
			this.msgElm.html('自動保存のエラー2');
			jQuery('#err').html(jqXHR.responseText);
		});
		
	}
	
}