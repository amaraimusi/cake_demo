<?php
App::uses('Model', 'Model');
App::uses('CrudBase', 'Model');

/**
 * タヌキのCakePHPモデルクラス
 *
 * @date 2015-9-16 | 2018-10-10
 * @version 3.1.2
 *
 */
class Tanuki extends AppModel {

	public $name='Tanuki';
	
	// 関連付けるテーブル CBBXS-1040
	public $useTable = 'nekos';

	// CBBXE

	/// バリデーションはコントローラクラスで定義
	public $validate = null;
	
	// ホワイトリスト（DB保存時にこのホワイトリストでフィルタリングが施される）
	public $fillable = [
		// CBBXS-2009
			'id',
			'neko_val',
			'neko_name',
			'neko_date',
			'neko_group',
			'en_sp_id',
			'neko_dt',
			'neko_flg',
			'img_fn',
			'note',
			'sort_no',
			'delete_flg',
			'update_user',
			'ip_addr',
			'created',
			'modified',

		// CBBXE
	];
	
	// CBBXS-2012
	const CREATED_AT = 'created';
	const UPDATED_AT = 'modified';

	// CBBXE
	
	private $cb; // CrudBase制御クラス
	
	
	public function __construct() {
		parent::__construct();
		
		// CrudBaseロジッククラスの生成
		if(empty($this->CrudBase)) $this->CrudBase = new CrudBase();
	}
	
	
	/**
	 * 初期化
	 * @param CrudBaseController $cb
	 */
	public function init($cb){
		$this->cb = $cb;
		
		// ホワイトリストをセット
		$cbParam = $this->cb->getCrudBaseData();
		$fields = $cbParam['fields'];
		$this->fillable = $fields;
	}
	
	/**
	 * 検索条件とページ情報を元にDBからデータを取得する
	 * @param array $crudBaseData
	 * @return []
	 *  - array data データ
	 *  - int non_limit_count LIMIT制限なし・データ件数
	 */
	public function getData(&$crudBaseData){
		
		$fields = $crudBaseData['fields']; // フィールド
		
		$kjs = $crudBaseData['kjs'];//検索条件情報
		$pages = $crudBaseData['pages'];//ページネーション情報
		
		// ▽ SQLインジェクション対策
		$kjs = $this->sqlSanitizeW($kjs);
		$pages = $this->sqlSanitizeW($pages);
		
		$page_no = $pages['page_no']; // ページ番号
		$row_limit = $pages['row_limit']; // 表示件数
		$sort_field = $pages['sort_field']; // ソートフィールド
		$sort_desc = $pages['sort_desc']; // ソートタイプ 0:昇順 , 1:降順
		$offset = $page_no * $row_limit;
		
		// 外部SELECT文字列を作成する。
		$outer_selects_str = $this->makeOuterSelectStr($crudBaseData);
		
		// 外部結合文字列を作成する。
		$outer_join_str = $this->makeOuterJoinStr($crudBaseData);
		
		//条件を作成
		$conditions=$this->createKjConditions($kjs);
		
		$sort_type = '';
		if(!empty($sort_desc)) $sort_type = 'DESC';
		$main_tbl_name = $this->useTable;
		
		$sql =
		"
				SELECT SQL_CALC_FOUND_ROWS Tanuki.* {$outer_selects_str}
				FROM {$main_tbl_name} AS Tanuki
				{$outer_join_str}
				WHERE {$conditions}
				ORDER BY {$sort_field} {$sort_type}
				LIMIT {$offset}, {$row_limit}
			";
		
		$data = $this->query($sql);
		
		
		//データ構造を変換（2次元配列化）
		$data2 = [];
		foreach($data as $i=>$tbl){
			foreach($tbl as $ent){
				foreach($ent as $key => $v){
					$data2[$i][$key]=$v;
				}
			}
		}

		// LIMIT制限なし・データ件数
		$non_limit_count = 0;
		$res = $this->query('SELECT FOUND_ROWS()');
		if(!empty($res)){
			$res = reset($res[0]);
			$non_limit_count= reset($res);
		}
		
		
		return ['data' => $data2, 'non_limit_count' => $non_limit_count];
		
	}
	
	
	// 外部結合文字列を作成する。
	private function makeOuterJoinStr(&$crudBaseData){
		$fieldData = $crudBaseData['fieldData'];
		$model_name_c = $crudBaseData['model_name_c'];
		$str = '';
		
		foreach($fieldData as $fEnt){
			if(empty($fEnt['outer_tbl_name'])) continue;
			$field = $fEnt['id'];
			$str .= "LEFT JOIN {$fEnt['outer_tbl_name']} AS {$fEnt['outer_tbl_name_c']} ON {$model_name_c}.{$field} = {$fEnt['outer_tbl_name_c']}.id";
			
		}
		
		return $str;
	}
	
	
	// 外部SELECT文字列を作成する。
	private function makeOuterSelectStr(&$crudBaseData){
		$fieldData = $crudBaseData['fieldData'];

		$str = '';
		
		foreach($fieldData as $fEnt){
			
			if(empty($fEnt['outer_tbl_name'])) continue;
			$str .= " ,{$fEnt['outer_tbl_name_c']}.{$fEnt['outer_field']} AS {$fEnt['outer_alias']} ";
			
		}
		
		
		return $str;
	}
	
	

