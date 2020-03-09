<?php
App::uses('CrudBaseController', 'Controller');
App::uses('PagenationForCake', 'Vendor/CrudBase');

/**
 * ネコ
 * 
 * @note
 * ネコ画面ではネコ一覧を検索閲覧、編集など多くのことができます。
 * 
 * @date 2015-9-16 | 2020-3-1
 *
 */
class NekoController extends CrudBaseController {

	/// 名称コード
	public $name = 'Neko';
	
	/// 使用しているモデル[CakePHPの機能]
	public $uses = array('Neko','CrudBase');
	
	/// オリジナルヘルパーの登録[CakePHPの機能]
	public $helpers = array('CrudBase');

	/// デフォルトの並び替え対象フィールド
	public $defSortFeild='Neko.sort_no';
	
	/// デフォルトソートタイプ	  0:昇順 1:降順
	public $defSortType=0;
	
	/// 検索条件情報の定義
	public $kensakuJoken=array();

	/// 検索条件のバリデーション
	public $kjs_validate = array();

	///フィールドデータ
	public $field_data=array();

	/// 編集エンティティ定義
	public $entity_info=array();

	/// 編集用バリデーション
	public $edit_validate = array();
	
	public $login_flg = 0; // ログインフラグ 0:ログイン不要, 1:ログイン必須
	
	// 当画面バージョン (バージョンを変更すると画面に新バージョン通知とクリアボタンが表示されます。）
	public $this_page_version = '3.2.4';

	
	
	public function beforeFilter() {

		// 未ログイン中である場合、未認証モードの扱いでページ表示する。
		if($this->login_flg == 0 && empty($this->Auth->user())){
			$this->Auth->allow(); // 未認証モードとしてページ表示を許可する。
		}
		
// 		if($this->action == 'front_a'){
// 			// 未ログイン中である場合、未認証モードの扱いでページ表示する。
// 			if(empty($this->Auth->user())){
// 				$this->Auth->allow(); // 未認証モードとしてページ表示を許可する。
// 			}
// 		}
	
		parent::beforeFilter();
	
		$this->initCrudBase();// フィールド関連の定義をする。
	
	}

	/**
	 * indexページのアクション
	 *
	 * indexページではネコ一覧を検索閲覧できます。
	 * 一覧のidから詳細画面に遷移できます。
	 * ページネーション、列名ソート、列表示切替、CSVダウンロード機能を備えます。
	 */
	public function index() {
		
		// CrudBase共通処理（前）
		$crudBaseData = $this->indexBefore('Neko');//indexアクションの共通先処理(CrudBaseController)
		
		// CBBXS-1019
		
		// CBBXE
		
		//一覧データを取得
		$data = $this->Neko->findData($crudBaseData);

		// CrudBase共通処理（後）
		$crudBaseData = $this->indexAfter($crudBaseData);//indexアクションの共通後処理
		
		// CBBXS-1020
		$nekoGroupList = $this->Neko->getNekoGroupList();
		$neko_group_json = json_encode($nekoGroupList,JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS);
		$this->set(array('nekoGroupList' => $nekoGroupList,'neko_group_json' => $neko_group_json));
		// CBBXE
		
		$this->set($crudBaseData);
		$this->set(array(
			'title_for_layout'=>'ネコ',
			'data'=> $data,
		));
		
		//当画面系の共通セット
		$this->setCommon();


	}
	
	
	/**
	 * フロントページA
	 */
	public function front_a(){
		
		// CrudBase共通処理（前）
		$option = array(
				'func_csv_export'=>0, // CSVエクスポート機能 0:OFF ,1:ON
				'func_file_upload'=>1, // ファイルアップロード機能 0:OFF , 1:ON
		);
		$crudBaseData = $this->indexBefore('Neko',$option);//indexアクションの共通先処理(CrudBaseController)
		
		//一覧データを取得
		$data = $this->Neko->findData($crudBaseData);
		
		// CrudBase共通処理（後）
		$crudBaseData = $this->indexAfter($crudBaseData,['method_url'=>'front_a']);//indexアクションの共通後処理
		
		// CBBXS-1020-2
		$nekoGroupList = $this->Neko->getNekoGroupList();
		$neko_group_json = json_encode($nekoGroupList,JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS);
		$this->set(array('nekoGroupList' => $nekoGroupList,'neko_group_json' => $neko_group_json));
		// CBBXE
		
		
// 		// ▼ サブ画像集約ライブラリ
// 		App::uses('SubImgAgg', 'Vendor/CrudBase');
// 		$subImgAgg = new SubImgAgg();
// 		$data = $subImgAgg->agg($data,array(
// 				'note_field' => 'note',			// ノートフィールド名
// 				'img_fn_field' => 'img_fn' ,	// 画像フィールド名
//			));	// ディレクトリパス・テンプレート
		
		
		$this->set($crudBaseData);
		$this->setCommon();//当画面系の共通セット
		$this->set(array(
				'header' => 'front_a_header',
				'title_for_layout'=>'ネコ',
				'data'=> $data,
		));
		
		
		
	}


	
	
	
	
