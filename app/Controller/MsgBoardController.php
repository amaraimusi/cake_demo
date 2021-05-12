<?php


/**
 * メッセージボード画面
 * 
 * @date 2015-9-16 | 2021-4-10
 *
 */
class MsgBoardController extends AppController {

	private $cb; // CrudBase制御クラス
	
	/// 名称コード
	public $name = 'MsgBoard';
	
	/// 使用しているモデル[CakePHPの機能]
	public $uses = ['MsgBoard'];
	
	public $login_flg = 0; // ログインフラグ 0:ログイン不要, 1:ログイン必須
	
	// 当画面バージョン (バージョンを変更すると画面に新バージョン通知とクリアボタンが表示されます。）
	public $this_page_version = '4.0.0';

	
	
	public function beforeFilter() {

		// 未ログイン中である場合、未認証モードの扱いでページ表示する。
		if($this->login_flg == 0 && empty($this->Auth->user())){
			$this->Auth->allow(); // 未認証モードとしてページ表示を許可する。
		}
		
		parent::beforeFilter();

	}

	/**
	 * indexページのアクション
	 *
	 * indexページではメッセージボード一覧を検索閲覧できます。
	 * 一覧のidから詳細画面に遷移できます。
	 * ページネーション、列名ソート、列表示切替、CSVダウンロード機能を備えます。
	 */
	public function index() {
		
		$this->init();
		
		// CrudBase共通処理（前）
		$crudBaseData = $this->cb->indexBefore();//indexアクションの共通先処理(CrudBaseController)
		$crudBaseData['pages']['sort_desc'] = 1;
		
		// Ajaxセキュリティ:CSRFトークンの取得
		$crudBaseData['csrf_token'] = CrudBaseU::getCsrfToken('msg_board');
		
		$res = $this->MsgBoard->getData($crudBaseData);
		$data = $res['data'];
		$non_limit_count = $res['non_limit_count']; // LIMIT制限なし・データ件数
		
		// CrudBase共通処理（後）
		$crudBaseData = $this->cb->indexAfter($crudBaseData, ['non_limit_count'=>$non_limit_count]);
		
		$userInfo = $crudBaseData['userInfo'];
		
		// 当画面のユーザータイプを取得 master:マスター型, login_user:一般ログインユーザー, guest:未ログインユーザー
		$this_user_type = $this->getThisUserType();
		
		// 当画面のユーザータイプによる変更ボタン、削除ボタンの表示、非表示情報をセットする
		$data = $this->MsgBoard->setBtnDisplayByThisUserType($this_user_type, $data, $userInfo);
		
		$crudBaseData['this_user_type'] = $this_user_type;
		
		$crud_base_json = json_encode($crudBaseData,JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS);

		$this->set([
			'title_for_layout'=>'メッセージボード',
			'data'=> $data,
			'crudBaseData'=> $crudBaseData,
			'crud_base_json'=> $crud_base_json,
		]);


	}

	
	/**
	 * Ajax 新規DB登録
	 *
	 */
	public function ajax_new_reg(){
		
		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		// CSRFトークンによるセキュリティチェック
		if(CrudBaseU::checkCsrfToken('msg_board') == false){
			return '不正なアクションを検出しました。';
		}
		
		$userInfo = $this->Auth->user(); // ログインユーザー情報を取得する
		
		$this->init();
		
		// JSON文字列をパースしてエンティティを取得する
		$json=$_POST['key1'];
		$ent = json_decode($json, true);
		
		// 登録パラメータ
		$reg_param_json = $_POST['reg_param_json'];
		$regParam = json_decode($reg_param_json,true);
		$form_type = $regParam['form_type']; // フォーム種別 new_inp,edit,delete,eliminate

		$ent['attach_fn'] = $this->cb->makeFilePath($_FILES, 'rsc/img/%field/y%Y/m%m/orig/%fn', $ent, 'attach_fn');

		$ent = $this->setCommonToEntity($ent);
		// CBBXE
		$ent = $this->md->saveEntity($ent, $regParam);
		
		// ファイルアップロードの一括作業
		$fileUploadK = $this->factoryFileUploadK();
		$res = $fileUploadK->putFile1($_FILES, 'attach_fn', $ent['attach_fn']);

		$json_str = json_encode($ent, JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS); // JSONに変換
		
		return $json_str;
		
	}
	
	
	/**
	 * Ajax 編集DB登録
	 *
	 */
	public function ajax_edit_reg(){
		
		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		// CSRFトークンによるセキュリティチェック
		if(CrudBaseU::checkCsrfToken('msg_board') == false){
			return '不正なアクションを検出しました。';
		}
		
			
		$userInfo = $this->getUserInfo();
		if(empty($userInfo['id'])) throw new Exception('システムエラー 210512A');
		
		$this->init();
		
		// JSON文字列をパースしてエンティティを取得する
		$json=$_POST['key1'];
		$ent = json_decode($json, true);
		
		if($userInfo['id'] != $ent['user_id']) throw new Exception('システムエラー 210512B');
		
		// 登録パラメータ
		$reg_param_json = $_POST['reg_param_json'];
		$regParam = json_decode($reg_param_json,true);

		$ent = $this->setCommonToEntity($ent);

		unset($ent['attach_fn']);
		if(empty($ent['id'])) throw new Exception('システムエラー 210512C');
		
		// CBBXE
		$ent = $this->md->saveEntity($ent, $regParam);
		
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
		if(CrudBaseU::checkCsrfToken('msg_board') == false){
			return '不正なアクションなアクションです。 210510B';
		}
		
		$userInfo = $this->getUserInfo();
		if(empty($userInfo['id'])){
			return '不正なアクションなアクションです。 210510C';
		}
		
		$config = 
			[
				'org_del_flg'=>'1', // マスター権限者は一般ログインユーザーのメッセージを削除できるか 0:削除不可, 1:削除フラグON, 2:抹消する
				'my_del_flg'=>'1', // 一般ログインユーザーは自分のメッセージを削除できるか。 0:削除不可, 1:削除フラグON, 2:抹消する
			];
			
		$org_del_flg = $config['org_del_flg'];
		$my_del_flg = $config['my_del_flg'];
		
		$user_id = $userInfo['id'];

		// 当画面のユーザータイプを取得 master:マスター型, login_user:一般ログインユーザー, guest:未ログインユーザー
		$this_user_type = $this->getThisUserType($userInfo); 
		
		// JSON文字列をパースしてエンティティを取得する
		$json=$_POST['key1'];
		$param = json_decode($json, true);
		$id = $param['id']; // メッセージボードID
		
		// 削除対象のメッセージボードエンティティを取得する
		$sql = "SELECT * FROM msg_boards WHERE id={$id}";
		$ent = $this->MsgBoard->query($sql);

		if(empty($ent)) return '不正なアクション 210511A';
		$ent = $ent[0]['msg_boards'];

		$my_msg_flg = 0; // 自分のメッセージであるか？ 0:違う, 1:自分のメッセージである。
		if($ent['user_id'] == $user_id){
			$my_msg_flg = 1;
		}
		
		if($this_user_type == 'master'){
			// 自分のメッセージである場合
			if($my_msg_flg == 1){
				$this->deleteActionToDb($my_del_flg, $ent, $userInfo);
			}
			
			// 自分のメッセージではない場合
			else{
				$this->deleteActionToDb($org_del_flg, $ent, $userInfo);
			}
		}else if($this_user_type == 'login_user'){
			if($my_msg_flg == 1){
				$this->deleteActionToDb($my_del_flg, $ent, $userInfo);
			}
			
			// 自分のメッセージではない場合は何もしない
			else{
				
			}
		}else{
			return 'システムエラー 210511B';
		}
		
		$res = ['success'=>1];
		
		$json_str =json_encode($res);//JSONに変換
		
		return $json_str;

	}
	
	
	/**
	 * 
	 * 当画面のユーザータイプを取得
	 * @param [] $userInfo
	 * @return string 当画面のユーザータイプ master:マスター型, login_user:一般ログインユーザー, guest:未ログインユーザー
	 */
	private function getThisUserType($userInfo = []){
		
		if(empty($userInfo)){
			$userInfo = $this->getUserInfo();
		}
		
		if(empty($userInfo['id'])) return 'guest';
		
		$this_user_type = 'login_user'; // 当画面のユーザータイプ 
		
		if($userInfo['authority']['level'] >= 30){
			$this_user_type = 'master';
		}
		
		return $this_user_type;
	}
	
	
	
