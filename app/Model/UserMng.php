<?php
App::uses('Model', 'Model');
App::uses('CrudBase', 'Model');

/**
 * ユーザー管理のCakePHPモデルクラス
 *
 * @since 2021-5-1
 * @version 1.0.0
 *
 */
class UserMng extends AppModel {

	public $name='UserMng';
	
	// 関連付けるテーブル CBBXS-1040
	public $useTable = 'users';

	// CBBXE

	/// バリデーションはコントローラクラスで定義
	public $validate = null;
	
	// ホワイトリスト（DB保存時にこのホワイトリストでフィルタリングが施される）
	public $fillable = [
		// CBBXS-2009
		'id',
		'username',
		'email',
		'nickname',
		'password',
		'role',
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
		$userInfo = $crudBaseData['userInfo'];
		$role = $userInfo['role'];

		// ▽ SQLインジェクション対策
		$kjs = $this->sqlSanitizeW($kjs);
		$pages = $this->sqlSanitizeW($pages);
		
		$page_no = $pages['page_no']; // ページ番号
		$row_limit = $pages['row_limit']; // 表示件数
		$sort_field = $pages['sort_field']; // ソートフィールド
		$sort_desc = $pages['sort_desc']; // ソートタイプ 0:昇順 , 1:降順
		$offset = $page_no * $row_limit;
		
		//条件を作成
		$conditions=$this->createKjConditions($kjs, $role);
		
		$sort_type = '';
		if(!empty($sort_desc)) $sort_type = 'DESC';
		
		$sql =
		"
				SELECT SQL_CALC_FOUND_ROWS UserMng.*
				FROM users AS UserMng
				WHERE {$conditions}
				ORDER BY {$sort_field} {$sort_type}
				LIMIT {$offset}, {$row_limit}
			";
		
		$data = $this->query($sql);
		
		//データ構造を変換（2次元配列化）
		$data2 = [];
		if(!empty($data)) $data2 = Hash::extract($data, '{n}.UserMng');
		
		// LIMIT制限なし・データ件数
		$non_limit_count = 0;
		$res = $this->query('SELECT FOUND_ROWS()');
		if(!empty($res)){
			$res = reset($res[0]);
			$non_limit_count= reset($res);
		}
		
		return ['data' => $data2, 'non_limit_count' => $non_limit_count];
		
	}
	
	/**
	 * ユーザー管理エンティティを取得
	 *
	 * ユーザー管理テーブルからidに紐づくエンティティを取得します。
	 *
	 * @param int $id ユーザー管理ID
	 * @return array ユーザー管理エンティティ
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
			$ent=$data['UserMng'];
		}
		



		return $ent;
	}

	
	/**
	 * SQLのダンプ
	 * @param  $option
	 */
	private function dumpSql($option){
		$dbo = $this->getDataSource();
		
		$option['table']=$dbo->fullTableName($this->UserMng);
		$option['alias']='UserMng';
		
		$query = $dbo->buildStatement($option,$this->UserMng);
		
		Debugger::dump($query);
	}



