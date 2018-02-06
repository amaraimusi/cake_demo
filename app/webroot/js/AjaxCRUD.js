/**
 * AjaxCRUD.js
 * 
 * @note
 * AjaxによるCRUD。
 * デフォルトでは、削除、編集、新規追加するたびにAjax通信を行う仕様である。
 * 削除、編集、新規追加するたびに更新するのが重い場合、適用ボタンで一括適用するモードも備える。
 * 
 * 課題
 * td内部へのSetやGetは、先頭要素とtd直下にしか対応していない。
 * 複雑なtd内部にも対応するとなるとコールバックを検討しなければならない。
 * 
 * @date 2016-9-21 | 2016-12-1
 * @version 1.2 copyAddShowメソッドを追加
 * 
 * @param object param
 *  - tbl_slt	CRUD対象テーブルセレクタ
 *  - edit_form_slt	編集フォームセレクタ
 *  - new_form_slt	新規フォームセレクタ
 *  - delete_form_slt	削除フォームセレクタ
 *  - edit_reg_url	編集登録サーバーURL
 *  - new_reg_url	新規登録サーバーURL
 *  - delete_reg_url	削除登録サーバーURL
 *  - form_position	フォーム位置 auto:自動, left:左側表示, center:中央表示, right:右側表示
 *  - form_width	フォーム横幅
 *  - form_height	フォーム縦幅
 *  - file_uploads	ファイルアップロードデータ
 *  - upload_file_dir	アップロードファイルディレクトリ
 *  - preview_img_width		プレビュー画像・横幅
 *  - preview_img_height	プレビュー画像・縦幅
 *  @param array fieldData フィールドデータ（フィールド名の配列。フィード名の順番は列並びと一致していること）
 */
