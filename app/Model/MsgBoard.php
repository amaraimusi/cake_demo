<?php
App::uses('Model', 'Model');
App::uses('CrudBase', 'Model');

/**
 * メッセージボードのCakePHPモデルクラス
 *
 * @date 2015-9-16 | 2018-10-10
 * @version 3.1.2
 *
 */
class MsgBoard extends AppModel {

	public $name='MsgBoard';
	
	// 関連付けるテーブル CBBXS-1040
	public $useTable = 'msg_boards';

	// CBBXE

	/// バリデーションはコントローラクラスで定義
	public $validate = null;
	
	// ホワイトリスト（DB保存時にこのホワイトリストでフィルタリングが施される）
	public $fillable = [
		// CBBXS-2009
			'id',
			'other_id',
			'user_id',
			'message',
			'attach_fn',
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
	public function getData($crudBaseData){
		
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
		
		//条件を作成
		$conditions=$this->createKjConditions($kjs);
		
		$sort_type = '';
		if(!empty($sort_desc)) $sort_type = 'DESC';
		
		$sql =
		"
				SELECT SQL_CALC_FOUND_ROWS MsgBoard.*
				FROM msg_boards AS MsgBoard
				WHERE {$conditions}
				ORDER BY {$sort_field} {$sort_type}
				LIMIT {$page_no}, {$row_limit}
			";
		
		$data = $this->query($sql);
		
		//データ構造を変換（2次元配列化）
		$data2 = [];
		if(!empty($data)) $data2 = Hash::extract($data, '{n}.MsgBoard');
		
		// LIMIT制限なし・データ件数
		$non_limit_count = 0;
		$res = $this->query('SELECT FOUND_ROWS()');
		if(!empty($res)){
			$res = reset($res[0]);
			$non_limit_count= reset($res);
		}
		
		// ユーザー名を取得してデータにセットする。
		$data2 = $this->getNickName($data2);
		
		return ['data' => $data2, 'non_limit_count' => $non_limit_count];
		
	}
	
	/**
	 * 検索条件とページ情報を元にDBからデータを取得する
	 * @param array $crudBaseData
	 * @return []
	 *  - array data データ
	 *  - int non_limit_count LIMIT制限なし・データ件数
	 */
	public function getData_old($crudBaseData){
		
		$fields = $crudBaseData['fields']; // フィールド
		
		$kjs = $crudBaseData['kjs'];//検索条件情報
		$pages = $crudBaseData['pages'];//ページネーション情報
		
		$page_no = $pages['page_no']; // ページ番号
		$row_limit = $pages['row_limit']; // 表示件数
		$sort_field = $pages['sort_field']; // ソートフィールド
		$sort_desc = $pages['sort_desc']; // ソートタイプ 0:昇順 , 1:降順
		
		//条件を作成
		$conditions=$this->createKjConditions($kjs);
		
		// オフセットの組み立て
		$offset=null;
		if(!empty($row_limit)) $offset = $page_no * $row_limit;
		
		// ORDER文の組み立て
		$order = $sort_field;
		if(empty($order)) $order='sort_no';
		if(!empty($sort_desc)) $order .= ' DESC';
		
		$option=array(
			'conditions' => $conditions,
			'limit' =>$row_limit,
			'offset'=>$offset,
			'order' => $order,
		);
		
		//DBからデータを取得
		$data = $this->find('all',$option);
		
		//データ構造を変換（2次元配列化）
		$data2=array();
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
		
		// ユーザー名を取得してデータにセットする。
		$data2 = $this->getNickName($data2);
		
		return ['data' => $data2, 'non_limit_count' => $non_limit_count];
		
	}
	
	
	
	/**
	 *  ユーザー名を取得してデータにセットする。
	 * @param [] $data
	 * @return [] ユーザー名セット後の$data
	 */
	private function getNickName(&$data){
		
		// ユーザー名のデフォルトをセット
		foreach($data as &$ent){
			$ent['nickname'] = 'none';
		}
		unset($ent);
		
		$ids = Hash::extract($data, '{n}.user_id');
		$ids = array_unique($ids);
		
		$ids_str = "'".implode("','",$ids)."'";
		
		$sql = "SELECT id, nickname FROM users WHERE id IN ({$ids_str})";
		$users = $this->query($sql);
		
		if(empty($users)) return $data;
		
		$userHm = Hash::combine($users, '{n}.users.id','{n}.users');

		foreach($data as &$ent){
			$user_id = $ent['user_id'];
			if(!empty($userHm[$user_id])){
				$ent['nickname'] = $userHm[$user_id]['nickname'];
			}
			
		}
		unset($ent);

		return $data;
	}
	
	/**
	 * メッセージボードエンティティを取得
	 *
	 * メッセージボードテーブルからidに紐づくエンティティを取得します。
	 *
	 * @param int $id メッセージボードID
	 * @return array メッセージボードエンティティ
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
			$ent=$data['MsgBoard'];
		}
		



		return $ent;
	}


	
	
	/**
	 * 一覧データを取得する
	 * @return array メッセージボード画面一覧のデータ
	 */
	public function findData(&$crudBaseData){
		
		$kjs = $crudBaseData['kjs'];//検索条件情報
		$pages = $crudBaseData['pages'];//ページネーション情報


		$page_no = $pages['page_no']; // ページ番号
		$row_limit = $pages['row_limit']; // 表示件数
		$sort_field = $pages['sort_field']; // ソートフィールド
		$sort_desc = $pages['sort_desc']; // ソートタイプ 0:昇順 , 1:降順
		
		
		//条件を作成
		$conditions=$this->createKjConditions($kjs);
		
		// オフセットの組み立て
		$offset=null;
		if(!empty($row_limit)) $offset = $page_no * $row_limit;
		
		// ORDER文の組み立て
		$order = $sort_field;
		if(empty($order)) $order='sort_no';
		if(!empty($sort_desc)) $order .= ' DESC';
		
		$option=array(
				'conditions' => $conditions,
				'limit' =>$row_limit,
				'offset'=>$offset,
				'order' => $order,
		);
		
		//DBからデータを取得
		$data = $this->find('all',$option);
		
		//データ構造を変換（2次元配列化）
		$data2=array();
		foreach($data as $i=>$tbl){
			foreach($tbl as $ent){
				foreach($ent as $key => $v){
					$data2[$i][$key]=$v;
				}
			}
		}

		
		return $data2;
	}

	
	
	/**
	 * SQLのダンプ
	 * @param  $option
	 */
	private function dumpSql($option){
		$dbo = $this->getDataSource();
		
		$option['table']=$dbo->fullTableName($this->MsgBoard);
		$option['alias']='MsgBoard';
		
		$query = $dbo->buildStatement($option,$this->MsgBoard);
		
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
			$cnds[]="CONCAT( IFNULL(MsgBoard.msg_board_name, '') ,IFNULL(MsgBoard.note, '')) LIKE '%{$kjs['kj_main']}%'";
		}
		
		// CBBXS-1003
		if(!empty($kjs['kj_id']) || $kjs['kj_id'] ==='0' || $kjs['kj_id'] ===0){
			$cnds[]="MsgBoard.id = {$kjs['kj_id']}";
		}
		if(!empty($kjs['kj_other_id']) || $kjs['kj_other_id'] ==='0' || $kjs['kj_other_id'] ===0){
			$cnds[]="MsgBoard.other_id = {$kjs['kj_other_id']}";
		}
		if(!empty($kjs['kj_user_id']) || $kjs['kj_user_id'] ==='0' || $kjs['kj_user_id'] ===0){
			$cnds[]="MsgBoard.user_id = {$kjs['kj_user_id']}";
		}
		if(!empty($kjs['kj_message'])){
			$cnds[]="MsgBoard.message LIKE '%{$kjs['kj_message']}%'";
		}
		if(!empty($kjs['kj_attach_fn'])){
			$cnds[]="MsgBoard.attach_fn LIKE '%{$kjs['kj_attach_fn']}%'";
		}
		if(!empty($kjs['kj_sort_no']) || $kjs['kj_sort_no'] ==='0' || $kjs['kj_sort_no'] ===0){
			$cnds[]="MsgBoard.sort_no = {$kjs['kj_sort_no']}";
		}
		$kj_delete_flg = $kjs['kj_delete_flg'];
		if(!empty($kjs['kj_delete_flg']) || $kjs['kj_delete_flg'] ==='0' || $kjs['kj_delete_flg'] ===0){
			if($kjs['kj_delete_flg'] != -1){
			   $cnds[]="MsgBoard.delete_flg = {$kjs['kj_delete_flg']}";
			}
		}
		if(!empty($kjs['kj_update_user'])){
			$cnds[]="MsgBoard.update_user LIKE '%{$kjs['kj_update_user']}%'";
		}
		if(!empty($kjs['kj_ip_addr'])){
			$cnds[]="MsgBoard.ip_addr LIKE '%{$kjs['kj_ip_addr']}%'";
		}
		if(!empty($kjs['kj_created'])){
			$kj_created=$kjs['kj_created'].' 00:00:00';
			$cnds[]="MsgBoard.created >= '{$kj_created}'";
		}
		if(!empty($kjs['kj_modified'])){
			$kj_modified=$kjs['kj_modified'].' 00:00:00';
			$cnds[]="MsgBoard.modified >= '{$kj_modified}'";
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
	 * メッセージボードエンティティをメッセージボードテーブルに保存します。
	 *
	 * @param array $ent メッセージボードエンティティ
	 * @param array $option オプション
	 *  - form_type フォーム種別  new_inp:新規入力 , copy:複製 , edit:編集
	 *  - ni_tr_place 新規入力追加場所フラグ 0:末尾 , 1:先頭
	 * @return array メッセージボードエンティティ（saveメソッドのレスポンス）
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
						'conditions' => "id={$ent['MsgBoard']['id']}"
				));

