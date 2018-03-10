<?php
App::uses('AppController', 'Controller');

/**
 * CRUD系画面用の基本クラス
 * 
 * CRUD系のコントローラはこちらを継承することにより、検索条件、ページネーション、ソートなどの開発が簡易になります。。
 * 
 *
 */
class CrudBaseController extends AppController {

	///バージョン
	var $version = "2.2.1";// setUploadFileValueToEntity

	///デフォルトの並び替え対象フィールド
	var $defSortFeild='sort_no';

	///デフォルトソートタイプ
	var $defSortType=0;//0:昇順 1:降順

	///検索条件のセッション保存フラグ
	public $kj_session_flg=true;

	///検索条件定義（要,オーバーライド）
	public $kensakuJoken=array();

	///検索条件のバリデーション（要,オーバーライド）
	public $kjs_validate = array();

	///フィールドデータ（要、オーバーライド）
	public $field_data = array();

	///一覧列情報(ソート機能付	 $field_dataの簡易版）
	public $table_fields=array();

	///編集エンティティ定義（要,オーバーライド）
	public $entity_info=array();

	///編集用バリデーション（要,オーバーライド）
	public $edit_validate = array();

	///巨大データ判定行数
	public $big_data_limit=501;

	//巨大データフィールド
	public $big_data_fields = array();
	
	// 当ページバージョン（各ページでオーバーライドすること)
	public $this_page_version = '1.0';
	
	// バージョン情報
	public $verInfo = array();

	// -- ▽ 内部処理用
	private $m_kj_keys;//検索条件キーリスト
	private $m_kj_defs;//検索条件デフォルト値
	private $m_edit_keys;//編集エンティティキーリスト
	private $m_edit_defs;//編集エンティティのデフォルト値
	private $main_model_name=null;//対応付けるモデルの名称。（例→AnimalX)
	private $main_model_name_s=null;//モデル名のスネーク記法番(例→animal_x)

	/**
	 * indexアクションの共通処理
	 *
	 * 検索条件情報の取得、入力エラー、ページネーションなどの情報を取得します。
	 * このメソッドはindexアクションの冒頭部分で呼び出されます。
	 * @param $name 	対応するモデル名（キャメル記法）
	 * @param $request 	HTTPリクエスト
	 * @return array
	 * - kjs <array> 検索条件情報
	 * - errMsg <string> 検索条件入力のエラーメッセージ
	 * - paginations <array> ページネーション情報
	 * - saveKjFlg <bool> 検索条件保存フラグ。true:検索条件を保存する, false:保存しない
	 * - bigDataFlg <bool> true:一覧データ件数が500件を超える,false:500件以下。500件の制限はオーバーライドで変更可能。
	 *
	 */
	protected function indexBefore($name,$request=null){

		if(empty($request)) $request = $this->request->data;

		$this->MainModel=ClassRegistry::init($name);
		$this->main_model_name=$name;
		$this->main_model_name_s=$this->snakize($name);

		// POSTデータを取得
		$postData = null;
		if(isset($this->request->data[$name])){
			$postData = $this->request->data[$name];
		}

		// アクションを判定してアクション種別を取得する（0:初期表示、1:検索ボタン、2:ページネーション、3:ソート）
		$actionType = $this->judgActionType();

		//▽検索入力保存フラグの処理
		$skfData = $this->judeSessionFlg($postData,$actionType,$name);
		$saveKjFlg = $skfData['saveKjFlg'];

		
 		// 新バージョンであるかチェック。新バージョンである場合セッションクリアを行う。２回目のリクエスト（画面表示）から新バージョンではなくなる。
		$verInfo = Configure::read('VersionInfo'); // 当システムのバージョン情報を取得
		$new_version_chg = 0; // 新バージョン変更フラグ: 0:通常  ,  1:新バージョンに変更
		$system_version = $this->checkNewPageVersion($verInfo['system_version']);
		if(!empty($system_version)){
			$new_version_chg = 1;
			$this->sessionClear();
		}
		//URLクエリ（GET)にセッションクリアフラグが付加されている場合、当画面に関連するセッションをすべてクリアする。
		if(!empty($this->request->query['sc'])){
			$this->sessionClear();
		}
		

		//URLクエリ（GET)から初期フラグを取得する。
		$iniFlg=0;
		if(!empty($this->request->query['ini'])){
			$iniFlg=$this->request->query['ini'];
		}

		//URLクエリ（GET)からCRUDタイプを取得する
		$crudType = 0; // 0:AjaxCrud.js型   1:submit型
		if(!empty($this->request->query['crud_type'])){
			$crudType = $this->request->query['crud_type'];
		}

		//巨大データフィールドデータを取得
		$big_data_fields = $this->big_data_fields;

		//フィールドデータが画面コントローラで定義されている場合、以下の処理を行う。
		if(!empty($this->field_data)){

			$res=$this->exe_field_data($this->field_data,$this->main_model_name_s);//フィールドデータに関する処理
			$this->table_fields=$res['table_fields'];
			$this->field_data=$res['field_data'];

		}

		//フィールドデータから列表示配列を取得
		$csh_ary = $this->exstractClmShowHideArray($this->field_data);
		$csh_json=json_encode($csh_ary);

		//サニタイズクラスをインポート
		App::uses('Sanitize', 'Utility');

		//検索条件情報をPOST,GET,SESSION,デフォルトのいずれから取得。
		$kjs=$this->getKjs($name,$saveKjFlg);

		//SQLインジェクション対策
		foreach($kjs as $i => $kj){
			if(!empty($kj)){
				$kjs[$i] = str_replace("'", '\'', $kj);
			}
		}

		//パラメータのバリデーション
		$errMsg=$this->valid($kjs,$this->kjs_validate);

		//入力エラーがあった場合。
		if(isset($errMsg)){
			//再表示用の検索条件情報をSESSION,あるいはデフォルトからパラメータを取得する。
			$kjs= $this->getKjsSD($name,$saveKjFlg);
		}

		//検索ボタンが押された場合
		$paginations=array();
		if(!empty($request['search'])){

			//ページネーションパラメータを取得
			$paginations=$this->getPageParamForSubmit($kjs,$saveKjFlg);

		}else{
			//ページネーション用パラメータを取得
			$overData['limit']=$kjs['kj_limit'];
			$paginations=$this->getPageParam($saveKjFlg,$overData);

		}

		//CSV用にセッションセット
		$this->Session->write($this->main_model_name_s.'_kjs',$kjs);

		//limitとorder部分を作成
		$this->PagenationForCake=new PagenationForCake();
		$pageLO=$this->PagenationForCake->createLimitAndOrder($paginations);

		$paginations=array_merge($paginations,$pageLO);

		$bigDataFlg=$this->checkBigDataFlg($kjs);//巨大データ判定

		//巨大データフィールドデータを取得
		$big_data_fields = $this->big_data_fields;

		//フィールドデータが定義されており、巨大データと判定された場合、巨大フィールドデータの再ソートをする。（列並替に対応）
		if(!empty($this->field_data) && $bigDataFlg ==true){

			//巨大データフィールドを列並替に合わせて再ソートする。
			$big_data_fields = $this->sortBigDataFields($big_data_fields,$this->field_data['active']);

		}

		$defKjsJson=$this->getDefKjsJson();// 検索条件情報からデフォルト検索JSONを取得する

		$debug_mode=Configure::read('debug');//デバッグモードを取得

		//アクティブフィールドデータを取得
		$active = array();
		if(!empty($this->field_data['active'])){
			$active = $this->field_data['active'];
		}

		// ユーザー情報を取得する
		$userInfo = $this->getUserInfo();
		
		$crudBaseData = array(
			'version'=>$this->version,
			'field_data'=>$active,
			'kjs'=>$kjs,
			'errMsg'=>$errMsg,
			'iniFlg'=>$iniFlg,
			'crudType'=>$crudType,
			'saveKjFlg'=>$saveKjFlg,
			'csh_json'=>$csh_json,
			'defKjsJson'=>$defKjsJson,
			'bigDataFlg'=>$bigDataFlg,
			'debug_mode'=>$debug_mode,
			'big_data_fields'=>$big_data_fields,
			'userInfo'=>$userInfo,
			'new_version_chg'=>$new_version_chg,
			'verInfo'=>$verInfo,
			'paginations'=>$paginations,
			'csh_ary'=>$csh_ary,
		);
		
		return $crudBaseData;

		// ■■■□□□■■■□□□■■■□□□
// 		$this->set(array(
// 				'version'=>$this->version,
// 				'field_data'=>$active,
// 				'kjs'=>$kjs,
// 				'errMsg'=>$errMsg,
// 				'iniFlg'=>$iniFlg,
// 				'crudType'=>$crudType,
// 				'saveKjFlg'=>$saveKjFlg,
// 				'csh_json'=>$csh_json,
// 				'defKjsJson'=>$defKjsJson,
// 				'bigDataFlg'=>$bigDataFlg,
// 				'debug_mode'=>$debug_mode,
// 				'big_data_fields'=>$big_data_fields,
// 				'userInfo'=>$userInfo,
// 				'new_version_chg'=>$new_version_chg,
// 				'verInfo'=>$verInfo,
				
// 		));


// 		$ret=array(
// 				'kjs'=>$kjs,
// 				'errMsg'=>$errMsg,
// 				'iniFlg'=>$iniFlg,
// 				'paginations'=>$paginations,
// 				'saveKjFlg'=>$saveKjFlg,
// 				'bigDataFlg'=>$bigDataFlg,
// 				'csh_ary'=>$csh_ary,
// 				'big_data_fields'=>$big_data_fields,
// 				'userInfo'=>$userInfo,
// 		);
		
		
		//-------------
		

//		return $ret;
	}


