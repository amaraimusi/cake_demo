/**
 * CrudBase.js
 * 
 * @note
 * CRUDのベース。
 * デフォルトでは、削除、編集、新規追加するたびにAjax通信を行う仕様である。
 * 削除、編集、新規追加するたびに更新するのが重い場合、適用ボタンで一括適用するモードも備える。
 * 
 * var 2.0からCrudBase.jsに名称変更、およびES6に対応（IE11は非対応）
 * ver 1.7からWordPressに対応
 * 
 * 
 * 課題
 * td内部へのSetやGetは、先頭要素とtd直下にしか対応していない。
 * 複雑なtd内部にも対応するとなるとコールバックを検討しなければならない。
 * 
 * @date 2016-9-21 | 2018-3-16
 * @version 2.1.1 
 * 
 * @param object param
 *  - tbl_slt	CRUD対象テーブルセレクタ
 *  - edit_form_slt	編集フォームセレクタ
 *  - new_form_slt	新規フォームセレクタ
 *  - delete_form_slt	削除フォームセレクタ
 *  - contents_slt	コンテンツセレクタ	コンテンツ全体を表すセレクタでフォームの位置調整で利用する。省略時すると画面windowを基準に位置調整する。
 *  - edit_reg_url	編集登録サーバーURL
 *  - new_reg_url	新規登録サーバーURL
 *  - delete_reg_url	削除登録サーバーURL *  - form_position	フォーム位置 auto:自動, left:左側表示, center:中央表示, right:右側表示,max:横幅いっぱい
 *  - form_width	フォーム横幅	数値で指定。未指定（null)である場合、autoと同様になる。ただしform_positionがmaxなら横幅最大になる。
 *  - form_height	フォーム縦幅	上記と同じ
 *  - file_uploads	ファイルアップロードデータ
 *  - upload_dp	アップロードファイルディレクトリ
 *  - preview_img_width		プレビュー画像・横幅
 *  - preview_img_height	プレビュー画像・縦幅
 *  - callback_after_file_change(e,field,form_type,fileName)	ファイルチェンジ後のコールバック
 *  - form_z_index	重なり順序(cssのz-indexと同じ)
 *  - valid_msg_slt	バリデーションメッセージセレクタ
 *  - auto_close_flg	自動閉フラグ	0:自動で閉じない  1:フォームの外側をクリックすると自動的に閉じる（デフォルト）
 *  - ni_tr_place	新規入力追加場所フラグ 0:末尾 , 1:先頭
 *  - kj_delete_flg 検索条件削除フラグ
 *  @param array fieldData フィールドデータ（フィールド名の配列。フィード名の順番は列並びと一致していること）
 */

class CrudBaseBase{

	/**
	 * コンストラクタ
	 * 
	 */
	constructor(){
		this.param; 		// パラメータ
		this.fieldData; 	// フィールドデータ
		this.fieldHashTable;// フィールドハッシュテーブル key:フィールド名  val:列インデックス
		this.formInfo; 		// フォーム情報
		this.defNiEnt; 		// デフォルト新規入力エンティティ
		this.formNewInp;	// 新規入力フォーム
		this.formEdit;		// 編集フォーム
		this.formDelete;	// 削除フォーム
		this.showFormStrategy; // 入力フォーム表示ストラテジー
		this.react; 		// CrudBaseのリアクティブ機能クラス | CrudBaseReact.js
		this.tbl;			// テーブルオブジェクト
		this.autoSave;		// 自動保存機能
	}
	
	
	/**
	 * コンテナのGetter
	 * 
	 * @note コンテナには当クラスのメンバを格納している。
	 * 
	 * @return コンテナ
	 */
	getContainer(){
		var container = {
				'param':this.param , //  パラメータ
				'fieldData':this.fieldData , //  フィールドデータ
				'fieldHashTable':this.fieldHashTable , //  フィールドハッシュテーブル key:フィールド名  val:列インデックス
				'formInfo':this.formInfo , //  フォーム情報
				'defNiEnt':this.defNiEnt , //  デフォルト新規入力エンティティ
				'formNewInp':this.formNewInp , // 新規入力フォーム
				'formEdit':this.formEdit , // 編集フォーム
				'formDelete':this.formDelete , // 削除フォーム
				'showFormStrategy':this.showFormStrategy , //  入力フォーム表示ストラテジー
				'react':this.react , //  CrudBaseのリアクティブ機能クラス | CrudBaseReact.js
		}
		return container;
	}

	/**
	 * ファイルアップロードのチェンジイベント(新規入力用）
	 */
	_fileChangeEventNewInp(e){
		var elm = jQuery(this);
		var field = this._getFieldByNameOrClass(elm);

		// ファイルアップロードのチェンジイベント
		this._fileChangeEvent(e,field,'new_inp');
	};


	/**
	 * ファイルアップロードのチェンジイベント(編集用）
	 */
	_fileChangeEventEdit(e){
		var elm = jQuery(this);
		var field = this._getFieldByNameOrClass(elm);

		// ファイルアップロードのチェンジイベント
		this._fileChangeEvent(e,field,'edit');
	};

	/**
	 * ファイルアップロードのチェンジイベント(削除用）
	 */
	_fileChangeEventDel(e){
		var elm = jQuery(this);
		var field = this._getFieldByNameOrClass(elm);

		// ファイルアップロードのチェンジイベント
		this._fileChangeEvent(e,field,'del');
	};


	/**
	 * ファイルアップロードのチェンジイベント
	 * @param e イベント
	 * @param field フィールド
	 * @param form_type フォーム種別
	 */
	_fileChangeEvent(e,field,form_type){

		// エンティティおよび入力要素エンティティを取得する
		var ent = this._getFieldEntByField(field);
		var inpKey = 'inp_' + form_type;
		var inp_ent = ent[inpKey];

		// イベントハンドラをファイルアップロードデータにセットする。（登録系の処理で用いる）
		inp_ent.evt = e;

		// --- ▽▽▽ サムネイルを表示する処理

		// Get a file object from event.
		var files = e.target.files;
		var oFile = files[0];

		if(oFile==null){
			return;
		}

		// Converting from a file object to a data url scheme.Conversion process by the asynchronous.
		var reader = new FileReader();
		reader.readAsDataURL(oFile);

		// After conversion of the event.
		reader.onload = (evt) => {

			// accept属性を取得する
			var accept = inp_ent.accept;

			// accept属性が空もしくは画像系であるかチェックする
			if (accept == '' || accept.indexOf('image') >= 0){

				// フォーム種別からフォーム要素を取得する
				var form = this.getForm(form_type);

				//画像プレビュー要素を取得。（なければ作成）
				imgElm = this._getPreviewImgElm(form,field,inp_ent);

				// A thumbnail image preview.
				imgElm.attr('src',reader.result);

			} 

		}

		// ファイルチェンジ後のコールバックを実行する
		if(this.param.callback_after_file_change){
			var fileName = oFile.name;
			this.param.callback_after_file_change(e,field,form_type,fileName);
		}

	}

	/**
	 * 画像プレビュー要素を取得。（なければ作成）
	 * @param form フォーム要素のオブジェクト
	 * @param field ﾌｨｰﾙﾄﾞ名
	 * @param inp_ent 入力要素の情報
	 * @return 画像プレビュー要素
	 */
	_getPreviewImgElm(form,field,inp_ent){

		// 画像プレビュー要素を取得する
		var imgElm = form.find("[data-file-preview='" + field + "']");
		if(!imgElm[0]){
			imgElm = this._old__getPreviewImgElm(inp_ent);// 旧：画像プレビュー要素を取得。（なければ作成）
		}

		return imgElm;
	}

	/**
	 * 旧：画像プレビュー要素を取得。（なければ作成）
	 * @param inp_ent 入力要素の情報
	 * @return 画像プレビュー要素
	 */
	_old__getPreviewImgElm(inp_ent){

		var fileElm = inp_ent.elm;

		var preview_slt = inp_ent.preview_slt;

		var imgElm = jQuery('#' + preview_slt);
		if(!imgElm[0]){
			var preview_img_html = "<div class='upload_img_iuapj'><img id='" + preview_slt +"'/></div>";
			fileElm.after(preview_img_html);
			imgElm=jQuery('#' + preview_slt);

			imgElm.attr({
				'width':this.param.preview_img_width,
				'height':this.param.preview_img_height,

			});

		}else{
			imgElm.show();
		}
		return imgElm;
	}


	// オーディオプレビュー要素を取得。（なければ作成）
	_getPreviewAdoElm(inp_ent,fp){

		var fileElm = inp_ent.elm;

		var preview_slt = inp_ent.preview_slt;

		var adoElm = jQuery('#' + preview_slt);
		if(!adoElm[0]){

			var preview_ado_html = "<div class='upload_ado_iuapj'><audio id='" + preview_slt +"' src=" + fp + " controls>" +
					"<p>音声を再生するには、audioタグをサポートしたブラウザが必要です。</p></audio></div>";
			fileElm.after(preview_ado_html);

		}else{
			adoElm.show();
		}
		return adoElm;
	}


	/**
	 * テーブルの行数を取得する
	 * 
	 * @note
	 * 入れ子のテーブルが存在していても正確に行数を数える。
	 * 
	 */
	getTblRowCount(){
		var tbl = jQuery('#' + this.param.tbl_slt);
		var tBody = tbl.children('tbody');
		var rowCnt = tBody.children('tr').length;
		return rowCnt;
	}



