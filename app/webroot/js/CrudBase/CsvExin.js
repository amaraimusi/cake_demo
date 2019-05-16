/**
 * 専属CSV読込 csv_exin
 * 
 * @date 2019-4-7 | 2019-5-16
 * @version 1.0.1
 * 
 */
class CsvExin{
	
	
	/**
	 * 初期化
	 * @param array csvFieldData CSVフィールドデータ
	 * @param object csvParam CSVパラメータ
	 *  - ajax_url AJAX通信先URL
	 */
	init(csvFieldData, csvParam){

		this.mainElm = jQuery('#csv_exin');
		this.csvFieldData = csvFieldData;
		this.csvParam = this._setParamIfEmpty(csvParam); // CSVパラメータ
		this.data; // CSVデータ
		
		// 各種フォーム要素を埋め込む
		var html = `
			<div id="csv_exin_step1">
				<label><input type="radio" name="csv_exin_str_code" value='utf-8' />UTF-8</label>
				<label><input type="radio" name="csv_exin_str_code" value='Shift_JIS' />Shift-Jis(ExcelのCSV)</label>
				<input id="csv_exin_file" type="file" multiple disabled>
			</div>
			<aside>基本的に上書きでDB登録されますが、idが空のレコードもしくはDBに存在しないidのレコードは「新規追加」になります。</aside>
			<div id="csv_exin_step2" style="display:none">
				<input id="csv_bulk_reg_btn" type="button" value="一括登録" class="btn btn-danger btn-sm" />
				<input id="csv_exin_retry_btn" type="button" value="やり直し" class="btn btn-default btn-xs" />
			</div>
			<div id="csv_exin_err" style="color:red"></div>
			<div id="csv_exin_success" class="text-success"></div>
			<div id="csv_exin_preview" style="overflow:auto;height:400px;display:none"></div>
		`;
		this.mainElm.html(html);
		
		this.bulkRegBtn = this.mainElm.find('#csv_bulk_reg_btn');
		
		// 文字コードラジオボタンのクリックイベントを追加
		this._addEventStrCodeRadioClick();
		
		// 「やり直し」ボタンにクリックイベントを追加
		this._addEventRetryBtn();

		// ファイルのチェンジイベントを追加
		this._addEventFileChange();
		
		// 一括登録ボタンのクリックイベントを追加
		this._addEventBulkReg();

	}
	
	
	/**
	 * If Param property is empty, set a value.
	 */
	_setParamIfEmpty(param){
		
		if(param == null)　param = {};
		
		if(param['ajax_url'] == null) param['ajax_url'] = 'dummy';
		
		return param;
	}
	
	
	/**
	 * ファイルのチェンジイベントを追加
	 */
	_addEventFileChange(){
		
		// ▼ CSVファイルのアップロードイベント
		this.mainElm.find('#csv_exin_file').change((e)=> {
			
			//ファイルオブジェクト配列を取得（配列要素数は選択したファイル数を表す）
			var files = e.target.files;
			var fileObj = files[0];
			
			//ファイルリーダーにファイルオブジェクトを渡すと、ファイル読込完了イベントなどをセットする。
			var reader = new FileReader();
			
			reader.readAsText(fileObj, this.csvParam.str_code);
			
			//ファイル読込完了イベント
			reader.onload = (evt) => {
				
				// CSVテキストを取得する
				var csv_text = evt.target.result;
				
				// プレビュー表示
				this._preview(csv_text);

			}
		});
	}
	
	
	/**
	 *  一括登録ボタンのクリックイベントを追加
	 */
	_addEventBulkReg(){
		
		this.mainElm.find("#csv_bulk_reg_btn").click((evt)=>{
			this._bulkReg();
		});
		
	}
	
	/**
	 * プレビュー表示
	 * @param string CSVテキスト
	 */
	_preview(csv_text){
		
		var csvFieldData = this.csvFieldData;
		var csvParam = this.csvParam;
		
		this._errShow(''); // エラー表示をクリア
		
		// 表示区分の切替
		this.mainElm.find('#csv_exin_step1').hide();
		this.mainElm.find('#csv_exin_step2').show();

		// CSVテキストを2次元配列に変換する
		var d2ary = this._csvTextToData(csv_text);
		
		// 2次元配列のチェック
		var err_msg = this._checkD2ary(d2ary);
		if(err_msg){
			this._errShow(err_msg);
			return;
		}else{
			this.bulkRegBtn.show(); // 一括登録ボタンを表示
		}
		
		// 列ヘッダーフラグとID列フラグを取得する
		var res = this._getClmHederFlgEtc(d2ary, csvFieldData);
		csvParam['clm_header_flg'] = res.clm_header_flg; // 列ヘッダーフラグ ← 1:CSVデータに列名が存在する
		csvParam['id_clm_flg'] = res.id_clm_flg; // ID列フラグ ← 一番左側の列はid列
		
		// 2次元配列からデータを作成
		var data = this._createDataFromD2ary(d2ary, csvFieldData, csvParam);
		this.data = data; // 送信のために保持する。
		
		// XSSサニタイズ
		var data2 = $.extend(true, {}, data); // クローン
		data2 = this._xss_sanitize(data2);
		
		// HTMLテーブルを組み立て表示
		var table_html = this._makeTableHtml(data2, csvFieldData);
		var previewElm = this.mainElm.find('#csv_exin_preview');
		previewElm.show();
		previewElm.html(table_html);
		
	}
	
