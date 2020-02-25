<?php

/**
 * 基本CRUDのモデル
 * 
 * @note
 * 各モデルで共通する処理を記述する。
 * saveメソッドを備える。
 * 
 * @version 1.0
 * @date 2017-4-28
 * @author k-uehara
 *
 */
class CrudBaseModelWp{
	
	
	protected $useTable = null; // 仕様テーブル
	
	protected $whiteList = null; // ホワイトリスト（テーブルのフィールド一覧）
	
	/**
	 * エンティティをDB保存する。
	 * 
	 * @note
	 * エンティティにidが含まれていればUPDATE扱いとなり、idがなければINSERT扱いになる。
	 * エンティティのフィールドはDBフィールドと厳密に一致させる必要はない。存在しないフィールドは無視する。
	 * 
	 * @param array $ent DB保存するエンティティ
	 * @param array $option
	 * - table: 	テーブル名:	テーブル名を指定する場合。デフォルトは$useTableメンバのテーブル名でる。
	 * - sanitaize: サニタイズ: 	true(デフォルト):SQLインジェクションを施す。
	 * - id_ins_flg:ID INSERTフラグ: 
	 *  - 0(デフォルト): 	INSERTする際、IDを除去（mysqlのautoincrementでID生成） 
	 *  - 1: 			IDを除去しない
	 *  - debug: 	0(デフォルト):SQLをダンプしない   1:SQLをダンプする
	 *  
	 */
	public function save($ent,$option=null){
		
		$option = $this->ifSetOption($option);
		
		
		$table = $option['table']; // テーブル名を取得

		// サニタイズフラグがONである場合、SQLサニタイズを施す。
		if(!empty($option['sanitaize'])){
			$this->sql_sanitize($ent);
		}

		// エンティティのIDが空でない場合
		$res_ent = array();
		if(!empty($ent['id'])){
			// IDに紐づく既存レコードを取得する
			$eEnt = $this->getEntity($ent['id'],$table);

			// 既存レコードが空である場合
			if(empty($eEnt)){
				return $this->insertEntity($ent,$table,$option);// INSERTメソッドを呼び出す
			}
			
			// 既存レコードをエンティティの値要素をセットする
			foreach($eEnt as $field=>$val){
				if(isset($ent[$field])){
					$eEnt[$field] = $ent[$field];
				}
			}


			// 既存レコードをUPDATE
			$res_ent = $this->updateEntity($eEnt,$table,$option);
		}

		
		// エンティティのIDが空である場合、INSERTを実行する
		else{
			$res_ent= $this->insertEntity($ent,$table,$option);// INSERTメソッドを呼び出す
		}
		
		// SQLサニタイズデコード
		if(!empty($option['sanitaize'])){
			$this->sql_sanitize_decord($res_ent);
		}
		
		
		return $res_ent;
		
	}
	
	
	
	/**
	 * データをDBに保存する。
	 * 
	 * @note
	 * 複数行を一括して登録する。
	 * データはエンティティの配列である。
	 * 
	 * @param array $data DBへ保存するデータ: エンティティの配列
	 * @param array $option
	 * - table: 	テーブル名:	テーブル名を指定する場合。デフォルトは$useTableメンバのテーブル名でる。
	 * - sanitaize: サニタイズ: 	true(デフォルト):SQLインジェクションを施す。
	 * - atomic:  	トランザクション:	false(デフォルト):内部でトランザクションを行わない
	 * - id_ins_flg:ID INSERTフラグ: 
	 *  - 0(デフォルト): 	INSERTする際、IDを除去（mysqlのautoincrementでID生成） 
	 *  - 1: 			IDを除去しない
	 * - debug: 	0(デフォルト):SQLをダンプしない   1:SQLをダンプする
	 */
	public function saveAll($data, $option){
		$option = $this->ifSetOption($option);
		
		// トランザクションフラグが有効である場合
		if(!empty($option['atomic'])){
			global $wpdb;
			try {
				$wpdb->get_results("BEGIN");
				foreach($data as $ent){
					$this->save($ent,$option);
				}
				$wpdb->get_results("COMMIT");
				
			} catch (Exception $e) {
				$wpdb->get_results("ROLLBACK");
				throw $e;
			}
		}
		
		// トランザクションフラグが無効である場合
		else{
			foreach($data as $ent){
				$this->save($ent,$option);
			}
		}
		
		

	}
	
	
	
	
	