	/**
	 * DB登録
	 *
	 * @note
	 * Ajaxによる登録。
	 * 編集登録と新規入力登録の両方に対応している。
	 */
	public function ajax_reg(){
		App::uses('Sanitize', 'Utility');
		$this->autoRender = false;//ビュー(ctp)を使わない。
		$errs = array(); // エラーリスト

		if($this->login_flg == 1 && empty($this->Auth->user())){
			return 'Error:login is needed.';// 認証中でなければエラー
		}
		
		// 未ログインかつローカルでないなら、エラーアラートを返す。
		if(empty($this->Auth->user()) && $_SERVER['SERVER_NAME']!='localhost'){
			return '一般公開モードでは編集登録はできません。';
		}
		
		// JSON文字列をパースしてエンティティを取得する
		$json=$_POST['key1'];
		$ent = json_decode($json,true);
		
		// 登録パラメータ
		$reg_param_json = $_POST['reg_param_json'];
		$regParam = json_decode($reg_param_json,true);
		$form_type = $regParam['form_type']; // フォーム種別 new_inp,edit,delete,eliminate

		// CBBXS-1024
		$ent['img_fn'] = $this->makeFilePath($_FILES, 'rsc/img/%field/y%Y/m%m/orig/%Y%m%d%H%i%s_%fn', $ent, 'img_fn');
		// CBBXE

		// 更新ユーザーなど共通フィールドをセットする。
		$ent = $this->setCommonToEntity($ent);
	
		// エンティティをDB保存
		$this->Neko->begin();
		$ent = $this->Neko->saveEntity($ent,$regParam);
		$this->Neko->commit();//コミット

		// CBBXS-1025
		// ファイルアップロードの一括作業
		App::uses('FileUploadK','Vendor/CrudBase/FileUploadK');
		$fileUploadK = new FileUploadK();
		$res = $fileUploadK->putFile1($_FILES, 'img_fn', $ent['img_fn']);
		// CBBXE
		
		if(!empty($res['err_msg'])) $errs[] = $res['err_msg'];
		
		if($errs) $ent['err'] = implode("','",$errs); // フォームに表示するエラー文字列をセット

		$json_data=json_encode($ent,true);//JSONに変換
	
		return $json_data;
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
		$this->Neko->begin();
		if($eliminate_flg == 0){
			$ent = $this->Neko->saveEntity($ent,$regParam); // 更新
		}else{
			$this->Neko->eliminateFiles($ent['id'], 'img_fn', $ent); // ファイル抹消（他のレコードが保持しているファイルは抹消対象外）
			$this->Neko->delete($ent['id']); // 削除
		}
		$this->Neko->commit();//コミット
		
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
		
		App::uses('Sanitize', 'Utility');
		
		if($this->login_flg == 1 && empty($this->Auth->user())){
			return 'Error:login is needed.';// 認証中でなければエラー
		}
		
		$json=$_POST['key1'];
		
		$data = json_decode($json,true);//JSON文字を配列に戻す
		
		// データ保存
		$this->Neko->begin();
		$this->Neko->saveAll($data); // まとめて保存。内部でSQLサニタイズされる。
		$this->Neko->commit();

		$res = array('success');
		
		$json_str = json_encode($res);//JSONに変換
		
		return $json_str;
	}
	
	/**
	 * 一括登録 | AJAX
	 * 
	 * @note
	 * 一括追加, 一括編集, 一括複製
	 */
	public function bulk_reg(){
		
		App::uses('DaoForCake', 'Model');
		App::uses('BulkReg', 'Vendor/CrudBase');
		
		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		
		// 更新ユーザーを取得
		$update_user = 'none';
		if(!empty($this->Auth->user())){
			$userData = $this->Auth->user();
			$update_user = $userData['username'];
		}

		$json_param=$_POST['key1'];
		$param = json_decode($json_param,true);//JSON文字を配列に戻す
		
		// 一括登録
		$dao = new DaoForCake();
		$bulkReg = new BulkReg($dao, $update_user);
		$res = $bulkReg->reg('nekos', $param);
		
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
		if(empty($this->Auth->user())) return 'Error:login is needed.';// 認証中でなければエラー
		
		$this->csv_fu_base($this->Neko,array('id','neko_val','neko_name','neko_date','neko_group','neko_dt','neko_flg','img_fn','note','sort_no'));
		
	}
	



	
	