	/**
	 * アクション種別を取得する
	 * @return アクション種別   0:初期表示、1:検索ボタン、2:ページネーション、3:ソート
	 */
	private function judgActionType(){

		$postData = $this->request->data;
		$getData = $this->request->query;

		$post_flg =false;
		if($postData){
			$post_flg = true;
		}

		$get_flg = false;
		if($getData){
			$get_flg = true;
		}

		$actionType = null;

		if($post_flg == true && $get_flg == true){
			$actionType = 1 ; // 検索ボタンアクション

		}else if($post_flg == true && $get_flg == false){
			$actionType = 1 ; // 検索ボタンアクション

		}else if($post_flg == false && $get_flg == true){

			// GETのパラメータを判定してアクション種別を取得する
			$actionType = $this->judgActionTypeByGet($getData);

		}else if($post_flg == false && $get_flg == false){
			$actionType = 0 ; // 初期表示アクション

		}

		return $actionType;
	}

	/**
	 * GETのパラメータを判定してアクション種別を取得する
	 * @param array $getData GETリクエストのパラメータ
	 * @return アクション種別  0:初期表示、 2:ページネーション、 3:ソート
	 */
	private function judgActionTypeByGet($getData){

		// GETパラメータにkj_○○というフィールドが存在したらアクション種別は「初期表示」と判定する
		foreach($getData as $key => $dummy){
			$s3 =mb_substr($key,0,3);
			if($s3 == 'kj_'){
				return 0; // 初期表示
			}
		}

		// ソートアクションの判定
		if(isset($getData['page_no']) && isset($getData['limit']) && isset($getData['sort'])){
			return 3; // ソート
		}

		// ページネーションアクションの判定
		else if(isset($getData['page_no']) && isset($getData['limit']) && !isset($getData['sort'])){
			return 2; // ページネーション・アクション
		}

		return 0; // その他は初期表示
	}