	/**
	 * 諸パラメータから追加行インデックスを決定する
	 * @param form フォーム要素
	 * @param form_type フォーム種別
	 * @param option
	 * @returns 追加行インデックス
	 */
	_decAddRowIndex(form,form_type,option){

		// オプション内の追加行インデックスがセット済みでならそれを返す。
		if(option['add_row_index'] != null){
			return option['add_row_index'];
		}

		var add_row_index = -1;// 末尾行への追加を表す
		if(this.param.ni_tr_place == 1){
			add_row_index = 0;// 先頭行への追加を表す
		}
		
		// フォーム種別が複製である場合、フォームから行番を取得してセットする。
		if(form_type == 'copy'){
			add_row_index = this.getValueFromForm(form,'row_index');
			add_row_index = add_row_index * 1;
			add_row_index++;
		}

		return add_row_index;

	}

	/**
	 * 基本的な削除機能
	 * @param ent idを含むエンティティ
	 * @param row_index 行番
	 * @param beforeCallBack Ajax送信前(削除前）のコールバック（送信データを編集できる）
	 * @param afterCallBack 削除後に実行するコールバック関数（省略可）
	 * @param option オプション
	 * - wp_action :WPアクション	WordPressでは必須
	 * - wp_nonce  :WPノンス	WordPressのトークン的なもの（なくても動くがセキュリティが下がる）
	 * @returns void
	 */
	_deleteRegBase(ent,row_index,beforeCallBack,afterCallBack,option){

		if(!ent['id']){
			throw new Error('Not id');
		}

		if(this._empty(option)){
			option = {};
		}

		// ファイルアップロード関連のエンティティをFormDataに追加する
		var fd = new FormData();
		fd.append( "form_type", 'del' );

		// Ajax送信前のコールバックを実行する
		if(beforeCallBack){

			var bcRes = beforeCallBack(ent,fd);
			if(bcRes['err']){
				this._errShow(bcRes['err'],'del');// エラーを表示
				return;
			}else if(bcRes['ent']){
				ent = bcRes['ent'];
				fd = bcRes['fd'];
			}else{
				ent = bcRes;
			}
		}

		var json = JSON.stringify(ent);//データをJSON文字列にする。
		fd.append( "key1", json );

		// WordPressの場合
		if(option['wp_action']){

			fd.append('action',option['wp_action']);

			if(option['wp_nonce']){
				fd.append('nonce',option['wp_nonce']);
			}
		}

		jQuery.ajax({
			type: "post",
			url: this.param.delete_reg_url,
			data: fd,
			cache: false,
			dataType: "text",
			processData: false,
			contentType: false,

		}).done((str_json, type) => {

			var ent;
			try{
				ent =jQuery.parseJSON(str_json);//パース

			}catch(e){
				alert('エラー');
				jQuery("#err").html(str_json);
			}

			if(!ent){return;}

			this._deleteRow(row_index); // 行番に紐づく行を削除する

			// 登録後にコールバック関数を非同期で実行する
			if(afterCallBack != null){
				window.setTimeout(()=>{
					afterCallBack(ent);
					}, 1);
			}

			this.closeForm('del');// フォームを閉じる

		}).fail((jqXHR, statusText, errorThrown) => {
			jQuery('#err').html(jqXHR.responseText);//詳細エラーの出力
			alert(statusText);
		});

	}


	/**
	 * 行番を指定してTR要素を取得する
	 * @param row_index 行番 (-1を指定すると末尾を取得）
	 * @return TR要素
	 */
	getTr(row_index){

		var slt = '#' + this.param.tbl_slt + ' tbody tr';
		var tr = jQuery(slt).eq(row_index);

		return tr;
	}


	/**
	 * 末尾のTR要素を取得する
	 * @return TR要素
	 */
	getLastTr(){

		var slt = '#' + this.param.tbl_slt + ' tbody tr';
		var tr = jQuery(slt).eq(-1);

		return tr;
	}


	/**
	 * 現在編集中の行要素を取得する
	 * @return TR要素
	 */
	getTrInEditing(){

		var slt = '#' + this.param.tbl_slt + ' tbody tr:eq(' + this.param.active_row_index + ')';
		var tr = jQuery(slt);

		return tr;
	}


	/**
	 * 行番とフィールド名からTD要素を取得する
	 * @param row_index 行番(-1で末行を指定）
	 * @param field フィールド名
	 * @return TD要素
	 */
	getTd(row_index,field){

		var tr = this.getTr(row_index); // 行番を指定してTR要素を取得する

		var elm = tr.find('.' + field);
		if(!elm[0]){
			return null;
		}

		var td = elm.parents('td');

		return td;

	}


	/**
	 * 現在編集中の行から、指定したフィールドに紐づくTD要素を取得する
	 * @param フィールド
	 * @return TD要素
	 */
	getTdInEditing(field){

		var tr = this.getTrInEditing(); // 現在編集中のTR要素を取得する

		var elm = tr.find('.' + field);
		if(!elm[0]){
			return null;
		}

		var td = elm.parents('td');

		return td;
	}


	/**
	 * 一覧テーブルの行番からエンティティを取得する
	 * @param row_index 行番(-1は末行)
	 * @return object エンティティ
	 */
	getEntity(row_index){
		
		if(row_index == null){
			row_index = this.param.active_row_index;
		}

		// 行番を指定してTR要素を取得する
		var tr = this.getTr(row_index);

		// TR要素からエンティティを取得する
		var ent = this.getEntityByTr(tr);

		return ent;
	}


	/**
	 * TR要素からエンティティを取得する
	 * @param TR要素
	 * @return object エンティティ
	 */
	getEntityByTr(tr){

		var ent = {};
		for(var i in this.fieldData){
			var f = this.fieldData[i].field;
			var elm = tr.find("[name='" + f + "']");
			ent[f] = elm.val();
		}

		return ent;
	};


	/**
	 * 行中の任意要素を指定して、エンティティを取得する
	 * @param elm 行内（TD要素内部）の任意要素
	 * @return エンティティ
	 */
	getEntityByInnerElm(elm){

		// 先祖をさかのぼりtr要素を取得する
		var tr=jQuery(elm).parents('tr');

		// 行番（インデックス）を取得する
		var index = tr.index();

		// 一覧行から行番にひもづくエンティティを取得する
		var ent = this.getEntity(index);

		return ent;
	};

	/**
	 * Htmlテーブルからデータを取得する
	 * 
	 * @note
	 * 旧メソッド名:getDataHTbl
	 * 
	 * @param tbl HTMLテーブル要素(省略可)
	 * @return object データ
	 */
	getDataFromTbl(tbl){
		
		if(tbl == null){
			tbl = this.tbl;
		}
		if(!(tbl instanceof jQuery)){
			tbl = jQuery(tbl);
		}
		var trs = tbl.find('tbody tr');
		var data = [];

		// テーブルの行をループする
		trs.each((i,elm) => {
			var tr = jQuery(elm);
			
			// TR要素からエンティティを取得する
			var ent = this.getEntityByTr(tr);

			data.push(ent);
		});

		return data;
	};

	/**
	 * フィールドリストを指定して、Htmlテーブルからデータを取得する
	 * @return object データ
	 */
	getDataFromTblByFields(fields){

		var slt = '#' + this.param.tbl_slt + ' tbody tr';

		var data = [];

		// テーブルの行をループする
		jQuery(slt).each((i,elm)=>{
			var tr = jQuery(elm);

			// TR要素からフィールド名を検索し、値を取得する
			var ent = {};
			for(var i in fields){
				var f = fields[i];
				var elm = tr.find('.' + f);
				ent[f] = this._getValueEx(elm);

			}

			data.push(ent);
		});

		return data;
	};

	/**
	 * タグ種類を問わずに要素から値を取得する
	 * @param elm 要素
	 * @returns 要素の値
	 */
	_getValueEx(elm){
		var tagName = elm.prop("tagName"); 

		if(tagName == 'INPUT' || tagName == 'SELECT' || tagName=='TEXTAREA'){
			return elm.val();
		}else{
			return elm.html();
		}
	}

	/**
	 * フォーム内のフィールドで指定した入力要素から、値を取得する。
	 * @param form フォーム要素
	 * @param field フィールド： 入力要素のフィールド名(name属性名あるいはclass属性名）
	 * @returns フィールドで指定した入力要素からの値。
	 *  - 入力要素が存在しない場合はnullを返す
	 */
	getValueFromForm(form,field){

		var inpElm = this._formFind(form,field); // 入力要素を取得
		var v = null;
		if(inpElm[0]){
			v = this._getValueEx(inpElm); // 入力要素から値を取得
		}

		return v;
	}


	/**
	 * フォーム内のフィールドで指定した入力要素へ値をセットする。
	 * @param form フォーム要素
	 * @param field フィールド： 入力要素のフィールド名(name属性名あるいはclass属性名）
	 * @param value セットする値
	 */
	setValueToFrom(form,field,value){
		var inpElm = this._formFind(form,field); // 入力要素を取得
		if(inpElm[0]){
			this._setValueEx(inpElm,value); // 要素の種類を問わずに値をセットする
		}
	}



	/**
	 * エラーをフォームに表示する
	 * @param err エラー情報
	 * @param form_type フォーム種別 new_inp:新規入力 edit:編集
	 * 
	 */
	_showErrToForm(err,form_type){

		// エラー情報が配列であれば、値を改行で連結して１つのエラーメッセージにする。
		var err1 = err;
		if(Array.isArray(err1)){
			err1 = err1.join('<br>');
		}

		// フォーム種別からフォーム要素を取得
		var info = this.formInfo[form_type];
		var form = jQuery(info.slt);

		// フォーム要素からエラー要素を取得
		var errElm = form.find('.err');

		// エラー要素にエラーメッセージを埋め込む。
		errElm.html(err1);
	}