	/**
	 * タヌキエンティティを取得
	 *
	 * タヌキテーブルからidに紐づくエンティティを取得します。
	 *
	 * @param int $id タヌキID
	 * @return array タヌキエンティティ
	 */
	public function findEntity($id){

		$conditions='id = '.$id;

		//DBからデータを取得
		$data = $this->find(
				'first',
				Array(
						'conditions' => $conditions,
				)
		);

		$ent=array();
		if(!empty($data)){
			$ent=$data['Tanuki'];
		}
		



		return $ent;
	}

	
	
	/**
	 * SQLのダンプ
	 * @param  $option
	 */
	private function dumpSql($option){
		$dbo = $this->getDataSource();
		
		$option['table']=$dbo->fullTableName($this->Tanuki);
		$option['alias']='Tanuki';
		
		$query = $dbo->buildStatement($option,$this->Tanuki);
		
		Debugger::dump($query);
	}



	/**
	 * 検索条件情報からWHERE情報を作成。
	 * @param array $kjs	検索条件情報
	 * @return string WHERE情報
	 */
	private function createKjConditions($kjs){

		$cnds=null;
		
		$this->CrudBase->sql_sanitize($kjs); // SQLサニタイズ
		
		if(!empty($kjs['kj_main'])){
			$cnds[]="CONCAT( IFNULL(Tanuki.tanuki_name, '') ,IFNULL(Tanuki.note, '')) LIKE '%{$kjs['kj_main']}%'";
		}
		
		// CBBXS-1003
		if(!empty($kjs['kj_id']) || $kjs['kj_id'] ==='0' || $kjs['kj_id'] ===0){
			$cnds[]="Tanuki.id = {$kjs['kj_id']}";
		}
		if(!empty($kjs['kj_neko_val1'])){
			$cnds[]="Tanuki.neko_val >= {$kjs['kj_neko_val1']}";
		}
		if(!empty($kjs['kj_neko_val2'])){
			$cnds[]="Tanuki.neko_val <= {$kjs['kj_neko_val2']}";
		}
		if(!empty($kjs['kj_neko_name'])){
			$cnds[]="Tanuki.neko_name LIKE '%{$kjs['kj_neko_name']}%'";
		}
		if(!empty($kjs['kj_neko_date1'])){
			$cnds[]="Tanuki.neko_date >= '{$kjs['kj_neko_date1']}'";
		}
		if(!empty($kjs['kj_neko_date2'])){
			$cnds[]="Tanuki.neko_date <= '{$kjs['kj_neko_date2']}'";
		}
		if(!empty($kjs['kj_neko_group']) || $kjs['kj_neko_group'] ==='0' || $kjs['kj_neko_group'] ===0){
			$cnds[]="Tanuki.neko_group = {$kjs['kj_neko_group']}";
		}
		if(!empty($kjs['kj_en_sp_id']) || $kjs['kj_en_sp_id'] ==='0' || $kjs['kj_en_sp_id'] ===0){
			$cnds[]="Tanuki.en_sp_id = {$kjs['kj_en_sp_id']}";
		}
		if(!empty($kjs['kj_neko_dt'])){
			$kj_neko_dt = $kjs['kj_neko_dt'];
			$dtInfo = $this->CrudBase->guessDatetimeInfo($kj_neko_dt);
			$cnds[]="DATE_FORMAT(Tanuki.neko_dt,'{$dtInfo['format_mysql_a']}') = DATE_FORMAT('{$dtInfo['datetime_b']}','{$dtInfo['format_mysql_a']}')";
		}
		$kj_neko_flg = $kjs['kj_neko_flg'];
		if(!empty($kjs['kj_neko_flg']) || $kjs['kj_neko_flg'] ==='0' || $kjs['kj_neko_flg'] ===0){
			if($kjs['kj_neko_flg'] != -1){
				$cnds[]="Tanuki.neko_flg = {$kjs['kj_neko_flg']}";
			}
		}
		if(!empty($kjs['kj_img_fn'])){
			$cnds[]="Tanuki.img_fn LIKE '%{$kjs['kj_img_fn']}%'";
		}
		if(!empty($kjs['kj_note'])){
			$cnds[]="Tanuki.note LIKE '%{$kjs['kj_note']}%'";
		}
		if(!empty($kjs['kj_sort_no']) || $kjs['kj_sort_no'] ==='0' || $kjs['kj_sort_no'] ===0){
			$cnds[]="Tanuki.sort_no = {$kjs['kj_sort_no']}";
		}
		$kj_delete_flg = $kjs['kj_delete_flg'];
		if(!empty($kjs['kj_delete_flg']) || $kjs['kj_delete_flg'] ==='0' || $kjs['kj_delete_flg'] ===0){
			if($kjs['kj_delete_flg'] != -1){
			   $cnds[]="Tanuki.delete_flg = {$kjs['kj_delete_flg']}";
			}
		}
		if(!empty($kjs['kj_update_user'])){
			$cnds[]="Tanuki.update_user LIKE '%{$kjs['kj_update_user']}%'";
		}
		if(!empty($kjs['kj_ip_addr'])){
			$cnds[]="Tanuki.ip_addr LIKE '%{$kjs['kj_ip_addr']}%'";
		}
		if(!empty($kjs['kj_created'])){
			$kj_created=$kjs['kj_created'].' 00:00:00';
			$cnds[]="Tanuki.created >= '{$kj_created}'";
		}
		if(!empty($kjs['kj_modified'])){
			$kj_modified=$kjs['kj_modified'].' 00:00:00';
			$cnds[]="Tanuki.modified >= '{$kj_modified}'";
		}

		// CBBXE
		
		$cnd=null;
		if(!empty($cnds)){
			$cnd=implode(' AND ',$cnds);
		}

		return $cnd;

	}