	/**
	 * 検索入力保存フラグの判定、取得、セッション更新を行う。
	 * @param array $postData POSTリクエストのデータ
	 * @param int $actionType アクション種別  0:初期表示、1:検索ボタン、2:ページネーション、3:ソート
	 * @param string $name モデル名
	 * @return 検索入力保存フラグ
	 */
	private function judeSessionFlg($postData,$actionType,$name){

		// KJセッション保存フラグ(検索条件セッション保存フラグ）をメンバから取得
		$saveKjFlg = $this->kj_session_flg;

		// フォーム・KSFを取得
		$f_saveKjFlg = null;
		if(isset($postData)){
			if(isset($postData['saveKjFlg'])){
				$f_saveKjFlg = $postData['saveKjFlg'];
			}
		}
		if(!isset($f_saveKjFlg)){
			if(isset($this->request->query['saveKjFlg'])){
				$f_saveKjFlg=$this->request->query['saveKjFlg'];
			}
		}

		// セッション・KSFを取得
		$s_saveKjFlg=$this->Session->read($this->main_model_name_s.'_saveKjFlg');

		// フォームKSF = 有
		if(isset($f_saveKjFlg)){

			// フォームからの値をKJセッション保存フラグにセットする。
			$saveKjFlg = $f_saveKjFlg;
			$s_saveKjFlg = $saveKjFlg;

		}

		// フォームKSF = 空
		else{
			// 	セッションKSF=有
			if(isset($s_saveKjFlg)){

				// 初期表示アクション
				if($actionType == 0){
					if($this->kj_session_flg==true){
						$saveKjFlg = $s_saveKjFlg;
					}

				}

				// 検索アクション
				else if($actionType == 1){
					if($this->kj_session_flg==true){
						$saveKjFlg = $s_saveKjFlg;
					}

				}

				// ページネーション・アクション
				else if($actionType == 2){
					$saveKjFlg = true;
				}

				// ソート
				else if($actionType == 3){
					$saveKjFlg = true;
				}

			}

			// セッションKSF=空
			else{
				// なにもしない
			}

		}

		// セッションKSFを保存する
		$this->Session->write($this->main_model_name_s.'_saveKjFlg',$s_saveKjFlg);

		$skfData = array(
				'kj_session_flg' => $this->kj_session_flg,// デフォルト
				'saveKjFlg'=>$saveKjFlg,// 実質のフラグ
				'f_saveKjFlg'=>$f_saveKjFlg,// フォームからのフラグ
				's_saveKjFlg'=>$s_saveKjFlg,// セッションからのフラグ
		);

		return $skfData;

	}


	/**
	 * 当画面に関連するセッションをすべてクリアする
	 * 
	 */
	public function sessionClear(){

		$page_code = $this->main_model_name_s; // スネーク記法のページコード（モデル名）
		$pageCode = $this->main_model_name; // スネーク記法のページコード（キャメル記法）

		$fd_ses_key=$page_code.'_sorter_field_data';//フィールドデータのセッションキー
		$tf_ses_key=$page_code.'_table_fields';//一覧列情報のセッションキー
		$err_ses_key=$page_code.'_err';//入力エラー情報のセッションキー
		$page_ses_key=$pageCode.'_page_param';//ページパラメータのセッションキー
		$kjs_ses_key=$pageCode;	//検索条件情報のセッションキー
		$svkj_ses_key=$page_code.'_saveKjFlg';//検索入力保存フラグのセッションキー
		$csv_ses_key=$page_code.'_kjs';//CSV用のセッションキー
		$mains_ses_key = $page_code.'_mains_cb';//主要パラメータのセッションキー

		$this->Session->delete($fd_ses_key);
		$this->Session->delete($tf_ses_key);
		$this->Session->delete($err_ses_key);
		$this->Session->delete($page_ses_key);
		$this->Session->delete($kjs_ses_key);
		$this->Session->delete($svkj_ses_key);
		$this->Session->delete($csv_ses_key);
		$this->Session->delete($mains_ses_key);

	}

	/**
	 * フィールドデータに関する処理
	 * 
	 * @param array $def_field_data コントローラで定義しているフィールドデータ
	 * @param string $page_code ページコード（モデル名）
	 * @return res 
	 * - table_fields 一覧列情報
	 */
	private function exe_field_data($def_field_data,$page_code){

		//フィールドデータをセッションに保存する
		$fd_ses_key=$page_code.'_sorter_field_data';

		//一覧列情報のセッションキー
		$tf_ses_key = $page_code.'_table_fields';

		//セッションキーに紐づくフィールドデータを取得する
		$field_data=$this->Session->read($fd_ses_key);

		$table_fields=array();//一覧列情報

		//フィールドデータが空である場合
		if(empty($field_data)){

			//定義フィールドデータをフィールドデータにセットする。
			$field_data=$def_field_data;

			//defをactiveとして取得。
			$active=$field_data['def'];

			//列並番号でデータを並び替える。データ構造も変換する。
			$active=$this->CrudBase->sortAndCombine($active);
			$field_data['active']=$active;

			//セッションにフィールドデータを書き込む
			$this->Session->write($fd_ses_key,$field_data);

			//フィールドデータから一覧列情報を作成する。
			$table_fields=$this->CrudBase->makeTableFieldFromFieldData($field_data);

			//セッションに一覧列情報をセットする。
			$this->Session->write($tf_ses_key,$table_fields);

		}

		//セッションから一覧列情報を取得する。
		if(empty($table_fields)){
			$table_fields = $this->Session->read($tf_ses_key);
		}

		$res['table_fields']=$table_fields;
		$res['field_data']=$field_data;

		return $res;

	}

	/**
	 * フィールドデータから列表示配列を取得
	 * @param array $field_data フィールドデータ
	 * @return 列表示配列
	 */
	private function exstractClmShowHideArray($field_data){
		$csh_ary=array();
		if(!empty($field_data)){
			$csh_ary=Hash::extract($field_data, 'active.{n}.clm_show');
		}
		return $csh_ary;
	}

	/**
	 * indexアクションの共通処理（後）
	 *
	 * @param $crudBaseData
	 * @return $crudBaseData
	 */
	protected function indexAfter(&$crudBaseData){

        // 検索データ数を取得
	    $kjs = $crudBaseData['kjs'];
		$data_count=$this->MainModel->findDataCnt($kjs); 

		//ページ情報を取得する
		$baseUrl=$this->webroot.$this->main_model_name_s; // ページネーションの基本URL
		$pages=$this->PagenationForCake->createPagenationData($data_count,$baseUrl , null,$this->table_fields,$kjs);

		$kjs_json = json_encode($kjs,JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS);
		
		$crudBaseData['pages'] = $pages; // ページ情報
		$crudBaseData['data_count'] = $data_count; // 検索データ数
		$crudBaseData['kjs_json'] = $kjs_json;

		return $crudBaseData;
	}


	/**
	 * ユーザー情報を取得する
	 * 
	 * @return ユーザー情報
	 * - ユーザー名
	 * - IPアドレス
	 * - ユーザーエージェント
	 */
	public function getUserInfo(){

		$userInfo = $this->Auth->user();

		$userInfo['update_user'] = $userInfo['username'];// 更新ユーザー
		$userInfo['ip_addr'] = $_SERVER["REMOTE_ADDR"];// IPアドレス
		$userInfo['user_agent'] = $_SERVER['HTTP_USER_AGENT']; // ユーザーエージェント

		// 権限が空であるならオペレータ扱いにする
		if(empty($userInfo['role'])){
			$userInfo['role'] = 'oparator';
		}

		// 権力データを取得してセットする
		$userInfo['authority'] = $this->getAuthority($userInfo['role']);

		return $userInfo;
	}

