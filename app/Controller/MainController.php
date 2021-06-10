<?php
App::uses('AppController', 'Controller');
/**
 * トップページ
 * 
 * @note 未ログインユーザーも閲覧可能なトップ画面
 * 
 * @since 2021-6-11
 *
 */
class MainController extends AppController {

	/// 名称コード
	public $name = 'Main';
	

	public function beforeFilter() {

		if($this->login_flg == 0 && empty($this->Auth->user())){
			$this->Auth->allow(); // 未認証モードとしてページ表示を許可する。
		}
	
		parent::beforeFilter();
	
	}

	/**
	 * indexページのアクション
	 */
	public function index() {
		
		$this->set([
			'header'=> 'header_plain',
			'title_for_layout'=>'CrudBase見本(Cake PHP2版）',
		]);


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
			['name'=>'kj_seminar_name', 'def'=>null],
			['name'=>'kj_seminar_category_id', 'def'=>null],
			['name'=>'kj_status1', 'def'=>null, 'field'=>'status'],
			['name'=>'kj_status2', 'def'=>null, 'field'=>'status'],
			['name'=>'kj_start_date_ym', 'def'=>null],
			['name'=>'kj_start_date1', 'def'=>null, 'field'=>'start_date'],
			['name'=>'kj_start_date2', 'def'=>null, 'field'=>'start_date'],
			['name'=>'kj_start_time', 'def'=>null],
			['name'=>'kj_seminar_content', 'def'=>null],
			['name'=>'kj_seminar_json', 'def'=>null],
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
				'row_order'=>'Seminar.id',//SQLでの並び替えコード
				'clm_show'=>1,//デフォルト列表示 0:非表示 1:表示
			],
			'seminar_name'=>[
				'name'=>'セミナー名',
				'row_order'=>'Seminar.seminar_name',
				'clm_show'=>1,
			],
			'seminar_category_id'=>[
				'name'=>'セミナーカテゴリID',
				'row_order'=>'Seminar.seminar_category_id',
				'clm_show'=>1,
			],
			'status'=>[
				'name'=>'状態',
				'row_order'=>'Seminar.status',
				'clm_show'=>1,
			],
			'start_date'=>[
				'name'=>'開催日',
				'row_order'=>'Seminar.start_date',
				'clm_show'=>1,
			],
			'start_time'=>[
				'name'=>'開催時間',
				'row_order'=>'Seminar.start_time',
				'clm_show'=>1,
			],
			'seminar_content'=>[
				'name'=>'セミナー内容',
				'row_order'=>'Seminar.seminar_content',
				'clm_show'=>1,
			],
			'seminar_json'=>[
				'name'=>'メタ情報',
				'row_order'=>'Seminar.seminar_json',
				'clm_show'=>1,
			],
			'sort_no'=>[
				'name'=>'順番',
				'row_order'=>'Seminar.sort_no',
				'clm_show'=>0,
			],
			'delete_flg'=>[
				'name'=>'無効フラグ',
				'row_order'=>'Seminar.delete_flg',
				'clm_show'=>0,
			],
			'update_user'=>[
				'name'=>'更新者',
				'row_order'=>'Seminar.update_user',
				'clm_show'=>0,
			],
			'ip_addr'=>[
				'name'=>'IPアドレス',
				'row_order'=>'Seminar.ip_addr',
				'clm_show'=>0,
			],
			'created'=>[
				'name'=>'生成日時',
				'row_order'=>'Seminar.created',
				'clm_show'=>0,
			],
			'modified'=>[
				'name'=>'更新日',
				'row_order'=>'Seminar.modified',
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
		
		
		$model = $this->Seminar; // モデルクラス
		
		$crudBaseData = [
			'fw_type' => 'cake',
			'model_name_c' => 'Seminar',
			'tbl_name' => 'seminars', // テーブル名をセット
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
	
	/**
	 * ■■■□□□■■■□□□
	 */
	public function demo() {
		$this->set([
			'title_for_layout'=>'セミナー詳細',
		]);
	}
	



}