	/**
	 * 検索条件情報からWHERE情報を作成。
	 * @param array $kjs	検索条件情報
	 * @param string $role 権限
	 * @return string WHERE情報
	 */
	private function createKjConditions($kjs, $role){

		$cnds=null;
		
		$this->CrudBase->sql_sanitize($kjs); // SQLサニタイズ
		
		if(!empty($kjs['kj_main'])){
			$cnds[]="CONCAT( IFNULL(UserMng.user_mng_name, '') ,IFNULL(UserMng.note, '')) LIKE '%{$kjs['kj_main']}%'";
		}
		
		// CBBXS-1003
		if(!empty($kjs['kj_id']) || $kjs['kj_id'] ==='0' || $kjs['kj_id'] ===0){
			$cnds[]="UserMng.id = {$kjs['kj_id']}";
		}
		if(!empty($kjs['kj_username'])){
			$cnds[]="UserMng.username LIKE '%{$kjs['kj_username']}%'";
		}
		if(!empty($kjs['kj_email'])){
			$cnds[]="UserMng.email LIKE '%{$kjs['kj_email']}%'";
		}
		if(!empty($kjs['kj_nickname'])){
			$cnds[]="UserMng.nickname LIKE '%{$kjs['kj_nickname']}%'";
		}
		if(!empty($kjs['kj_password'])){
			$cnds[]="UserMng.password LIKE '%{$kjs['kj_password']}%'";
		}
		if(!empty($kjs['kj_role']) || $kjs['kj_role'] ==='0' || $kjs['kj_role'] ===0){
			$cnds[]="UserMng.role = '{$kjs['kj_role']}'";
		}
		if(!empty($kjs['kj_sort_no']) || $kjs['kj_sort_no'] ==='0' || $kjs['kj_sort_no'] ===0){
			$cnds[]="UserMng.sort_no = {$kjs['kj_sort_no']}";
		}
		$kj_delete_flg = $kjs['kj_delete_flg'];
		if(!empty($kjs['kj_delete_flg']) || $kjs['kj_delete_flg'] ==='0' || $kjs['kj_delete_flg'] ===0){
			if($kjs['kj_delete_flg'] != -1){
			   $cnds[]="UserMng.delete_flg = {$kjs['kj_delete_flg']}";
			}
		}
		if(!empty($kjs['kj_update_user'])){
			$cnds[]="UserMng.update_user LIKE '%{$kjs['kj_update_user']}%'";
		}
		if(!empty($kjs['kj_ip_addr'])){
			$cnds[]="UserMng.ip_addr LIKE '%{$kjs['kj_ip_addr']}%'";
		}
		if(!empty($kjs['kj_created'])){
			$kj_created=$kjs['kj_created'].' 00:00:00';
			$cnds[]="UserMng.created >= '{$kj_created}'";
		}
		if(!empty($kjs['kj_modified'])){
			$kj_modified=$kjs['kj_modified'].' 00:00:00';
			$cnds[]="UserMng.modified >= '{$kj_modified}'";
		}
		
		$cnd_role = $this->createRoleCondition($role); // 権限による条件式を作成
		if(!empty($cnd_role)){
			$cnds[] = $cnd_role;
		}

		// CBBXE
		
		$cnd='';
		if(!empty($cnds)){
			$cnd=implode(' AND ',$cnds);
		}

		return $cnd;

	}
	
	
	/**
	 * 権限による条件式を作成
	 * @param string $role 権限
	 * @return string 条件式
	 */
	private function createRoleCondition($role){
		$cnd_str = '';
		switch($role){
			case 'master':
				break;
			case 'developer':
				$cnd_str = "UserMng.role NOT IN ('master')";
				break;
			case 'admin':
				$cnd_str = "UserMng.role NOT IN ('master', 'developer', 'admin')";
				break;
			default:
				throw new Exception('アクセス禁止権限 210530E');
			
		}
		return $cnd_str;
	}
	

	/**
	 * エンティティをDB保存
	 *
	 * ユーザー管理エンティティをユーザー管理テーブルに保存します。
	 *
	 * @param array $ent ユーザー管理エンティティ
	 * @param array $option オプション
	 *  - form_type フォーム種別  new_inp:新規入力 , copy:複製 , edit:編集
	 *  - ni_tr_place 新規入力追加場所フラグ 0:末尾 , 1:先頭
	 * @return array ユーザー管理エンティティ（saveメソッドのレスポンス）
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
						'conditions' => "id={$ent['UserMng']['id']}"
				));

		$ent=$ent['UserMng'];
		if(empty($ent['delete_flg'])) $ent['delete_flg'] = 0;

		return $ent;
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
	 * 権限リストをDBから取得する
	 * @param string $role 権限
	 */
	public function getRoleList($role){
		global $crudBaseAuthorityData;
		$data = $crudBaseAuthorityData;
		
		switch($role){
			case 'master':
				break;
			case 'developer':
				unset($data['master']);
				break;
			case 'admin':
				unset($data['master']);
				unset($data['developer']);
				unset($data['admin']);
				break;
			default:
				throw new Exception('UM210530F');
		}
		
		$list=Hash::combine($data, '{s}.name','{s}.wamei');
		
		return $list;
	}

	// CBBXE
	
	/**
	 * Eメールの重複チェック
	 * @param string $email Eメール
	 * @return bool true:重複なし, false:重複あり（エラー）
	 */
	public function checkDuplicateOfEmail($email){
		$email = $this->sqlSanitizeW($email);
		$sql = "SELECT id FROM users WHERE email = '{$email}' ";
		$res = $this->query($sql);
		if(empty($res)){
			return true;
		}
		return false;
		
	}


}