	/**
	 * 権限に紐づく権力エンティティを取得する
	 * @param string $role 権限
	 * @return 権力エンティティ
	 */
	protected function getAuthority($role){

		// 権力データを取得する
		$authorityData = $this->getAuthorityData();

		$authority = array();
		if(!empty($authorityData[$role])){
			$authority = $authorityData[$role];
		}

		return $authority;
	}

	/**
	 * 権力データを取得する
	 * @return 権力データ
	 */
	protected function getAuthorityData(){
		$data=array(
			'master'=>array(
				'name'=>'master',
				'wamei'=>'マスター',
				'level'=>41,
			),
			'developer'=>array(
				'name'=>'developer',
				'wamei'=>'開発者',
				'level'=>40,
			),
			'admin'=>array(
				'name'=>'admin',
				'wamei'=>'管理者',
				'level'=>30,
			),
			'client'=>array(
				'name'=>'client',
				'wamei'=>'クライアント',
				'level'=>20,
			),
			'oparator'=>array(
				'name'=>'oparator',
				'wamei'=>'オペレータ',
				'level'=>10,
			),

		);

		return $data;
	}

	/**
	 * editアクションの共通処理
	 *
	 * エンティティ、入力エラーメッセージ、モードを取得します。
	 * エンティティはテーブルのレコードのことです。
	 * エラーメッセージは登録ボタン押下時の入力エラーメッセージです。
	 *
	 * @param $name 対象モデル名（キャメル記法）
	 * @return array
	 * - noData <bool> true:エンティティが空(※非推奨)
	 * - ent <array> エンティティ（テーブルのレコード）$this
	 * - errMsg <string> 入力エラーメッセージ
	 * - mode <string> new:新規入力モード, edit:編集モード
	 *
	 */
	protected function edit_before($name){
		$this->MainModel=ClassRegistry::init($name);
		$this->main_model_name=$name;
		$this->main_model_name_s=$this->snakize($name);

		App::uses('Sanitize', 'Utility');//インクルード

		$err=$this->Session->read($this->main_model_name_s.'_err');
		$this->Session->delete($this->main_model_name_s.'_err');
		$noData=false;
		$ent=null;
		$errMsg=null;
		$mode=null;

		//入力エラー情報が空なら通常の遷移
		if(empty($err)){

			$id=$this->getGet('id');//GETからIDを取得

			//IDがnullなら新規登録モード
			if(empty($id)){

				$ent=$this->getDefaultEntity();
				$mode='new';//モード（new:新規追加  edit:更新）

				//IDに数値がある場合、編集モード。
			}else if(is_numeric($id)){

				//IDに紐づくエンティティをDBより取得
				$ent=$this->MainModel->findEntity($id);
				$mode='edit';//モード（new:新規追加  edit:更新）

			}else{

				//数値以外は「NO DATA」表示
				$noData=true;
			}

		}

		//入力エラーによる再遷移の場合
		else{

			$ent=$err['ent'];
			$mode=$err['mode'];
			$errMsg=$err['errMsg'];

 			//エンティティには入力フォーム分のフィールドしか入っていないため、不足分のフィールドをDBから取得しマージする
 			$ent2=$this->MainModel->findEntity($ent['id']);
 			$ent=Hash::merge($ent2,$ent);

		}

		//リファラを取得
		$referer = ( !empty($this->params['url']['referer']) ) ? $this->params['url']['referer'] : null;

		$this->set(array(
				'noData'=>$noData,
				'mode'=>$mode,
				'errMsg'=>$errMsg,
				'referer'=>$referer,
		));

		$ret=array(
				'ent'=>$ent,
				'noData'=>$noData,
				'errMsg'=>$errMsg,
				'mode'=>$mode,
				'referer'=>$referer,
		);


		return $ret;

	}

	/**
	 * regアクション用の共通処理
	 *
	 * 結果エンティティとモードを取得します。
	 * 結果エンティティは登録したエンティティで、また全フィールドを持っています。
	 * @param $name 対象モデル名
	 * @return array
	 * - ent <array> 結果エンティティ
	 * - mode <string> new:新規入力モード,edit:編集モード
	 *
	 */
	protected function reg_before($name){
		$this->MainModel=ClassRegistry::init($name);
		$this->main_model_name=$name;
		$this->main_model_name_s=$this->snakize($name);

		//リロードチェック
		if(empty($this->ReloadCheck)){
			App::uses('ReloadCheck','Vendor/Wacg');
			$this->ReloadCheck=new ReloadCheck();
		}

		if ($this->ReloadCheck->check()!=1){//1以外はリロードと判定し、一覧画面へリダイレクトする。
			return $this->redirect(array('controller' => $this->main_model_name_s, 'action' => 'index'));
		}

		App::uses('Sanitize', 'Utility');//インクルード

		$ent=$this->getEntityFromPost();

		$mode=$this->request->data[$this->main_model_name]['mode'];
		$errMsg=$this->valid($ent,$this->edit_validate);

		if(isset($errMsg)){

			//エラー情報をセッションに書き込んで、編集画面にリダイレクトで戻る。
			$err=array('mode'=>$mode,'ent'=>$ent,'errMsg'=>$errMsg);
			$this->Session->write($this->main_model_name_s.'_err',$err);
			$this->redirect(array('action' => 'edit'));

			return null;
		}

		//更新関係のパラメータをエンティティにセットする。
		$ent=$this->setUpdateInfo($ent,$mode);

		//リファラを取得
		$referer = ( !empty($this->request->data[$this->main_model_name]['referer']) ) ? $this->request->data[$this->main_model_name]['referer'] : null;

		$this->set(array(
				'mode'=>$mode,
				'referer'=>$referer,
		));

		$res = array(
				'ent'=>$ent,
				'mode'=>$mode,
				'referer'=>$referer,
				);

		return $res;


	}