	/**
	 * バリデーションエラーメッセージをクリアする
	 * @param form_type フォーム種別 new_inp:新規入力 edit:編集
	 */
	_clearValidErr(form){

		var errElm = form.find(this.param.valid_msg_slt);
		errElm.html("");

		for(var i in this.fieldData){
			var field = this.fieldData[i]['field'];
			var label = form.find("[for='" + field + "']");
			if(label[0]){
				label.html("");
			}
		}
	}


	/**
	 * フォームのバリデーション
	 * @param form_type フォーム種別 new_inp:新規入力 edit:編集
	 * @return validFlg バリデーションフラグ true:正常 false:入力エラー
	 */
	_validationCheckForm(form_type){

		var validFlg = true; // バリデーションフラグ

		// フォーム種別からフォーム要素を取得
		var info = this.formInfo[form_type];
		var form = jQuery(info.slt);

		form.find('.valid').each((i,elm)=>{
			var elm = jQuery(elm);
			var field = this._getFieldByNameOrClass(elm);

			// 入力要素単位でバリデーションを行う
			var res = this._validationCheck(elm,field);

			if(res == false){
				validFlg = false;
			}

		});

		return validFlg;
	};


	/**
	 * 入力要素単位でバリデーションを行う
	 * @param elm 入力要素
	 * @param field 入力要素のフィールド名
	 * @return validFlg バリデーションフラグ true:正常 false:入力エラー
	 */
	_validationCheck(elm,field){

		var validFlg = true; // バリデーションフラグ

		var label = jQuery("[for='" + field + "']");
		var title = elm.attr('title');

		try{
			validFlg=elm[0].checkValidity();

			if(validFlg == true){
				label.attr('class','text-success');
				label.html('');
			}else{
				label.attr('class','text-danger');
				label.html(title);
			}

		}catch( e ){

			throw e;
		}

		return validFlg;
	}


	// ファイルアップロード要素のクリア
	_resetFileUpload(fuEnt){
		fuEnt.evt = null;
		var fileElm = fuEnt.elm;
		try {
			fileElm.val("");
		} catch (e) {
			console.log('It can not be reset in IE ');
		}

		// Reset a thubnail preview.
		var imgElm = jQuery('#' + fuEnt.preview_slt);
		imgElm.attr('src','');
		imgElm.hide();

		return fuEnt;
	}


	/**
	 * 新しい行を作成する
	 * @param ent 行エンティティ
	 * @param add_row_index 追加行インデックス :テーブル行の挿入場所。-1にすると末尾へ追加。-1がデフォルト。
	 * @param option 拡張予定
	 */
	_addTr(ent,add_row_index,option){

		if(add_row_index == null) add_row_index = -1;
		add_row_index *= 1; // 数値型に変換する。
		
		if(!option) option = {};

		// テーブルのtbody要素を取得する
		var tbl_slt = '#' + this.param.tbl_slt;
		var trs = jQuery(tbl_slt + ' tbody tr'); // TR群要素

		// 先頭行が空ならブラウザリロードを行う。
		if(trs.length == 0){
			location.reload(true);
		}
		
		var tr0 = trs.eq(0);// 先頭行を取得

		// 先頭行から新行を作成する
		var new_tr_html = "<tr style='background-color:#fdeaea'>" + tr0.html() + "</tr>";

		// TR要素をテーブルの指定行に挿入する
		var newTr = this._insertTr(tbl_slt,add_row_index,new_tr_html);

		// 新行要素にエンティティをセットする
		option['form_type'] = 'new_inp';
		this.setEntityToTr(newTr,ent,option);

	}

	/**
	 * TR要素をテーブルの指定行に挿入する
	 * @note
	 * tbodyは必須
	 * 
	 * @param string tbl_slt テーブル要素のセレクタ
	 * @param int row_index 挿入行インデックス (1行目に挿入する場合は0を指定する。末尾に追加する場合は行数以上の数字を指定）
	 * @param string tr_html 挿入TR要素
	 * @returns 新規追加TR要素
	 */
	_insertTr(tbl_slt,row_index,tr_html){
		var tbody = jQuery(tbl_slt + " tbody");
		var trs = tbody.find("tr");
		var tr_len = trs.length;
		var new_index = null;
	
		// 行数が1件以上である場合
		if(tr_len > 0){
			
			// 追加行番が行数未満である場合
			if(row_index < tr_len && row_index > -1){
				// 行番にひもづくTR要素を取得
				var tr = trs[row_index];
				
				// TR要素の上に新TR要素を追加
				jQuery(tr).before(tr_html);// × → tr.before(tr_html);
				new_index = row_index;
			}
			// 追加行番が行数以上である場合
			else{
				// 最後のTR要素を取得
				var tr = trs[tr_len-1];
				
				// TR要素の下に新TR要素を追加する
				jQuery(tr).after(tr_html);
				new_index = tr_len;
			}
		}
		// 行数が0件である場合,tbody要素にtr要素を追加する。
		else{
			tbody.append(tr_html);
			new_index = 0;
		}
		
		trs = tbody.find("tr");
		var newTr = trs[new_index];
		
		return jQuery(newTr); 
	}


	/**
	 * 編集中の行にエンティティを反映する。
	 * @param ent 行エンティティ
	 * @param <jQuery object> tr 編集中の行要素
	 * @param option 拡張予定
	 */
	_setEntityToEditTr(ent,tr,option){

		if(ent==null) return;
		if(!option) option = {};

		// 現在編集中の行要素を取得する
		if(tr==null){
			var tr = this.getTrInEditing();
		}

		// TR要素にエンティティをセットする
		option['form_type'] = 'edit';
		this.setEntityToTr(tr,ent,option);

	};
	
	
	/**
	 * テーブル要素にデータをセットする
	 * 
	 * @note
	 * 少々、重い処理なので注意。
	 * 
	 * @param tbl テーブル要素（省略可）
	 * @param data セットするデータ
	 * @param option
	 *  - form_type フォーム種別 new_inp,edit,del
	 * 
	 */
	setDataToTbl(tbl,data,option){
		
		if(tbl == null) tbl = this.tbl;
		
		var trs = tbl.find('tbody tr');
		trs.each((i,tr)=>{

			if(data[i] == null) return; // 次のループへ
			tr = jQuery(tr);
			var ent = data[i];
			this.setEntityToTr(tr,ent,option); // TR要素にエンティティをセットする
		});
	}


	/**
	 * TR要素にエンティティをセットする
	 * @param tr TR要素オブジェクト
	 * @param ent エンティティ
	 * @param option
	 *  - form_type フォーム種別 new_inp,edit,del
	 */
	setEntityToTr(tr,ent,option){

		if(ent==null) return;
		
		this.entToBinds(tr,ent,'class',option);// エンティティをclass属性バインド要素群へセットする
		this.entToBinds(tr,ent,'name',option);// エンティティをname属性バインド要素群へセットする
	};

	_nl2brEx(v){
		if(v == null || v == '' || v=='0'){
			return v;
		}

		if (typeof v != 'string'){
			return v;
		}

		v = v.replace(/\r\n|\n\r|\r|\n/g,'<br>');
		return v;
	}

	// 行番に紐づく行を隠す
	_hideTr(row_index){

		var tr = this.getTr(row_index);
		tr.hide();
	};

	/**
	 * 行版に紐づく行を削除する
	 * @param row_index	行番
	 * @returns
	 */
	_deleteRow(row_index){
		var tr = this.getTr(row_index);
		tr.remove();
	}


	/**
	 * フォームからエンティティを取得する
	 * @param string form_type フォーム種別  edit,new_inp,delete
	 * @return エンティティ
	 */
	_getEntByForm(form_type){

		// 現在編集中の行要素を取得する
		var tr = this.getTrInEditing();

		// TR要素からエンティティを取得する
		var ent = {};

		// フォーム要素を取得する
		var form = this.getForm(form_type);

		if(form_type=='edit' || form_type=='delete'){
			ent = this.getEntityByTr(tr);
		}

		// フォームからエンティティを取得
		var ent2 = {};
		for(var i in this.fieldData){

			// フィールドデータからフィールド名を取得する
			var f = this.fieldData[i].field;

			// name属性またはclass属性を指定して入力要素を取得する。
			var inps = this._formFind(form,f);

			// 該当する入力要素の件数を取得する
			var cnt=inps.length;

			var v = null;// 取得値

			// 0件である場合、該当する入力要素は存在しないため、何もせず次へ。
			if(cnt==0){
				continue;
			}

			// 入力要素が1件である場合、その要素から値を取得する。
			else if(cnt==1){
				v = this._getEntByForm2(inps,form,f);
			}

			// 入力要素が2件以上である場合、最初の1件のみ取得
			else{
				inps.each((i,elm)=>{
					var inp = jQuery(elm);
					v = this._getEntByForm2(inp,form,f);
					return;
				});
			}
			ent2[f] = v;
		}

		jQuery.extend(ent, ent2);

		return ent;
	}

