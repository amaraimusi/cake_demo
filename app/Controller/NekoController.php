<?php
App::uses('CrudBaseController', 'Controller');
App::uses('PagenationForCake', 'Vendor/Wacg');

/**
 * ネコ
 * 
 * ネコ画面ではネコ一覧を検索閲覧、および編集ができます。
 * 
 * 
 * @date 2015-9-16	新規作成
 * @author k-uehara
 *
 */
class NekoController extends CrudBaseController {

	/// 名称コード
	public $name = 'Neko';
	
	/// 使用しているモデル
	public $uses = array('Neko','CrudBase');
	
	/// オリジナルヘルパーの登録
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
	
	// 当画面バージョン (バージョンを変更すると画面に新バージョン通知とクリアボタンが表示されます。）
	public $this_page_version = '1.9.1'; 



	public function beforeFilter() {
	
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
		
		//一覧データを取得
		$data = $this->Neko->findData2($crudBaseData);

		// CrudBase共通処理（後）
		$crudBaseData = $this->indexAfter($crudBaseData);//indexアクションの共通後処理
		
		$nekoGroupList = array(1=>'ペルシャ',2=>'ボンベイ',3=>'三毛',4=>'シャム',5=>'雉トラ',6=>'スフィンクス');
		$neko_group_json = json_encode($nekoGroupList,JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS);
		
		$this->set($crudBaseData);
		$this->set(array(
			'title_for_layout'=>'ネコ',
			'data'=> $data,
			'nekoGroupList' => $nekoGroupList,
			'neko_group_json' => $neko_group_json,
		));
		
		//当画面系の共通セット
		$this->setCommon();


	}

	/**
	 * 詳細画面
	 * 
	 * ネコ情報の詳細を表示します。
	 * この画面から入力画面に遷移できます。
	 * 
	 */
	public function detail() {
		
		$res=$this->edit_before('Neko');
		$ent=$res['ent'];
	

		$this->set(array(
				'title_for_layout'=>'ネコ・詳細',
				'ent'=>$ent,
		));
		
		//当画面系の共通セット
		$this->setCommon();
	
	}













	/**
	 * 入力画面
	 * 
	 * 入力フォームにて値の入力が可能です。バリデーション機能を実装しています。
	 * 
	 * URLクエリにidが付属する場合は編集モードになります。
	 * idがない場合は新規入力モードになります。
	 * 
	 */
	public function edit() {

		$res=$this->edit_before('Neko');
		$ent=$res['ent'];

		$this->set(array(
				'title_for_layout'=>'ネコ・編集',
				'ent'=>$ent,
		));
		
		//当画面系の共通セット
		$this->setCommon();

	}
	
	 /**
	 * 登録完了画面
	 * 
	 * 入力画面の更新ボタンを押し、DB更新に成功した場合、この画面に遷移します。
	 * 入力エラーがある場合は、入力画面へ、エラーメッセージと共にリダイレクトで戻ります。
	 */
	public function reg(){
		$res=$this->reg_before('Neko');
		$ent=$res['ent'];
		
		$regMsg="<p id='reg_msg'>更新しました。</p>";

		//オリジナルバリデーション■■■□□□■■■□□□■■■□□□
		//$xFlg=$this->validNeko();
		$xFlg=true;
		if($xFlg==false){
			//エラーメッセージと一緒に編集画面へ、リダイレクトで戻る。
			$this->errBackToEdit("オリジナルバリデーションのエラー");
		}
		
		//★DB保存
		$this->Neko->begin();//トランザクション開始
		$ent=$this->Neko->saveEntity($ent);//登録
		$this->Neko->commit();//コミット

		$this->set(array(
				'title_for_layout'=>'ネコ・登録完了',
				'ent'=>$ent,
				'regMsg'=>$regMsg,
		));
		
		//当画面系の共通セット
		$this->setCommon();

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
	
		// JSON文字列をパースしてエンティティを取得する
		$json=$_POST['key1'];
		$ent = json_decode($json,true);
	
	
		// アップロードファイルが存在すればエンティティにセットする。
		$upload_file = null;
		if(!empty($_FILES["upload_file"])){
			$upload_file = $_FILES["upload_file"]["name"];
			$ent['neko_fn'] = $upload_file;
		}
	
	
		// 更新ユーザーなど共通フィールドをセットする。
		$ent = $this->setCommonToEntity($ent);
	
		// エンティティをDB保存
		$this->Neko->begin();
		$ent = $this->Neko->saveEntity($ent);
		$this->Neko->commit();//コミット

		if(!empty($upload_file)){
			
			// ファイルパスを組み立て
			$upload_file = $_FILES["upload_file"]["name"];
			$ffn = "game_rs/app{$id}/app_icon/{$fn}";
			
			// 一時ファイルを所定の場所へコピー（フォルダなければ自動作成）
			$this->copyEx($_FILES["upload_file"]["tmp_name"], $ffn);
	
	
		}

		$json_data=json_encode($ent,true);//JSONに変換
	
		return $json_data;
	}
	
	
	
	
	
	
	