	/**
	 * 編集画面へリダイレクトで戻ります。その際、入力エラーメッセージも一緒に送られます。
	 *
	 * @param $errMsg 入力エラーメッセージ
	 * @return なし。（編集画面に遷移する）
	 */
	protected function errBackToEdit($errMsg){

		$ent=$this->getEntityFromPost();
		$mode=$this->request->data[$this->main_model_name]['mode'];

		//エラー情報をセッションに書き込んで、編集画面にリダイレクトで戻る。
		$err=array('mode'=>$mode,'ent'=>$ent,'errMsg'=>$errMsg);
		$this->Session->write($this->main_model_name_s.'_err',$err);
		$this->redirect(array('action' => 'edit'));

	}


	/**
	 * 検索条件のバリデーション
	 *
	 * 引数のデータを、バリデーション情報を元にエラーチェックを行います。
	 * その際、エラーがあれば、エラーメッセージを作成して返します。
	 *
	 * @param  $data バリデーション対象データ
	 * @param  $validate バリデーション情報
	 * @return 正常な場合、nullを返す。異常値がある場合、エラーメッセージを返す。
	 */
	protected function valid($data,$validate){

		$errMsg=null;
		//▽バリデーション（入力チェック）を行い、正常であれば、改めて検索条件情報を取得。
		$this->MainModel->validate=$validate;

		$this->MainModel->set($data);
		if (!$this->MainModel->validates($data)){

			////入力値に異常がある場合。（エラーメッセージの出力仕組みはcake phpの仕様に従う）
			$errors=$this->MainModel->validationErrors;//入力チェックエラー情報を取得
			if(!empty($errors)){

				foreach ($errors  as  $err){

					foreach($err as $val){

						$errMsg.= $val.' ： ';

					}
				}

			}

		}

		return $errMsg;
	}

	/**
	 * POST,またはSESSION,あるいはデフォルトから検索条件情報を取得します。
	 *
	 * @param $formKey form要素のキー。通常はモデル名をキーにしているので、モデルを指定すれば良い。
	 * @param $saveKjFlg セッション保存フラグ
	 * @return 検索条件情報
	 */
	protected function getKjs($formKey,$saveKjFlg){

		$def=$this->getDefKjs();//デフォルトパラメータ
		$keys=$this->getKjKeys();//検索条件キーリストを取得

		$kjs=$this->getParams($keys,$formKey,$def,$saveKjFlg);

		foreach($kjs as $k=>$v){
			if(is_array($v)){
				$kjs[$k]=$v;
			}else{
				$kjs[$k]=trim($v);
			}

		}

		return $kjs;

	}

	/**
	 * 検索条件キーリストを取得
	 *
	 * 検索条件情報からname要素だけを、キーリストとして取得します。
	 * @return 検索条件キーリスト
	 */
	protected function getKjKeys(){

		if(empty($this->m_kj_keys)){
			foreach($this->kensakuJoken as $ent){
				$this->m_kj_keys[]=$ent['name'];
			}
		}

		return $this->m_kj_keys;
	}

	/**
	 * デフォルト検索条件を取得
	 *
	 * 検索条件情報からdef要素だけを、デフォルト検索条件として取得します。
	 * @return デフォルト検索条件
	 */
	protected function getDefKjs(){

		if(empty($this->m_kj_defs)){
			foreach($this->kensakuJoken as $ent){
				$this->m_kj_defs[$ent['name']]=$ent['def'];
			}
		}

		return $this->m_kj_defs;

	}

	/**
	 * SESSION,あるいはデフォルトから検索条件情報を取得する
	 *
	 * @param $formKey モデル名、またはformタグのname要素
	 * @param $saveKjFlg セッション保存フラグ
	 * @return 検索条件情報
	 */
	protected function getKjsSD($formKey,$saveKjFlg){

		$def=$this->getDefKjs();//デフォルトパラメータ
		$keys=$this->getKjKeys();
		$kjs=$this->getParamsSD($keys,$formKey,$def,$saveKjFlg);

		return $kjs;
	}

	/**
	 * 
	 * POSTからデータを取得。ついでにサニタイズする。
	 *
	 * POSTからデータを取得する際、ついでにサニタイズします。
	 * サニタイズはSQLインジェクション対策用です。
	 *
	 * @param $key リクエストキー
	 * @return リクエストの値
	 * 
	 */
	protected function getPost($key){
		$v=null;
		if(isset($this->request->data[$this->main_model_name][$key])){
			$v=$this->request->data[$this->main_model_name][$key];
			//$v=Sanitize::escape($v);//SQLインジェクションのサニタイズ　// 何らかのバージョンによっては2重サニタイズになってしまう。
		}
		return $v;
	}


	/**
	 * GET情報（URLのクエリ）からページネーション情報を取得します。
	 *
	 * ページネーション情報は、ページ番号の羅列であるページ目次のほかに、ソート機能にも使われます。
	 *
	 * @param $saveKjFlg セッション保存フラグ
	 * @param $overData 上書きデータ
	 * @return array
	 * - page_no <int> 現在のページ番号
	 * - limit <int> 表示件数
	 * - sort <string> ソートする列フィールド
	 * - sort_type <int> 並び方向。 0:昇順 1:降順
	 */
	protected function getPageParam($saveKjFlg,$overData){
		//GETよりパラメータを取得する。
		$pageParam=$this->params['url'];

		// 上書き
		$pageParam=Hash::merge($pageParam,$overData);

		//空ならセッションから取得する。
		if(empty($pageParam) && $saveKjFlg==true){
			$pageParam=$this->Session->read($this->main_model_name.'_page_param');
		}

		$defs=$this->getDefKjs();//デフォルト情報を取得

		//空ならデフォルトをセット
		if(empty($pageParam['page_no'])){
			$pageParam['page_no']=0;
		}
		if(empty($pageParam['limit'])){
			$pageParam['limit']=$defs['kj_limit'];
		}
		if(empty($pageParam['sort'])){
			$pageParam['sort']=$this->defSortFeild;
		}
		if(!isset($pageParam['sort_type'])){
			$pageParam['sort_type']=$this->defSortType;//0:昇順 1:降順
		}

		//セッションに詰める。
		if($saveKjFlg==true){
			$this->Session->write($this->main_model_name.'_page_param',$pageParam);//セッションへの書き込み
		}

		return $pageParam;
	}