	/**
	 * フォーム要素を取得する
	 * @param form_type フォーム種別
	 * @param cache キャッシュフラグ 0:キャッシュから取得しない , 1:キャッシュがあればそこから取得
	 * @returns フォーム要素
	 */
	getForm(form_type,cache){

		if(cache == null){
			cache = 1;
		}

		var form;
		if(form_type=='new_inp' || form_type=='copy'){
			if(cache == 1){
				if(this.formNewInp != null){
					form = this.formNewInp;
				}else{
					form = jQuery('#' + this.param.new_form_slt);
				}
			}else{
				form = jQuery('#' + this.param.new_form_slt);
			}
			this.formNewInp = form;

		}else if(form_type=='edit'){

			if(cache == 1){
				if(this.formEdit != null){
					form = this.formEdit;
				}else{
					form = jQuery('#' + this.param.edit_form_slt);
				}
			}else{
				form = jQuery('#' + this.param.edit_form_slt);
			}
			this.formEdit = form;

		}else if(form_type=='delete'){

			if(cache == 1){
				if(this.formDelete != null){
					form = this.formDelete;
				}else{
					form = jQuery('#' + this.param.delete_form_slt);
				}
			}else{
				form = jQuery('#' + this.param.delete_form_slt);
			}
			this.formDelete = form;

		}else{
			throw new Error('Uknown form_type!');
		}

		return form;
	}


	/**
	 * 様々な入力要素から値を取得する
	 * @param inp 入力要素<jquery object>
	 * @param form フォーム要素<jquery object>
	 * @param f フィールド名
	 * @return 入力要素の値
	 */
	_getEntByForm2(inp,form,f){

		var tagName = inp.get(0).tagName; // 入力要素のタグ名を取得する

		// 値を取得する
		var v = null;
		if(tagName == 'INPUT' || tagName == 'SELECT' || tagName == 'TEXTAREA'){

			// type属性を取得する
			var typ = inp.attr('type');

			if(typ=='file'){

				// アップロードファイル系である場合、ひもづいているlabel要素から値を取得する。
				v = this._getValFromLabel(form,f);
			}

			else if(typ=='checkbox'){
				v = 0;
				if(inp.prop('checked')){
					v = 1;
				}
			}

			else if(typ=='radio'){
				var opElm = form.find("[name='" + f + "']:checked");
				v = 0;
				if(opElm[0]){
					v = opElm.val();
				}
			}

			else{
				v = inp.val();
			}
		}

		// IMGタグへのセット
		else if(tagName == 'IMG'){

			//IMG系である場合、ひもづいているlabel要素から値を取得する。
			v = this._getValFromLabel(form,f);

		}

		else{
			v = inp.html();
		}

		return v;
	}


	/**
	 * フィールドデータからファイルアップロード要素であるエンティティだけ抽出する
	 * @param fieldData フィールドデータ
	 * @param form_type フォーム種別
	 */
	_extractFuEnt(fieldData,form_type){
		var fuEnts = [];
		for(var i in fieldData){
			var ent = fieldData[i];

			// 入力要素エンティティを取得する
			var inp_key = 'inp_' + form_type;
			var inp_ent;
			if(ent[inp_key]){
				inp_ent = ent[inp_key];
			}else{
				continue;
			}

			if(inp_ent.type_name == 'file'){
				fuEnts.push(ent);
			}

		}

		return fuEnts;
	}


	/**
	 * ファイルアップロード関連のエンティティをFormDataに追加する
	 * @param fd FormData（フォームデータ）
	 * @param fuEnts フィールドエンティティリスト（ファイルアップロード関連のもの）
	 * @param form_type フォーム種別
	 * @return 追加後のfd
	 */
	_addFuEntToFd(fd,fuEnts,form_type){

		for(var i in fuEnts){
			var fuEnt = fuEnts[i];

			var fu_key = fuEnt.field;
			var inp_key = 'inp_' + form_type;
			var elm = fuEnt[inp_key].elm; // ファイル要素オブジェクトを取得

			fd.append( fu_key, elm.prop("files")[0] );
		}

		return fd;
	}


	/**
	 * フィールドを指定してlabel要素から値を取得する
	 * @param form フォーム要素オブジェクト
	 * @param field フィールド名
	 * @return labelから取得した値
	 */
	_getValFromLabel(form,field){
		var v = null;
		var label = form.find("[for='" + field + "']");
		if(label[0]){
			v = label.html();
		}

		return v;
	}

	/**
	 * name属性またはclass属性でフォーム内を探し、入力要素を取得する
	 * @param form	フォーム要素オブジェクト
	 * @param string フィールド名（name属性またはclass属性でもある）
	 * @return jquery_object 入力要素
	 */
	_formFind(form,feild){

		var inp = form.find("[name='" + feild + "']");
		if(inp[0]==null){
			inp = form.find('.' + feild);
		}

		return inp;
	}


	/**
	 * 入力フォームをダイアログ化する
	 * @param formInfo フォーム情報
	 * @param form_z_index 深度 
	 * @returns
	 */
	_convertFormToDlg(formInfo,form_z_index){
		var param = this.param;

		if(form_z_index==null){
			form_z_index = param.form_z_index
		}

		// フォームのオブジェクトを取得する
		var form = formInfo.form;

		//デフォルトCSSデータ
		var cssData = {
			'z-index':form_z_index,
			'position':'absolute',

		}

		// フォームにCSSデータをセットする
		form.css(cssData);

		//ツールチップの外をクリックするとツールチップを閉じる
		if(this.param.auto_close_flg==1){
			jQuery(document).click(
					 ()=>{

						// フォーム表示ボタンが押されたときは、フォームを閉じないようにする。（このイベントはフォームボタンを押した時にも発動するため）
						if(formInfo.show_flg==1){
							formInfo.show_flg=0;
						}else{
							jQuery(formInfo.slt).hide();
						}

					});

			//領域外クリックでツールチップを閉じるが、ツールチップ自体は領域内と判定させ閉じないようにする。
			form.click((e) => {
				e.stopPropagation();
			});
		}

		form.hide();//フォームを隠す

	}


	// パラメータに空プロパティがあれば、デフォルト値をセットする
	_setParamIfEmpty(param){

		if(param == null){
			param = {};
		}

		// CRUD対象テーブルセレクタ
		if(param['tbl_slt'] == null){
			param['tbl_slt'] = 'ajax_crud_tbl';
		}

		// 編集フォームセレクタ
		if(param['edit_form_slt'] == null){
			param['edit_form_slt'] = 'ajax_crud_edit_form';
		}

		// 新規フォームセレクタ
		if(param['new_form_slt'] == null){
			param['new_form_slt'] = 'ajax_crud_new_inp_form';
		}

		// 削除フォームセレクタ
		if(param['delete_form_slt'] == null){
			param['delete_form_slt'] = 'ajax_crud_delete_form';
		}

		// コンテンツセレクタ
		if(param['contents_slt'] == null){
			param['contents_slt'] = null;
		}

		// 編集登録サーバーURL
		if(param['edit_reg_url'] == null){
			param['edit_reg_url'] = 'xxx';
		}

		// 新規登録サーバーURL
		if(param['new_reg_url'] == null){
			param['new_reg_url'] = 'xxx';
		}

		// 削除登録サーバーURL
		if(param['delete_reg_url'] == null){
			param['delete_reg_url'] = 'xxx';
		}

		// 自動保存サーバーURL
		if(param['auto_save_url'] == null){
			param['auto_save_url'] = 'xxx';
		}
		
		// ファイルアップロードディレクトリ
		if(param['upload_dp'] == null){
			param['upload_dp'] = null;
		}

		// ファイルアップロードデータ
		if(param['file_uploads'] == null){
			param['file_uploads'] = null;
		}

		// フォーム横幅
		if(param['form_width'] == null){
			param['form_width'] = null; // nullはフォーム幅がauto
		}

		// フォーム縦幅
		if(param['form_height'] == null){
			param['form_height'] = null; // nullはフォーム幅がauto
		}

		// フォーム位置
		if(param['form_position'] == null){
			param['form_position'] = 'auto';
		}

		// プレビュー画像・横幅
		if(param['preview_img_width'] == null){
			param['preview_img_width'] = 80;
		}

		// プレビュー画像・縦幅
		if(param['preview_img_height'] == null){
			param['preview_img_height'] = 80;
		}

		// フォームの前面深度(z-index)
		if(param['form_z_index'] == null){
			param['form_z_index'] = 9;
		}

		// バリデーションメッセージセレクタ
		if(param['valid_msg_slt'] == null){
			param['valid_msg_slt'] = '.err';
		}

		// 自動閉フラグ
		if(param['auto_close_flg'] == null){
			param['auto_close_flg'] = 1;
		}

		// 新規入力追加場所フラグ
		if(param['ni_tr_place'] == null){
			param['ni_tr_place'] = 0;
		}

		// アクティブ行インデックス
		if(param['active_row_index'] == null){
			param['active_row_index'] = 0;
		}

		// 表示フィルターデータ
		if(param['disFilData'] == null){
			param['disFilData'] = null;
		}

		// 検索条件削除フラグ
		if(param['kj_delete_flg'] == null){
			param['kj_delete_flg'] = null;
		}else if(param['kj_delete_flg'] === ""){
			param['kj_delete_flg'] = null;
		}else{
			param['kj_delete_flg'] = param['kj_delete_flg'] * 1;
		}
		
		return param;

	}


	/**
	 * フィールドデータへ新規入力フォーム内の要素情報をセットする
	 * @param fieldData フィールドデータ
	 * @param formInfo フォーム情報
	 * @param form_type フォームタイプ new_inp,edit
	 * @return フィールドデータ
	 */
	_setFieldDataFromForm(fieldData,formInfo,form_type){

		// フォーム要素オブジェクトを取得する
		var info = formInfo[form_type];
		var form = info.form;

		for(var i in fieldData){

			// エンティティからフィールドを取得する
			var ent = fieldData[i];
			var f = ent.field;

			// 入力要素エンティティ
			var inp_ent = {
					'elm':null,
					'tag_name':null,
					'type_name':null,
					'accept':'',
			};

			// name属性またはclass属性を指定して入力要素を取得する。
			var inp = this._formFind(form,f);
			inp_ent['elm'] = inp;

			// 入力要素が取得できなければcontinueする。
			if(inp[0]==null){
				continue;
			}

			var tag_name = inp.get(0).tagName; // 入力要素のタグ名を取得する
			inp_ent['tag_name'] = tag_name;

			// 値を取得する
			var v = null;
			if(tag_name == 'INPUT' || tag_name == 'SELECT' || tag_name == 'TEXTAREA'){

				// type属性を取得する
				var typ = inp.attr('type');
				inp_ent['type_name'] = typ;

				if(typ=='file'){

					// 受け入れファイルタイプを取得
					var accept = inp.attr('accept');
					inp_ent['accept'] = accept;

				}

			}

			ent['inp_' + form_type] = inp_ent;

		}

		return fieldData;
	}


