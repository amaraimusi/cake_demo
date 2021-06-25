<?php


/**
 * ユーザー管理画面
 * 
 * @since 2021-4-1
 *
 */
class UserMngController extends AppController {

	private $cb; // CrudBase制御クラス
	
	/// 名称コード
	public $name = 'UserMng';
	
	/// 使用しているモデル[CakePHPの機能]
	public $uses = ['UserMng'];
	
	public $login_flg = 0; // ログインフラグ 0:ログイン不要, 1:ログイン必須
	
	// 当画面バージョン (バージョンを変更すると画面に新バージョン通知とクリアボタンが表示されます。）
	public $this_page_version = '1.0.2';

	
	
	public function beforeFilter() {

		$userInfo = $this->getUserInfo();
		$role_level = $userInfo['authority']['level'];
		
		if($role_level < 30){
			$this->redirect(['controller' => 'users', 'action' => 'login']);
			die();
		}

		parent::beforeFilter();

	}

	/**
	 * indexページのアクション
	 *
	 * indexページではユーザー管理一覧を検索閲覧できます。
	 * 一覧のidから詳細画面に遷移できます。
	 * ページネーション、列名ソート、列表示切替、CSVダウンロード機能を備えます。
	 */
	public function index() {
		
		$this->init();
		
		// CrudBase共通処理（前）
		$crudBaseData = $this->cb->indexBefore();//indexアクションの共通先処理(CrudBaseController)
		$userInfo = $this->getUserInfo();
		$crudBaseData['userInfo'] = $userInfo;
		
		// 権限チェック
		$this->checkRole($userInfo);
		
		
		// Ajaxセキュリティ:CSRFトークンの取得
		$crudBaseData['csrf_token'] = CrudBaseU::getCsrfToken('user_mng');
		
		
		$res = $this->md->getData($crudBaseData);
		$data = $res['data'];
		$non_limit_count = $res['non_limit_count']; // LIMIT制限なし・データ件数

		// CrudBase共通処理（後）
		$crudBaseData = $this->cb->indexAfter($crudBaseData, ['non_limit_count'=>$non_limit_count]);
		
		$masters = []; // マスターリスト群
		
		// CBBXS-2020

		// 権限リスト
		$roleList = $this->md->getRoleList($userInfo['role']);
		$masters['roleList'] = $roleList;

		// CBBXE
		
		$crudBaseData['masters'] = $masters;
		
		$crud_base_json = json_encode($crudBaseData,JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS);

		// CBBXS-2019

		// CBBXE

		$this->set([
			'title_for_layout'=>'ユーザー管理',
			'data'=> $data,
			'crudBaseData'=> $crudBaseData,
			'crud_base_json'=> $crud_base_json,
		]);


	}
	