	/**
	 * エンティティをDB保存
	 *
	 * タヌキエンティティをタヌキテーブルに保存します。
	 *
	 * @param array $ent タヌキエンティティ
	 * @param array $option オプション
	 *  - form_type フォーム種別  new_inp:新規入力 , copy:複製 , edit:編集
	 *  - ni_tr_place 新規入力追加場所フラグ 0:末尾 , 1:先頭
	 * @return array タヌキエンティティ（saveメソッドのレスポンス）
	 */
	public function saveEntity($ent,$option=array()){

		// 新規入力であるなら新しい順番をエンティティにセットする。
		if($option['form_type']=='new_inp' ){
			if(empty($option['ni_tr_place'])){
				$ent['sort_no'] = $this->CrudBase->getLastSortNo($this); // 末尾順番を取得する
			}else{
				$ent['sort_no'] = $this->CrudBase->getFirstSortNo($this); // 先頭順番を取得する
			}
		}
		

		//DBに登録('atomic' => false　トランザクションなし。saveでSQLサニタイズされる）
		$ent = $this->save($ent, array('atomic' => false,'validate'=>false));

		//DBからエンティティを取得
		$ent = $this->find('first',
				array(
						'conditions' => "id={$ent['Tanuki']['id']}"
				));

		$ent=$ent['Tanuki'];
		if(empty($ent['delete_flg'])) $ent['delete_flg'] = 0;

		return $ent;
	}

	


	/**
	 * 全データ件数を取得
	 *
	 * limitによる制限をとりはらった、検索条件に紐づく件数を取得します。
	 *  全データ件数はページネーション生成のために使われています。
	 *
	 * @param array $kjs 検索条件情報
	 * @return int 全データ件数
	 */
	public function findDataCnt($kjs){

		//DBから取得するフィールド
		$fields=array('COUNT(id) AS cnt');
		$conditions=$this->createKjConditions($kjs);

		//DBからデータを取得
		$data = $this->find(
				'first',
				Array(
						'fields'=>$fields,
						'conditions' => $conditions,
				)
		);

		$cnt=$data[0]['cnt'];
		return $cnt;
	}
	
	/**
	 * アップロードファイルの抹消処理
	 * 
	 * @note
	 * 他のレコードが保持しているファイルは抹消対象外
	 * 
	 * @param int $id
	 * @param string $fn_field_strs ファイルフィールド群文字列（複数ある場合はコンマで連結）
	 * @param array $ent エンティティ
	 */
	public function eliminateFiles($id, $fn_field_strs, &$ent){
		$this->CrudBase->eliminateFiles($this, $id, $fn_field_strs, $ent);
	}
	
	
	// CBBXS-1021
	/**
	 * 猫種別リストをDBから取得する
	 */
	public function getNekoGroupList(){
		if(empty($this->NekoGroup)){
			App::uses('NekoGroup','Model');
			$this->NekoGroup=ClassRegistry::init('NekoGroup');
		}
		$fields=array('id','neko_group_name');//SELECT情報
		$conditions=array("delete_flg = 0");//WHERE情報
		$order=array('sort_no');//ORDER情報
		$option=array(
				'fields'=>$fields,
				'conditions'=>$conditions,
				'order'=>$order,
		);

		$data=$this->NekoGroup->find('all',$option); // DBから取得
		
		// 構造変換
		if(!empty($data)){
			$data = Hash::combine($data, '{n}.NekoGroup.id','{n}.NekoGroup.neko_group_name');
		}
		
		return $data;
	}

	// CBBXE


}