	/**
	 * DBへの削除処理
	 * @param int $del_flg 削除方法フラグ 0:削除しない, 1:削除フラグをON, 2:抹消（DELETE）
	 * @param [] $ent メッセージボードエンティティ
	 * @param [] $userInfo ユーザー情報
	 */	
	private function deleteActionToDb($my_del_flg, &$ent, &$userInfo){
		
		if($my_del_flg == 0) return;
		
		// 削除フラグON
		elseif($my_del_flg == 1){
			$ent['update_user'] = $userInfo['update_user'];
			$ent['ip_addr'] = $userInfo['ip_addr'];
			$ent['delete_flg'] = 1;
			$this->MsgBoard->save($ent, ['validate'=>false]);
			
		}
		
		// 抹消
		elseif($my_del_flg == 2){
			$this->MsgBoard->delete($ent['id']);
		}
		
		else{
			throw new Exception('システムエラー 210511C');
		}
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
		if(CrudBaseU::checkCsrfToken('msg_board') == false){
			return '不正なアクションを検出しました。';
		}
		
		App::uses('Sanitize', 'Utility');
		
		if($this->login_flg == 1 && empty($this->Auth->user())){
			return 'Error:login is needed.';// 認証中でなければエラー
		}
		
		$json=$_POST['key1'];
		
		$data = json_decode($json,true);//JSON文字を配列に戻す
		
		// データ保存
		$this->MsgBoard->begin();
		$this->MsgBoard->saveAll($data); // まとめて保存。内部でSQLサニタイズされる。
		$this->MsgBoard->commit();

		$res = array('success');
		
		$json_str = json_encode($res);//JSONに変換
		
		return $json_str;
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
		if(CrudBaseU::checkCsrfToken('msg_board') == false){
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
		$res = $bulkReg->reg('msg_boards', $param);
		
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
		if(CrudBaseU::checkCsrfToken('msg_board') == false){
			return '不正なアクションを検出しました。';
		}
		
		if(empty($this->Auth->user())) return 'Error:login is needed.';// 認証中でなければエラー
		
		$this->csv_fu_base($this->MsgBoard,array('id','msg_board_val','msg_board_name','msg_board_date','msg_board_group','msg_board_dt','msg_board_flg','img_fn','note','sort_no'));
		
	}

	
	/**
	 * CSVダウンロード
	 *
	 * 一覧画面のCSVダウンロードボタンを押したとき、一覧データをCSVファイルとしてダウンロードします。
	 */
	public function csv_download(){
		$this->autoRender = false;//ビューを使わない。
		
		// CSRFトークンによるセキュリティチェック
		if(CrudBaseU::checkCsrfToken('msg_board') == false){
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
		$fn='msg_board'.$strDate.'.csv';

		//CSVダウンロード
		App::uses('CsvDownloader','Vendor/CrudBase');
		$csv= new CsvDownloader();
		$csv->output($fn, $data);

	}

	
	//ダウンロード用のデータを取得する。
	private function getDataForDownload(){
		 
		
		//セッションから検索条件情報を取得
		$kjs=$this->Session->read('msg_board_kjs');
		
		// セッションからページネーション情報を取得
		$pages = $this->Session->read('msg_board_pages');

		$page_no = 0;
		$row_limit = 100000;
		$sort_field = $pages['sort_field'];
		$sort_desc = $pages['sort_desc'];
		
		$crudBaseData = array(
				'kjs' => $kjs,
				'pages' => $pages,
				'page_no' => $page_no,
				'row_limit' => $row_limit,
				'sort_field' => $sort_field,
				'sort_desc' => $sort_desc,
		);
		

		//DBからデータ取得
		$data=$this->MsgBoard->findData($crudBaseData);
		if(empty($data)){
			return array();
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
				['name'=>'kj_other_id', 'def'=>null],
				['name'=>'kj_user_id', 'def'=>null],
				['name'=>'kj_message', 'def'=>null],
				['name'=>'kj_attach_fn', 'def'=>null],
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
					'row_order'=>'MsgBoard.id',//SQLでの並び替えコード
					'clm_show'=>1,//デフォルト列表示 0:非表示 1:表示
			],
			'other_id'=>[
					'name'=>'外部ID',
					'row_order'=>'MsgBoard.other_id',
					'clm_show'=>1,
			],
			'user_id'=>[
					'name'=>'ユーザーID',
					'row_order'=>'MsgBoard.user_id',
					'clm_show'=>1,
			],
			'message'=>[
					'name'=>'メッセージ',
					'row_order'=>'MsgBoard.message',
					'clm_show'=>1,
			],
			'attach_fn'=>[
					'name'=>'添付ファイル',
					'row_order'=>'MsgBoard.attach_fn',
					'clm_show'=>1,
			],
			'sort_no'=>[
					'name'=>'順番',
					'row_order'=>'MsgBoard.sort_no',
					'clm_show'=>0,
			],
			'delete_flg'=>[
					'name'=>'無効フラグ',
					'row_order'=>'MsgBoard.delete_flg',
					'clm_show'=>0,
			],
			'update_user'=>[
					'name'=>'更新者',
					'row_order'=>'MsgBoard.update_user',
					'clm_show'=>0,
			],
			'ip_addr'=>[
					'name'=>'IPアドレス',
					'row_order'=>'MsgBoard.ip_addr',
					'clm_show'=>0,
			],
			'created'=>[
					'name'=>'生成日時',
					'row_order'=>'MsgBoard.created',
					'clm_show'=>0,
			],
			'modified'=>[
					'name'=>'更新日',
					'row_order'=>'MsgBoard.modified',
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
		
		require_once CRUD_BASE_PATH . 'CrudBaseController.php';

		$model = $this->MsgBoard; // モデルクラス
		
		$crudBaseData = [
			'fw_type' => 'cake',
			'model_name_c' => 'MsgBoard',
			'tbl_name' => 'msg_boards', // テーブル名をセット
			'kensakuJoken' => $kensakuJoken, //検索条件情報
			'fieldData' => $fieldData, //フィールドデータ
		];

		$crudBaseCon = new CrudBaseController($this, $model, $crudBaseData);

		$model->init($crudBaseCon);
		
		$this->md = $model;
		$this->cb = $crudBaseCon;

		$crudBaseData = $crudBaseCon->getCrudBaseData();

		return $crudBaseData;
		
	}


}