	/**
	 * サブミット時用のページネーション情報を取得
	 *
	 * GET情報（URLのクエリ）からページネーション情報を取得します。
	 * ついでにセッションへのページネーション情報を保存します。
	 * このメソッドはサブミット時の処理用です。
	 *
	 * @param $kjs 検索条件情報。kj_limitのみ利用する。
	 * @param $saveKjFlg セッション保存フラグ
	 * @return array
	 * - page_no <int> ページ番号
	 * - limit <int> 表示件数
	 *
	 */
	protected function getPageParamForSubmit($kjs,$saveKjFlg){
		$d=$this->params['url'];
		$d['limit']=1000;
		if(!empty($kjs['kj_limit'])){
			$d['limit']=$kjs['kj_limit'];
		}
		$d['page_no']=0;
		if($saveKjFlg==true){
			$this->Session->write($this->main_model_name.'_page_param',$d);//セッションへの書き込み
		}
		return $d;
	}





	////////////共通処理///////////////////////////////////

	/**
	 * SESSION,あるいはデフォルトからパラメータを取得する。
	 * @param  $keys	キーリスト
	 * @param  $formKey	フォームキー
	 * @param  $def		デフォルトパラメータ
	 * @param $saveKjFlg セッション保存フラグ
	 * @return フォームデータ <array>
	 */
	protected function getParamsSD($keys,$formKey,$def,$saveKjFlg){

		$ses=null;
		if($saveKjFlg==true){
			$ses=$this->Session->read($formKey);
		}

		$prms=null;
		foreach($keys as $key){
			$prms[$key]=$this->getParamSD($key, $formKey,$ses,$def);
		}
		return $prms;

	}

	/**
	 * SESSION,あるいはデフォルトからパラメータを取得する。
	 *
	 * 内部処理用です。
	 *
	 */
	protected function getParamSD($key,$formKey,$ses,$def){


		$v=null;

		if(isset($ses)){
			$v=$ses[$key];
		}else{

			$v=$def[$key];
		}

		return $v;
	}


	/**
	 * POST,GET,SESSION,デフォルトのいずれかからパラメータリストを取得する
	 * @param  $keys キーリスト
	 * @param  $formKey フォームキー
	 * @param  $def デフォルトパラメータ
	 * @param $saveKjFlg セッション保存フラグ
	 * @return パラメータ
	 */
	protected function getParams($keys,$formKey,$def,$saveKjFlg){

		$ses=null;
		if($saveKjFlg==true){
			$ses=$this->Session->read($this->main_model_name_s.'_kjs');//セッションのパラメータを取得
		}

		$prms=null;
		foreach($keys as $key){
			$prms[$key]=$this->getParam($key, $formKey,$ses,$def);
		}

		return $prms;
	}

	/**
	 * POST,GET,SESSION,デフォルトのいずれかからパラメータを取得する。
	 * @param  $key	パラメータのキー
	 * @param  $formKey	フォームキー
	 * @param  $ses		セッションパラメータ
	 * @param  $def		デフォルトパラメータ
	 *
	 * @return パラメータ
	 */
	protected function getParam($key,$formKey,$ses,$def){
		$v=null;

		//POSTからデータ取得を試みる。
		if(isset($this->request->data[$formKey][$key])){
			$v=$this->request->data[$formKey][$key];
			//$v=Sanitize::escape($v);//SQLインジェクションのサニタイズ

		}

		//GETからデータ取得を試みる。
		elseif(isset($this->params['url'][$key])){
			$v=$this->params['url'][$key];
			//$v=Sanitize::escape($v);

		}

		//SESSIONからデータを読み取る。
		elseif(isset($ses[$key])){
			$v=$ses[$key];
		}

		//デフォルトのパラメータをセット
		else{
			$v=$def[$key];
		}

		return $v;
	}

	/**
	 * キャメル記法に変換
	 * @param  $str スネーク記法のコード
	 * @return キャメル記法のコード
	 */
	protected function camelize($str) {
		$str = strtr($str, '_', ' ');
		$str = ucwords($str);
		return str_replace(' ', '', $str);
	}

	/**
	 * スネーク記法に変換
	 * @param $str キャメル記法のコード
	 * @return スネーク記法のコード
	 */
	protected function snakize($str) {
		$str = preg_replace('/[A-Z]/', '_\0', $str);
		$str = strtolower($str);
		return ltrim($str, '_');
	}


	/**
	 * 巨大データ判定
	 * @param $kjs 検索条件情報
	 * @return 巨大データフラグ 0:通常データ  1:巨大データ
	 *
	 */
	private function checkBigDataFlg($kjs){

		$bigDataFlg=0;//巨大データフラグ

		//制限行数
		$kj_limit=0;
		if(empty($kjs['kj_limit'])){
			return $bigDataFlg;
		}else{
			$kj_limit=$kjs['kj_limit'];
		}

		// 制限行数が巨大データ判定行数以上である場合
		if($kj_limit >= $this->big_data_limit){

			App::uses('Sanitize', 'Utility');
			$kjs = Sanitize::clean($kjs, array('encode' => false));
			
			// DBよりデータ件数を取得
			$cnt=$this->MainModel->findDataCnt($kjs);

			// データ件数が巨大データ判定行数以上である場合、巨大データフラグをONにする。
			if($cnt >= $this->big_data_limit){
				$bigDataFlg=1;
			}

		}

		return $bigDataFlg;
	}

	/**
	 * 巨大データフィールドを列並替に合わせて再ソートする
	 * 
	 * @param array $big_data_fields 巨大データフィールド
	 * @param array $active アクティブフィールドデータ
	 * @return ソート後の巨大データフィールド
	 */
	private function sortBigDataFields($big_data_fields,$active){

		//巨大データフィールドのキーと値を入れ替えて、マッピングを作成する。
		$map = array_flip($big_data_fields);

		//巨大データフィールドを列並替に合わせて再ソートする
		$big_data_fields2 = array();
		foreach($active as $ent){
			$f = $ent['id'];
			if(isset($map[$f])){
				$big_data_fields2[] = $f;
			}
		}

		return $big_data_fields2;

	}

