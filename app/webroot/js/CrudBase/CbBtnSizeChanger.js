/**
 * ボタンサイズ変更【CrudBase用】
 * @version 1.1.4
 * @date 2018-10-27 | 2019-5-13 ボタン表示切替に対応
 */
class CbBtnSizeChanger{
	
	/**
	 * コンストラクタ
	 * 
	 * @param object cnfData 設定データ（省略可）
	 * @param object param
	 * - save_flg 保存フラグ 0:保存しない , 1:保存する（デフォルト）
	 * - 
	 */
	constructor(param, p_cnfData){

		// ローカルストレージキーを作成
		var url = location.href;
		var url = url.split(/[?#]/)[0]; // URLからクエリ部分を除去する
		this.ls_key = url + "-CbBtnSizeChanger_1.1.4"; // ローカルストレージにparamを保存するときのキー。

		this.param = this._setParamIfEmpty(param);
		
		// デフォルト設定データに引数設定データをマージして初期設定データを作成する。
		this.iniCnfData = this._makeIniCnfData(p_cnfData);
		
		// 設定データの初期化
		var cnfData = this._initCnfData(this.iniCnfData);

		// 設定フォームを作成
		var cnf_html = this._createCnfFormHtml(cnfData);
		var mainForm = jQuery(this.param.main_slt); // 設定フォーム
		mainForm.html(cnf_html);
		
		// 設定フォームにラジオボタンのチェックイベント（クリックイベント）を組み込む
		this._setCheckEvent(mainForm, cnfData);
		
		// 表示切替チェックボックスにクリックイベントを組み込み
		this._setVisibleCbClickEvent(mainForm, cnfData);
		
		// サブイベントをセットする
		this._setSubEvents(mainForm);
		
		// 保存フラグがONである場合
		if(this.param.save_flg == 1){
			this._changeSizeAll(cnfData); // 一覧各ボタンのサイズを設定データに合わせて変更する
			this._changeBtnVisibleAll(cnfData); // 一覧各ボタンを設定データに合わせて表示切替する。
		}
		
		this.mainForm = mainForm;
		this.cnfData = cnfData;
		
	}
	
	/**
	 * デフォルト設定データに引数設定データをマージして初期設定データを作成する。
	 */
	_makeIniCnfData(p_cnfData){
		var defCnfData = this._getDefaultCnfData(); // デフォルト設定データを取得する
		jQuery.extend(defCnfData, p_cnfData); // デフォルト設定データに引数設定データをマージ
		
		var iniCnfData = defCnfData; // 初期設定データ
		return iniCnfData;
		
	}
	
	
	/**
	 * デフォルト設定データを取得する
	 */
	_getDefaultCnfData(){
		var defCnfData = [
			{'slt':'.row_edit_btn','wamei':'編集ボタン','visible':true ,'def_size':'btn-xs','size':'btn-xs'},
			{'slt':'.row_copy_btn','wamei':'複製ボタン','visible':true ,'def_size':'btn-xs','size':'btn-xs'},
			{'slt':'.row_delete_btn','wamei':'削除ボタン','visible':true ,'def_size':'btn-xs','size':'btn-xs'},
			{'slt':'.row_eliminate_btn','wamei':'抹消ボタン','visible':false ,'def_size':'btn-xs','size':'btn-xs'},
			{'slt':'.row_exc_btn','wamei':'行入替ボタン(↑↓ボタン)','visible':true ,'def_size':'btn-xs','size':'btn-xs'},
			{'slt':'.row_enabled_btn','wamei':'有効ボタン','visible':false ,'def_size':'btn-xs','size':'btn-xs'},
			
		];
		
		// ▼ セレクタからコード文字列を取得する
		for(var i in defCnfData){
			var cnfEnt = defCnfData[i];
			cnfEnt['code'] = this._getCodeFromSlt(cnfEnt.slt);
		}

		return defCnfData;
	}
	
	
	/**
	 * If Param property is empty, set a value.
	 */
	_setParamIfEmpty(param){
		
		if(param == null) param = {};

		if(param['main_slt'] == null) param['main_slt'] = '#CbBtnSizeChanger';
		
		// ラジオボタンデータ
		if(param['radioData'] == null){
			param['radioData'] = [
				{'value':'btn-xs', 'wamei':' 極小'},
				{'value':'btn-sm', 'wamei':' 小　'},
				{'value':'', 'wamei':' 普通'},
				{'value':'btn-lg', 'wamei':' 大　'},
				]
		}
		
		if(param['save_flg'] == null) param['save_flg'] = 1;

		return param;
	}
	
	
	/**
	 * 設定データの生成
	 * @param array iniCnfData 初期設定データ
	 * @return object 設定データ
	 */
	_initCnfData(iniCnfData){

		var cnfData = this._loadCnfData();
		if(this._empty(cnfData)) {
			cnfData = jQuery.extend(true, {}, iniCnfData); // クローンコピーする
		}
		
		return cnfData;
		
	}
	
	
	/**
	 * セレクタからコード文字列を取得する
	 * @param string slt セレクタ
	 * @return string コード文字列
	 */
	_getCodeFromSlt(slt){
		
		var code = slt; // コード文字列
		
		// ▼ 先頭の一文字が「.」または「#」なら除去する。
		var s1 = code.charAt(0); // 先頭の一文字を取得する
		if(s1=='.' || s1=='#'){
			code = code.substr(1);
		}
		return code;
	}
	
	
	
	
	/**
	 * 設定フォームHTMLを作成
	 * @param object cnfData 設定フォーム
	 * @return string 設定フォームHTML
	 */
	_createCnfFormHtml(cnfData){

		var html = `
			<div style='padding:10px;margin-bottom:10px;background-color:#8dbbf3;border-radius:5px;display:inline-block'>
			<table class='tbl2'><tbody>
		`;
		
		for(var i in cnfData){
			var cnfEnt = cnfData[i];
			var visible_cb_html = this._createVisibleCbHtml(cnfEnt, i); // 表示切替チェックボックスのHTMLを生成する。
			var radios_html = this._createRadiosHtml(cnfEnt); // ラジオボタンHTMLを作成
			html += `
			<tr>
				<td>${cnfEnt.wamei}</td>
				<td>${visible_cb_html}</td>
				<td>${radios_html}</td>
			</tr>
			`;

		}
		
		html += `
				</tbody></table>
				<input id='cbbsc_def_btn' type='button' value='初期に戻す' class='btn btn-default btn-xs' >
				<input id='cbbsc_close_btn' type='button' value='閉じる' class='btn btn-default btn-xs' >
			</div>
		`;
		
		return html;
	}
	
	
	/**
	 * 表示切替チェックボックスのHTMLを生成する。
	 * @param object cnfEnt 設定エンティティ
	 * @param int index インデックス
	 * @return string 表示切替チェックボックスのHTML
	 */
	_createVisibleCbHtml(cnfEnt, index){
		var checked = '';
		if(cnfEnt.visible == true) checked = 'checked';
		var html = `<label><input type='checkbox' class='cbsc_visible_cb' data-index='${index}' ${checked}> 表示</label>`;
		return html;
	}
	
	
	/**
	 * ラジオボタンHTMLを作成
	 * @param object cnfEnt 設定エンティティ
	 * @return string ラジオボタンHTML
	 */
	_createRadiosHtml(cnfEnt){
		
		var html = ""; // ラジオボタンHTML
		var radioData = this.param.radioData; // ラジオボタンデータ
		
		for(var i in radioData){
			var rEnt = radioData[i];
			
			var checked_str = '';
			if(rEnt.value == cnfEnt.size) checked_str = 'checked';
			
			var radio_name = 'cbbsc_r_' + cnfEnt.code;
			var radio_value = rEnt.value;
			
			var unit_radio_h = "<label class='btn btn-primary btn-sm'><input type='radio' " +
					"name='" + radio_name + "' " +
					"value='" + radio_value + "' " +
					checked_str + " >" +
					rEnt.wamei + "</label>";
			
			html += unit_radio_h;
		}
		
		html = "<div class='btn-group' >" + html + "</div>";
		return html;
	}
	
	
	/**
	 * 設定フォームにチェックイベント（クリックイベント）を組み込む
	 * @param jQuery mainForm 設定フォーム・jQueryオブジェクト
	 * @param object cnfData 設定データ
	 */
	_setCheckEvent(mainForm, cnfData){
		
		for(var i in cnfData){
			var cnfEnt = cnfData[i];
			var radio_name = 'cbbsc_r_' + cnfEnt.code;
			mainForm.find("[name='" + radio_name + "']").click((e)=>{
				this._checkEvent(e); // ラジオボタンのチェックイベント
			});
		}
	}
	
	
	/**
	 * ラジオボタンのチェックイベント
	 */
	_checkEvent(e){
		
		var radio = jQuery(e.target);
		
		var name = radio.attr('name');
		var value = radio.val();
		
		// name属性から設定エンティティを取得する
		var cnfEnt = this._getCnfEntByName(name);
		cnfEnt.size = value;

		// ▼設定エンティティのセレクタにひもづく要素をループしてサイズを変更する
		jQuery(cnfEnt.slt).each((i,btn) => {
			this._changeSize(btn,value);
		});
		
		if(this.param.save_flg == 1){
			this._saveCnfData(); // 設定を保存する
		}
		
	}
	
	/**
	 * name属性から設定エンティティを取得する
	 * @param string name ラジオボタンのname属性
	 * @return object 設定エンティティ
	 */
	_getCnfEntByName(name){
		
		var search_name = name.replace('cbbsc_r_', '');
		for(var i in this.cnfData){
			var cnfEnt = this.cnfData[i];
			if(cnfEnt.code == search_name){
				return cnfEnt;
			}
		}
		return null;
	}
	
	/**
	 * ボタン要素のサイズ変更する
	 * @param object btn ボタン要素
	 * @param string size サイズ文字列
	 */
	_changeSize(btn,size){
		btn = jQuery(btn);
		
		// ▼ ボタンサイズのclass属性をいったん除去する
		var radioData = this.param.radioData; // ラジオボタンデータ
		for(var i in radioData){
			var class_str = radioData[i].value; // ボタンサイズのclass属性  btn-xs, btn-sm, btn-lg
			if(class_str == '') continue;
			if(btn.hasClass(class_str)){
				if(size == class_str) return; // 変更不要であるなら処理抜け
				btn.removeClass(class_str);
			}
		}
		
		// サイズ文字列が空、つまり「普通」サイズならこの時点で処理を抜ける。
		if(size == '') return;
		
		// サイズ文字列をclass属性に追加する。
		btn.addClass(size);
		
	}
	
	
	/**
	 * 設定データのボタンサイズ設定を各ボタンへ反映
	 * @param cnfData 設定データ
	 */
	_changeSizeAll(cnfData){
		
		for(var i in cnfData){
			var cnfEnt = cnfData[i];
			jQuery(cnfEnt.slt).each((i,btn) => {
				this._changeSize(btn,cnfEnt.size);
			});
		}
	}
	
	
	/**
	 * 表示切替チェックボックスにクリックイベントを組み込み
	 * @param jQuery mainForm 設定フォーム・jQueryオブジェクト
	 * @param object cnfData 設定データ
	 */
	_setVisibleCbClickEvent(mainForm, cnfData){
		
		for(var i in cnfData){
			var cnfEnt = cnfData[i];
			var slt = `.cbsc_visible_cb[data-index='${i}']`;
			mainForm.find(slt).click((evt)=>{
				var cb = jQuery(evt.currentTarget);
				this.visibleCbClickEvent(cb); // 表示切替チェックボックスにクリックイベント
			});
		}
		
	}
	
	
	/**
	 * 表示切替チェックボックスにクリックイベント
	 */
	visibleCbClickEvent(cb){
		var index = cb.attr('data-index');
		var visible = cb.prop('checked');

		var cnfEnt = this.cnfData[index];
		cnfEnt['visible'] = visible;
		
		this._changeBtnVisible(cnfEnt); // ボタン類の表示切替
		
		if(this.param.save_flg == 1){
			this._saveCnfData(); // 設定を保存する
		}
	}
	
	
	/**
	 * ボタン類の表示切替
	 * @param object cnfEnt 設定エンティティ
	 */
	_changeBtnVisible(cnfEnt){
		
		var visible = cnfEnt.visible;
		
		jQuery(cnfEnt.slt).each((i,btn) => {
			
			btn = jQuery(btn);
			if(visible == true){
				btn.show();
			}else{
				btn.hide();
			}
		});

	}
	
	
	/**
	 * 一覧各ボタンを設定データに合わせて表示切替する。
	 * @param array cnfData 設定データ
	 */
	_changeBtnVisibleAll(cnfData){
		for(var i in cnfData){
			var cnfEnt = cnfData[i];
			this._changeBtnVisible(cnfEnt); // ボタン類の表示切替
		}
	}
	

	/**
	 * サブイベントをセットする
	 * @param jQuery mainForm 設定フォーム・jQueryオブジェクト
	 */
	_setSubEvents(mainForm){
		
		// ▼「初期に戻す」ボタンにイベントをセットする
		mainForm.find("#cbbsc_def_btn").click((e)=>{
			this._returnToInit(); // 初期に戻す
		});
		
		// ▼「閉じる」ボタンにイベントをセットする
		mainForm.find("#cbbsc_close_btn").click((e)=>{
			this.mainForm.hide();
		});
		
	}
	
	/**
	 * 初期に戻す
	 */
	_returnToInit(){
		
		// ▼設定データを初期に戻す
		this.cnfData = jQuery.extend(true, {}, this.iniCnfData); // クローンコピーする
		var cnfData = this.cnfData;
		
		// 設定データのボタンサイズ設定を各ボタンへ反映
		this._changeSizeAll(cnfData);
		
		// 一覧各ボタンを設定データに合わせて表示切替する。
		this._changeBtnVisibleAll(cnfData);
		
		// ラジオボタンに設定データを反映する
		this._setCnfDataToRadios(cnfData);
		
		// 表示切替チェックボックスに設定データを反映する
		this._setCnfDataToVisibleCb(cnfData);

		// ローカルストレージに設定を保存
		this._saveCnfData();
	}
	
	
	/**
	 * ラジオボタンに設定データを反映する
	 * @param object cnfData 設定データ
	 */
	_setCnfDataToRadios(cnfData){
		
		for(var i in cnfData){
			var cnfEnt = cnfData[i];
			var radio_name = 'cbbsc_r_' + cnfEnt.code;
			var radio = this.mainForm.find("[name='" + radio_name + "'][value='" + cnfEnt.size + "']");
			if(radio[0]){
				radio.prop('checked',true);
			}
		}
		
	}
	
	
	/**
	 * 表示切替チェックボックスに設定データを反映する
	 */
	_setCnfDataToVisibleCb(cnfData){
		for(var i in cnfData){
			var cnfEnt = cnfData[i];
			
			// 表示切替チェックボックス要素を取得する
			var slt = `.cbsc_visible_cb[data-index='${i}']`;
			var cb = this.mainForm.find(slt);
			
			// 表示切替チェックボックス要素に設定データのチェックをセットする。
			if(cnfEnt.visible){
				cb.prop('checked', true);
			}else{
				cb.prop('checked', false);
			}

		}
	}

	
	/**
	 * ローカルストレージから設定データを読み取り
	 * @return array 設定データ
	 */
	_loadCnfData(){
		var cnfData = {}; // 設定データ
		
		// ローカルストレージで保存していた設定JSONを取得する
		var cnf_json = localStorage.getItem(this.ls_key);
		if(!this._empty(cnf_json)){
			var cnfData = JSON.parse(cnf_json);
		}
		return cnfData;
	}

	/**
	 * ローカルストレージにパラメータを保存する
	 */
	_saveCnfData(){

		var cnf_json = JSON.stringify(this.cnfData);
		localStorage.setItem(this.ls_key, cnf_json);
	}

	// Check empty.
	_empty(v){
		if(v == null || v == '' || v=='0'){
			return true;
		}else{
			if(typeof v == 'object'){
				if(Object.keys(v).length == 0){
					return true;
				}
			}
			return false;
		}
	}
	
	
	/**
	 * 設定データのセッター
	 * 
	 * @note 外部モジュールから設定データを変更できるメソッド。
	 * @param array pCnfData 設定データ
	 */
	setCnfData(pCnfData){

		// 初期データへ引数設定データをマージする
		this.iniCnfData = this._makeIniCnfData(pCnfData);

		// ▼ セレクタからコード文字列を取得する
		for(var i in this.iniCnfData){
			var cnfEnt = this.iniCnfData[i];
			cnfEnt['code'] = this._getCodeFromSlt(cnfEnt.slt);
		}
		
		// ローカルストレージのデータが空である場合、フォームは一覧の各ボタンを初期状態に戻す
		var lsCnfData = this._loadCnfData();
		if(this._empty(lsCnfData)){
			this._returnToInit(); // 初期状態に戻す
		}
		
	}
	
	
	
	
	
}