	/**
	 * 列ヘッダーフラグとID列フラグを取得する
	 * @param array d2ary 2次元配列
	 * @param array csvFieldData CSVフィールドデータ
	 * @return object
	 *  - clm_header_flg 列ヘッダーフラグ ← 1:CSVデータに列名が存在する
	 *  - id_clm_flg ID列フラグ ← 一番左側の列はid列
	 */
	_getClmHederFlgEtc(d2ary, csvFieldData){
		
		var res = {
				'clm_header_flg': 0,  // 列ヘッダーフラグ
				'id_clm_flg': 0,  // ID列フラグ
		}
		
		var c1 = d2ary[0][0]; // 先頭行の1番目を取得
		
		// 先頭行の1列目は数値である。
		if(isNaN(c1) == false){
			res.id_clm_flg = 1;
			return res;
		}
		
		// 先頭行の1列名はidである。
		if(c1.toLowerCase() == 'id'){
			res.clm_header_flg = 1;
			res.id_clm_flg = 1;
			return res;
		}
		
		// 先頭行の1列目はCSVフィールドデータの列名2である。
		var wamei2 = csvFieldData[1]['wamei'];
		if(c1 == wamei2){
			res.clm_header_flg = 1;
			return res;
		}
		
		// 先頭行の1番目は上記以外である。
		return res;
	}
	
	/**
	 * 2次元配列からデータを作成
	 * @param array d2ary 2次元配列
	 * @param array csvFieldData CSVフィールドデータ
	 * @param object csvParam CSVパラメータ
	 */
	_createDataFromD2ary(d2ary, csvFieldData, csvParam){
		
		var data = [];

		var clm_header_flg = csvParam.clm_header_flg; // 列ヘッダーフラグ
		var id_clm_flg = csvParam.id_clm_flg; // ID列フラグ
		
		
		for(var i in d2ary){
			
			var ent = {};
			
			// 列ヘッダーフラグがON（列行が存在する）なら飛ばす
			if(i == 0 && clm_header_flg == 1){
				continue;
			}
			
			var d1ary = d2ary[i];

			for(var c_i in csvFieldData){

				var cfEnt = csvFieldData[c_i];
				if(id_clm_flg==0){
					if(c_i==0){
						ent['id'] = null;
					}else{
						ent[cfEnt.field] = d1ary[c_i - 1];
					}
				}else{
					ent[cfEnt.field] = d1ary[c_i];
				}
			}
			
			data.push(ent);

		}

		return data;
		
	}
	
	
	/**
	 * 文字コードラジオボタンのクリックイベントを追加
	 */
	_addEventStrCodeRadioClick(){
		this.mainElm.find("input[name='csv_exin_str_code']").click((evt)=>{
			
			var btnElm = $(evt.currentTarget);
			this.csvParam['str_code'] = btnElm.val();
			
			this.mainElm.find('#csv_exin_file').prop('disabled', false);
			
		});
	}
	