var AjaxCRUD =function(param,fieldData){

	this.param = param;
	this.fieldData = fieldData; // フィールドデータ
	this.fieldHashTable = []; // フィールドハッシュテーブル key:フィールド名  val:列インデックス
	this.formInfo; // フォーム情報
	this.editRowIndex;// 編集行のインデックス
	this.deleteRowIndex;// 削除行のインデックス

	

	// 自分自身のインスタンス。  プライベートメソッドやコールバック関数で利用するときに使う。
	var myself=this;

	/**
	 * コンストラクタ
	 */
	this.constract=function(){
		
		// パラメータに空プロパティがあれば、デフォルト値をセットする
		this.param = setParamIfEmpty(this.param);
		
		// フォーム情報の取得と初期化
		this.formInfo = initFormInfo(this.param);

		// フィールドデータにプロパティを追加する
		this.fieldData = addMoreFieldData(this.param.tbl_slt,this.fieldData);

		// フィールドデータへフォーム内の要素情報をセットする
		this.fieldData = setFieldDataFromForm(this.fieldData,this.formInfo,'new_inp');
		this.fieldData = setFieldDataFromForm(this.fieldData,this.formInfo,'edit');
		this.fieldData = setFieldDataFromForm(this.fieldData,this.formInfo,'del');
		
		// フィールドデータにファイル要素の情報をセット、およびファイルチェンジイベントを登録する。
		this.fieldData = initFileUpData(this.fieldData);

		
		// フィールドハッシュテーブルをフィールドデータから生成する。
		this.fieldHashTable = createFieldHashTable(this.fieldData);

	};
	
	
	function fileChangeEventNewInp(e){
		var elm = $(this);
		var field = getFieldByNameOrClass(elm);
		
		// ファイルアップロードのチェンジイベント
		fileChangeEvent(e,field,'new_inp');
	};
	
	

	function fileChangeEventEdit(e){
		var elm = $(this);
		var field = getFieldByNameOrClass(elm);
		
		// ファイルアップロードのチェンジイベント
		fileChangeEvent(e,field,'edit');
	};
	
	

	function fileChangeEventDel(e){
		var elm = $(this);
		var field = getFieldByNameOrClass(elm);
		
		// ファイルアップロードのチェンジイベント
		fileChangeEvent(e,field,'del');
	};
	
	/**
	 * ファイルアップロードのチェンジイベント
	 * @param e イベント
	 * @param field フィールド
	 * @param formType フォーム種別
	 */
	function fileChangeEvent(e,field,formType){
		
		// エンティティおよび入力要素エンティティを取得する
		var ent = getFieldEntByField(field);
		var inpKey = 'inp_' + formType;
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
		reader.onload = function(evt) {
			
			// accept属性を取得する
			var accept = inp_ent.accept;

			
			// accept属性が空もしくは画像系であるかチェックする
			if (accept == '' || accept.indexOf('image') >= 0){

				//画像プレビュー要素を取得。（なければ作成）
				imgElm = getPreviewImgElm(inp_ent);

				
				// A thumbnail image preview.
				imgElm.attr('src',reader.result);
				
			} 

		}

		
		
	}
	
	
	// 画像プレビュー要素を取得。（なければ作成）
	function getPreviewImgElm(inp_ent){
		

		var fileElm = inp_ent.elm;

		var preview_slt = inp_ent.preview_slt;
		
		var imgElm = $('#' + preview_slt);
		if(!imgElm[0]){
			var preview_img_html = "<div class='upload_img_iuapj'><img id='" + preview_slt +"'/></div>";
			fileElm.after(preview_img_html);
			imgElm=$('#' + preview_slt);
			
			imgElm.attr({
				'width':myself.param.preview_img_width,
				'height':myself.param.preview_img_height,
				
			});
			
		}else{
			imgElm.show();
		}
		return imgElm;
	}
	
	
	// オーディオプレビュー要素を取得。（なければ作成）
	function getPreviewAdoElm(inp_ent,fp){
		

		var fileElm = inp_ent.elm;

		var preview_slt = inp_ent.preview_slt;
		
		var adoElm = $('#' + preview_slt);
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
	 * 編集フォームを表示
	 * 
	 * @param elm 編集ボタン要素
	 * @param option オプション（省略可）
	 *           -  upload_file_dirアップロードファイルディレクトリ
	 * @param callBack フォームに一覧の行データを自動セットしたあとに呼び出されるコールバック関数(省略可）
	 */
	this.editShow = function(elm,option,callBack){
	
		var tr=$(elm).parents('tr'); // 先祖をさかのぼりtr要素を取得する
		myself.editRowIndex = tr.index(); // 行番（インデックス）を取得する
		
		
		var info = myself.formInfo['edit'];

		info.show_flg=1; // 表示制御フラグを表示中にする
		

		// TR要素からエンティティを取得する
		var ent = myself.getEntityByTr(tr);
		
	
		var form = $(info.slt);// 編集フォーム要素を取得
		
		// オプションからアップロードファイルディレクトリを取得する
		var upload_file_dir = undefined;
		if(option){
			upload_file_dir = option['upload_file_dir'];
		}
		
		// フォームに親要素内の各フィールド値をセットする。
		setFieldsToForm('edit',form,ent,upload_file_dir);
		
		// コールバックを実行する
		if(callBack){
			callBack(tr,form,ent);
		}
		
		
		// triggerElm要素の下付近に入力フォームを表示する。
		showForm(form,elm);
		


	};
	
	

	
	
	
	
	/**
	 * 新規入力フォームを表示
	 */
	this.newInpShow = function(elm){


		var info = myself.formInfo['new_inp'];

		info.show_flg=1; // 表示制御フラグを表示中にする
		
		var form = $(info.slt);// フォーム要素を取得
		

		// triggerElm要素の下付近に入力フォームを表示する。
		showForm(form,elm);


	};
	
	
	
	
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
	this.copyAddShow = function(elm,option,callBack){


		var tr=$(elm).parents('tr'); // 先祖をさかのぼりtr要素を取得する
		myself.editRowIndex = tr.index(); // 行番（インデックス）を取得する
		
		
		var info = myself.formInfo['new_inp'];

		info.show_flg=1; // 表示制御フラグを表示中にする
		

		// TR要素からエンティティを取得する
		var ent = myself.getEntityByTr(tr);
		
	
		var form = $(info.slt);// 編集フォーム要素を取得
		
		// オプションからアップロードファイルディレクトリを取得する
		var upload_file_dir = undefined;
		if(option){
			upload_file_dir = option['upload_file_dir'];
		}
		
		// フォームに親要素内の各フィールド値をセットする。
		setFieldsToForm('new_inp',form,ent,upload_file_dir);
		
		// コールバックを実行する
		if(callBack){
			callBack(tr,form,ent);
		}
		
		
		// triggerElm要素の下付近に入力フォームを表示する。
		showForm(form,elm);
		
		
		



	};
	
	
	
	
	
	/**
	 * 編集登録
	 */
	this.editReg = function(afterCallBack){

		// バリデーション
		var res = validationCheckForm('edit');
		if(res == false){
			return;
		}
		
		var index = myself.editRowIndex; // 編集行のインデックス
		
		
		var fd = new FormData();
		
		// フィールドデータからファイルアップロード要素であるフィールドリストを抽出する
		fuEnts = extractFuEnt(myself.fieldData,'edit');

		// ファイルアップロード関連のエンティティをFormDataに追加する
		fd = addFuEntToFd(fd,fuEnts,'edit');
		
		// 新規入力フォームからエンティティを取得およびJSON化し、FormDataにセットする
		var ent = getEntByForm('edit');
		var json = JSON.stringify(ent);//データをJSON文字列にする。
		fd.append( "key1", json );

		
		$.ajax({
			type: "POST",
			url: myself.param.edit_reg_url,
			data: fd,
			cache: false,
			dataType: "text",
			processData : false,
			contentType : false,
			success: function(str_json, type) {

				var ent = null;
				try{
					var ent =$.parseJSON(str_json);//パース
					
				}catch(e){
					alert('エラー');
					$("#err").html(str_json);
				}
				
				// 編集中の行にエンティティを反映する。
				if(ent){
					setEntityToEditTr(ent);
					
					// 登録後にコールバック関数を非同期で実行する
					if(afterCallBack != null){
						window.setTimeout(function(){
							afterCallBack(ent);
							}, 1);
					}
					
					myself.closeForm('edit');// フォームを閉じる
				}



			},
			error: function(xmlHttpRequest, textStatus, errorThrown){
				$('#err').html(xmlHttpRequest.responseText);//詳細エラーの出力
				alert(textStatus);
			}
		});
		
	};
	
	
	
	
	
	
	
	
	
	
	/**
	 * 新規入力登録
	 */
	this.newInpReg = function(afterCallBack){


		// バリデーション
		var res = validationCheckForm('new_inp');
		if(res == false){
			return;
		}
		

		var fd = new FormData();
		
		// フィールドデータからファイルアップロード要素であるフィールドリストを抽出する
		fuEnts = extractFuEnt(myself.fieldData,'new_inp');

		// ファイルアップロード関連のエンティティをFormDataに追加する
		fd = addFuEntToFd(fd,fuEnts,'new_inp');
		
		// 新規入力フォームからエンティティを取得およびJSON化し、FormDataにセットする
		var ent = getEntByForm('new_inp');
		var json = JSON.stringify(ent);//データをJSON文字列にする。
		fd.append( "key1", json );
		

		
		$.ajax({
			type: "POST",
			url: myself.param.new_reg_url,
			data: fd,
			cache: false,
			dataType: "text",
			processData : false,
			contentType : false,
			success: function(str_json, type) {

				var ent;
				try{
					ent =$.parseJSON(str_json);//パース
					
		
				}catch(e){
					alert('エラー');
					$("#err").html(str_json);
				}

				
				// 新しい行を作成する
				addTr(ent);
				
				// 登録後にコールバック関数を非同期で実行する
				if(afterCallBack != null){
					window.setTimeout(function(){
						afterCallBack(ent);
						}, 1);
				}
				
				
				myself.closeForm('new_inp');// フォームを閉じる

			},
			error: function(xmlHttpRequest, textStatus, errorThrown){
				$('#err').html(xmlHttpRequest.responseText);//詳細エラーの出力
				alert(textStatus);
			}
		});
		
	};
	
	
	
	
	
	
	
	
	/**
	 * 削除表示
	 * 
	 * @param elm 削除ボタン要素
	 * @param upload_file_dir アップロードファイルディレクトリ（省略可）
	 * 
	 */
	this.deleteShow = function(elm,upload_file_dir){

		var tr=$(elm).parents('tr'); // 先祖をさかのぼりtr要素を取得する
		myself.deleteRowIndex = tr.index(); // 行番（インデックス）を取得する
		
		
		var info = myself.formInfo['del'];

		info.show_flg=1; // 表示制御フラグを表示中にする
		

		// TR要素からエンティティを取得する
		var ent = myself.getEntityByTr(tr);
		
	
		var form = $(info.slt);// 削除フォーム要素を取得
		
		// フォームに親要素内の各フィールド値をセットする。
		setFieldsToForm('del',form,ent,upload_file_dir);
		
		
		// triggerElm要素の下付近に入力フォームを表示する。
		showForm(form,elm);
	};
	
	
	
	
	
	
	
	/**
	 * 削除登録
	 */
	this.deleteReg = function(afterCallBack){

		var index = myself.deleteRowIndex; // 削除行のインデックス
		
		// 削除フォームからエンティティを取得する
		var ent = getEntByForm('delete');
		


		var json = JSON.stringify(ent);//データをJSON文字列にする。

		
		$.ajax({
			type: "POST",
			url: myself.param.delete_reg_url,
			data: "key1="+json,
			cache: false,
			dataType: "text",
			success: function(str_json, type) {

				var ent;
				try{
					ent =$.parseJSON(str_json);//パース

				}catch(e){
					alert('エラー');
					$("#err").html(str_json);
				}
				
				if(!ent){return;}
				
				// 削除中の行を一覧から隠す
				hideTr(index);

				// 登録後にコールバック関数を非同期で実行する
				if(afterCallBack != null){
					window.setTimeout(function(){
						afterCallBack(ent);
						}, 1);
				}
				
				myself.closeForm('del');// フォームを閉じる


			},
			error: function(xmlHttpRequest, textStatus, errorThrown){
				$('#err').html(xmlHttpRequest.responseText);//詳細エラーの出力
				alert(textStatus);
			}
		});
		
	};
	
	
	
	
	
	/**
	 * フォームを閉じる
	 * @parma string formType new_inp:新規入力 edit:編集 delete:削除
	 */
	this.closeForm = function(formType){
		
		// フォーム情報を取得
		var fi = myself.formInfo[formType];
		
		// フォームのオブジェクトを取得する
		var form = fi.form;
		
		// フォームを隠す
		form.hide();
		
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 行番を指定してTR要素を取得する
	 * @param row_index 行番 (-1を指定すると末尾を取得）
	 * @return TR要素
	 */
	this.getTr = function(row_index){

		var slt = '#' + myself.param.tbl_slt + ' tbody tr';
		var tr = $(slt).eq(row_index);
		
		return tr;
	};
	
	
	
	
	
	/**
	 * 現在編集中の行要素を取得する
	 * @return TR要素
	 */
	this.getTrInEditing = function(){

		var slt = '#' + myself.param.tbl_slt + ' tbody tr:eq(' + myself.editRowIndex + ')';
		var tr = $(slt);
		
		return tr;
	};
	
	
	
	/**
	 * 行番とフィールド名からTD要素を取得する
	 * @param row_index 行番(-1で末行を指定）
	 * @param field フィールド名
	 * @return TD要素
	 */
	this.getTd = function(row_index,field){
		
		var tr = this.getTr(row_index); // 行番を指定してTR要素を取得する
		var tdIndex = this.fieldHashTable[field]; // 指定フィールドの列番を取得する
		var td = tr.find('td').eq(tdIndex);// TR要素の列番からTD要素を取得する
		
		return td;
	};
	
	
	
	/**
	 * 現在編集中の行から、指定したフィールドに紐づくTD要素を取得する
	 * @param フィールド
	 * @return TD要素
	 */
	this.getTdInEditing = function(field){
		
		var tr = this.getTrInEditing(); // 現在編集中のTR要素を取得する
		var tdIndex = this.fieldHashTable[field]; // 指定フィールドの列番を取得する
		var td = tr.find('td').eq(tdIndex);// TR要素の列番からTD要素を取得する
		
		return td;
	};
	
	
	
	
	/**
	 * 一覧テーブルの行番からエンティティを取得する
	 * @param row_index 行番(-1は末行)
	 * @return object エンティティ
	 */
	this.getEntity = function(row_index){

		// 行番を指定してTR要素を取得する
		var tr = myself.getTr(row_index);

		// TR要素からエンティティを取得する
		var ent = myself.getEntityByTr(tr);

		return ent;
	};
	
	
	
	
	/**
	 * TR要素からエンティティを取得する
	 * @param TR要素
	 * @return object エンティティ
	 */
	this.getEntityByTr = function(tr){
		
		var ent = {};
		for(var i in myself.fieldData){
			var f = myself.fieldData[i].field;
			var elm = tr.find('.' + f);
			ent[f] = elm.text();
		}
		
		return ent;
		
		

	};
	
	
	
	
	
	/**
	 * 行中の任意要素を指定して、エンティティを取得する
	 * @param elm 行内（TD要素内部）の任意要素
	 * @return エンティティ
	 */
	this.getEntityByInnerElm = function(elm){
		
		// 先祖をさかのぼりtr要素を取得する
		var tr=$(elm).parents('tr');
		
		// 行番（インデックス）を取得する
		var index = tr.index();
		
		// 一覧行から行番にひもづくエンティティを取得する
		var ent = myself.getEntity(index);

		return ent;
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * フォームのバリデーション
	 * @param formType フォーム種別 new_inp:新規入力 edit:編集
	 * @return validFlg バリデーションフラグ true:正常 false:入力エラー
	 */
	function validationCheckForm(formType){
		
		var validFlg = true; // バリデーションフラグ
		
		// フォーム種別からフォーム要素を取得
		var info = myself.formInfo[formType];
		var form = $(info.slt);
		
		form.find('.valid').each(function(){
			var elm = $(this);
			var field = getFieldByNameOrClass(elm);
			
			// 入力要素単位でバリデーションを行う
			var res = validationCheck(elm,field);
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
	function validationCheck(elm,field){
		
		var validFlg = true; // バリデーションフラグ

		var label = $("[for='" + field + "']");
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
	function resetFileUpload(fuEnt){
		fuEnt.evt = null;
		var fileElm = fuEnt.elm;
		try {
			fileElm.val("");
		} catch (e) {
			console.log('It can not be reset in IE ');
		}
		
		// Reset a thubnail preview.
		var imgElm = $('#' + fuEnt.preview_slt);
		imgElm.attr('src','');
		imgElm.hide();

		return fuEnt;
	}

	
	
	
	
	
	// 新しい行を作成する
	function addTr(ent){
		

		
		// テーブルの先頭行をコピーしてTR要素のHTMLを作成する。
		var slt = '#' + myself.param.tbl_slt + ' tbody tr';
		var tr0 = $(slt).eq(0);
		
		// 初回の行作成のみブラウザリロードを行う。
		if(!tr0[0]){
			location.reload(true);
		}

		
		var newTrHtml = "<tr class='new_line'>" + tr0.html() + "</tr>";

		// TR要素を追加する。
		var tbodySlt = '#' + myself.param.tbl_slt + ' tbody';
		$(tbodySlt).append(newTrHtml);
		
		//　TR要素のオブジェクトを取得
		var newTr = $(slt).eq(-1);

		// TR要素にエンティティをセットする
		setEntityToTr(newTr,ent,'new_inp');
		
	}
	
	
	
	// 編集中の行にエンティティを反映する。
	function setEntityToEditTr(ent){
		
		if(ent==null){
			return;
		}

		// 現在編集中の行要素を取得する
		var tr = myself.getTrInEditing();
		
		// TR要素にエンティティをセットする
		setEntityToTr(tr,ent,'edit');
		
		
	};
	
	
	
	/**
	 * TR要素にエンティティをセットする
	 * @param tr TR要素オブジェクト
	 * @param ent エンティティ
	 * @param formType フォーム種別 new_inp,edit,del
	 */
	function setEntityToTr(tr,ent,formType){


		if(ent==null){
			return;
		}
		
		// フォーム種別からフォーム要素を取得
		var info = myself.formInfo[formType];
		var form = $(info.slt);
		
		// TR要素内の各プロパティ要素内にエンティティの値をセットする
		for(var f in ent){
			// 源値要素への反映
			var elm = tr.find('.' + f);
			var v = ent[f];
			if(elm[0]){
				elm.html(v);
			}
			
			//display系要素への反映
			setEntityToTrDisplay(tr,f,v,form);

		}

	};
	
	
	/**
	 * TR要素内のdisplay系要素にエンティティをセットする
	 * @param tr tr要素
	 * @param f フィールド名
	 * @param v 値
	 * @param form フォーム要素
	 */
	function setEntityToTrDisplay(tr,f,v,form){
		
		if(f=='delete_flg'){
			var disp = tr.find('.' + f + '_display');
			
			if(v==0 || v==null || v==''){
				disp.html("<span style='color:#23d6e4;'>有効</span>");
			}else{
				disp.html("<span style='color:#b4b4b4;'>無効</span>");
			}
			return;
		}

		
		
		// class属性またはname属性を指定して入力要素を取得する。
		var inp = form.find('.' + f);
		if(inp[0]==undefined){
			inp = form.find("[name='" + f + "']")		}
		
		// 入力要素が取得できなければ処理抜けする
		if(inp[0]==undefined){
			return;
		}
		
		var tagName = inp.get(0).tagName; // 入力要素のタグ名を取得する
		
		if(tagName=='INPUT'){
			
			// type属性を取得
			var typ = inp.attr('type');
			
			
			
			
			if(typ=='radio'){
				var opElm = form.find("[name='" + f + "']:checked");
				if(!opElm[0]){
					return;
				}
				
				var dVal = opElm.parent('label').text();
				
				// display系要素を取得し、表記をセットする。
				var disp = tr.find('.' + f + '_display');
				if(!disp[0]){
					return;
				}
				disp.html(dVal);

			}
			
			
			
			
		}
		
		else if(tagName=='SELECT'){

			// フォームのSELECT要素から表記を取得する
			var opElm = inp.find("option[value='" + v + "']");
			if(!opElm[0]){
				return;
			}
			var dVal = opElm.html();// 表記
			
			// display系要素を取得し、表記をセットする。
			var disp = tr.find('.' + f + '_display');
			if(!disp[0]){
				return;
			}
			disp.html(dVal);
			
		}
		
	};
	
	
	
	
	
	
	// 行番に紐づく行を隠す
	function hideTr(row_index){
		
		var tr = myself.getTr(row_index);
		tr.hide();
	};
	
	
	
	
	
	
	
	
	
	
	/**
	 * 編集フォームからエンティティを取得する
	 * @param string form_flg フォームフラグ  edit or new
	 * @return エンティティ
	 */
	function getEntByForm(form_flg){
		
		// 現在編集中の行要素を取得する
		var tr = myself.getTrInEditing();

		// TR要素からエンティティを取得する
		var ent = {};
		
		var form;
		if(form_flg=='new_inp'){
			form = $('#' + myself.param.new_form_slt);
		}else if(form_flg=='edit'){
			form = $('#' + myself.param.edit_form_slt);
			ent = myself.getEntityByTr(tr);
		}else if(form_flg=='delete'){
			form = $('#' + myself.param.delete_form_slt);
			ent = myself.getEntityByTr(tr);
		}else{
			throw new Error('form_flg is null');
		}
		
		// フォームからエンティティを取得
		var ent2 = {};
		for(var i in myself.fieldData){
			
			// フィールドデータからフィールド名を取得する
			var f = myself.fieldData[i].field;

			// name属性またはclass属性を指定して入力要素を取得する。
			var inps = formFind(form,f);
			
			// 該当する入力要素の件数を取得する
			var cnt=inps.length;
			
			var v = null;// 取得値
			
			// 0件である場合、該当する入力要素は存在しないため、何もせず次へ。
			if(cnt==0){
				continue;
			}
			
			// 入力要素が1件である場合、その要素から値を取得する。
			else if(cnt==1){
				v = getEntByForm2(inps,form,f);
			}
			
			// 入力要素が2件以上である場合、それぞれの要素から値を取得して配列（object)とする。
			else{

				v = {};
				var i = 0;
				inps.each(function(){
					var inp = $(this);
					var v2 = getEntByForm2(inp,form,f);
					v[i] = v2;
					i++;
				});
				
			}
			
			ent2[f] = v;

		}

		$.extend(ent, ent2);

		return ent;

	};
	
	
	/**
	 * 様々な入力要素から値を取得する
	 * @param inp 入力要素<jquery object>
	 * @param form フォーム要素<jquery object>
	 * @param f フィールド名
	 * @return 入力要素の値
	 */
	function getEntByForm2(inp,form,f){
		
		var tagName = inp.get(0).tagName; // 入力要素のタグ名を取得する


		// 値を取得する
		var v = null;
		if(tagName == 'INPUT' || tagName == 'SELECT' || tagName == 'TEXTAREA'){
			
			// type属性を取得する
			var typ = inp.attr('type');
			
			
			if(typ=='file'){

				// アップロードファイル系である場合、ひもづいているlabel要素から値を取得する。
				v = getValFromLabel(form,f);

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
			v = getValFromLabel(form,f);

		}
		
		else{
			v = inp.html();
		}
		
		return v;
	};
	
	

	
	
	
	
	
	
	
	/**
	 * フィールドデータからファイルアップロード要素であるエンティティだけ抽出する
	 * @param fieldData フィールドデータ
	 * @param formType フォーム種別
	 */
	function extractFuEnt(fieldData,formType){
		var fuEnts = [];
		for(var i in fieldData){
			var ent = fieldData[i];
			
			// 入力要素エンティティを取得する
			var inp_key = 'inp_' + formType;
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
	};
	
	
	
	
	
	
	
	
	/**
	 * ファイルアップロード関連のエンティティをFormDataに追加する
	 * @param fd FormData（フォームデータ）
	 * @param fuEnts フィールドエンティティリスト（ファイルアップロード関連のもの）
	 * @param formType フォーム種別
	 * @return 追加後のfd
	 */
	function addFuEntToFd(fd,fuEnts,formType){
		
		for(var i in fuEnts){
			var fuEnt = fuEnts[i];
			
			var fu_key = fuEnt.field;
			var inp_key = 'inp_' + formType;
			var elm = fuEnt[inp_key].elm; // ファイル要素オブジェクトを取得
			
			fd.append( fu_key, elm.prop("files")[0] );
		}
		
		return fd;
	};
	
	
	
	
	
	
	
	
	
	
	/**
	 * フィールドを指定してlabel要素から値を取得する
	 * @param form フォーム要素オブジェクト
	 * @param field フィールド名
	 * @return labelから取得した値
	 */
	function getValFromLabel(form,field){
		var v = null;
		var label = form.find("[for='" + field + "']");
		if(label[0]){
			v = label.html();
		}
		
		return v;
				
	};
	
	
	/**
	 * name属性またはclass属性でフォーム内を探し、入力要素を取得する
	 * @param form	フォーム要素オブジェクト
	 * @param string フィールド名（name属性またはclass属性でもある）
	 * @return jquery_object 入力要素
	 */
	function formFind(form,feild){
		
		
		var inp = form.find("[name='" + feild + "']");
		if(inp[0]==undefined){
			inp = form.find('.' + feild);
		}
		
		
		return inp;
	}
	
	

	
	
	// 入力フォームをダイアログ化する
	function convertFormToDlg(formInfo){
		
		var param = myself.param;

		// フォームのオブジェクトを取得する
		var form = formInfo.form;
		
		
		var form_width_px = param.form_width + 'px';
		var form_height_px = param.form_height + 'px';
		
		//デフォルトCSSデータ
		var cssData = {
			'z-index':9,
			'position':'absolute',
//			'background-color':'white',
//			'border':'solid 2px #ccb1bf',//■■■□□□■■■□□□■■■□□□パネルに対応
//			'padding':'5px',
//			'width': form_width_px,
//			'height': form_height_px,
//			'overflow-y':'auto',
		}
		

		
		// フォームにCSSデータをセットする
		form.css(cssData);
		
		//ツールチップの外をクリックするとツールチップを閉じる
		$(document).click(
				function (){
					
					// フォーム表示ボタンが押されたときは、フォームを閉じないようにする。（このイベントはフォームボタンを押した時にも発動するため）
					if(formInfo.show_flg==1){
						formInfo.show_flg=0;
					}else{
						$(formInfo.slt).hide();
					}
					
					
				});
		
		//領域外クリックでツールチップを閉じるが、ツールチップ自体は領域内と判定させ閉じないようにする。
		form.click(function(e) {
			e.stopPropagation();
		});
		
		form.hide();//フォームを隠す
		
	}
	
	
	
	// パラメータに空プロパティがあれば、デフォルト値をセットする
	function setParamIfEmpty(param){
		
		if(param == undefined){
			param = {};
		}
		
		// CRUD対象テーブルセレクタ
		if(param['tbl_slt'] == undefined){
			param['tbl_slt'] = 'ajax_crud_tbl';
		}
		
		// 編集フォームセレクタ
		if(param['edit_form_slt'] == undefined){
			param['edit_form_slt'] = 'ajax_crud_edit_form';
		}
		
		// 新規フォームセレクタ
		if(param['new_form_slt'] == undefined){
			param['new_form_slt'] = 'ajax_crud_new_inp_form';
		}
		
		// 削除フォームセレクタ
		if(param['delete_form_slt'] == undefined){
			param['delete_form_slt'] = 'ajax_crud_delete_form';
		}
		
		// 編集登録サーバーURL
		if(param['edit_reg_url'] == undefined){
			param['edit_reg_url'] = 'xxx';
		}

		// 新規登録サーバーURL
		if(param['new_reg_url'] == undefined){
			param['new_reg_url'] = 'xxx';
		}
		
		// 削除登録サーバーURL
		if(param['delete_reg_url'] == undefined){
			param['delete_reg_url'] = 'xxx';
		}

		// ファイルアップロードディレクトリ
		if(param['upload_file_dir'] == undefined){
			param['upload_file_dir'] = null;
		}

		// ファイルアップロードデータ
		if(param['file_uploads'] == undefined){
			param['file_uploads'] = null;
		}
		
		// フォーム横幅
		if(param['form_width'] == undefined){
			param['form_width'] = 500;
		}

		// フォーム縦幅
		if(param['form_height'] == undefined){
			param['form_height'] = 460;
		}

		// フォーム位置
		if(param['form_position'] == undefined){
			param['form_position'] = 'auto';
		}
		
		// プレビュー画像・横幅
		if(param['preview_img_width'] == undefined){
			param['preview_img_width'] = 80;
		}

		// プレビュー画像・縦幅
		if(param['preview_img_height'] == undefined){
			param['preview_img_height'] = 80;
		}
		
		
		return param;
		
		
	}
	
	
	
	
	/**
	 * フィールドデータへ新規入力フォーム内の要素情報をセットする
	 * @param fieldData フィールドデータ
	 * @param formInfo フォーム情報
	 * @param formType フォームタイプ new_inp,edit
	 * @return フィールドデータ
	 */
	function setFieldDataFromForm(fieldData,formInfo,formType){
		
		// フォーム要素オブジェクトを取得する
		var info = formInfo[formType];
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
			var inp = formFind(form,f);
			inp_ent['elm'] = inp;

			// 入力要素が取得できなければcontinueする。
			if(inp[0]==undefined){
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
			
			ent['inp_' + formType] = inp_ent;

		}


		return fieldData;
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * フィールドデータにファイル要素の情報をセット、およびファイルチェンジイベントを登録する。
	 * @param fieldData フィールドデータ
	 */
	function initFileUpData(fieldData){
		
		// フォーム名のリスト
		var formTypeList = ['new_inp','edit','del'];
		
		// ファイル要素系にのみ、ファイル要素情報をセットする。
		for(var i in fieldData){
			var f_ent = fieldData[i];
			
			for(var ft_i = 0 ; ft_i < formTypeList.length ; ft_i++){
				var formType = formTypeList[ft_i];
				var key = 'inp_' + formType;
				
				if(!f_ent[key]){
					continue;
				}
				var ent = f_ent[key];

				if(ent.type_name == 'file'){

					// ファイル要素情報を入力要素エンティティにセットする
					ent = setFileUploadEntity(f_ent.field,ent);

					// イベントリスナを登録する
					if(formType == 'new_inp'){
						ent.elm.change(fileChangeEventNewInp);
					}else if(formType == 'edit'){
						ent.elm.change(fileChangeEventEdit);
					}else{
						ent.elm.change(fileChangeEventDel);
					}
					
				}
				
			}
			
		}
		


		

		
		return fieldData;
		
		
	};
	
	
	
	/**
	 * ファイル要素情報を入力要素エンティティにセットする
	 * @param field フィールド名
	 * @param ent 入力要素エンティティ（type=file)
	 * @return 入力要素エンティティ
	 */
	function setFileUploadEntity(field,ent){
		
		// プレビュー要素
		var preview_slt = field + '_preview';

		ent['evt'] = null;
		ent['file_name'] = null;
		ent['file_path'] = myself.param.upload_file_dir;
		ent['preview_slt'] = preview_slt;
		
		return ent;
		
		
	};
	
	

	/**
	 * フォームにエンティティをセットする
	 * @param string formType フォーム種別
	 * @param object form フォーム
	 * @param object ent エンティティ
	 * @param string upload_file_dir アップロードファイルディレクトリ（省略可）
	 */
	function setFieldsToForm(formType,form,ent,upload_file_dir){
		
		for(var f in ent){
		
			// class属性またはname属性を指定して入力要素を取得する。
			var inp = form.find('.' + f);
			if(inp[0]==undefined){
				inp = form.find("[name='" + f + "']");
			}
			
			// 入力要素が取得できなければcontinueする。
			if(inp[0]==undefined){
				continue;
			}
			
			var v = ent[f];
			
			var tagName = inp.get(0).tagName; // 入力要素のタグ名を取得する
			
			// 値を入力フォームにセットする。
			if(tagName == 'INPUT' || tagName == 'SELECT' || tagName == 'TEXTAREA'){
				
				// type属性を取得
				var typ = inp.attr('type');
				
				
				if(typ=='file'){
					
					// アップロードファイル要素用の入力フォームセッター
					setToFormForFile(formType,form,f,v,upload_file_dir);

					
				}
				
				else if(typ=='checkbox'){
					if(v ==0 || v==null || v==''){
						inp.prop("checked",false);
					}else{
						inp.prop("checked",true);
					}
					
				}
				
				else if(typ=='radio'){
					var opElm = form.find("[name='" + f + "'][value='" + v + "']");
					if(opElm[0]){
						opElm.prop("checked",true);
					}

				}
				
				else{
					inp.val(v);
				}

				
			}
			
			// IMGタグへのセット
			else if(tagName == 'IMG'){
				// IMG要素用の入力フォームセッター
				setToFormForImg(formType,form,inp,f,v,upload_file_dir);
			}
			
			// audioタグへのセット
			else if(tagName == 'AUDIO'){
				
				// オーディオ要素用の入力フォームセッター
				setToFormForAdo(formType,form,inp,f,v,upload_file_dir);
				
			}else{
				inp.html(v);
			}
			
		
		}
		

		
		
	}

	
	// アップロードファイル要素用の入力フォームセッター
	function setToFormForFile(formType,form,field,v,upload_file_dir){
		
		
		// 入力要素エンティティを取得する
		var ent = getFieldEntByField(field);
		var inp_ent = ent['inp_' + formType];

		if(!upload_file_dir){
			upload_file_dir = inp_ent.file_path;
		}
		var fp = upload_file_dir + v;

		var accept = inp_ent.accept;
		
		// acceptが画像系である場合、画像プレビューを表示
		if(accept.indexOf('image') >= 0 ){
			
			var imgElm = getPreviewImgElm(inp_ent);
			imgElm.attr('src',fp);
		}
		
		// acceptがオーディオ系である場合、オーディオプレビューを表示
		else if(accept.indexOf('audio') >= 0){
			var adoElm = getPreviewAdoElm(inp_ent,fp);
			//adoElm.attr('src',fp);
		}


		setLabel(form,field,v);// ラベル要素へセット
	}

	/**
	 * フィールド名を指定してフィールドエンティティを取得する
	 */
	function getFieldEntByField(field){
		var index = myself.fieldHashTable[field];
		var ent = myself.fieldData[index];
		return ent;
	}
	
	/**
	 * 入力要素エンティティを取得する
	 * @param field フィールド
	 * @param formType フォーム種別
	 * @return 入力要素エンティティ
	 */
	function getInpEnt(field,formType){
		var index = myself.fieldHashTable[field];
		var ent = myself.fieldData[index];
		var inp_ent;
		var inp_key = 'inp_' + formType;
		if(ent[inp_key]){
			inp_ent = ent[inp_key];
		}
		return inp_ent;
	}
	
	
	
	
	
	// IMG要素用の入力フォームセッター
	function setToFormForImg(formType,form,imgElm,field,v,upload_file_dir){

		
		// 入力エンティティを取得する
		var inp_ent = getInpEnt(field,formType)
		
		if(!upload_file_dir){
			upload_file_dir = inp_ent.file_path;
		}
		var fp = upload_file_dir + v;
		imgElm.attr('src',fp);
		
		setLabel(form,field,v);// ラベル要素へセット
		

	}
	
	
	// オーディオ要素用の入力フォームセッター
	function setToFormForAdo(formType,form,adoElm,field,v,upload_file_dir){

		
		// 入力エンティティを取得する
		var inp_ent = getInpEnt(field,formType)
		
		if(!upload_file_dir){
			upload_file_dir = inp_ent.file_path;
		}
		var fp = upload_file_dir + v;
		adoElm.attr('src',fp);
		
		setLabel(form,field,v);// ラベル要素へセット
		

	}
	
	
	
	
	/**
	 * ラベル要素へセット
	 * @param object form フォーム要素オブジェクト
	 * @param string field フィールド名
	 * @param v ラベルにセットする値
	 */
	function setLabel(form,field,v){
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
	 */
	function showForm(form,triggerElm){
		
		form.show();
		
		//トリガー要素の右上位置を取得
		triggerElm = $(triggerElm);
		var offset=triggerElm.offset();
		var left = offset.left;
		var top = offset.top;
		
		var ww = $(window).width();// Windowの横幅（ブラウザの横幅）
		var form_width = myself.param.form_width;// フォームの横幅
		
		// フォーム位置Yをセット
		var trigger_height = triggerElm.outerHeight();
		var tt_top=top + trigger_height;

		// フォーム位置
		var form_position = myself.param.form_position;
		
		
		var tt_left=0;// フォーム位置X
		
		// フォーム位置の種類毎にフォーム位置Xを算出する。
		switch (form_position) {
		
		case 'left':
			
			// トリガーの左側にフォームを表示する。
			tt_left=left - form_width;
			break;
			
		case 'center':

			// フォームを中央にする。
			tt_left=(ww / 2) - (form_width / 2);
			break;
			
		case 'right':
			
			// トリガーの右側にフォームを表示する
			tt_left=left;
			break;
			

		default:// auto

			// 基本的にトリガーの右側にフォームを表示する。
			// ただし、トリガーが右端付近にある場合、フォームは外側にでないよう左側へ寄せる。
			
			tt_left=left;
			if(tt_left + form_width > ww){
				tt_left = ww - form_width;
			}
			
			break;
		}


		//フォーム要素に位置をセット
		form.offset({'top':tt_top,'left':tt_left });
	}
	
	
	

	
	// フィールドデータにプロパティを追加する
	function addMoreFieldData(tbl_slt,fieldData){
		
		// フィールドデータが空であるなら一覧テーブルのth要素からフィールド名を取得する
		if(!fieldData){
			fieldData = getFieldDataFromTh();

			if(!fieldData){
				throw new Error('fieldDataを取得できません。th要素のclass属性にフィールド名を指定してください。');
			}
		}
		
		
		
		var fieldData2 = [];
		
		// thループ
		var i=0;
		$('#' + tbl_slt + ' th').each(function(){
			
			var wamei = $(this).text();
			
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
	};
	
	
	// th要素からフィールド情報を取得する
	function getFieldDataFromTh(){
		
		var fieldData = [];
		
		var slt = '#' + myself.param.tbl_slt + ' th';
		$(slt).each(function(){
			var thElm = $(this);
			var field = getFieldByClassOrName(thElm);////class属性またはname属性からフィールド名を取得する
			if(field){
				fieldData.push(field);
			};
		});
		
		return fieldData;
		
	};
	
	
	
	// フィールドハッシュテーブルをフィールドデータから生成する。
	function createFieldHashTable(fieldData){
		
		var hashTable = {};
		
		for(var i in fieldData){
			var fEnt = fieldData[i];
			
			hashTable[fEnt.field] = i;
			
		}
		

		return hashTable;
	}
	
	
	
	
	
	// フォーム情報の初期化
	function initFormInfo(param){

		var formInfo = {};// フォーム情報
		
		// 新規フォーム情報の設定
		var res = classifySlt(param['new_form_slt']);
		var newInpForm = $(res['slt']);
		formInfo['new_inp'] = {
			'xid':res['xid'],	// ID属性
			'slt':res['slt'],	// フォーム要素のセレクタ
			'show_flg':0,		// 表示制御フラグ（閉じるイベント制御用）
			'form':newInpForm,	// フォーム要素
		};
		convertFormToDlg(formInfo.new_inp);// フォームをダイアログ化する。
		
		
		// 編集フォーム情報の設定
		res = classifySlt(param['edit_form_slt']);
		var editForm = $(res['slt']);
		formInfo['edit'] = {
			'xid':res['xid'],	// ID属性
			'slt':res['slt'],	// フォーム要素のセレクタ
			'show_flg':0,		// 表示制御フラグ（閉じるイベント制御用）
			'form':editForm,	// フォーム要素
		};
		convertFormToDlg(formInfo.edit);// フォームをダイアログ化する。
		
		
		

		
		
		// 削除フォーム情報の設定
		var res = classifySlt(param['delete_form_slt']);
		var deleteForm = $(res['slt']);
		formInfo['del'] = {
			'xid':res['xid'],	// ID属性
			'slt':res['slt'],	// フォーム要素のセレクタ
			'show_flg':0,		// 表示制御フラグ（閉じるイベント制御用）
			'form':deleteForm,	// フォーム要素
		};
		convertFormToDlg(formInfo['del']);// フォームをダイアログ化する。

		return formInfo;

	};
	
	
	
	
	/**
	* name属性またはclass属性からフィールド名を取得する
	* 
	* @note
	* class属性が複数である場合、先頭のclass属性を取得する
	*
	* @parma elm 入力要素オブジェクト
	* @return フィールド名
	*/
	function getFieldByNameOrClass(elm){
		
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
		
	};
	
	
	
	/**
	* class属性またはname属性からフィールド名を取得する
	* 
	* @note
	* class属性が複数である場合、先頭のclass属性を取得する
	*
	* @parma elm 入力要素オブジェクト
	* @return フィールド名
	*/
	function getFieldByClassOrName(elm){
		
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
		
	};
	
	
	
	
	
	
	
	
	
	/**
	 * 対象文字列をID属性とセレクタに分類する
	 * @param slt 対象文字列
	 * @returns res
	 *  - xid ID属性
	 *  - slt セレクタ
	 */
	function classifySlt(slt){
		
		var xid='';
		var slt2 = '';
		
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
		
		
	};
 
	

	
	
	
	
	
	
	// Check the value is empty
	function _isEmpty(v){
		if(v =='' || v==null){
			return true;
		}else{
			return false;
		}
	};
	
	// Check the value is not empty
	function _isSet(v){
		if(v =='' || v==null){
			return false;
		}else{
			return true;
		}
	};
	
	
	
	
	
	
	
	//コンストラクタ呼出し(クラス末尾にて定義すること）
	this.constract();
};