	/**
	 * 削除登録
	 *
	 * @note
	 * Ajaxによる削除登録。
	 * 物理削除でなく削除フラグをONにする方式。
	 */
	public function ajax_delete(){
		App::uses('Sanitize', 'Utility');
	
		$this->autoRender = false;//ビュー(ctp)を使わない。
	
		// JSON文字列をパースしてエンティティを取得する
		$json=$_POST['key1'];
		$ent = json_decode($json,true);

		// 削除用のエンティティを取得する
		$ent = $this->getEntForDelete($ent['id']);
	
		// エンティティをDB保存
		$this->Neko->begin();
		$ent = $this->Neko->saveEntity($ent);
		$this->Neko->commit();//コミット
	
	
		$ent=Sanitize::clean($ent, array('encode' => true));//サニタイズ（XSS対策）
	
		$json_data=json_encode($ent);//JSONに変換
	
		return $json_data;
	}
	
	
	/**
	* Ajax | 自動保存
	* 
	* @note
	* バリデーション機能は備えていない
	* 
	*/
	public function auto_save(){
		
		App::uses('Sanitize', 'Utility');
		
		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		$json=$_POST['key1'];
		
		$data = json_decode($json,true);//JSON文字を配列に戻す
		
		$data = Sanitize::clean($data, array('encode' => false));
		
		// データ保存
		$this->Neko->begin();
		$this->Neko->saveAll($data);
		$this->Neko->commit();

		$res = array('success');
		
		$json_str = json_encode($res);//JSONに変換
		
		return $json_str;
	}
	

	
	
	/**
	 * CSVインポート | AJAX
	 *
	 * @note
	 *
	 */
	public function csv_fu(){
		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		$this->csv_fu_base($this->Neko,array('id','neko_val','neko_name','neko_date','neko_group','neko_dt','note','sort_no'));
		
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
		
		
		// ユーザーエージェントなど特定の項目をダブルクォートで囲む
		foreach($data as $i=>$ent){
			if(!empty($ent['user_agent'])){
				$data[$i]['user_agent']='"'.$ent['user_agent'].'"';
			}
		}

		
		
		//列名配列を取得
		$clms=array_keys($data[0]);
	
		//データの先頭行に列名配列を挿入
		array_unshift($data,$clms);
	
	
		//CSVファイル名を作成
		$date = new DateTime();
		$strDate=$date->format("Y-m-d");
		$fn='neko'.$strDate.'.csv';
	
	
		//CSVダウンロード
		App::uses('CsvDownloader','Vendor/Wacg');
		$csv= new CsvDownloader();
		$csv->output($fn, $data);
		 
	
	
	}
	
	

	
	