	/**
	 * エンティティをDBへマージ保存する。
	 * 
	 * @note
	 * テーブルのフィールドにはidとdelete_flgが必要。
	 * 
	 * @param array $data 入力データ（保存対象データ）
	 * @param string or array  $condition 条件(文字列、配列の２通り指定可）
	 * @param array $option
	 * - table テーブル名:	テーブル名を指定する場合。デフォルトは$useTableメンバのテーブル名でる。
	 * - sanitaize サニタイズ: trueの場合、SQLインジェクションを施す。（デフォルトではtrue)
	 * - atomic  トランザクション false:内部でトランザクションを行わない  true:トランザクションを行う。
	 * - delete_field 無効フラグのフィールド名（デフォルト=delete_flg)
	 */
	public function saveMerge($data,$condition,$option=null){
		
		// 空チェック
		if(empty($data)){
			return $data;
		}
		
		$option = $this->ifSetOption($option);
		
		// 条件情報が文字列型なら配列型に変換する。
		if(!is_array($condition)){
			$condition = array($condition);
		}

		// 削除フィールド名
		$delete_field = $option['delete_field'];
		
		// 検索条件にパラメータをセット
		$condition = $this->setParamToCondition($data,$condition);
		
		// 条件で対象テーブルを検索して既存データを取得する
		$eData = $this->existData($condition,$option['table']);
		
		// 一旦、既存データの削除フラグをすべてONにして登録データにセットする。
		$regData = $this->deleteFlgOn($eData,$delete_field);
		
		// 入力データからID配列を取り出す
		$ids = $this->getIdsFromInpData($data);

		// 登録データのID配列にひもづくエンティティへ、済フラグをセットする。
		$regData = $this->setSettedFlg($regData,$ids);
		
		// 入力データをループしながら登録データへマージする。
		foreach($data as $i=>$ent){

			// 入力エンティティにidが存在する場合
			if(!empty($ent['id'])){
				
				// 登録データからIDに一致するエンティティのインデックスを取得する
				$index = $this->getIndexFromDataById($regData,$ent['id']);
				
				// インデックスが取得できた場合
				if($index >= 0){

					// 登録データに入力エンティティをマージする | その1
					$regData = $this->mergeRegData1($regData,$ent,$index,$delete_field);
				}
				
				// インデックスが取得できなかった場合
				else{
					// 登録データに入力エンティティをマージする | その2
					unset($ent['id']);
					$regData =$this->mergeRegData2($regData,$ent,$index,$delete_field);
				}
			}
			
			// 入力エンティティにidが存在しない場合
			else{
				
				// 登録データに入力エンティティをマージする | その2
				$regData =$this->mergeRegData2($regData,$ent,0,$delete_field);

			}
			

		}
		
		$this->saveAll($regData, $option);

	}
	
	
	/**
	 * 登録データに入力エンティティをマージする | その1
	 * @param array $regData 登録データ(参照引数型）
	 * @param array $ent 入力エンティティ
	 * @param int $index インデックス
	 * @param string $delete_field 削除フィールド名
	 * @return array マージ後の登録データ
	 */
	private function mergeRegData1(&$regData,$ent,$index,$delete_field){
		$regEnt = $regData[$index];
		$regEnt = array_merge($regEnt,$ent);
		$regEnt[$delete_field] = 0;
		$regData[$index] = $regEnt;
		unset($regEnt['modified']);
		return $regData;
	}
	
	
	/**
	 * 登録データに入力エンティティをマージする | その2
	 * @param array $regData 登録データ
	 * @param array $ent 入力エンティティ
	 * @param int $index インデックス
	 * @param string $delete_field 削除フィールド名
	 * @return array マージ後の登録データ
	 */
	private function mergeRegData2($regData,$ent,$index,$delete_field){
		
		
		// 登録データから済フラグなし且つ、上位のインデックスを取得する。
		$index = -1;
		foreach($regData as $i => $regEnt){
			if(empty($regEnt['setted_flg_xxx'])){
				$index = $i;
				break;
			}
		}
		

		// インデックスが取得できた場合、マージを行う
		if($index >= 0){
			$regEnt = $regData[$index];
			$regEnt = array_merge($regEnt,$ent);
			$regEnt[$delete_field] = 0;
			$regEnt['setted_flg_xxx'] = true;
			unset($regEnt['modified']);
			$regData[$index] = $regEnt;
			
		}
		
		// インデックスが取得できなかった場合、入力エンティティを追加する。
		else{
			$regEnt = $ent;
			unset($regEnt['id']);
			$regEnt[$delete_field] = 0;
			$regEnt['setted_flg_xxx'] = true;
			unset($regEnt['modified']);
			$regData[] = $regEnt;
		}
		
		return $regData;
		
	}
	
	

	
	