	/**
	 * フィールドデータにファイル要素の情報をセット、およびファイルチェンジイベントを登録する。
	 * @param fieldData フィールドデータ
	 */
	_initFileUpData(fieldData){

		// フォーム名のリスト
		var form_typeList = ['new_inp','edit','del'];

		// ファイル要素系にのみ、ファイル要素情報をセットする。
		for(var i in fieldData){
			var f_ent = fieldData[i];

			for(var ft_i = 0 ; ft_i < form_typeList.length ; ft_i++){
				var form_type = form_typeList[ft_i];
				var key = 'inp_' + form_type;

				if(!f_ent[key]){
					continue;
				}
				var ent = f_ent[key];

				if(ent.type_name == 'file'){

					// ファイル要素情報を入力要素エンティティにセットする
					ent = this._setFileUploadEntity(f_ent.field,ent);

					// イベントリスナを登録する
					if(form_type == 'new_inp'){
						ent.elm.change(this._fileChangeEventNewInp);
					}else if(form_type == 'edit'){
						ent.elm.change(this._fileChangeEventEdit);
					}else{
						ent.elm.change(this._fileChangeEventDel);
					}
				}
			}
		}

		return fieldData;
	}


	/**
	 * ファイル要素情報を入力要素エンティティにセットする
	 * @param field フィールド名
	 * @param ent 入力要素エンティティ（type=file)
	 * @return 入力要素エンティティ
	 */
	_setFileUploadEntity(field,ent){

		// プレビュー要素
		var preview_slt = field + '_preview';

		ent['evt'] = null;
		ent['file_name'] = null;
		ent['file_path'] = this.param.upload_dp;
		ent['preview_slt'] = preview_slt;

		return ent;
	}
	
	
	
	/**
	 * TRからDIVへ反映
	 * @param par(string or jQuery object) 親要素オブジェクトまたはセレクタ
	 * @parma row_index 行インデックス	省略した場合アクティブTRの行インデックスになる。
	 * @param option
	 *  - form_type フォーム種別
	 *  - upload_dp アップロードディレクトリパス
	 *  - xss サニタイズフラグ 0:サニタイズしない , 1:xssサニタイズを施す（デフォルト）
	 */
	trToDiv(par,row_index,option){
		var ent = this.getEntity(row_index); // アクティブTR要素からエンティティを取得する
		this.entToBinds(par,ent,'class',option);// エンティティをclass属性バインド要素群へセットする
		this.entToBinds(par,ent,'name',option);// エンティティをname属性バインド要素群へセットする
		
	}
	
	/**
	 * エンティティをバインド要素群へセットする
	 * 
	 * @note
	 * entのフィールドに紐づく値がundefinedならバインド要素にセットしない。nullならセットする。
	 * 
	 * @param par(string or jQuery object) 親要素オブジェクトまたはセレクタ
	 * @param ent エンティティ
	 * @param bind_attr バインド属性	'class' or 'name'
	 * @param option
	 *  - form_type フォーム種別
	 *  - upload_dp アップロードディレクトリパス
	 *  - xss サニタイズフラグ 0:サニタイズしない , 1:xssサニタイズを施す（デフォルト）
	 *  - disFilData object[フィールド]{フィルタータイプ,オプション} 表示フィルターデータ
	 */
	entToBinds(par,ent,bind_attr,option){
		var bindElms = this.getBindElms(par,bind_attr,option); // class属性に紐づくバインド要素リストを親要素から取得する
		
		if(!option) option = {};
		
		// class属性である場合、表示フィルターをONにする。name属性であるならOFFにする。
		if(bind_attr == 'class'){
			option['dis_fil_flg'] = 1;
		}else if (bind_attr == 'name'){
			option['dis_fil_flg'] = 0;
		}

		// バインド要素リストにエンティティをセットする
		for(var i in this.fieldData){
			var field = this.fieldData[i].field;

			if(ent[field] === undefined) continue;

			var elms = bindElms[field];
			for(var e_i in elms){
				var elm = elms[e_i];
				this.setValueToElement(elm,field,ent[field],option); // バインド要素リストを取得する
			}
		}
	}
	
	
	/**
	 * バインド要素リストを取得する
	 * @param par(string or jQuery object) 親要素
	 * @param bind_attr バインド属性	'class' or 'name'
	 * @return object[s][n] バインド属性リスト  
	 */
	getBindElms(par,bind_attr){
		
		
		var bindElms = {}; 
		
		if(!(par instanceof jQuery)){
			par = jQuery(par);
		}
		
		for(var i in this.fieldData){
			
			var fEnt = this.fieldData[i];
			
			//要素を取得する
			var bElms;
			if(bind_attr == 'class'){
				bElms = par.find('.' + fEnt.field);
			}else if(bind_attr == 'name'){
				bElms = par.find(`[name='${fEnt.field}']`);
			}else{
				continue;
			}

			if(!bElms[0]) continue;// 要素が取得できなかったら次へ
			
			// 2層構造でバインド要素リストに取得要素をセットする
			var bElms2 = [];
			for(var be_i=0;be_i<bElms.length;be_i++){
				bElms2.push(bElms.eq(be_i));
			}
			bindElms[fEnt.field] = bElms2;
		}
		return bindElms;
	}


	/**
	 * フォームにエンティティをセットする
	 * @param string form_type フォーム種別
	 * @param object ent エンティティ
	 * @param option 省略可
	 *  - upload_dp アップロードファイルディレクトリ
	 *  - disFilData object[フィールド]{フィルタータイプ,オプション} 表示フィルターデータ
	 */
	setFieldsToForm(form_type,ent,option){

		var form = this.getForm(form_type);// フォーム要素を取得
		
		if(option==null) option = {};
		option = {
				'par':form,
				'form_type':form_type,
		}
		
		this.entToBinds(form,ent,'class',option);// エンティティをclass属性バインド要素群へセットする
		this.entToBinds(form,ent,'name',option);// エンティティをname属性バインド要素群へセットする
		
	}
	
	
	/**
	 * 様々なタイプの要素へ値をセットする
	 * @param elm(string or jQuery object) 要素オブジェクト、またはセレクタ
	 * @param field フィールド
	 * @param val1 要素にセットする値
	 * @param option
	 *  - par 親要素(jQuery object)
	 *  - form_type フォーム種別
	 *  - upload_dp アップロードディレクトリパス
	 *  - xss サニタイズフラグ 0:サニタイズしない , 1:xssサニタイズを施す（デフォルト）
	 *  - disFilData object[フィールド]{フィルタータイプ,オプション} 表示フィルターデータ
	 *  - dis_fil_flg 表示フィルター適用フラグ 0:OFF(デフォルト) , 1:ON
	 */
	setValueToElement(elm,field,val1,option){
		
		if(!(elm instanceof jQuery)) elm = jQuery(elm);// 要素がjQueryオブジェクトでなければ、jQueryオブジェクトに変換。
		
		// オプションの初期化
		if(option == null) option = {};
		
		// サニタイズフラグを取得する
		var xss = 0;
		if(option['xss']==null){
			xss = 1;
		}else{
			xss = option['xss'];
		}
		
		var tag_name = elm.get(0).tagName; // 入力要素のタグ名を取得する
		
		// 値に表示フィルターをかける
		if(option['dis_fil_flg']){
			var res = this.displayFilter(val1,field,option.disFilData,xss);
			val1 = res.val1;
			xss = res.xss;
		}
		
		// 値を入力フォームにセットする。
		if(tag_name == 'INPUT' || tag_name == 'SELECT'){

			// type属性を取得
			var typ = elm.attr('type');

			if(typ=='file'){

				// アップロードファイル要素用の入力フォームセッター
				this._setToFormForFile(option.form_type,option.par,field,val1,option.upload_dp);

			}

			else if(typ=='checkbox'){
				if(val1 ==0 || val1==null || val1==''){
					elm.prop("checked",false);
				}else{
					elm.prop("checked",true);
				}

			}

			else if(typ=='radio'){
				var opElm = option.par.find("[name='" + field + "'][value='" + val1 + "']");
				if(opElm[0]){
					opElm.prop("checked",true);
				}else{
					// 値が空である場合、ラジオボタンのすべての要素からチェックをはずす。
					if(this._empty(val1)){
						var radios = option.par.find("[name='" + field + "']");
						radios.prop("checked",false);
					}
				}

			}

			else{
				val1 = this._xssSanitaizeDecode(val1);// XSSサニタイズを解除
				elm.val(val1);
			}

		}

		// テキストエリア用のセット
		else if(tag_name == 'TEXTAREA'){

			if(val1!="" && val1!=null){
				val1=val1.replace(/<br>/g,"\r");
				val1 = this._xssSanitaizeDecode(val1);
			}
			elm.val(val1);
		}

		// IMGタグへのセット
		else if(tag_name == 'IMG'){
			// IMG要素用の入力フォームセッター
			this._setToFormForImg(option.form_type,option.par,elm,field,val1,option.upload_dp);
		}

		// audioタグへのセット
		else if(tag_name == 'AUDIO'){

			// オーディオ要素用の入力フォームセッター
			this._setToFormForAdo(option.form_type,option.par,elm,field,val1,option.upload_dp);

		}else{
			if( typeof val1 == 'string'){
				val1=val1.replace(/<br>/g,"\r");
				// XSSサニタイズを施す
				if(option.xss == 1){
					val1 = this._xssSanitaizeEncode(val1); 
				}
				val1 = this._nl2brEx(val1);// 改行コートをBRタグに変換する
			}
			elm.html(val1);
		}
		
		
	}
	
