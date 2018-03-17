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
 * @date 2016-9-21 | 2018-3-13
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
 *  - delete_reg_url	削除登録サーバーURL
 *  - auto_save_url	自動保存サーバーURL
 *  - form_position	フォーム位置 auto:自動, left:左側表示, center:中央表示, right:右側表示,max:横幅いっぱい
 *  - form_width	フォーム横幅	数値で指定。未指定（null)である場合、autoと同様になる。ただしform_positionがmaxなら横幅最大になる。
 *  - form_height	フォーム縦幅	上記と同じ
 *  - file_uploads	ファイルアップロードデータ
 *  - upload_file_dir	アップロードファイルディレクトリ
 *  - preview_img_width		プレビュー画像・横幅
 *  - preview_img_height	プレビュー画像・縦幅
 *  - callback_after_file_change(e,field,form_type,fileName)	ファイルチェンジ後のコールバック
 *  - form_z_index	重なり順序(cssのz-indexと同じ)
 *  - valid_msg_slt	バリデーションメッセージセレクタ
 *  - auto_close_flg	自動閉フラグ	0:自動で閉じない  1:フォームの外側をクリックすると自動的に閉じる（デフォルト）
 *  - ni_tr_place	新規入力追加場所フラグ 0:末尾 , 1:先頭
 *  @param array fieldData フィールドデータ（フィールド名の配列。フィード名の順番は列並びと一致していること）
 */

class CrudBase extends CrudBaseBase{

	/**
	 * コンストラクタ
	 * 
	 * @param param
	 * - flg
	 */
	constructor(param,fieldData){

		super();
		
		// --- 初期化: CrudBaseBaseクラスのメンバを初期化する ----
		
		// パラメータに空プロパティがあれば、デフォルト値をセットする
		this.param = this._setParamIfEmpty(param);

		// フォーム情報の取得と初期化
		this.formInfo = this._initFormInfo(this.param);

		// フィールドデータにプロパティを追加する
		this.fieldData = this._addMoreFieldData(this.param.tbl_slt,this.fieldData);

		// フィールドデータへフォーム内の要素情報をセットする
		this.fieldData = this._setFieldDataFromForm(this.fieldData,this.formInfo,'new_inp');
		this.fieldData = this._setFieldDataFromForm(this.fieldData,this.formInfo,'edit');
		this.fieldData = this._setFieldDataFromForm(this.fieldData,this.formInfo,'del');

		// フィールドデータにファイル要素の情報をセット、およびファイルチェンジイベントを登録する。
		this.fieldData = this._initFileUpData(this.fieldData);

		// フィールドハッシュテーブルをフィールドデータから生成する。
		this.fieldHashTable = this._createFieldHashTable(this.fieldData);

		// デフォルト新規入力エンティティを新規入力フォームから取得する
		this.defNiEnt = this._getEntByForm('new_inp');
		
		// テーブルオブジェクト
		this.tbl = jQuery('#' + this.param.tbl_slt);
		
		// 自動保存機能の初期化
		this.autoSave = new CrudBaseAutoSave(this);
		
		// 行入替機能の初期化
		this.rowExchange = new CrudBaseRowExchange(this,null,()=>{
			this.rowExchangeAfter();
		});
		
		// 行入替機能のボタン表示切替
		var row_exc_flg = jQuery('#row_exc_flg').val();
		this.rowExcBtnShow(row_exc_flg);
		
		// --------

	}





	/**
	 * 新規入力フォームを表示
	 * @param option オプション（現バージョンでは未使用）
	 * @param callBack フォームに一覧の行データを自動セットしたあとに呼び出されるコールバック関数(省略可）
	 */
	newInpShow(elm,option,callBack){
		var info = this.formInfo['new_inp'];

		info.show_flg=1; // 表示制御フラグを表示中にする

		// デフォルト新規入力エンティティを新規入力フォームにセットする
		this.setFieldsToForm('new_inp',this.defNiEnt);

		var form = this.getForm('new_inp');// フォーム要素を取得

		// フォーム種別をフォーム内の指定入力要素へセット
		this.setValueToFrom(form,'form_type','new_inp');

		// バリデーションエラーメッセージをクリアする
		this._clearValidErr(form);

		// コールバックを実行する
		if(callBack){
			var c_param ={'form':form};
			callBack(c_param);
		}

		// triggerElm要素の下付近に入力フォームを表示する。
		this._showForm(form,elm,option);
	}