	/**
	 * 検索条件情報からデフォルト検索JSONを取得する
	 *
	 * デフォルト検索JSONはリセットボタンの処理に使われます。
	 *
	 * @param $noResets リセット対象外フィールドリスト<array> 省略可
	 * @return デフォルト検索JSON
	 */
	protected function getDefKjsJson($noResets=null){

		$kjs=$this->kensakuJoken;//メンバの検索条件情報を取得

		$defKjs=Hash::combine($kjs, '{n}.name','{n}.def');//構造変換

		//リセット対象外フィールドリストが空でなければ、対象外のフィールドをはずす。
		if(!empty($noResets)){
			foreach($noResets as $noResetField){
				unset($defKjs[$noResetField]);
			}
		}

		$defKjsJson=json_encode($defKjs);//JSON化

		return $defKjsJson;
	}





	////////// 編集画面用 ///////////////////////


	/**
	 * POSTからデータを取得
	 *
	 * SQLインジェクションのサニタイズも行われます。
	 * 編集画面の内部処理用です。
	 */
	protected function getGet($key){
		$v=null;
		if(isset($this->params['url'][$key])){
			$v=$this->params['url'][$key];
			$v=Sanitize::escape($v);//SQLインジェクションのサニタイズ

		}

		return $v;
	}

	/**
	 * デフォルトエンティティを取得
	 *
	 * 編集画面の内部処理用です。
	 */
	protected function getDefaultEntity(){

		if(empty($this->m_edit_defs)){
			foreach($this->entity_info as $ent){
				$this->m_edit_defs[$ent['name']]=$ent['def'];
			}
		}

		return $this->m_edit_defs;

	}

	/**
	 * 編集エンティティのキーリストを取得
	 *
	 * 編集画面の内部処理用です。
	 */
	protected function getKeysForEdit(){
		if(empty($this->m_edit_keys)){
			foreach($this->entity_info as $ent){
				$this->m_edit_keys[]=$ent['name'];
			}
		}

		return $this->m_edit_keys;
	}


	////////// 登録完了画面用 ///////////////////////

	/**
	 * POSTからエンティティを取得する。
	 *
	 * 登録完了画面の内部処理用です。
	 */
	protected function getEntityFromPost(){

		$keys=$this->getKeysForEdit();
		foreach($keys as $key){
			$v=$this->getPost($key);
			$ent[$key]=trim($v);
		}

		return $ent;
	}

	/**
	 * 更新関係のパラメータをエンティティにセット。
	 *
	 * 登録完了画面の内部処理用です。
	 *
	 * @param $ent	エンティティ
	 * @param $mode	モード new or edit
	 * @return 更新関係をセットしたエンティティ
	 */
	protected function setUpdateInfo($ent,$mode){

		//更新者をセット
		$user=$this->Auth->user();
		$ent['update_user']=$user['username'];

		//更新者IPアドレスをセット
		$ent['ip_addr'] = $_SERVER["REMOTE_ADDR"];

		//新規モードであるなら作成日をセット
		if($mode=='new'){
			$ent['created']=date('Y-m-d H:i:s');
		}

		//※更新日はDBテーブルにて自動設定されているので省略

		return $ent;
	}





	/**
	 * 拡張コピー　存在しないディテクトリも自動生成
	 * 日本語ファイルに対応
	 * @param  $sourceFn コピー元ファイル名
	 * @param $copyFn コピー先ファイル名 
	 * @param $permission パーミッション（ファイルとフォルダの属性。デフォルトはすべて許可の777。8進数で指定する）
	 */
	protected function copyEx($sourceFn,$copyFn,$permission=0777){

		if(empty($this->CopyEx)){
			App::uses('CopyEx', 'Vendor/Wacg');
			$this->CopyEx = $this->Animal=new CopyEx();
		}

		$this->CopyEx->copy($sourceFn,$copyFn,$permission);

	}

	/**
	 * 日本語ディレクトリの存在チェック
	 * @param  $dn	ディレクトリ名
	 * @return boolean	true:存在	false:未存在
	 */
	protected function isDirEx($dn){
		$dn=mb_convert_encoding($dn,'SJIS','UTF-8');
		if (is_dir($dn)){
			return true;
		}else{
			return false;
		}
	}

	/**
	 * パス指定によるディレクトリ作成（パーミッションをすべて許可）
	 *
	 * @note
	 * ディレクトリが既に存在しているならディレクトリを作成しない。
	 * パスに新しく作成せねばならないディレクトリ情報が複数含まれている場合でも、順次ディレクトリを作成する。
	 *
	 * @param string $path ディレクトリのパス
	 *
	 */
	protected function mkdir777($path,$sjisFlg=false){

		if(empty($this->MkdirEx)){
			App::uses('MkdirEx', 'Vendor/Wacg');
			$this->MkdirEx = new MkdirEx();
		}

		$this->MkdirEx->mkdir777($path,$sjisFlg);

	}

	// 更新ユーザーなど共通フィールドをセットする。
	protected function setCommonToEntity($ent){

		// 更新ユーザーの取得とセット
		$update_user = $this->Auth->user('username');
		$ent['update_user'] = $update_user;

		// ユーザーエージェントの取得とセット
		$user_agent = $_SERVER['HTTP_USER_AGENT'];
		$user_agent = mb_substr($user_agent,0,255);
		$ent['user_agent'] = $user_agent;

		// IPアドレスの取得とセット
		$ip_addr = $_SERVER["REMOTE_ADDR"];
		$ent['ip_addr'] = $ip_addr;

		// idが空（新規入力）なら生成日をセットし、空でないなら除去
		if(empty($ent['id'])){
			$ent['created'] = date('Y-m-d H:i:s');
		}else{
			unset($ent['created']);
		}

		// 更新日時は除去（DB側にまかせる）
		unset($ent['modified']);

		return $ent;

	}

	// 更新ユーザーなど共通フィールドをデータにセットする。
	protected function setCommonToData($data){

		// 更新ユーザー
		$update_user = $this->Auth->user('username');

		// ユーザーエージェント
		$user_agent = $_SERVER['HTTP_USER_AGENT'];
		$user_agent = mb_substr($user_agent,0,255);

		// IPアドレス
		$ip_addr = $_SERVER["REMOTE_ADDR"];

		// 本日
		$today = date('Y-m-d H:i:s');

		// データにセットする
		foreach($data as $i => $ent){

			$ent['update_user'] = $update_user;
			$ent['user_agent'] = $user_agent;
			$ent['ip_addr'] = $ip_addr;

			// idが空（新規入力）なら生成日をセットし、空でないなら除去
			if(empty($ent['id'])){
				$ent['created'] = $today;
			}else{
				unset($ent['created']);
			}

			// 更新日時は除去（DB側にまかせる）
			unset($ent['modified']);

			$data[$i] = $ent;
		}


		return $data;

	}