	/**
	 * 値に表示フィルターをかける
	 * @param val1 値
	 * @param field フィールド
	 * @param disFilData 表示フィルターデータ
	 * @param xss XSSサニタイズフラグ
	 * @return object
	 *  - [val1] フィルター後の値
	 *  - [xss] XSSサニタイズフラグ
	 */
	displayFilter(val1,field,disFilData,xss){
		
		 var res = {'val1':val1,'xss':xss};

		if(!disFilData) disFilData = this.param.disFilData;
		if(!disFilData) return res;
		if(!disFilData[field]) return res;
		
		var filEnt = disFilData[field];
		var xss = 0 ; // xssサニタイズフラグ
		
		switch (filEnt.fil_type) {
		case 'select':
			
			res.val1 = this.disFilSelect(val1,field,filEnt.option);// 表示フィルター・SELECTリスト
			break;
			
		case 'delete_flg':

			res.val1 = this.disFilDeleteFlg(val1,field,filEnt.option);// 表示フィルター・削除フラグ
			res.xss = 0;
			break;
			
		case 'money':

			res.val1 = this.disFilMoney(val1,field,filEnt.option);// 表示フィルター・金額
			res.xss =0;
			break;

		default:
			break;
		}
		
		return res;
	}
	
	/**
	 * 表示フィルターデータのSetter
	 * @param disFilData 表示フィルターデータ
	 */
	setDisplayFilterData(disFilData){
		this.param['disFilData'] = disFilData;
	}
	
	/**
	 * 表示フィルター・SELECTリスト
	 * @param val1 フィルターをかける値
	 * @param field フィールド
	 * @param option 
	 * 
	 */
	disFilSelect(val1,field,option){
		
		if(val1 == null) return val1;
		
		var list = {};
		if(option){
			if(option['list']){
				list = option['list'];
			}
		}
		
		var display_value = ""; // 表示する値
		if(list[val1] != null){
			display_value = list[val1];
		}
		return display_value;

	}
	
	/**
	 * 表示フィルター・削除フラグ
	 * @param val1 フィルターをかける値
	 * @param field フィールド
	 * @param option 
	 * 
	 */
	disFilDeleteFlg(val1,field,option){

		if(val1 == null) return val1;
		
		if(val1 == 1){
			return '<span style="color:#b4b4b4;">無効</span>';
		}else{
			return '<span style="color:#23d6e4;">有効</span>';
		}

	}
	
	/**
	 * 表示フィルター・金額
	 * @param val1 フィルターをかける値
	 * @param field フィールド
	 * @param option 
	 * 
	 */
	disFilMoney(val1,field,option){
		
		if(val1 == null) return val1;
		
		var currency = "&yen;";
		if(option){
			if(option['currency']){
				currency = option['currency'];
			}
		}
		return currency + String(val1).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');

	}
	

	// アップロードファイル要素用の入力フォームセッター
	_setToFormForFile(form_type,form,field,v,upload_dp){

		// 入力要素エンティティを取得する
		var ent = this._getFieldEntByField(field);

		var inp_ent = ent['inp_' + form_type];

		// アップロードファイル要素をクリアする
		var inpElm = inp_ent.elm;
		inpElm.val("");

		if(!upload_dp){
			upload_dp = inp_ent.file_path;
		}
		var fp = upload_dp + v;

		var accept = inp_ent.accept;

		// acceptが画像系である場合、画像プレビューを表示
		if(accept.indexOf('image') >= 0 ){

			var imgElm = this._getPreviewImgElm(form,field,inp_ent);

			if(!this._empty(v)){
				imgElm.attr('src',fp);
			}

		}

		// acceptがオーディオ系である場合、オーディオプレビューを表示
		else if(accept.indexOf('audio') >= 0){
			var adoElm = this._getPreviewAdoElm(inp_ent,fp);
		}

		this._setLabel(form,field,v);// ラベル要素へセット
	}

	/**
	 * フィールド名を指定してフィールドエンティティを取得する
	 */
	_getFieldEntByField(field){
		var index = this.fieldHashTable[field];
		var ent = this.fieldData[index];

		return ent;
	}

	/**
	 * 入力要素エンティティを取得する
	 * @param field フィールド
	 * @param form_type フォーム種別
	 * @return 入力要素エンティティ
	 */
	_getInpEnt(field,form_type){
		var index = this.fieldHashTable[field];
		var ent = this.fieldData[index];
		var inp_ent;
		var inp_key = 'inp_' + form_type;
		if(ent[inp_key]){
			inp_ent = ent[inp_key];
		}
		return inp_ent;
	}


	// IMG要素用の入力フォームセッター
	_setToFormForImg(form_type,form,imgElm,field,v,upload_dp){

		// 入力エンティティを取得する
		var inp_ent = this._getInpEnt(field,form_type)

		if(!upload_dp){
			upload_dp = inp_ent.file_path;
		}
		var fp = upload_dp + v;
		imgElm.attr('src',fp);

		this._setLabel(form,field,v);// ラベル要素へセット

	}

	// オーディオ要素用の入力フォームセッター
	_setToFormForAdo(form_type,form,adoElm,field,v,upload_dp){

		// 入力エンティティを取得する
		var inp_ent = this._getInpEnt(field,form_type)

		if(!upload_dp){
			upload_dp = inp_ent.file_path;
		}
		var fp = upload_dp + v;
		adoElm.attr('src',fp);

		this._setLabel(form,field,v);// ラベル要素へセット
	}


	/**
	 * ラベル要素へセット
	 * @param object form フォーム要素オブジェクト
	 * @param string field フィールド名
	 * @param v ラベルにセットする値
	 */
	_setLabel(form,field,v){
		var label = form.find("[for='" + field + "']");
		if(label){
			label.html(v);
		}
	};


	/**
	 * 入力フォームを表示する
	 * 
	 * @param object form フォーム要素オブジェクト
	 * @param string triggerElm トリガー要素  ボタンなど
	 * @param option
	 *  - form_position フォーム位置フラグ:  auto(空）:基本位置 , left:トリガーの左側にフォームを表示 , center:横中央 , right:右側  , max:フルサイズ
	 *  - use_show_form_strategy 入力フォームストラテジーの使用:  入力フォームストラテジーがセットされている場合、利用するか。デフォルトは使用する。
	 */
	_showForm(form,triggerElm,option){

		if(option == null){
			option = {};
		}

		// フォーム位置フラグ
		if(option['form_position'] == null){
			option['form_position'] = this.param.form_position;
		}

		// 入力フォームストラテジーの使用
		if(option['use_show_form_strategy'] == null){
			option['use_show_form_strategy'] = 1;
		}

		// 複数のフォームを開いてフォームが重なった時、新しく開いたフォームが上になるようにする。
		if(this.param.auto_close_flg == 0){
			this.param.form_z_index ++;
			// ※ z_indexの最大値は32bit整数,あるいは64bit整数の最大値である。

			form.css('z-index',this.param.form_z_index);
		}

		form.show();

		// 入力フォームストラテジーがセットされている場合、こちらの処理を実行する。（ストラテジーパターンによる拡張である）
		if(option.use_show_form_strategy == 1 && this.showFormStrategy != null){
			var res = this.showFormStrategy.showForm(form,triggerElm);
			if(res==true){
				return;
			}
		}

		//トリガー要素の右上位置を取得
		if(!(triggerElm instanceof jQuery)){
			triggerElm = jQuery(triggerElm);
		}
		var offset=triggerElm.offset();
		var left = offset.left;
		var top = offset.top;

		var ww = jQuery(window).width();// Windowの横幅（ブラウザの横幅）

		// フォームのサイズを取得する。パラメータでサイズ指定されていない場合、フォームからサイズを取得する
		var form_width = this.param.form_width;// フォームの横幅
		var form_height = this.param.form_height;// フォームの縦幅
		if(this._empty(form_width)){
			form_width = form.outerWidth();
		}
		if(this._empty(form_height)){
			form_height = form.outerHeight();
		}

		// フォーム位置Yをセット
		var trigger_height = triggerElm.outerHeight();
		var tt_top=top + trigger_height;


		var tt_left=0;// フォーム初期位置X
		var full_w = ww; // コンテンツのフル横幅

		// コンテンツ要素が指定されている場合、コンテンツ要素の初期位置Xと横幅をセットする。
		if(!this._empty(this.param.contents_slt)){
			var conElm = jQuery(this.param.contents_slt);
			if(conElm[0]){
				tt_left = conElm.offset.left;
				full_w = conElm.width();
			}
		}


		// フォーム位置の種類毎にフォーム位置Xを算出する。
		switch (option.form_position) {

		case 'left':

			// トリガーの左側にフォームを表示する。
			tt_left=left - form_width;
			break;

		case 'center':

			// フォームを中央にする。
			tt_left=(full_w / 2) - (form_width / 2);
			break;

		case 'right':

			// トリガーの右側にフォームを表示する
			tt_left=left;
			break;

		case 'max':

			form_width = full_w;

			break;

		default:// auto

			// 基本的にトリガーの右側にフォームを表示する。
			// ただし、トリガーが右端付近にある場合、フォームは外側にでないよう左側へ寄せる。
			tt_left=left;
			if(tt_left + form_width > full_w){
				tt_left = full_w - form_width;
			}

			break;
		}

		if(tt_left < 0){
			tt_left = 0;
		}

		//フォーム要素に位置をセット
		form.offset({'top':tt_top,'left':tt_left });

		if(!this._empty(form_width)){
			form.width(form_width);
		}

		if(!this._empty(form_height)){
			form.height(form_height);
		}
	}


