/**
 * 一括緯度経度取得・バッチ処理 Yahoo API版
 * 
 * @note
 * ReqBatch.jsに依存。
 * ReqBatch.jsは「リクエスト分散バッチ処理」と呼ばれるバッチ処理系のライブラリ
 * 
 * @date 2019-4-26
 * @version 1.0.0
 */
class BulkLatlngBatY{
	
	
	init(){
		this.reqBatch = new ReqBatch(); // リクエスト分散バッチ処理
		this.reqBatch.init({
			div_xid:'bulk_latlng_bat_y',
			start_btn_xid:'bulk_latlng_bat_start_btn',
			interval:600,
			fail_limit:100,
			ajax_url:'job/bulk_latlng_bat',
			asyn_res_cb:this.asynRes,
		});
	}
	
	
	/**
	 * バッチ処理開始
	 */
	start(){

		var sendData = {a:'1'};
		var send_json = JSON.stringify(sendData);//データをJSON文字列にする。

		// AJAX
		jQuery.ajax({
			type: "POST",
			url: "job/bulk_latlng_bat_get_jobs",
			data: "key1=" + send_json,
			cache: false,
			dataType: "text",
		})
		.done((res_json, type) => {
			var res;
			try{
				res =jQuery.parseJSON(res_json);//パース
			}catch(e){
				jQuery("#err").append(res_json);
				return;
			}
			console.log(res);
			var data = res; // 緯度経度が空の求人データ
			
			// ★  バッチ処理開始
			this.reqBatch.start(data);
			
		})
		.fail((jqXHR, statusText, errorThrown) => {
			jQuery('#err').append('アクセスエラー');
			jQuery('#err').append(jqXHR.responseText);
			alert(statusText);
		});
		
		
	}

	
	/**
	 * 非同期処理のレスポンスコールバック
	 * @param object res 非同期処理のレスポンスデータ
	 */
	asynRes(res){
		console.log(res);//■■■□□□■■■□□□■■■□□□)
	}

}