		$ent=$ent['MsgBoard'];
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
	 * 当画面のユーザータイプによる変更ボタン、削除ボタンの表示、非表示情報をセットする
	 * @param string $this_user_type 当画面のユーザータイプ
	 * @param [] $data メッセージボード・データ
	 * @param [] $userInfo ユーザー情報
	 * @return [] メッセージボード・データ
	 */
	public function setBtnDisplayByThisUserType($this_user_type, &$data, &$userInfo){
		
		$self_user_id = $userInfo['id'] ?? -1; // 自分のユーザーID

		foreach($data as &$ent){
			
			if($this_user_type == 'master'){
				// 自分のメッセージである場合
				if($ent['user_id'] == $self_user_id){
					$ent['edit_btn'] = '';
					$ent['delete_btn'] = '';
					$ent['menu_btn'] = '';
				}
				
				// 他のユーザーのメッセージである場合
				else{
					$ent['edit_btn'] = 'display:none;';
					$ent['delete_btn'] = '';
					$ent['menu_btn'] = '';
				}
			}else if($this_user_type == 'login_user'){
				// 自分のメッセージである場合
				if($ent['user_id'] == $self_user_id){
					$ent['edit_btn'] = '';
					$ent['delete_btn'] = '';
					$ent['menu_btn'] = '';
				}
				
				// 他のユーザーのメッセージである場合
				else{
					$ent['edit_btn'] = 'display:none;';
					$ent['delete_btn'] = 'display:none;';
					$ent['menu_btn'] = 'display:none;';
				}
			}
			
			//　ゲストユーザーである場合、編集ボタンも変更ボタンを非表示
			else if($this_user_type == 'guest'){
				$ent['edit_btn'] = 'display:none;';
				$ent['delete_btn'] = 'display:none;';
				$ent['menu_btn'] = 'display:none;';
			}else{
				throw new Exception('システムエラー 210511D');
			}
			
		}
		unset($ent);
		
		return $data;
	}

	

}