	// フィールドデータにプロパティを追加する
	_addMoreFieldData(tbl_slt,fieldData){

		// フィールドデータが空であるなら一覧テーブルのth要素からフィールド名を取得する
		if(!fieldData){
			fieldData = this._getFieldDataFromTh();

			if(!fieldData){
				throw new Error('fieldDataを取得できません。th要素のclass属性にフィールド名を指定してください。');
			}
		}

		var fieldData2 = [];

		// thループ
		var i=0;
		jQuery('#' + tbl_slt + ' th').each((i,elm)=>{

			var wamei = jQuery(elm).text();

			var field = null;
			if(fieldData[i]){
				field = fieldData[i];
			}

			if(field != null){
				var ent = {
						'index':i,
						'field':field,
						'wamei':wamei,
					};

				fieldData2.push(ent);

				i++;
			}
		});

		return fieldData2;
	}

	// th要素からフィールド情報を取得する
	_getFieldDataFromTh(){

		var fieldData = [];

		var slt = '#' + this.param.tbl_slt + ' th';
		jQuery(slt).each((i,elm)=>{
			var thElm = jQuery(elm);
			var field = this._getFieldByClassOrName(thElm);////class属性またはname属性からフィールド名を取得する
			if(field){
				fieldData.push(field);
			};
		});
		return fieldData;
	}


	// フィールドハッシュテーブルをフィールドデータから生成する。
	_createFieldHashTable(fieldData){

		var hashTable = {};

		for(var i in fieldData){
			var fEnt = fieldData[i];

			hashTable[fEnt.field] = i;

		}

		return hashTable;
	}


	// フォーム情報の初期化
	_initFormInfo(param){

		var formInfo = {};// フォーム情報

		// 新規フォーム情報の設定
		var res = this._classifySlt(param['new_form_slt']);
		var newInpForm = jQuery(res['slt']);
		formInfo['new_inp'] = {
			'xid':res['xid'],	// ID属性
			'slt':res['slt'],	// フォーム要素のセレクタ
			'show_flg':0,		// 表示制御フラグ（閉じるイベント制御用）
			'form':newInpForm,	// フォーム要素
		};
		this._convertFormToDlg(formInfo.new_inp);// フォームをダイアログ化する。

		// 編集フォーム情報の設定
		res = this._classifySlt(param['edit_form_slt']);
		var editForm = jQuery(res['slt']);
		formInfo['edit'] = {
			'xid':res['xid'],	// ID属性
			'slt':res['slt'],	// フォーム要素のセレクタ
			'show_flg':0,		// 表示制御フラグ（閉じるイベント制御用）
			'form':editForm,	// フォーム要素
		};
		this._convertFormToDlg(formInfo.edit);// フォームをダイアログ化する。


		// 削除フォーム情報の設定
		var res = this._classifySlt(param['delete_form_slt']);
		var deleteForm = jQuery(res['slt']);
		formInfo['del'] = {
			'xid':res['xid'],	// ID属性
			'slt':res['slt'],	// フォーム要素のセレクタ
			'show_flg':0,		// 表示制御フラグ（閉じるイベント制御用）
			'form':deleteForm,	// フォーム要素
		};
		this._convertFormToDlg(formInfo['del']);// フォームをダイアログ化する。

		return formInfo;

	};

	/**
	 * バリデーションによるエラーを表示する
	 * @param errData エラーデータ
	 *  - 文字列型<string>	エラーメッセージのみ
	 *  - エラー出力指定型(単一) <{'err_slt','err_msg'}>		出力先セレクタとエラーメッセージ
	 *  - エラー出力指定型（複数） <[{'err_slt','err_msg'}]>	上記の配列
	 * @param form_type フォーム種別
	 * @returns void
	 */
	_errShow(errData,form_type){

		// フォーム種別からフォーム要素を取得する
		var form = this.getForm(form_type);

		// 一旦、バリデーションエラーメッセージをクリアする
		this._clearValidErr(form);

		// エラーメッセージのみである場合
		if (typeof errData == 'string'){
			var errElm = form.find(this.param.valid_msg_slt);
			if(errElm[0]){
				if(errElm.length > 1){
					errElm = errElm.eq(0);
				}
				errElm.html(errData.err_msg);
			}
			errElm.html(errData);

		}

		// エラーセレクタによってエラー出力先が指定されている場合
		else{

			// 複数エラータイプである場合
			if(errData[0]){
				for(var i in errData){
					var errEnt = errData[i];
					var errElm = form.find(errEnt.err_slt);
					errElm.html(errEnt.err_msg);
				}
			}

			// 単一エラータイプである場合
			else{
				var errElm = form.find(errData.err_slt);
				errElm.html(errData.err_msg);
			}
		}
	}


	/**
	 * 検索
	 * @param searchBtnElm 検索ボタン要素
	 * @param <jquery object> formElm 検索入力フォーム (省略可)
	 * @param option オプション (省略可)
	 */
	searchKjs(searchBtnElm,formElm,option){

		// 検索ボタン要素をjQueryオブジェクトに変換する
		var btnElm; // 検索ボタン要素
		if(searchBtnElm instanceof jQuery){
			btnElm = searchBtnElm;
		}else{
			btnElm = jQuery(searchBtnElm);
		}

		// オプションの初期セット
		if(option == null){
			option = {};
		}
		if(this._empty(option['form_slt'])){
			option['form_slt'] = '.form_kjs';
		}
		if(this._empty(option['inp_slt'])){
			option['inp_slt'] = '.kjs_inp';
		}

		// URLからパラメータを取得する
		var param = this._getUrlQuery();

		// form要素が空なら生成する
		if(!formElm){
			var form_slt = option['form_slt'];
			formElm = btnElm.parents(form_slt);
		}

		// form要素内の入力要素群をループする。
		var kjs = {}; // 検索条件情報
		var removes = []; // 除去リスト（入力が空の要素のフィールド）
		var inp_slt =  option['inp_slt'];
		formElm.find(inp_slt).each((i,elm)=>{

			// 要素から選択値を取得する
			var kjsElm = jQuery(elm);
			var val = kjsElm.val();

			// 選択値が空でない場合（0も空ではない扱い）
			var field = kjsElm.attr('name'); // 要素のname属性から検索条件フィールドを取得する
			if(!this._emptyNotZero(val)){
				val = encodeURIComponent(val); // 要素の値をURLエンコードする
				kjs[field] = val; // 検索条件情報にセットする
			}else{
				removes.push(field);
			}
		});

		// パラメータに検索条件情報をマージする
		jQuery.extend(param, kjs);

		// パラメータから除去リストのフィールドを削除する。
		for(var i in removes){
			var rem_field = removes[i];
			delete param[rem_field];
		}

		// 1ページ目をセットする
		param['kj_page_no'] = 0;

		// パラメータからURLクエリを組み立てる
		var query = '';
		for(var field in param){
			var val = param[field];
			query += field + '=' + val + '&';
		}

		// URLの組み立て
		var url;
		if(query != ''){
			query = query.substr(0,query.length-1); // 末尾の一文字を除去する
			url = '?' + query;
		}

		// URLへ遷移
		window.location.href = url;
	}



	/**
	 * 検索リセット
	 * @param resetBtnElm 検索ボタン要素
	 * @param <jquery object> formElm 検索入力フォーム (省略可)
	 * @param option オプション (省略可)
	 * @param outFields 対象外フィールド（例 ['kj_xxx','kj_yyy'] )
	 */
	resetKjs(resetBtnElm,formElm,option,outFields){

		// 検索ボタン要素をjQueryオブジェクトに変換する
		var btnElm; // 検索ボタン要素
		if(resetBtnElm instanceof jQuery){
			btnElm = resetBtnElm;
		}else{
			btnElm = jQuery(resetBtnElm);
		}

		// オプションの初期セット
		if(option == null){
			option = {};
		}
		if(this._empty(option['form_slt'])){
			option['form_slt'] = '.form_kjs';
		}
		if(this._empty(option['inp_slt'])){
			option['inp_slt'] = '.kjs_inp';
		}
		if(this._empty(option['def_slt'])){
			option['def_slt'] = '.def_kjs_json';
		}

		// 対象外ハッシュの作成
		var outs = {};
		if(!this._empty(outFields)){
			for(var i in outFields){
				var f = outFields[i];
				outs[f] = 1;
			}
		}

		// form要素が空なら生成する
		if(!formElm){
			var form_slt = option['form_slt'];
			formElm = btnElm.parents(form_slt);
		}

		// デフォルト検索条件JSONを取得する。空なら処理抜け。
		var def_kjs_json = formElm.find(option['def_slt']).val();
		if(this._empty(def_kjs_json)) return;
		var protoDefKjs = JSON.parse(def_kjs_json);

		// デフォルト検索条件データの構造変換
		var defKjs = {};
		for(var i in protoDefKjs){
			var ent = protoDefKjs[i];
			defKjs[ent.name] = ent.def;
		}

		// form要素内の入力要素群をループする。
		var inp_slt =  option['inp_slt'];
		formElm.find(inp_slt).each((i,elm)=>{

			// 要素から選択値を取得する
			var kjsElm = jQuery(elm);

			// 選択値が空でない場合（0も空ではない扱い）
			var field = kjsElm.attr('name'); // 要素のname属性から検索条件フィールドを取得する

			// デフォルト検索条件を要素にセットする
			if(defKjs[field]!==null && outs[field]==null){
				kjsElm.val(defKjs[field]);
			}

		});

	}



