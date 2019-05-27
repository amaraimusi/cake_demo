/**
 * 一括緯度経度取得・バッチ処理 Google API版
 * 
 * @note
 * 一括で複数の住所から緯度経度を取得する機能。GoogleのAPIを使用している。
 * 
 * 有料！
 * 一組の緯度経度を取得するごとに$0.006の利用料金が発生するため注意。
 * 
 * @note
 * ReqBatch.jsに依存。
 * ReqBatch.jsは「リクエスト分散バッチ処理」と呼ばれるバッチ処理系のライブラリ
 * 
 * @date 2019-5-4
 * @version 1.0.0
 */
class BulkLatlngBatG{
	
	
	init(){
		this.geocoder = new google.maps.Geocoder(); //Google ジオコーディング
		this.reqBatch = new ReqBatch(); // リクエスト分散バッチ処理
		this.reqBatch.init({
			div_xid:'bllbg_bat',
			start_btn_xid:'bllbg_start',
			interval:600,
			fail_limit:100,
			asyn_cb:this.asynGetLatLng,
			asyn_param:this,
			asyn_res_cb:this.asynRes,
		});
		
		this.param = {}; // パラメータ
		this.data = null; // 対象データ
		
		this.tDiv = jQuery('#bllbg_w');
		this.nowLoadElm = jQuery('#bllbg_now_loding'); // ローディングメッセージ要素
		this.dataCntElm = this.tDiv.find('#bllbg_data_count'); // 対象データ数要素
		this.exeCntElm = this.tDiv.find('#bllbg_exe_count'); // 実行数要素
		this.feeElm = this.tDiv.find('#bllbg_fee'); // 推定料金
		
	}
	
	
	/**
	 * 機能を開くとともに対象データを取得する
	 */
	openAndGetData(){
		
		if(this.tDiv.css('display') == 'none'){
			if(this.data == null){
				this.nowLoadElm.show(); // ローディングメッセージの表示 | 「Now Loading ...」の表示
				this._getDataFromBackend(); // バックエンドから対象データを取得する
			}
			
		}else{
			this.tDiv.hide();
		}

	}
	
	
	/**
	 * バックエンドから対象データを取得する
	 */
	_getDataFromBackend(){

		var sendData={'a':1};
		var send_json = JSON.stringify(sendData);

		// バックエンドから対象データを取得する  | AJAX
		jQuery.ajax({
			type: "POST",
			url: "job/bllbg_get_data",
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
			this.data = res; // レスポンスを対象データにセットする
			var data_count = this.data.length; // 対象データ数を取得
			var exe_count = data_count; // 実行数
			if(exe_count > 1000) exe_count = 1000; // 実行数は1000件を上限とする
			var fee = exe_count * 0.006;
			fee = Math.round(fee * 1000) / 1000; // 切り捨て
			
			// パラメータへセット
			this.param['data_count'] = data_count;
			this.param['exe_count'] = exe_count;
			this.param['fee'] = fee;
			
			// DOM要素への反映
			this.nowLoadElm.hide();
			this.tDiv.show();
			this.dataCntElm.html(data_count);
			this.exeCntElm.val(exe_count);
			this.feeElm.html(fee);
			
		})
		.fail((jqXHR, statusText, errorThrown) => {
			jQuery('#err').append('アクセスエラー');
			console.log(jqXHR.responseText);
			alert(statusText);
		});
	}
	
	
	/**
	 * バッチ処理開始
	 */
	start(){
		
		var exe_count = this.exeCntElm.val();
		if(!exe_count.match(/^[0-9]*$/)){
			alert('半角数字を入力してください。');
			return;
		}
		this.param['exe_count'] = exe_count;
		
		var data = this.data;
		data = this._removeOverData(data, exe_count); // データを実行数だけにする | 多すぎる分は除去

		// バッチ処理開始
		this.reqBatch.start(data);

	}
	
	
	/**
	 * データを実行数だけにする | 多すぎる分は除去
	 * @param array data 対象データ
	 * @param int exe_count 実行数
	 * @return array 実行数まで除去したデータ
	 */
	_removeOverData(data, exe_count){
		var data2 = [];
		if(data.length > exe_count){
			for(var i=0; i<exe_count; i++){
				var ent = data[i];
				data2.push(ent);
			}	
		}else{
			data2 = data;
		}
		return data2;
	}

	
	/**
	 * 非同期処理のレスポンスコールバック
	 * @param object res 非同期処理のレスポンスデータ
	 */
	asynRes(res){
		console.log(res);
	}
	
	
	/**
	 * 外・非同期処理 | Googleジオコーダで住所から緯度経度を取得
	 * @param index インデックス
	 * @param ent エンティティ
	 */
	asynGetLatLng(index, ent, param){

		var self = param;
		var address = ent.address; // 住所

		self.geocoder.geocode({address: address}, (results, status) => {
				if (status === 'OK' && results[0]){
					var result = results[0];
					
					ent['full_address'] = result.formatted_address; // 正規住所

					ent['place_id'] = result.place_id; // プレースID
					
					// 緯度経度
					ent['lat'] = result.geometry.location.lat();
					ent['lng'] = result.geometry.location.lng();
					
					self._saveToDb(ent); // DBに保存する

					
				}else{
					var fail_msg = `「${address}」の緯度経度は見つかりませんでした。:` + status;
					self.reqBatch.asynFail(fail_msg); // 非同期処理・失敗

				}
			});
		
	}
	
	
	/**
	 * DBに保存する
	 * @param object ent;
	 */
	_saveToDb(ent){
		
		var ent = this._ampTo26(ent); // _データ中の「&」を「%26」に一括エスケープ

		// 送信データ
		var sendData = ent;
		var send_json = JSON.stringify(sendData);//データをJSON文字列にする。

		// AJAX
		jQuery.ajax({
			type: "POST",
			url: "job/bllbg_save",
			data: "key1=" + send_json,
			cache: false,
			dataType: "text",
		})
		.done((res_json, type) => {
			var res;
			try{
				res =jQuery.parseJSON(res_json);//パース
			}catch(e){
				this.reqBatch.asynFail(res_json); // 非同期処理・失敗
				return;
			}
			this.reqBatch.asynSuccess(ent); // 非同期処理・成功
			
		})
		.fail((jqXHR, statusText, errorThrown) => {
			jQuery('#err').append('アクセスエラー');
			console.log(jqXHR.responseText);
			alert(statusText);
		});
	}
	
	
	/**
	 * データ中の「&」を「%26」に一括エスケープ
	 * @note
	 * PHPのJSONデコードでエラーになるので、＆記号を「%26」に変換する
	 * 
	 * @param mixed data エスケープ対象 :文字列、オブジェクト、配列を指定可
	 * @returns エスケープ後
	 */
	_ampTo26(data){
		if (typeof data == 'string'){
			if ( data.indexOf('&') != -1) {
				return data.replace(/&/g, '%26');
			}else{
				return data;
			}
		}else if (typeof data == 'object'){
			for(var i in data){
				data[i] = this._ampTo26(data[i]);
			}
			return data;
		}else{
			return data;
		}
	}
	
	

}