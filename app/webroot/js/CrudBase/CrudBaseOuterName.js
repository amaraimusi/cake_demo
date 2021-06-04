/**
 * 外部名称クラス： 外部idに紐づく外部テーブルの名前要素を制御
 * @since 2021-6-2
 * @license MIT
 * @version 1.0.0
 */
class CrudBaseOuterName{

	/**
	 * 初期化
	 * @param {} crudBaseData
	 * @param [{}] data 外部名称データ
	 * 	- string unique_code 一意コード：
	 *		「アクションメソッド_フォーム種別_IDフィールド」のパターンで書くと下記パラメータを省略できる。例→kj_en_sp_id, edit_en_sp_id, ni_en_sp_id
	 * 	- string wamei 和名
	 * 	- string outer_id_slt	外部ID要素のセレクタ（省略可）。例→#slt-kj_en_sp_id-outer_id
	 * 	- string outer_name_slt	外部名称要素のセレクタ（省略可）。例→#kj_en_sp_id-outer_name
	 * 	- string outer_show_btn_slt	外部名称表示母田ののセレクタ（省略可）。例→#kj_en_sp_id-outer_show_btn
	 * 	- string form_type	フォーム種別（省略可）。例→kj, edit, ni(new_inp)
	 */
	init(crudBaseData, data, option){
		
		this.crudBaseData = crudBaseData;
		this.csrf_token = crudBaseData.csrf_token;
		
		// 省略されている値をセットする。
		data = this._setValueIfEmpty(data);
		console.log(data);//■■■□□□■■■□□□
		
		this.data = data;
		
		if(option == null) option = {};
		if(option['ajax_action_method'] == null ) option['ajax_action_method'] = 'getOuterName';
		this.option = option;
		
		this.box = this._createBox(data);

	}
	
	
	_createBox(data){
		let box = {};
		
		for(let i in data){
			let ent = data[i];
			let unique_code = ent['unique_code'];
			let boxEnt = {};
			
			boxEnt['ent'] = ent;

			let outerIdElm = jQuery(ent['outer_id_slt']);
			if(outerIdElm[0] == null) throw new Error('CBCN0604F nothing→' + ent['outer_id_slt']);
			boxEnt['outerIdElm'] = outerIdElm;

			let outerNameElm = jQuery(ent['outer_name_slt']);
			if(outerNameElm[0] == null) throw new Error('CBCN0604F nothing→' + ent['outer_name_slt']);
			boxEnt['outerNameElm'] = outerNameElm;

			let outerShowBtnElm = jQuery(ent['outer_show_btn_slt']);
			if(outerShowBtnElm[0] == null) throw new Error('CBCN0604F nothing→' + ent['outer_show_btn_slt']);
			boxEnt['outerShowBtnElm'] = outerShowBtnElm;
			
			box[unique_code] = boxEnt;
			
		}
		
		console.log(box);//■■■□□□■■■□□□
		
		return box;
	}
	
	
	// 省略されている値をセットする。
	_setValueIfEmpty(data){
		
		for(let i in data){
			let ent = data[i];
			if(ent['unique_code'] == null) throw new Error('CBON0604D i=' + i);
			let unique_code = ent['unique_code'];
			if(ent['wamei'] == null) ent['wamei'] = '';
			if(ent['outer_id_slt'] == null) ent['outer_id_slt'] = '.OuterName-' + unique_code + '-outer_id';
			if(ent['outer_name_slt'] == null) ent['outer_name_slt'] = '.OuterName-' + unique_code + '-outer_name';
			if(ent['outer_show_btn_slt'] == null) ent['outer_show_btn_slt'] = '.OuterName-' + unique_code + '-outer_show_btn';
			if(ent['form_type'] == null) ent['form_type'] = this._extactFromType(unique_code);
		}
		
		return data;
	}
	
	
	// フォーム種別を一意コードから抽出する。
	_extactFromType(unique_code){
		let ary = unique_code.split('_');
		let form_type = ary[0];
		
		switch(form_type){
			case 'kj':
				break;
			case 'edit':
				break;
			case 'ni':
				form_type = 'new_inp'
				break;
			case 'new_inp':
				break;
			default:
				throw new Error('CBON210604E');
		}
		
		return form_type;
	}
	
	
	
	/**
	 * 外部idに紐づく外部テーブルの名前フィールドを取得する
	 */
	getOuterName(unique_code){
		let boxEnt = this.box[unique_code];
		let outerIdElm = boxEnt['outerIdElm'];
		
		let outer_id = outerIdElm.val();
		outer_id = outer_id.trim();
		if(outer_id == '') return;
		outer_id = this._hankaku2Zenkaku(outer_id);
		if(isNaN(outer_id)){
			alert('半角数値を入力してください。');
			return ;
		}
		
		// IDフィールド名を取得する
		let outer_id_field = outerIdElm.attr('id');
		if(outer_id_field == null) outer_id_field = outerIdElm.attr('name');
		if(outer_id_field == null) throw new Exception('システムエラー CBON210604A');
		
		// 「kj_」がついていたら除去する
		let s3 = outer_id_field.substr( 0, 3);
		if(s3=='kj_'){
			outer_id_field = outer_id_field.substr(3);
		}
		
		let model_name_s = this.crudBaseData.model_name_s;
		let crud_base_project_path = this.crudBaseData.crud_base_project_path;
		let ajax_url = crud_base_project_path + '/' + model_name_s + '/getOuterName'

		let sendData={
			outer_id:outer_id,
			outer_id_field:outer_id_field
		};
		
		let fd = new FormData();
		
		let send_json = JSON.stringify(sendData);//データをJSON文字列にする。
		fd.append( "key1", send_json );
		
		// CSRFトークンを取得
		let csrf_token = this.crudBaseData.csrf_token;
		fd.append( "csrf_token", csrf_token );
		
		// AJAX
		jQuery.ajax({
			type: "post",
			url: ajax_url,
			data: fd,
			cache: false,
			dataType: "text",
			processData: false,
			contentType : false,
		})
		.done((res_json, type) => {
			let res;
			try{
				res =jQuery.parseJSON(res_json);//パース
			}catch(e){
				jQuery("#err").append(res_json);
				return;
			}
			
			let outer_name = res.outer_name;
			outer_name = this._xss_sanitize(outer_name);
			
			if(outer_name == '') outer_name='一致はありません';
			
			let outerNameElm = boxEnt['outerNameElm'];
			outerNameElm.html(outer_name);
			
		})
		.fail((jqXHR, statusText, errorThrown) => {
			let errElm = jQuery('#err');
			errElm.append('アクセスエラー');
			errElm.append(jqXHR.responseText);
			alert(statusText);
		});
	}
	
	
	/**
	 表示中の外部名称をクリアする。
	 */
	clear(){
		jQuery(".OuterName-outer_name").each((index, elm)=> {
			jQuery(elm).html('');
		 });
		
	}
	
	// 全角を半角に変換する
	_hankaku2Zenkaku(str) {
		return str.replace(/[Ａ-Ｚａ-ｚ０-９]/g, function(s) {
			return String.fromCharCode(s.charCodeAt(0) - 0xFEE0);
		});
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
	
}