	/**
	 * 現在の検索条件がデフォルトの検索条件を比較し、検索初期状態であるかチェックする。
	 * 
	 * @param outFields 比較対象外フィールド配列
	 * @param kjs 検索条件情報(省略可）
	 * @param defKjs デフォルト検索条件（省略可）
	 * @returns 検索初期状態 0:初期状態でない , 1:初期状態
	 */
	isDefaultKjs(outFields,kjs,defKjs){

		// 検索条件情報が省略されている場合はHTMLの埋込JSONから取得する。
		if(kjs==null){
			var kjs_json = $('#kjs_json').html();
			kjs = JSON.parse(kjs_json);
		}

		// デフォルト検索条件が省略されている場合はHTMLの埋込JSONから取得する。
		if(defKjs==null){
			var defKjsJson = $('#defKjsJson').val();
			defKjs = JSON.parse(defKjsJson);
		}

		// 比較対象外フィールドマッピング
		var outFieldMap = {};
		for(var i in outFields){
			var field = outFields[i];
			outFieldMap[field] = 1;
		}

		var is_def_flg = 1; // 検索初期状態

		for(var field in defKjs){

			// 対象外フィールドに存在するフィールドであればコンテニュー。
			if(outFieldMap[field]){
				continue;
			}

			if(kjs[field] === null){
				continue;
			}else{

				// null,null,空文字はnullとして扱う。
				var kjs_value = kjs[field];
				if(this._emptyNotZero(kjs_value)){
					kjs_value = null;
				}
				
				var def_value = defKjs[field];
				if(this._emptyNotZero(def_value)){
					def_value = null;
				}

				// 値が異なるのであれば検索初期状態 は初期状態でないと判定する。
				if(kjs_value != def_value){

					is_def_flg = 0;
					break
				}
				
			}

		}

		return is_def_flg;

	}



	/**
	* name属性またはclass属性からフィールド名を取得する
	* 
	* @note
	* class属性が複数である場合、先頭のclass属性を取得する
	*
	* @parma elm 入力要素オブジェクト
	* @return フィールド名
	*/
	_getFieldByNameOrClass(elm){

		var field = elm.attr('name');
		if(!field){
			field = elm.attr('class');
		}

		if(!field){
			return field;
		}

		field = field.trim();
		var a = field.indexOf(' ');
		if(a != -1){
			field = field.substr(0,field.length - a);
		}

		return field;
	}


	/**
	* class属性またはname属性からフィールド名を取得する
	* 
	* @note
	* class属性が複数である場合、先頭のclass属性を取得する
	*
	* @parma elm 入力要素オブジェクト
	* @return フィールド名
	*/
	_getFieldByClassOrName(elm){

		var field = elm.attr('class');
		if(!field){
			field = elm.attr('name');
		}

		if(!field){
			return field;
		}

		field = field.trim();
		var a = field.indexOf(' ');
		if(a != -1){
			field = field.substr(0,field.length - a);
		}

		return field;
	}

	/**
	 * 対象文字列をID属性とセレクタに分類する
	 * @param slt 対象文字列
	 * @returns res
	 *  - xid ID属性
	 *  - slt セレクタ
	 */
	_classifySlt(slt){

		var xid='';
		var slt2 = '';

		if(!slt){
			return res = {
					'xid':xid,
					'slt':slt2
			}
		}

		var s1 = slt.charAt(0);
		if(s1=='#'){
			xid = slt.replace('#','');
			slt2 = slt;
		}else{
			xid = slt;
			slt2 = '#' + slt;
		}

		var res = {
				'xid':xid,
				'slt':slt2
		}

		return res;
	}


	//XSSサニタイズエンコード
	_xssSanitaizeEncode(str){
		if(typeof str == 'string'){
			return str.replace(/</g, '&lt;').replace(/>/g, '&gt;').replace('/&/','&amp;');;
		}else{
			return str;
		}
	}

	//XSSサニタイズデコード
	_xssSanitaizeDecode(str){
		if(typeof str == 'string'){
			return str.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&');
		}else{
			return str;
		}
	}

	// 改行をBRタグに変換
	_nl2br(str) {
		if(typeof str == 'string'){
			return str.replace(/[\n\r]/g, "<br>");
		}else{
			return str;
		}
	}

	// 空判定
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
	 * 空判定 | ただし「0」はfalseを返す
	 * @param v
	 */
	_emptyNotZero(v){
		var res = this._empty(v);
		if(res){
			if(v===0 || v==='0'){
				res = false;
			}
		}
		return res;
	}

	/**
	 * URLクエリデータを取得する
	 * 
	 * @return object URLクエリデータ
	 */
	_getUrlQuery(){
		query = window.location.search;

		if(query =='' || query==null){
			return {};
		}
		var query = query.substring(1,query.length);
		var ary = query.split('&');
		var data = {};
		for(var i=0 ; i<ary.length ; i++){
			var s = ary[i];
			var prop = s.split('=');

			data[prop[0]]=prop[1];

		}	
		return data;
	}


	/**
	 * 入力フォームストラテジーのセッター
	 * @param obj 入力フォームストラテジーのオブジェクト
	 */
	setShowFormStrategy(obj){
		this.showFormStrategy = obj;
	}



	/**
	 * 要素の種類を問わずに値をセットする
	 * @param elm 要素(jQueryオブジェクト）
	 * @pramm v 値
	 * @version 1.0
	 */
	_setValueEx(elm,v){

		if(!elm[0]){
			return;
		}

		var tagName = elm.get(0).tagName; // 入力要素のタグ名を取得する

		// 値を入力フォームにセットする。
		if(tagName == 'INPUT' || tagName == 'SELECT'){

			// type属性を取得
			var typ = elm.attr('type');

			if(typ=='checkbox'){
				if(v ==0 || v==null || v==''){
					elm.prop("checked",false);
				}else{
					elm.prop("checked",true);
				}
			}

			else if(typ=='radio'){
				var f = elm.attr('name');
				var parElm = elm.parent();
				var opElm = parElm.find("[name='" + f + "'][value='" + v + "']");
				if(opElm[0]){
					opElm.prop("checked",true);
				}
			}
			else{

				if(typeof v == 'string'){
					v = v.replace(/&lt;/g, '<').replace(/&gt;/g, '>');
				}
				elm.val(v);
			}
		}

		// テキストエリア用のセット
		else if(tagName == 'TEXTAREA'){

			if(v!="" && v!=null){
				v=v.replace(/<br>/g,"\r");

				if(typeof v == 'string'){
					v = v.replace(/&lt;/g, '<').replace(/&gt;/g, '>');
				}
			}

			elm.val(v);

		}

		// IMGタグへのセット
		else if(tagName == 'IMG'){
			// IMG要素用の入力フォームセッター
			elm.attr('src',v);

		}

		// audioタグへのセット
		else if(tagName == 'AUDIO'){
			elm.attr('src',v);

		}else{
			if(v!="" && v!=null){
				v=v.replace(/<br>/g,"\r");
				if(typeof v == 'string'){
					v = v.replace(/</g, '&lt;').replace(/>/g, '&gt;');
				}
				v = v.replace(/\r\n|\n\r|\r|\n/g,'<br>');// 改行コートをBRタグに変換する
			}

			elm.html(v);
		}

	}
	
	
	/**
	 * 自動保存の依頼をする
	 * 
	 * @note
	 * バックグランドでHTMLテーブルのデータをすべてDBへ保存する。
	 * 二重処理を防止するメカニズムあり。
	 * 
	 * @param data 保存対象データ   省略した場合、HTMLテーブルのデータを保存する。
	 * @parma option 
	 *  - reflect_on_tbl 0:HTMLテーブルにdataを反映しない , 1:HTMLテーブルにdataを反映する
	 */
	saveRequest(data,option){
		this.autoSave.saveRequest(data,option);// 保存依頼
	}
	
	
	/**
	 * Ajax送信データ用エスケープ。実体参照（&lt; &gt; &amp; &）を記号に戻す。
	 * 
	 * @param any data エスケープ対象 :文字列、オブジェクト、配列を指定可
	 * @returns エスケープ後
	 */
	escapeForAjax(data){
		if (typeof data == 'string'){
			if ( data.indexOf('&') != -1) {
				data = data.replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
				return encodeURIComponent(data);
			}else{
				return data;
			}
		}else if (typeof data == 'object'){
			for(var i in data){
				data[i] = this.escapeForAjax(data[i]);
			}
			return data;
		}else{
			return data;
		}
	}
	
	/**
	 * 行入替後の処理
	 */
	rowExchangeAfter(){

		var data = this.getDataFromTbl();// Htmlテーブルからデータを取得
		
		var page_no = jQuery("#page_no").val() * 1;
		var limit = jQuery("#limit").val() * 1;

		// データに順番をセットする
		var sort_no = (page_no * limit) + 1;
		
		for(var i in data){
			var ent = data[i];
			ent['sort_no'] = sort_no;
			sort_no ++;
		}
		
		var option = {
				'reflect_on_tbl':1, // 1:HTMLテーブルにdataを反映する
		}
		this.saveRequest(data,option);// 自動保存の依頼をする
	}
	

}