	/**
	 * CSVダウンロード
	 *
	 * 一覧画面のCSVダウンロードボタンを押したとき、一覧データをCSVファイルとしてダウンロードします。
	 */
	public function csv_download(){
		$this->autoRender = false;//ビューを使わない。
	
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
		$fn='neko'.$strDate.'.csv';
	
	
		//CSVダウンロード
		App::uses('CsvDownloader','Vendor/CrudBase');
		$csv= new CsvDownloader();
		$csv->output($fn, $data);
		 
	
	
	}
	
	

	
	
	//ダウンロード用のデータを取得する。
	private function getDataForDownload(){
		 
		
		//セッションから検索条件情報を取得
		$kjs=$this->Session->read('neko_kjs');
		
		// セッションからページネーション情報を取得
		$pages = $this->Session->read('neko_pages');

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
		$data=$this->Neko->findData($crudBaseData);
		if(empty($data)){
			return array();
		}
	
		return $data;
	}
	

	/**
	 * 当画面系の共通セット
	 */
	private function setCommon(){

		
		// 新バージョンであるかチェックする。
		$new_version_flg = $this->checkNewPageVersion($this->this_page_version);
		
		$this->set(array(
				'header' => 'header',
				'new_version_flg' => $new_version_flg, // 当ページの新バージョンフラグ   0:バージョン変更なし  1:新バージョン
				'this_page_version' => $this->this_page_version,// 当ページのバージョン
		));
	}
	

