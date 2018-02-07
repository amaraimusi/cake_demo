<?php
App::uses('Model', 'Model');


/**
 * タナガーのモデルクラス
 *
 * タナガー画面用のDB関連メソッドを定義しています。
 * タナガーテーブルと関連付けられています。
 *
 * @date 2015/09/16	新規作成
 * @author k-uehara
 *
 */
class Tanager extends AppModel {


	/// タナガーテーブルを関連付け
	public $name='Tanager';


	/// バリデーションはコントローラクラスで定義
	public $validate = null;
	
	/**
	 * タナガーエンティティを取得
	 *
	 * タナガーテーブルからidに紐づくエンティティを取得します。
	 *
	 * @param int $id タナガーID
	 * @return array タナガーエンティティ
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
			$ent=$data['Tanager'];
		}
		



		return $ent;
	}

	/**
	 * タナガー画面の一覧に表示するデータを、タナガーテーブルから取得します。
	 * 
	 * 検索条件、ページ番号、表示件数、ソート情報からDB（タナガーテーブル）を検索し、
	 * 一覧に表示するデータを取得します。
	 * 
	 * @param $kjs 検索条件情報
	 * @param $page_no ページ番号
	 * @param $limit 表示件数
	 * @param $findOrder ソート情報
	 * @return タナガー画面一覧のデータ
	 */
	public function findData($kjs,$page_no,$limit,$findOrder){

		//条件を作成
		$conditions=$this->createKjConditions($kjs);

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
		
		//$this->dumpSql($option);■■■□□□■■■□□□■■■□□□
		
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
		
		$option['table']=$dbo->fullTableName($this->Tanager);
		$option['alias']='Tanager';
		
		$query = $dbo->buildStatement($option,$this->Tanager);
		
		Debugger::dump($query);
	}



	/**
	 * 検索条件情報からWHERE情報を作成。
	 * @param  $kjs	検索条件情報
	 * @return WHERE情報
	 */
	private function createKjConditions($kjs){

		$cnds=null;
		
		// --- Start kjConditions
		
		if(!empty($kjs['kj_id'])){
			$cnds[]="Tanager.id = {$kjs['kj_id']}";
		}
		
		if(!empty($kjs['kj_tanager_val1'])){
			$cnds[]="Tanager.tanager_val >= {$kjs['kj_tanager_val1']}";
		}
		
		if(!empty($kjs['kj_tanager_val2'])){
			$cnds[]="Tanager.tanager_val <= {$kjs['kj_tanager_val2']}";
		}
		
		if(!empty($kjs['kj_tanager_name'])){
			$cnds[]="Tanager.tanager_name LIKE '%{$kjs['kj_tanager_name']}%'";
		}
		
		if(!empty($kjs['kj_tanager_date1'])){
			$cnds[]="Tanager.tanager_date >= '{$kjs['kj_tanager_date1']}'";
		}
		
		if(!empty($kjs['kj_tanager_date2'])){
			$cnds[]="Tanager.tanager_date <= '{$kjs['kj_tanager_date2']}'";
		}
		
		if(!empty($kjs['kj_tanager_group'])){
			$cnds[]="Tanager.tanager_group = {$kjs['kj_tanager_group']}";
		}
		
		if(!empty($kjs['kj_tanager_dt'])){
			$cnds[]="Tanager.tanager_dt = '{$kjs['kj_tanager_dt']}'";
		}

		if(!empty($kjs['kj_note'])){
			$cnds[]="Tanager.note LIKE '%{$kjs['kj_note']}%'";
		}
		
		if(!empty($kjs['kj_delete_flg']) || $kjs['kj_delete_flg'] ==='0' || $kjs['kj_delete_flg'] ===0){
			$cnds[]="Tanager.delete_flg = {$kjs['kj_delete_flg']}";
		}

		if(!empty($kjs['kj_update_user'])){
			$cnds[]="Tanager.update_user = '{$kjs['kj_update_user']}'";
		}

		if(!empty($kjs['kj_ip_addr'])){
			$cnds[]="Tanager.ip_addr = '{$kjs['kj_ip_addr']}'";
		}
		
		if(!empty($kjs['kj_user_agent'])){
			$cnds[]="Tanager.user_agent LIKE '%{$kjs['kj_user_agent']}%'";
		}

		if(!empty($kjs['kj_created'])){
			$kj_created=$kjs['kj_created'].' 00:00:00';
			$cnds[]="Tanager.created >= '{$kj_created}'";
		}
		
		if(!empty($kjs['kj_modified'])){
			$kj_modified=$kjs['kj_modified'].' 00:00:00';
			$cnds[]="Tanager.modified >= '{$kj_modified}'";
		}
		
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
	 * タナガーエンティティをタナガーテーブルに保存します。
	 *
	 * @param array $ent タナガーエンティティ
	 * @return array タナガーエンティティ（saveメソッドのレスポンス）
	 */
	public function saveEntity($ent){


		//DBに登録('atomic' => false　トランザクションなし）
		$ent = $this->save($ent, array('atomic' => false,'validate'=>'true'));

		//DBからエンティティを取得
		$ent = $this->find('first',
				array(
						'conditions' => "id={$ent['Tanager']['id']}"
				));
		
		$ent=$ent['Tanager'];
		
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














}