	//ダウンロード用のデータを取得する。
	private function getDataForDownload(){
		 
		
		//セッションから読取
		$kjs=$this->Session->read('neko_kjs');
		
		
		//DBからデータ取得
		$data=$this->Neko->findData($kjs,null,null,null);
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
				'header' => 'header_demo',
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

		
		
		
		
		/// 検索条件情報の定義
		$this->kensakuJoken=array(
		
				array('name'=>'kj_id','def'=>null),
				array('name'=>'kj_neko_val1','def'=>null),
				array('name'=>'kj_neko_val2','def'=>null),
				array('name'=>'kj_neko_name','def'=>null),
				array('name'=>'kj_neko_date_ym','def'=>null),
				array('name'=>'kj_neko_date1','def'=>null),
				array('name'=>'kj_neko_date2','def'=>null),
				array('name'=>'kj_neko_group','def'=>null),
				array('name'=>'kj_neko_dt','def'=>null),
				array('name'=>'kj_note','def'=>null),
				array('name'=>'kj_sort_no','def'=>null),
				array('name'=>'kj_delete_flg','def'=>0),
				array('name'=>'kj_update_user','def'=>null),
				array('name'=>'kj_ip_addr','def'=>null),
				array('name'=>'kj_created','def'=>null),
				array('name'=>'kj_modified','def'=>null),
				array('name'=>'row_limit','def'=>50),
					
		);
		
		
		
		
		
		/// 検索条件のバリデーション
		$this->kjs_validate=array(
		
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
		);
		
		
		
		
		
		///フィールドデータ
		$this->field_data = array('def'=>array(
		
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
		));

		// 列並び順をセットする
		$clm_sort_no = 0;
		foreach ($this->field_data['def'] as &$fEnt){
			$fEnt['clm_sort_no'] = $clm_sort_no;
			$clm_sort_no ++;
		}
		unset($fEnt);


		
//■■■□□□■■■□□□■■■□□□■■■		
// 		/// 編集エンティティ定義
// 		$this->entity_info=array(
		
// 				array('name'=>'id','def'=>null),
// 				array('name'=>'neko_val','def'=>null),
// 				array('name'=>'neko_name','def'=>null),
// 				array('name'=>'neko_date','def'=>null),
// 				array('name'=>'neko_group','def'=>null),
// 				array('name'=>'neko_dt','def'=>null),
// 				array('name'=>'note','def'=>null),
// 				array('name'=>'delete_flg','def'=>0),
		
		
// 		);
		
		
		
		
		//■■■□□□■■■□□□■■■□□□■■■
// 		/// 編集用バリデーション
// 		$this->edit_validate=array(

// 				'neko_val' => array(
// 						'custom'=>array(
// 								'rule' => array( 'custom', '/^[-]?[0-9]+?$/' ),
// 								'message' => 'ネコ数値は整数を入力してください。',
// 								'allowEmpty' => true
// 						),
// 				),
					
// 				'neko_name'=> array(
// 						'maxLength'=>array(
// 								'rule' => array('maxLength', 255),
// 								'message' => 'ネコ名前は255文字以内で入力してください',
// 								'allowEmpty' => true
// 						),
// 				),
					
// 				'neko_date'=> array(
// 						'rule' => array( 'date', 'ymd'),
// 						'message' => 'ネコ日は日付形式【yyyy-mm-dd】で入力してください。',
// 						'allowEmpty' => true
// 				),
					
// 				'neko_dt'=> array(
// 						'rule' => array( 'datetime', 'ymd'),
// 						'message' => 'ネコ日時は日時形式【yyyy-mm-dd h:i:s】で入力してください。',
// 						'allowEmpty' => true
// 				),
					
// 				'note'=> array(
// 						'maxLength'=>array(
// 								'rule' => array('maxLength', 255),
// 								'message' => '備考は255文字以内で入力してください',
// 								'allowEmpty' => true
// 						),
// 				),

// 		);
		
		
		
		
		 
	}
	
	
	
	
	
	
	
	
	


}