	/**
	 * 登録データのID配列にひもづくエンティティへ、済フラグをセットする。
	 * @param array $regData 登録データ
	 * @param array $ids ID配列
	 * @return array 登録データ
	 */
	private function setSettedFlg($regData,$ids){
		if(empty($ids)){
			return $regData;
		}
		
		foreach($regData as $i=>&$ent){
			foreach($ids as $id_x){
				if($ent['id']==$id_x){
					$ent['setted_flg_xxx'] = true;
					continue;
				}
			}
		}
		unset($ent);
		
		return $regData;
	}
	
	
	
	/**
	 * 入力データからID配列を取り出す
	 * @param array $data 入力データ
	 * @return array ID配列
	 */
	private function getIdsFromInpData($data){
		$ids = array();
		foreach($data as $ent){
			if(!empty($ent['id'])){
				$ids[] = $ent['id'];
			}
		}
		return $ids;
	}
	
	
	/**
	 * データ中の削除フラグをすべてONにする。
	 * @param array $data データ
	 * @param string $delete_field 削除フィールド
	 * @return array 削除フラグをONにしたデータ
	 */
	private function deleteFlgOn($data,$delete_field){

		foreach($data as &$ent){
			$ent[$delete_field] = 1;
		}
		unset($ent);
		
		return $data;
	}
	
	
	
	
	/**
	 * データからIDにひもづくエンティティのインデックスを取得する
	 * @param array $data データ
	 * @param int $id_x ID
	 * @return int インデックス
	 */
	private function getIndexFromDataById($data,$id_x){
		
		foreach($data as $i=>$ent){
			if($ent['id'] == $id_x){
				return $i;
			}
		}
		return -1;
		
	}
	
	/**
	 * 検索条件にパラメータをセット
	 * @param array $data 入力データ
	 * @param array $condition 条件
	 * @return array パラメータをセットした検索条件
	 */
	private function setParamToCondition($data,$condition){
		
		$ent0 = $data[0];
		$cond2 = array();
		foreach($condition as $field){
			$cond2[$field] = $ent0[$field];
		}
		return $cond2;
	}
	
