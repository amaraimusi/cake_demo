<?php
App::uses('Model', 'Model');


/**
 * ユーザー管理のモデルクラス
 *
 * ユーザー管理画面用のDB関連メソッドを定義しています。
 * ユーザー管理テーブルと関連付けられています。
 *
 */
class UserMngBk extends AppModel {


	
	public $name='UserMng';
	
	var $useTable='users';// usersテーブルと関連づける


	/// バリデーションはコントローラクラスで定義
	public $validate = null;
	
	// 権限検索条件
	private $role_cond = null;
	
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
	 * ユーザー管理画面の一覧に表示するデータを、ユーザー管理テーブルから取得します。
	 * 
	 * 検索条件、ページ番号、表示件数、ソート情報からDB（ユーザー管理テーブル）を検索し、
	 * 一覧に表示するデータを取得します。
	 * 
	 * @param $kjs 検索条件情報
	 * @param $page_no ページ番号
	 * @param $limit 表示件数
	 * @param $findOrder ソート情報
	 * @param $auth_level 権限レベル
	 * @param $authoritise 権力データ
	 * @return ユーザー管理画面一覧のデータ
	 */
	public function findData($kjs,$page_no,$limit,$findOrder,$auth_level,$authoritise){
		
		// 権限検索条件を作成する
		$role_cond = $this->makeRoleCondition($auth_level,$authoritise);
		$this->role_cond = $role_cond; // findDataCnt関数でも権限検索条件は使うのでメンバとして保持しておく。

		//条件を作成
		$conditions=$this->createKjConditions($kjs,$role_cond);

		//ORDERのデフォルトをセット
		if(empty($findOrder)){
			$findOrder='id';
		}
		
		$offset=null;
		if(!empty($limit)){
			$offset=$page_no * $limit;
		}
		
		$option=array(
					'conditions' => $conditions,
					'limit' =>$limit,
					'offset'=>$offset,
					'order' => $findOrder,
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
	 * 権力レベルと権力データから権限検索条件を作成する
	 * @param $auth_level 権限レベル
	 * @param $authoritise 権力データ
	 * @return string 権限検索条件
	 */
	private function makeRoleCondition($auth_level,$authoritise){
		
		$list = array(); // 権限リスト
		foreach($authoritise as $a_ent){
			
			// ログインユーザーの権限レベルから下の権限である場合、条件リストに追加する。
			if($a_ent['level'] <= $auth_level){
				$list[] = $a_ent['name'];
			}
		}
		
		$role_cond = null; // 権限検索条件
		
		if(empty($list)){
			return $role_cond;
		}
		
		// 権限検索条件文字列を組み立てる
		$j_str = "'".implode("','",$list)."'";
		$role_cond = "UserMng.role IN ({$j_str})";
		
		return $role_cond;
		
	}
	
	
	
	/**
	 * アプリIDにひもづくデータを取得する
	 * @param int $app_id アプリID
	 * @return データ
	 */
	public function getDataByAppId($app_id){
		//条件を作成
		$conditions=array(
				'app_id'=>$app_id,
				'delete_flg'=>0,
		);
		
		
		$option=array(
				'conditions' => $conditions,
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
		
		$option['table']=$dbo->fullTableName($this->UserMng);
		$option['alias']='UserMng';
		
		$query = $dbo->buildStatement($option,$this->UserMng);
		
		Debugger::dump($query);
	}



	/**
	 * 検索条件情報からWHERE情報を作成。
	 * @param $kjs	検索条件情報
	 * @param $role_cond 権限検索条件
	 * @return WHERE情報
	 */
	private function createKjConditions($kjs,$role_cond){

		$cnds=null;
		
		// --- Start kjConditions	

		if(!empty($kjs['kj_id'])){
			$cnds[]="UserMng.id = '{$kjs['kj_id']}'";
		}
		if(!empty($kjs['kj_username'])){
			$cnds[]="UserMng.username = '{$kjs['kj_username']}'";
		}
		if(!empty($kjs['kj_role'])){
			$cnds[]="UserMng.role = '{$kjs['kj_role']}'";
		}
		if(!empty($kjs['kj_op_name'])){
			$cnds[]="UserMng.op_name = '{$kjs['kj_op_name']}'";
		}
		if(!empty($kjs['kj_delete_flg'])){
			$cnds[]="UserMng.delete_flg = '{$kjs['kj_delete_flg']}'";
		}
		if(!empty($kjs['kj_update_user'])){
			$cnds[]="UserMng.update_user = '{$kjs['kj_update_user']}'";
		}
		if(!empty($kjs['kj_update_ip_addr'])){
			$cnds[]="UserMng.update_ip_addr = '{$kjs['kj_update_ip_addr']}'";
		}
		if(!empty($kjs['kj_created'])){
			$kj_created=$kjs['kj_created'].' 00:00:00';
			$cnds[]="UserMng.created >= '{$kj_created}'";
		}
		if(!empty($kjs['kj_modified'])){
			$kj_modified=$kjs['kj_modified'].' 00:00:00';
			$cnds[]="UserMng.modified >= '{$kj_modified}'";
		}
	

		// 権限検索条件を条件式に追加する
		$cnds[] = $role_cond;
		
		// --- End kjConditions
		
		$cnd=null;
		if(!empty($cnds)){
			$cnd=implode(' AND ',$cnds);
		}

		return $cnd;

	}

	/**
	 * エンティティをDB保存
	 *
	 * ユーザー管理エンティティをユーザー管理テーブルに保存します。
	 *
	 * @param array $ent ユーザー管理エンティティ
	 * @return array ユーザー管理エンティティ（saveメソッドのレスポンス）
	 */
	public function saveEntity($ent){


		//DBに登録('atomic' => false　トランザクションなし）
		$ent = $this->save($ent, array('atomic' => false,'validate'=>'true'));

		//DBからエンティティを取得
		$ent = $this->find('first',
				array(
						'conditions' => "id={$ent['UserMng']['id']}"
				));
		
		$ent=$ent['UserMng'];
		
		
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

		// findDataメソッドでセットした権限検索条件を取得する
		$role_cond = $this->role_cond;

		//DBから取得するフィールド
		$fields=array('COUNT(id) AS cnt');
		$conditions=$this->createKjConditions($kjs,$role_cond);

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














}