	// 権限チェック
	private function checkRole(&$userInfo){
		
		if(empty($userInfo)) throw new Exception('システムエラー 210530A');
		if(empty($userInfo['authority'])) throw new Exception('システムエラー 210530B');
		if(empty($userInfo['authority']['name'])) throw new Exception('システムエラー 210530C');
		
		$permission = false;
		if($userInfo['authority']['name'] == 'master') $permission = true;
		if($userInfo['authority']['name'] == 'developer') $permission = true;
		if($userInfo['authority']['name'] == 'admin') $permission = true;
		
		if($permission == false) throw new Exception('アクセス禁止の権限です。 210530D');

	}
	

	
	/**
	 * DB登録
	 *
	 * @note
	 * Ajaxによる登録。
	 * 編集登録と新規入力登録の両方に対応している。
	 */
	public function ajax_reg(){
		
		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		// CSRFトークンによるセキュリティチェック
		if(CrudBaseU::checkCsrfToken('user_mng') == false){
			return '不正なアクションを検出しました。';
		}
		
		$userInfo = $this->Auth->user(); // ログインユーザー情報を取得する
		
		$this->init();

		// 未ログインかつローカルでないなら、エラーアラートを返す。
		if(empty($userInfo) && $_SERVER['SERVER_NAME']!='localhost'){
			return 'Error:ログイン認証が必要です。 Login is needed';
		}
		
		// JSON文字列をパースしてエンティティを取得する
		$json=$_POST['key1'];
		$ent = json_decode($json, true);
		
		// 登録パラメータ
		$reg_param_json = $_POST['reg_param_json'];
		$regParam = json_decode($reg_param_json,true);
		$form_type = $regParam['form_type']; // フォーム種別 new_inp,edit,delete,eliminate
		
		// Eメールの重複チェック
		if($form_type == 'new_inp'){
			if($this->md->checkDuplicateOfEmail($ent['email'])==false){
				$errs = ['err'=>'すでに登録されているメールアドレスです。<br>一覧にて登録が確認できない場合、削除状態で登録されていることもあります。詳細検索にて「削除」で検索すると削除状態のデータを確認できます。']; // エラーリスト
				$json_str = json_encode($errs, JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS); // JSONに変換
				return $json_str;
			}
		}
		
		// CBBXS-1024
		// パスワードを暗号化する
		if(!empty($ent['password'])){
			$ent['password'] = AuthComponent::password($ent['password']);
		}else{
			unset($ent['password']);
		}

		// CBBXE
		
		// CBBXS-2024

		// CBBXE
		
		if(empty($ent['username'])){
			$ent['username'] = $ent['email'];
		}
		
		$ent = $this->setCommonToEntity($ent); // 更新者などの情報をセットする
		$ent = $this->md->saveEntity($ent, $regParam);
		
		// CBBXS-2025

		// CBBXE
		
		$json_str = json_encode($ent, JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS); // JSONに変換
		
		return $json_str;
		
	}

	
	/**
	 * 削除登録
	 *
	 * @note
	 * Ajaxによる削除登録。
	 * 削除更新でだけでなく有効化に対応している。
	 * また、DBから実際に削除する抹消にも対応している。
	 */
	public function ajax_delete(){

		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		// CSRFトークンによるセキュリティチェック
		if(CrudBaseU::checkCsrfToken('user_mng') == false){
			return '不正なアクションを検出しました。';
		}
		
		if($this->login_flg == 1 && empty($this->Auth->user())){
			return 'Error:login is needed.';// 認証中でなければエラー
		}

		// JSON文字列をパースしてエンティティを取得する
		$json=$_POST['key1'];
		$ent0 = json_decode($json,true);
		
		// 登録パラメータ
		$reg_param_json = $_POST['reg_param_json'];
		$regParam = json_decode($reg_param_json,true);

		// 抹消フラグ
		$eliminate_flg = 0;
		if(isset($regParam['eliminate_flg'])) $eliminate_flg = $regParam['eliminate_flg'];
		
		// 削除用のエンティティを取得する
		$ent = $this->getEntForDelete($ent0['id']);
		$ent['delete_flg'] = $ent0['delete_flg'];
	
		// エンティティをDB保存
		$this->UserMng->begin();
		if($eliminate_flg == 0){
			$ent = $this->UserMng->saveEntity($ent,$regParam); // 更新
		}else{
			$this->UserMng->eliminateFiles($ent['id'], 'img_fn', $ent); // ファイル抹消（他のレコードが保持しているファイルは抹消対象外）
			$this->UserMng->delete($ent['id']); // 削除
		}
		$this->UserMng->commit();//コミット
		
		$json_str =json_encode($ent);//JSONに変換
	
		return $json_str;
	}
	
	
	/**
	* Ajax | 自動保存
	* 
	* @note
	* バリデーション機能は備えていない
	* 
	*/
	public function auto_save(){
		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		// CSRFトークンによるセキュリティチェック
		if(CrudBaseU::checkCsrfToken('user_mng') == false){
			return '不正なアクションを検出しました。';
		}
		
		App::uses('Sanitize', 'Utility');
		
		if($this->login_flg == 1 && empty($this->Auth->user())){
			return 'Error:login is needed.';// 認証中でなければエラー
		}
		
		$json=$_POST['key1'];
		
		$data = json_decode($json,true);//JSON文字を配列に戻す
		
		// データ保存
		$this->UserMng->begin();
		$this->UserMng->saveAll($data); // まとめて保存。内部でSQLサニタイズされる。
		$this->UserMng->commit();

		$res = array('success');
		
		$json_str = json_encode($res);//JSONに変換
		
		return $json_str;
	}
	
	
	/**
	 * AJAX | 一覧のチェックボックス複数選択による一括処理
	 * @return string
	 */
	public function ajax_pwms() {
		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		$this->init();
		return $this->cb->ajax_pwms();
		
	}
	
	
	/**
	 * ファイルアップロードクラスのファクトリーメソッド
	 * @return \App\Http\Controllers\FileUploadK
	 */
	private function factoryFileUploadK(){
		$crud_base_path = CRUD_BASE_PATH;
		require_once $crud_base_path . 'FileUploadK/FileUploadK.php';
		$fileUploadK = new \FileUploadK();
		return $fileUploadK;
	}
	
	
	/**
	 * 一括登録 | AJAX
	 *
	 * @note
	 * 一括追加, 一括編集, 一括複製
	 */
	public function bulk_reg(){
		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		// CSRFトークンによるセキュリティチェック
		if(CrudBaseU::checkCsrfToken('user_mng') == false){
			return '不正なアクションを検出しました。';
		}
		
		$this->init();
		
		require_once CRUD_BASE_PATH . 'BulkReg.php';
		
		// 更新ユーザーを取得
		$update_user = 'none';
		if(!empty($this->Auth->user())){
			$userData = $this->Auth->user();
			$update_user = $userData['username'];
		}else{
			throw new Exception('Login is needed. ログインが必要です。');
			die();
		}
		
		$json_param=$_POST['key1'];
		$param = json_decode($json_param,true);//JSON文字を配列に戻す
		
		// 一括登録
		$strategy = $this->cb->getStrategy(); // フレームワークストラテジーを取得する
		$bulkReg = new \BulkReg($strategy, $update_user);
		$res = $bulkReg->reg('users', $param);
		
		//JSONに変換
		$str_json = json_encode($res,JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS);
		
		return $str_json;
	}

	
	/**
	 * CSVインポート | AJAX
	 *
	 * @note
	 *
	 */
	public function csv_fu(){
		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		// CSRFトークンによるセキュリティチェック
		if(CrudBaseU::checkCsrfToken('user_mng') == false){
			return '不正なアクションを検出しました。';
		}
		
		if(empty($this->Auth->user())) return 'Error:login is needed.';// 認証中でなければエラー
		
		$this->csv_fu_base($this->UserMng, array('id','user_mng_val','user_mng_name','user_mng_date','user_mng_group','user_mng_dt','user_mng_flg','img_fn','note','sort_no'));
		
	}

	
	/**
	 * CSVダウンロード
	 *
	 * 一覧画面のCSVダウンロードボタンを押したとき、一覧データをCSVファイルとしてダウンロードします。
	 */
	public function csv_download(){
		$this->autoRender = false;//ビューを使わない。
		
		// CSRFトークンによるセキュリティチェック
		if(CrudBaseU::checkCsrfToken('user_mng') == false){
			return '不正なアクションを検出しました。';
		}
	
		//ダウンロード用のデータを取得する。
		$data = $this->getDataForDownload();
		
		// ダブルクォートで値を囲む
		foreach($data as &$ent){
			unset($ent['xml_text']);
			foreach($ent as $field => $value){
				if(mb_strpos($value,'"')!==false){
					$value = str_replace('"', '""', $value);
				}
				$value = '"' . $value . '"';
				$ent[$field] = $value;
			}
		}
		unset($ent);
		
		//列名配列を取得
		$clms=array_keys($data[0]);
	
		//データの先頭行に列名配列を挿入
		array_unshift($data,$clms);
	
		//CSVファイル名を作成
		$date = new DateTime();
		$strDate=$date->format("Y-m-d");
		$fn='user_mng'.$strDate.'.csv';

		//CSVダウンロード
		App::uses('CsvDownloader','Vendor/CrudBase');
		$csv= new CsvDownloader();
		$csv->output($fn, $data);

	}

	
	//ダウンロード用のデータを取得する。
	private function getDataForDownload(){
		 
		
		//セッションから検索条件情報を取得
		$kjs=$this->Session->read('user_mng_kjs');
		
		// セッションからページネーション情報を取得
		$pages = $this->Session->read('user_mng_pages');

		$page_no = 0;
		$row_limit = 100000;
		$sort_field = $pages['sort_field'];
		$sort_desc = $pages['sort_desc'];
		
		$pages['page_no'] = $page_no;
		$pages['row_limit'] = $row_limit;
		$pages['sort_field'] = $sort_field;
		$pages['sort_desc'] = $sort_desc;
		
		$crudBaseData = $this->init();
		$crudBaseData['kjs'] = $kjs;
		$crudBaseData['pages'] = $pages;
		$crudBaseData['userInfo'] = $this->getUserInfo();

		//DBからデータ取得
		$res=$this->UserMng->getData($crudBaseData);
		$data = $res['data'];
		if(empty($data)){
			return [];
		}
	
		return $data;
	}

	
	/**
	 * CrudBase用の初期化処理
	 *
	 * @note
	 * フィールド関連の定義をする。
	 *
	 */
	private function init(){

		/// 検索条件情報の定義
		$kensakuJoken=[
			
			['name'=>'kj_main', 'def'=>null],
			// CBBXS-2000
			['name'=>'kj_id', 'def'=>null],
			['name'=>'kj_username', 'def'=>null],
			['name'=>'kj_email', 'def'=>null],
			['name'=>'kj_nickname', 'def'=>null],
			['name'=>'kj_password', 'def'=>null],
			['name'=>'kj_role', 'def'=>null],
			['name'=>'kj_sort_no', 'def'=>null],
			['name'=>'kj_delete_flg', 'def'=>0],
			['name'=>'kj_update_user', 'def'=>null],
			['name'=>'kj_ip_addr', 'def'=>null],
			['name'=>'kj_created', 'def'=>null],
			['name'=>'kj_modified', 'def'=>null],

			// CBBXE
			
			['name'=>'row_limit', 'def'=>50],
			
		];
		
		
		///フィールドデータ
		$fieldData = ['def'=>[
			
			// CBBXS-2002
			'id'=>[
					'name'=>'ID',//HTMLテーブルの列名
					'row_order'=>'UserMng.id',//SQLでの並び替えコード
					'clm_show'=>1,//デフォルト列表示 0:非表示 1:表示
			],
			'username'=>[
					'name'=>'username',
					'row_order'=>'UserMng.username',
					'clm_show'=>0,
			],
			'email'=>[
				'name'=>'メールアドレス',
				'row_order'=>'UserMng.email',
				'clm_show'=>1,
			],
			'nickname'=>[
				'name'=>'表示名',
				'row_order'=>'UserMng.nickname',
				'clm_show'=>1,
			],
			'password'=>[
					'name'=>'PWハッシュ',
					'row_order'=>'UserMng.password',
					'clm_show'=>0,
			],
			'role'=>[
					'name'=>'権限',
					'row_order'=>'UserMng.role',
					'clm_show'=>1,
			],
			'sort_no'=>[
					'name'=>'順番',
					'row_order'=>'UserMng.sort_no',
					'clm_show'=>0,
			],
			'delete_flg'=>[
					'name'=>'削除フラグ',
					'row_order'=>'UserMng.delete_flg',
					'clm_show'=>0,
			],
			'update_user'=>[
					'name'=>'更新ユーザー',
					'row_order'=>'UserMng.update_user',
					'clm_show'=>0,
			],
			'ip_addr'=>[
					'name'=>'更新IPアドレス',
					'row_order'=>'UserMng.ip_addr',
					'clm_show'=>0,
			],
			'created'=>[
					'name'=>'作成日時',
					'row_order'=>'UserMng.created',
					'clm_show'=>0,
			],
			'modified'=>[
					'name'=>'更新日時',
					'row_order'=>'UserMng.modified',
					'clm_show'=>0,
			],

			// CBBXE
		]];
		
		// 列並び順をセットする
		$clm_sort_no = 0;
		foreach ($fieldData['def'] as &$fEnt){
			$fEnt['clm_sort_no'] = $clm_sort_no;
			$clm_sort_no ++;
		}
		unset($fEnt);
		
		$crud_base_path = CRUD_BASE_PATH;
		$crud_base_js = CRUD_BASE_JS;
		$crud_base_css = CRUD_BASE_CSS;
		require_once $crud_base_path . 'CrudBaseController.php';

		
		$model = $this->UserMng; // モデルクラス
		
		$crudBaseData = [
			'fw_type' => 'cake',
			'model_name_c' => 'UserMng',
			'tbl_name' => 'users', // テーブル名をセット
			'kensakuJoken' => $kensakuJoken, //検索条件情報
			'fieldData' => $fieldData, //フィールドデータ
			'crud_base_path' => $crud_base_path,
			'crud_base_js' => $crud_base_js,
			'crud_base_css' => $crud_base_css,
		];

		$crudBaseCon = new CrudBaseController($this, $model, $crudBaseData);

		$model->init($crudBaseCon);
		
		$this->md = $model;
		$this->cb = $crudBaseCon;

		$crudBaseData = $crudBaseCon->getCrudBaseData();

		return $crudBaseData;
		
	}


}