	/**
	 *  「やり直し」ボタンにクリックイベントを追加
	 */
	_addEventRetryBtn(){
		this.mainElm.find("#csv_exin_retry_btn").click((evt)=>{
			
			// 表示区分の切替
			this.mainElm.find('#csv_exin_file').val('');
			this.mainElm.find('#csv_exin_step1').show();
			this.mainElm.find('#csv_exin_step2').hide();
			this.mainElm.find('#csv_exin_err').html('');
			var previewElm = this.mainElm.find('#csv_exin_preview');
			previewElm.hide();
			previewElm.html('');
			
		});
	}
	
	
	/**
	 * CSVテキストを2次元配列に変換する
	 * @note
	 * ExcelのCSVに対応
	 * ダブルクォート内の改行に対応
	 * 「""」エスケープに対応
	 * 
	 * @param string csv_text CSVテキスト
	 * @returns array 2次元配列
	 */
	_csvTextToData(csv_text){
		
		if(csv_text=='' || csv_text==null) return null;
		
		// CSVテキストの末尾が改行でないければ改行を付け足す。
		var last = csv_text[csv_text.length - 1];
		if(!last.match(/\r|\n/)){
			csv_text += "\n";
		}
		
		var data = [];
		var len = csv_text.length;
		var enclose = 0; // ダブルクォート囲み状態フラグ  0:囲まれていない , 1:囲まれている
		var cell = '';
		var row = [];

		for(var i=0; i<len; i++){
			
			var one = csv_text[i];
			
			// ダブルクォートで囲まれていない
			if(enclose == 0){
				if(one == '"'){
					enclose = 1; // 囲み状態にする
				}
				else if(one == ','){
					row.push(cell);
					cell = '';
				}
				else if(one.match(/\r|\n/)){
					row.push(cell);
					data.push(row);
					cell = '';
					row = [];
					
					// 次も改行文字ならインデックスを飛ばす
					if(i < len - 1){
						var ns = csv_text[i+1];
						if(ns.match(/\r|\n/)){
							i++;
						}
					}
				}else{
					cell += one;
				}
			}
			
			// ダブルクォートで囲まれている
			else{
				if(one == '"'){
					if(i < len - 1){
						var s2 = one + csv_text[i + 1]; // 2文字分を取得
						// 2文字が「""」であるなら、一つの「"」とみなす。
						if(s2 == '""'){
							cell += '"';
							i++;
						}else{
							enclose = 0; // 囲み状態を解除する
						}
					}
					
				}
				else{
					cell += one;
				}
			}
			
		}
		return data;
	}
	
	
	/**
	 * 2次元配列のチェック
	 * @param array CSVテキストから取得した2次元配列
	 * @return string err_msg エラーメッセージ → エラーがなければnullを返す
	 */
	_checkD2ary(d2ary){
		if(d2ary == null) return 'CSVのデータが空です。';
		if(d2ary.length == 0) return 'CSVのデータが空です。';
		if(d2ary[0].length == 0) return '対象のCSVファイルではありません。';
		if(d2ary[0].length == 1) return '対象のCSVファイルではありません。';
		return null;
		
	}


	/**
	 * HTMLテーブルのhtmlを作成
	 * @param array data 2次元配列データ
	 * @param array csvFieldData CSVフィールドデータ
	 * @return string テーブルのhtml
	 */
	_makeTableHtml(data, csvFieldData){
		var html = "<table id='csv_exin_table' class='tbl2' style='white-space:nowrap;'>";
		
		// 列部分を組み立て
		html += "<thead><tr>";
		for(var c_i in csvFieldData){
			var cfEnt = csvFieldData[c_i];
			html += "<th>" + cfEnt.wamei + "</th>";
		}
		html += "</tr></thead><tbody>";
		
		for(var i in data){
			var ent = data[i];
			html += "<tr>";
			for(var e_i in ent){
				var value = ent[e_i];
				if(typeof value == 'string'){
					value = value.replace(/\r\n|\r|\n/g, '<br>');
				}
				if(value==null) value='';
				html += '<td>' + value + '</td>';
			}
			html += "</tr>";
			
		}
		html += "</tbody></table>";
		return html;
	}

	 
	/**
	 * XSSサニタイズ
	 * 
	 * @note
	 * 「<」と「>」のみサニタイズする
	 * 
	 * @param any data サニタイズ対象データ | 値および配列を指定
	 * @returns サニタイズ後のデータ
	 */
	_xss_sanitize(data){
		if(typeof data == 'object'){
			for(var i in data){
				data[i] = this._xss_sanitize(data[i]);
			}
			return data;
		}
		
		else if(typeof data == 'string'){
			return data.replace(/</g, '&lt;').replace(/>/g, '&gt;');
		}
		
		else{
			return data;
		}
	}
	
	/**
	 * エラーメッセージを表示
	 * @param string err_msg エラーメッセージ
	 */
	_errShow(err_msg){
		this.mainElm.find('#csv_exin_err').html(err_msg);
		this.bulkRegBtn.hide();
	}
	
	
	/**
	 * 一括登録処理
	 */
	_bulkReg(){

		var csvParam = this.csvParam;
		var data = this.data;
		
		// データ中の「&」を「%26」に一括エスケープ
		data = this._ampTo26(data);
		
		// AJAX送信データ
		var sendData = {
				data:data,
				csvFieldData:this.csvFieldData,
				csvParam:this.csvParam,
		}

		var send_json = JSON.stringify(sendData);//データをJSON文字列にする。
		
		this.mainElm.find('#csv_exin_success').html('登録中です...');
		
		// AJAX
		jQuery.ajax({
			type: "POST",
			url: csvParam.ajax_url,
			data: "key1=" + send_json,
			cache: false,
			dataType: "text",
		})
		.done((res_json, type) => {
			var res;
			try{
				res =jQuery.parseJSON(res_json);//パース
				console.log(res);
				location.reload(true);

			}catch(e){
				this._errShow(res_json);
				return;
			}
			console.log(res);
		})
		.fail((jqXHR, statusText, errorThrown) => {
			this._errShow(jqXHR.responseText);
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