	/**
	 * 編集フォームを表示
	 * 
	 * @param elm 編集ボタン要素
	 * @param option オプション（省略可）
	 *           -  upload_file_dirアップロードファイルディレクトリ
	 * @param callBack フォームに一覧の行データを自動セットしたあとに呼び出されるコールバック関数(省略可）
	 */
	editShow(elm,option,callBack){

		var tr=jQuery(elm).parents('tr'); // 先祖をさかのぼりtr要素を取得する
		this.param.active_row_index = tr.index(); // 行番（インデックス）を取得する

		var info = this.formInfo['edit'];

		info.show_flg=1; // 表示制御フラグを表示中にする

		// TR要素からエンティティを取得する
		var ent = this.getEntityByTr(tr);

		// フォームに親要素内の各フィールド値をセットする。
		this.setFieldsToForm('edit',ent,option);

		var form = jQuery(info.slt);// 編集フォーム要素を取得

		// バリデーションエラーメッセージをクリアする
		this._clearValidErr(form);

		// コールバックを実行する
		if(callBack){
			callBack(tr,form,ent);
		}

		// triggerElm要素の下付近に入力フォームを表示する。
		this._showForm(form,elm,option);
	}


	/**
	 * 複製による新規入力フォーム表示
	 * 
	 * @note
	 * 複製元のデータがあらかじめ入力された状態で新規入力フォームを表示する。
	 * 
	 * @param elm 複製ボタン要素
	 * @param option オプション（省略可）
	 *           -  upload_file_dirアップロードファイルディレクトリ
	 * @param callBack フォームに一覧の行データを自動セットしたあとに呼び出されるコールバック関数(省略可）
	 * 
	 */
	copyShow(elm,option,callBack){

		var tr=jQuery(elm).parents('tr'); // 先祖をさかのぼりtr要素を取得する
		this.param.active_row_index = tr.index(); // 行番（インデックス）を取得する

		var info = this.formInfo['new_inp'];

		info.show_flg=1; // 表示制御フラグを表示中にする

		// TR要素からエンティティを取得する
		var ent = this.getEntityByTr(tr);

		var form = this.getForm('copy');

		// フォーム種別をフォーム内の指定入力要素へセット
		this.setValueToFrom(form,'form_type','copy');

		// 行番を取得し、要素にセットする
		var row_index = tr.index(); // 行番（インデックス）を取得する
		this.setValueToFrom(form,'row_index',row_index);

		// フォームにエンティティの値をセットする
		this.setFieldsToForm('new_inp',ent,option);

		// バリデーションエラーメッセージをクリアする
		this._clearValidErr(form);

		// コールバックを実行する
		if(callBack){
			callBack(tr,form,ent);
		}

		// triggerElm要素の下付近に入力フォームを表示する。
		this._showForm(form,elm,option);

	}


	/**
	 * 削除フォーム表示
	 * 
	 * @param elm 削除ボタン要素
	 * @param option オプション（省略可）
	 *           -  upload_file_dirアップロードファイルディレクトリ
	 * @param callBack フォームに一覧の行データを自動セットしたあとに呼び出されるコールバック関数(省略可）
	 * 
	 */
	deleteShow(elm,option,callBack){
		var tr=jQuery(elm).parents('tr'); // 先祖をさかのぼりtr要素を取得する
		this.param.active_row_index = tr.index(); // 行番（インデックス）を取得する

		var info = this.formInfo['del'];

		info.show_flg=1; // 表示制御フラグを表示中にする

		// TR要素からエンティティを取得する
		var ent = this.getEntityByTr(tr);

		var form = jQuery(info.slt);// 削除フォーム要素を取得

		// フォームに親要素内の各フィールド値をセットする。
		this.setFieldsToForm('del',ent,option);

		// コールバックを実行する
		if(callBack){
			callBack(tr,form,ent);
		}

		// triggerElm要素の下付近に入力フォームを表示する。
		this._showForm(form,elm,option);

	}