	/**
	 * 新バージョンであるかチェックする。
	 * @param string $this_page_version 当ページバージョン
	 * @return 新バージョンフラグ  0:バージョン変更なし   1:新バージョンに変更されている
	 */
	public function checkNewPageVersion($this_page_version){

		$sesKey = $this->main_model_name_s.'_ses_page_version_cb';

		// セッションページバージョンを取得する
		$ses_page_version = $this->Session->read($sesKey);

		// セッションページバージョンがセッションに存在しない場合
		if(empty($ses_page_version)){

			// 当ページバージョンを新たにセッションに保存し、バージョン変更なしを表す"0"を返す。
			$this->Session->write($sesKey,$this_page_version);
			return 0;
		}

		// セッションページバージョンがセッションに存在する場合
		else{

			// セッションページバージョンと当ページバージョンが一致する場合、バージョン変更なしを表す"0"を返す。
			if($this_page_version == $ses_page_version){
				return 0;
			}

			// セッションページバージョンと当ページバージョンが異なる場合、新バージョンによる変更を表す"1"を返す。
			else{
				
				$this->Session->write($sesKey,$this_page_version);
				return 1;
			}
		}
	}


	/**
	 * 主要パラメータをkjsにセットする。
	 * 
	 * @note
	 * kj_idなど特に主要なパラメータをセットする。
	 * 主要パラメータを単にリクエストで保持すると、常にそのパラメータを受け渡しをしなければならず不便である。
	 * 当メソッドでは、主要パラメータをセッションで保持し、リクエストで主要パラメータを保持する必要がなくなる。
	 * 
	 * @param multi $mains 主要パラメータのキー。配列指定も可能。
	 * @param array $kjs 検索条件情報
	 * @param kjs( 検索条件情報)
	 */
	protected function setMainsToKjs($mains,$kjs){

		// 配列でないなら配列化する
		if(!is_array($mains)){
			$mains = array($mains);
		}

		// 主要パラメータのセッションキー
		$sesKey = $this->main_model_name_s.'_mains_cb';

		// セッションで保持している主要パラメータ
		$sesMains = array();

		// kjsに主要パラメータをセットする。
		foreach($mains as $key){

			// kjs内のパラメータが空である場合
			if(empty($kjs[$key])){

				// セッションの主要パラメータが空ならセッションから取得
				if(empty($sesMains)){
					$sesMains = $this->Session->read($sesKey);
				}

				// セッションのパラメータをkjsにセットする
				if(!empty($sesMains[$key])){
					$kjs[$key] = $sesMains[$key];
				}

			}else{
				$sesMains[$key] = $kjs[$key];
			}
		}

		// 主要パラメータをセッションで保持する。
		$this->Session->write($sesKey,$sesMains);

		return $kjs;

	}


	/**
	 * AJAX | 一覧のチェックボックス複数選択による一括処理
	 * @return string
	 */
	public function ajax_pwms(){

		App::uses('Sanitize', 'Utility');

		$this->autoRender = false;//ビュー(ctp)を使わない。

		$json_param=$_POST['key1'];

		$param=json_decode($json_param,true);//JSON文字を配列に戻す

		// IDリストを取得する
		$ids = $param['ids'];

		// アクション種別を取得する
		$kind_no = $param['kind_no'];

		// 更新ユーザーを取得する
		$update_user = $this->Auth->user('username');

		$this->MainModel=ClassRegistry::init($this->name);

		// アクション種別ごとに処理を分岐
		switch ($kind_no){
			case 10:
				$this->MainModel->switchDeleteFlg($ids,0,$update_user); // 有効化
				break;
			case 11:
				$this->MainModel->switchDeleteFlg($ids,1,$update_user); // 無効化
				break;
			default:
				return "'kind_no' is unknown value";

		}

		return 'success';
	}


	/**
	 * アップロードファイルが存在すれば、アップロードファイル名をエンティティにセットする
	 * @param array $files アップロードファイル情報($_FILESを指定する)
	 * @param array $ent エンティティ
	 * @param any $fnField ファイル名フィールド（複数あるときは配列指定可）
	 * @return アップロードファイル名をセットしたエンティティ 
	 */
	protected function setUploadFileValueToEntity($files,$ent,$fnField){

		// ファイルフィールド名リストの初期セット
		$fnFields = array(); // ファイルフィールド名リスト
		if(is_array($fnField)){
			$fnFields = $fnField;
		}else{
			$fnFields[] = $fnField;
		}

		// アップロードファイル情報が空ならエンティティから該当フィールドを除去して処理抜け
		if(empty($files)){
			foreach($fnFields as $fu_key){
				unset($ent[$fu_key]);
			}

			return array(
				'ent' => $ent,
				'fuKeys' => array(),
			);
		}

		$fuKeys = array();// アップロードファイル関連のキーリスト
		foreach($fnFields as $fu_key){
			if(empty($files[$fu_key])){
				continue;
			}
			$fData = $files[$fu_key];

			if(!empty($fData["name"]) && $fData["name"] != ''){
				$fn = $fData["name"];
				$ent[$fu_key] = $fn;
				$fuKeys[] = $fu_key;
			}

			// アップロードするファイルがないなら、エンティティからアップロードファイルのフィールドを除去する。
			else{
				unset($ent[$fu_key]);
			}
		}

		$res = array(
				'ent' => $ent,
				'fuKeys' => $fuKeys,
		);

		return $res;
	}


	/**
	 * パラメータ内の指定したフィールドが数値であるかチェックする
	 * 
	 * @note
	 * リクエストパラメータ内のidなどを調べる。
	 * idにSQLインジェクションを引き起こすコードが入っていないかなどを調べる。
	 * 
	 * @param array $param リクエストパラメータ
	 * @param array $numProps 数値フィールドリスト： チェック対象のフィールドを配列で指定する
	 * @return 指定したフィールドに紐づくパラメータの値のうち、一つでも数値でないものがあればfalseを返す。
	 */
	protected function checkNumberParam($param,$numProps=array('id')){

		foreach($numProps as $field){
			if(!is_numeric($param[$field])){
				return false;
			}
		}
		return true;
	}


}