	/**
	 * 条件で対象テーブルを検索して既存データを取得する
	 * @param array $condition 条件
	 * @param array $table テーブル名
	 * @return array 既存データ
	 */
	private function existData($condition,$table){
		
		if(empty($table)){
			$err_msg = '$table is empty!';
			var_dump('Erorr:'.$err_msg);
			throw new Exception($err_msg);
		}
		
	
		// WHERE文を組み立てる
		$wh=''; // WHERE文
		foreach($condition as $field=>$value){
			$wh .= "\n AND {$field} = '{$value}' ";
		}
		
		
		global $wpdb;
		$sql = 
			"
			SELECT *
			FROM {$table}
			WHERE 1=1 {$wh}
			";
		
		$data = $wpdb->get_results($sql);
		
		// stdClassオブジェクトから配列に変換する
		$data2=array();
		if(!empty($data)){
			foreach($data as $stdClassEnt){
				$data2[] = (array) $stdClassEnt;
			}
				
		}
		
		
		return $data2;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * DBからIDに紐づくエンティティを取得する
	 * @param int $id
	 * @return array エンティティ
	 */
	private function getEntity($id,$table=null){

		if(empty($table)){
			$table = $this->useTable;
		}
		
		global $wpdb;
		$ent = $wpdb->get_row(
			"
			SELECT *
			FROM {$table}
			WHERE id = '{$id}'
			"
		);

		if(!empty($ent)){
			$ent = (array) $ent;
		}else{
			$ent = array();
		}
		
		return $ent;
		
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * オプションの空プロパティに初期セット
	 * @param array $option オプション
	 * @return array 初期セット後のオプション
	 */
	private function ifSetOption($option){
		if($option==null){
			$option = array();
		}
		
		if(!isset($option['table'])){
			$option['table'] = $this->useTable;
		}
		
		if(!isset($option['sanitaize'])){
			$option['sanitaize'] = true;
		}
		
		if(!isset($option['delete_field'])){
			$option['delete_field'] = 'delete_flg';
		}
		
		if(!isset($option['id_ins_flg'])){
			$option['id_ins_flg'] = 0;
		}
		
		if(!isset($option['debug'])){
			$option['debug'] = 0;
		}
		
		
		return $option;
	}
	
	
	
	
	/**
	 * エンティティのINSERT
	 * @param array $ent_p エンティティ
	 * @param array $table テーブル名
	 * @param array $opation オプション（省略可）
	 * - id_ins_flg: ID INSERTフラグ: 
	 *  - 0(デフォルト): INSERTする際、IDを除去（mysqlのautoincrementでID生成） 
	 *  - 1: IDを除去しない
	 * - debug: 	0(デフォルト):SQLをダンプしない   1:SQLをダンプする
	 * 
	 * @return 追加した新レコード（エンティティ）
	 */
	private function insertEntity($ent_p,$table,$option=array()){
		
		// ホワイトリスト（テーブルのフィールド名リスト）を取得する
		if(empty($this->whiteList)){
			
			$this->whiteList = $this->getWhiteList($table);
		}
		$whiteList = $this->whiteList;
		
		// エンティティをホワイトリストでフィルタリングする。
		$ent_s = array();
		foreach($whiteList as $white_field){
			
			if(isset($ent_p[$white_field])){
				$ent_s[$white_field] = $ent_p[$white_field];
			}
		}
		
		// ID INSERTフラグが0であるならIDをクリアする。IDはmysqlのautoincrementにまかせる。
		if(empty($option['id_ins_flg'])){
			$ent_s['id'] = null;
		}
		
	
		//  該当テーブルへ保存する
		global $wpdb;

		// デバッグモードのSQLダンプ準備
		if(!empty($option['debug'])){
			$wpdb->show_errors();
		}
		
		// ★INSERT実行
		$result = $wpdb->insert( $table, $ent_s);
		
		// デバッグモードのSQLダンプ出力
		if(!empty($option['debug'])){
			$wpdb->print_error();
		}
		

		// 最新行を取得する
		$sql = 				
			"
			SELECT *
			FROM {$table}
			ORDER BY id
			DESC LIMIT 1
			";
		$entStd = $wpdb->get_row($sql);
		

		$ent = (array)$entStd;
		
		return $ent;

	}
	
	
	/**
	 * ホワイトリスト（テーブルのフィールド名リスト）を取得する
	 * @param string $table テーブル名
	 * @return array ホワイトリスト
	 */
	private function getWhiteList($table=null){
		if(empty($table)){
			$table = $this->useTable;
		}
		
		// 該当テーブルから列情報を取得する。
		global $wpdb;
		$columns = $wpdb->get_results(
				"
				SHOW 
				FULL 
				COLUMNS 
				FROM {$table}
				"
		);
		
		// 列情報からホワイトリストを抽出する。
		$whiteList = array();
		foreach($columns as $clmStd){
			$whiteList[] = $clmStd->Field;
		}
		
		return $whiteList;
		
	}
	
	
	
	/**
	 * エンティティのUPDATE
	 * @param array $ent エンティティ
	 * @param array $table テーブル名
	 * @return array エンティティ
	 */
	private function updateEntity($ent,$table,$option){

		global $wpdb;
		
		
		// デバッグモードのSQLダンプ準備
		if(!empty($option['debug'])){
			$wpdb->show_errors();
		}
		
		$id = $ent['id'];
		$result = $wpdb->update(
				$table,
				$ent,
				array( 'id' => $id )// WHERE条件
				);
		
		// デバッグモードのSQLダンプ出力
		if(!empty($option['debug'])){
			$wpdb->print_error();
		}
		
		return $ent;
	}
	
	
	
	
	
	
	
	
	
	
	

	
	/**
	 * SQLインジェクションサニタイズ
	 *
	 * @note
	 * SQLインジェクション対策のためデータをサニタイズする。
	 * 高速化のため、引数は参照（ポインタ）にしている。
	 *
	 * @param any サニタイズデコード対象のデータ | 値および配列を指定可
	 * @return void
	 */
	protected function sql_sanitize(&$data){
	
		if(is_array($data)){
			foreach($data as &$val){
				$this->sql_sanitize($val);
			}
			unset($val);
		}elseif(gettype($data)=='string'){
			$data = addslashes($data);// SQLインジェクション のサニタイズ
		}else{
			// 何もしない
		}
	}
	
	
	/**
	 * SQLサニタイズデコード
	 *
	 * @note
	 * SQLインジェクションでサニタイズしたデータを元に戻す。
	 * 高速化のため、引数は参照（ポインタ）にしている。
	 *
	 * @param any サニタイズデコード対象のデータ | 値および配列を指定可
	 * @return void
	 */
	protected function sql_sanitize_decord(&$data){
	
		if(is_array($data)){
			foreach($data as &$val){
				$this->sql_sanitize_decord($val);
			}
			unset($val);
		}elseif(gettype($data)=='string'){
			$data = stripslashes($data);
		}else{
			// 何もしない
		}
	}
	
	
	
	
	
	
	
	/**
	 * データを利用しやすいように正規化する
	 * 
	 * @note
	 * stdClass型から配列型に変換する。
	 * SQLインジェクション対策のサニタイズを元に戻す。
	 * 
	 * @param array<stdClass> $data
	 * @param array $option オプション
	 * - sql_sanitaize_decode 0:デコードしない , 1 デコードする（デフォルト）
	 */
	protected function dataNormalization($data,$option=null){
		
		if(empty($option)){
			$option = array();
		}
		if(!isset($option['sql_sanitaize_decode'])){
			$option['sql_sanitaize_decode'] = 1;
		}
		
		
		$sql_sanitaize_decode = $option['sql_sanitaize_decode'];

		// stdClassオブジェクトから配列に変換する
		$data2=array();
		foreach($data as $stdClassEnt){
			$data2[] = (array) $stdClassEnt;
		}
		
		// SQLサニタイズデコード
		$this->sql_sanitize_decord($data2);

		return $data2;
	}
	
	

	/**
	 * テーブル名にプリフィックスを付加する
	 * @param プロとテーブル名（プリフィックスなしのテーブル名）
	 * @return string プリフィックスを付加したテーブル名
	 */
	protected function prefixTableName($proto_tbl_name){
		global $wpdb;
		$prefix = $wpdb->prefix; // プリフィックス
		$table_name = $prefix.'enqnx_'.$proto_tbl_name;
		return $table_name;
	}
	
	
	
	/**
	 * nullでないかチェック
	 *
	 * @note
	 * false : null,空文字,未セット
	 * true : TRUE系値,0,false
	 * @param array $kjs
	 * @param string $field
	 * @return boolean
	 */
	protected function isnotNull($kjs,$field){
		if(isset($kjs[$field])){
			if(empty($kjs[$field])){
				if($kjs[$field] ==='0' || $kjs[$field] ===0 || $kjs[$field] ===false){
					return true;
				}else{
					return false;
				}
			}else{
				return true;
			}
		}else{
			return false;
		}
	}
	
	
	
	
	
	
}