	/**
	 * CrudBase用の初期化処理
	 *
	 * @note
	 * フィールド関連の定義をする。
	 *
	 *
	 */
	private function initCrudBase(){

		
		// CBBXS-3001 
		$xxx=0;
		
		// CBBXE
		
		
		/// 検索条件情報の定義
		$this->kensakuJoken=array(
				
				array('name'=>'kj_main','def'=>null),
				// CBBXS-1000 
				array('name'=>'kj_id','def'=>null),
				array('name'=>'kj_neko_val1','def'=>null),
				array('name'=>'kj_neko_val2','def'=>null),
				array('name'=>'kj_neko_name','def'=>null),
				array('name'=>'kj_neko_date_ym','def'=>null),
				array('name'=>'kj_neko_date1','def'=>null),
				array('name'=>'kj_neko_date2','def'=>null),
				array('name'=>'kj_neko_group','def'=>null),
				array('name'=>'kj_neko_dt','def'=>null),
				array('name'=>'kj_neko_flg','def'=>null),
				array('name'=>'kj_img_fn','def'=>null),
				array('name'=>'kj_note','def'=>null),
				array('name'=>'kj_sort_no','def'=>null),
				array('name'=>'kj_delete_flg','def'=>0),
				array('name'=>'kj_update_user','def'=>null),
				array('name'=>'kj_ip_addr','def'=>null),
				array('name'=>'kj_created','def'=>null),
				array('name'=>'kj_modified','def'=>null),
				// CBBXE
				
				array('name'=>'row_limit','def'=>50),
				
		);
		
		
		
		
		
		/// 検索条件のバリデーション
		$this->kjs_validate=array(
				
				// CBBXS-1001
				
				'kj_id' => array(
						'naturalNumber'=>array(
								'rule' => array('naturalNumber', true),
								'message' => 'IDは数値を入力してください',
								'allowEmpty' => true
						),
				),
					
				'kj_neko_val1' => array(
						'custom'=>array(
								'rule' => array( 'custom', '/^[-]?[0-9]+?$/' ),
								'message' => 'ネコ数値1は整数を入力してください。',
								'allowEmpty' => true
						),
				),
					
				'kj_neko_val2' => array(
						'custom'=>array(
								'rule' => array( 'custom', '/^[-]?[0-9]+?$/' ),
								'message' => 'ネコ数値2は整数を入力してください。',
								'allowEmpty' => true
						),
				),
					
		
				'kj_neko_name'=> array(
						'maxLength'=>array(
								'rule' => array('maxLength', 255),
								'message' => 'ネコ名前は255文字以内で入力してください',
								'allowEmpty' => true
						),
				),
		
				'kj_neko_date1'=> array(
						'rule' => array( 'date', 'ymd'),
						'message' => 'ネコ日【範囲1】は日付形式【yyyy-mm-dd】で入力してください。',
						'allowEmpty' => true
				),
		
				'kj_neko_date2'=> array(
						'rule' => array( 'date', 'ymd'),
						'message' => 'ネコ日【範囲2】は日付形式【yyyy-mm-dd】で入力してください。',
						'allowEmpty' => true
				),
					
				'kj_note'=> array(
						'maxLength'=>array(
								'rule' => array('maxLength', 255),
								'message' => '備考は255文字以内で入力してください',
								'allowEmpty' => true
						),
				),
			
				'kj_sort_no' => array(
					'custom'=>array(
						'rule' => array( 'custom', '/^[-]?[0-9]+?$/' ),
						'message' => '順番は整数を入力してください。',
						'allowEmpty' => true
					),
				),
					
				'kj_update_user'=> array(
						'maxLength'=>array(
								'rule' => array('maxLength', 50),
								'message' => '更新者は50文字以内で入力してください',
								'allowEmpty' => true
						),
				),
					
				'kj_ip_addr'=> array(
						'maxLength'=>array(
								'rule' => array('maxLength', 40),
								'message' => '更新IPアドレスは40文字以内で入力してください',
								'allowEmpty' => true
						),
				),
					
				'kj_created'=> array(
						'maxLength'=>array(
								'rule' => array('maxLength', 20),
								'message' => '生成日時は20文字以内で入力してください',
								'allowEmpty' => true
						),
				),
					
				'kj_modified'=> array(
						'maxLength'=>array(
								'rule' => array('maxLength', 20),
								'message' => '更新日時は20文字以内で入力してください',
								'allowEmpty' => true
						),
				),
				
				// CBBXE
		);
		
		
		
		
		
		///フィールドデータ
		$this->field_data = array('def'=>array(
		
			// CBBXS-1002
			'id'=>array(
					'name'=>'ID',//HTMLテーブルの列名
					'row_order'=>'Neko.id',//SQLでの並び替えコード
					'clm_show'=>1,//デフォルト列表示 0:非表示 1:表示
			),
			'neko_val'=>array(
					'name'=>'ネコ数値',
					'row_order'=>'Neko.neko_val',
					'clm_show'=>0,
			),
			'neko_name'=>array(
					'name'=>'ネコ名前',
					'row_order'=>'Neko.neko_name',
					'clm_show'=>1,
			),
			'neko_group'=>array(
				'name'=>'ネコ種別',
				'row_order'=>'Neko.neko_group',
				'clm_show'=>1,
			),
			'neko_date'=>array(
					'name'=>'ネコ日',
					'row_order'=>'Neko.neko_date',
					'clm_show'=>1,
			),
			'neko_dt'=>array(
					'name'=>'ネコ日時',
					'row_order'=>'Neko.neko_dt',
					'clm_show'=>1,
			),
			'neko_flg'=>array(
					'name'=>'ネコフラグ',
					'row_order'=>'Neko.neko_flg',
					'clm_show'=>1,
			),
			'img_fn'=>array(
					'name'=>'画像ファイル名',
					'row_order'=>'Neko.img_fn',
					'clm_show'=>1,
			),
			'note'=>array(
					'name'=>'備考',
					'row_order'=>'Neko.note',
					'clm_show'=>0,
			),
			'sort_no'=>array(
				'name'=>'順番',
				'row_order'=>'Neko.sort_no',
				'clm_show'=>0,
			),
			'delete_flg'=>array(
					'name'=>'削除フラグ',
					'row_order'=>'Neko.delete_flg',
					'clm_show'=>1,
			),
			'update_user'=>array(
					'name'=>'更新者',
					'row_order'=>'Neko.update_user',
					'clm_show'=>0,
			),
			'ip_addr'=>array(
					'name'=>'更新IPアドレス',
					'row_order'=>'Neko.ip_addr',
					'clm_show'=>0,
			),
			'created'=>array(
					'name'=>'生成日時',
					'row_order'=>'Neko.created',
					'clm_show'=>0,
			),
			'modified'=>array(
					'name'=>'更新日時',
					'row_order'=>'Neko.modified',
					'clm_show'=>1,
			),
			// CBBXE
		));

		// 列並び順をセットする
		$clm_sort_no = 0;
		foreach ($this->field_data['def'] as &$fEnt){
			$fEnt['clm_sort_no'] = $clm_sort_no;
			$clm_sort_no ++;
		}
		unset($fEnt);

		 
	}



}