	/**
	 * 新規入力登録
	 * @param beforeCallBack Ajax送信前のコールバック（送信データを編集できる）
	 * @param afterCallBack Ajax送信後のコールバック
	 * @param option オプション 
	 * - add_row_index 追加行インデックス :テーブル行の挿入場所。-1にすると末尾へ追加。-1がデフォルト。
	 * - wp_action WPアクション: WordPressでは必須
	 * - wp_nonce  WPノンス: WordPressのトークン的なもの（なくても動くがセキュリティが下がる）
	 */
	newInpReg(beforeCallBack,afterCallBack,option){

		var form = this.getForm('new_inp'); // 入力フォーム要素のオブジェクトを取得する

		// バリデーション
		var res = this._validationCheckForm('new_inp');
		if(res == false){
			return;
		}

		if(this._empty(option)){
			option = {};
		}


		// フィールドデータからファイルアップロード要素であるフィールドリストを抽出する
		var fuEnts = this._extractFuEnt(this.fieldData,'new_inp');

		// ファイルアップロード関連のエンティティをFormDataに追加する
		var fd = new FormData();
		fd = this._addFuEntToFd(fd,fuEnts,'new_inp');

		// 新規入力フォームからエンティティを取得およびJSON化し、FormDataにセットする
		var ent = this._getEntByForm('new_inp');

		// idに値がセットされ編集扱いとなっている場合、IDフラグをtrueにする。
		var id_flg = false;
		if(!this._empty(ent['id'])){
			id_flg = true;
		}

		// Ajax送信前のコールバックを実行する
		if(beforeCallBack){

			var bcRes = beforeCallBack(ent,fd);
			if(bcRes['err']){
				this._errShow(bcRes['err'],'new_inp');// エラーを表示
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

		// フォーム種別を取得してFDにセット
		var form_type = this.getValueFromForm(form,'form_type');

		fd.append( "form_type", form_type );

		// 諸パラメータから追加行インデックスを決定する
		var add_row_index = this._decAddRowIndex(form,form_type,option);


		jQuery.ajax({
			type: "post",
			url: this.param.new_reg_url,
			data: fd,
			cache: false,
			dataType: "text",
			processData: false,
			contentType : false,
		})
		.done((str_json, type) =>{

			var ent;
			try{
				ent =jQuery.parseJSON(str_json);//パース

			}catch(e){
				alert('エラー');
				jQuery("#err").html(str_json);
				return;
			}

			if(ent['err']){

				// エラーをフォームに表示する
				this._showErrToForm(ent['err'],'new_inp');

			}else{

				// IDがセットされて、編集扱いとなっている場合はリロードする。
				if(id_flg==true){
					location.reload(true);
				}

				// 新しい行を作成する
				this._addTr(ent,add_row_index);

				// 登録後にコールバック関数を非同期で実行する
				if(afterCallBack != null){
					window.setTimeout(()=>{
						afterCallBack(ent);
						}, 1);
				}

				this.closeForm('new_inp');// フォームを閉じる

			}

		})
		.fail((jqXHR, statusText, errorThrown) =>{
			jQuery('#err').html(jqXHR.responseText);//詳細エラーの出力
			alert(statusText);
		});

	}


	
	
	/**
	 * 編集登録
	 * @param beforeCallBack Ajax送信前のコールバック（送信データを編集できる）
	 * @param afterCallBack Ajax送信後のコールバック
	 * @param option オプション
	 * - wp_action :WPアクション	WordPressでは必須
	 * - wp_nonce  :WPノンス	WordPressのトークン的なもの（なくても動くがセキュリティが下がる）
	 * 
	 */
	editReg(beforeCallBack,afterCallBack,option){
		// バリデーション
		var res = this._validationCheckForm('edit');
		if(res == false){
			return;
		}

		if(this._empty(option)){
			option = {};
		}

		// アクティブ行インデックスを取得する
		var index = this.param.active_row_index; 

		// 編集フォームからエンティティを取得する。
		var ent = this._getEntByForm('edit');

		// フィールドデータからファイルアップロード要素であるフィールドリストを抽出する
		var fuEnts = this._extractFuEnt(this.fieldData,'edit');

		// ファイルアップロード関連のエンティティをFormDataに追加する
		var fd = new FormData();
		fd = this._addFuEntToFd(fd,fuEnts,'edit');

		// Ajax送信前のコールバックを実行する
		if(beforeCallBack){

			var bcRes = beforeCallBack(ent,fd);
			if(bcRes['err']){
				this._errShow(bcRes['err'],'edit');// エラーを表示
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

		fd.append( "form_type", 'edit' );

		jQuery.ajax({
			type: "post",
			url: this.param.edit_reg_url,
			data: fd,
			cache: false,
			dataType: "text",
			processData: false,
			contentType: false,

		}).done((str_json, type) => {
			var ent = null;
			try{
				var ent =jQuery.parseJSON(str_json);//パース

			}catch(e){
				alert('エラー');
				console.log(str_json);
				jQuery("#err").html(str_json);
			}

			// 編集中の行にエンティティを反映する。
			if(ent){
				if(ent['err']){

					// エラーをフォームに表示する
					this._showErrToForm(ent['err'],'edit');
					return;
				}
				
				// 削除フラグがONである場合、削除中の行を一覧から隠す
				if(this.param['kj_delete_flg'] == 0 && ent['delete_flg']==1){
					this._hideTr(index);// 削除中の行を一覧から隠す
				}

				// 編集中のTR要素を取得する
				var tr = this.getTrInEditing();

				// エンティティのIDとTR要素のIDが不一致である場合、ブラウザをリロードする
				if(ent['id'] !=tr.find('.id').text()){
					location.reload(true);
				}

				// TR要素にエンティティの値をセットする
				this._setEntityToEditTr(ent,tr);

				// 登録後にコールバック関数を非同期で実行する
				if(afterCallBack != null){
					window.setTimeout(()=>{
						afterCallBack(ent);
					}, 1);
				}
	
				this.closeForm('edit');// フォームを閉じる
				

			}

		}).fail((jqXHR, statusText, errorThrown) => {
			jQuery('#err').html(jqXHR.responseText);//詳細エラーの出力
			alert(statusText);
		});
	}



	/**
	 * 削除登録
	 * @param beforeCallBack Ajax送信前(削除前）のコールバック（送信データを編集できる）
	 * @param afterCallBack Ajax送信後(削除後）のコールバック
	 * @param option オプション
	 * - wp_action :WPアクション	WordPressでは必須
	 * - wp_nonce  :WPノンス	WordPressのトークン的なもの（なくても動くがセキュリティが下がる）
	 */
	deleteReg (beforeCallBack,afterCallBack,option){

		var row_index = this.param.active_row_index; // アクティブ行インデックス

		// 削除フォームからエンティティを取得する
		var ent = this._getEntByForm('delete');

		if(beforeCallBack){
			beforeCallBack(ent);
		}

		// 削除を実行
		this._deleteRegBase(ent,row_index,beforeCallBack,afterCallBack,option);

	}



	/**
	 * 行番号を指定して削除登録を行う。
	 * @param row_index 行番号
	 * @param beforeCallBack Ajax送信前(削除前）のコールバック（送信データを編集できる）
	 * @param afterCallBack Ajax送信後(削除後）のコールバック
	 */
	deleteRegByRowIndex(row_index,beforeCallBack,afterCallBack){

		// HTMLテーブルから行番を指定してエンティティを取得する
		var ent = this.getEntity(row_index);

		// 削除を実行
		this._deleteRegBase(ent,row_index,beforeCallBack,afterCallBack)

	}


	/**
	 * フォームを閉じる
	 * @parma string form_type new_inp:新規入力 edit:編集 delete:削除
	 */
	closeForm(form_type){

		// フォーム情報を取得
		var fi = this.formInfo[form_type];

		// フォームのオブジェクトを取得する
		var form = fi.form;

		// フォームを隠す
		form.hide();

	}
	
	
	/**
	 * 行入替機能のフォームを表示
	 * @param btnElm ボタン要素
	 */
	rowExchangeShowForm(btnElm){
		this.rowExchange.showForm(btnElm);
	}
	
	/**
	 * 行入替ボタンの表示切替
	 * @param int row_exc_flg 行入替機能フラグ 0:ボタン非表示 , 1:ボタン表示
	 */
	rowExcBtnShow(row_exc_flg){
		
		if(row_exc_flg == 1){
			jQuery('.row_exc_btn').show();
		}else{
			jQuery('.row_exc_btn').hide();
		}
	}
	

}


