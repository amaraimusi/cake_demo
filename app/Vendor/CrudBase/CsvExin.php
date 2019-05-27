<?php
require_once('IDao.php');
/**
 * 専属CSV読込 csv_exin
 * 
 * @date 2019-1-9 | 2019-5-27
 * @version 1.1.0
 */
class CsvExin{

	var $dao;
	var $update_user; // 更新ユーザー
	var $ip_addr; // 更新者のIPアドレス
	var $created; // 生成日時
	
	/**
	 * コンストラクタ
	 * @param IDao $dao データベースアクセスオブジェクト
	 * @param string $update_user 更新ユーザー
	 */
	public function __construct(IDao &$dao, $update_user = 'none'){
		$this->dao = $dao;
		$this->update_user = $update_user;
		$this->ip_addr = $_SERVER["REMOTE_ADDR"];
		$this->created = date('Y-m-d H:i:s');
	}
	
	/**
	 * 登録
	 * @param array $csvExinData
	 *  - data 登録対象のCSVデータ
	 *  - csvFieldData CSVフィールドデータ
	 *  - csvParam CSVパラメータ
	 *      - main_table_name メインテーブル名
	 * @return レスポンス（新規追加数、上書き数）
	 */
	public function reg(&$csvExinData){
		
		$data = $csvExinData['data'];
		$csvFieldData = $csvExinData['csvFieldData'];
		$csvParam = $csvExinData['csvParam'];
		$masterBoxs = []; // マスターボックスリスト ←マスター関連のデータ
		$ins_cnt = 0; // 新規追加数
		$upd_cnt = 0; // 上書き数

		// マスターボックスリストにCSVフィールドデータのマスタ関連プロパティをセットする。
		$masterBoxs = $this->setMasterBoxsFromFieldData($masterBoxs, $csvFieldData);

		foreach($masterBoxs as $master=>&$box){
			
			// CSVデータからマスタ系フィールドの値リストを取得する(重複および空白除去）
			$box['values'] = $this->getMasterValues($data, $box);
			
			// 次順番を取得する
			$box['next_sort_no'] = $this->getNextSortNo($box['table_name']);
			
			// DBから値リストに紐づくIDを含むデータをマスタデータとして取得する
			$box['masterData'] = $this->getMasterDataFromDb($box);
			
		}
		unset($box);

		$this->dao->begin();
		try {
			
			// マスターデータをDB登録
			$masterBoxs = $this->regMasterData($masterBoxs);
			
			// IDマッピングを作成
			$masterBoxs = $this->makeIdMap($masterBoxs);

			// 登録メインデータを作成
			$mainData = $this->createMainData($data, $masterBoxs, $csvFieldData);
			
			// 登録メインデータ加工：追加と上書きに分ける。ついでに共通情報もセット。
			$main_table_name = $csvParam['main_table_name'];
			$mainData = $this->prosMainData($mainData, $main_table_name);
			$this->xss_escape($mainData);
			
			// テーブルフィールドフィルター: テーブルに存在しないフィールドをデータから除去する
			$mainData = $this->tableFieldFilter($main_table_name, $mainData);
			
			// データからINSERTとUPDATEのSQL文を生成する
			$res = $this->createInsertAndUpdate($main_table_name, $mainData);

			
			// UPDATEを実行
			$updates = $res['updates'];
			foreach($updates as $sql){
				$this->dao->sqlExe($sql);
			}
			
			// INSERTを実行
			$inserts = $res['inserts'];
			foreach($inserts as $sql){
				$this->dao->sqlExe($sql);
			}
			
			$ins_cnt = count($inserts); // 新規追加数
			$upd_cnt = count($updates); // 上書き数
			
		} catch (Exception $e) {
			$this->dao->rollback();
			throw $e;
		}
		$this->dao->commit();
		
		return [
				'ins_cnt' => $ins_cnt,
				'upd_cnt' => $upd_cnt,
		];
		
	}
	
	
	/**
	 * マスターボックスリストにCSVフィールドデータのマスタ関連プロパティをセットする。
	 * @param array $masterBoxs マスターボックスリスト
	 * @param array $csvFieldData CSVフィールドデータ
	 * @return array マスタ関連プロパティをセットしたマスターボックスリスト
	 */
	private function setMasterBoxsFromFieldData(&$masterBoxs, &$csvFieldData){

		foreach($csvFieldData as $cfEnt){
			if(empty($cfEnt['master'])) continue;
			$master = $cfEnt['master'];
			
			// テーブル名取得
			$table_name = $this->snakize($master);
			$table_name .= 's';
			$cfEnt['table_name'] = $table_name;
			
			$masterBoxs[$master] = $cfEnt;
		}
		
		return $masterBoxs;
	}
	
	
	/**
	 * スネークケースにキャメルケースから変換
	 * @param string $str キャメルケース
	 * @return string スネークケース
	 */
	private function snakize($str) {
		$str = preg_replace('/[A-Z]/', '_\0', $str);
		$str = strtolower($str);
		return ltrim($str, '_');
	}
	
	
	/**
	 * CSVデータからマスタ系フィールドの値リストを取得する(重複および空白除去）
	 * @param array $data CSVデータ
	 * @param array $box マスターボックス
	 * @return array 値リスト
	 */
	private function getMasterValues($data, $box){

		$field = $box['field'];
		$values = []; // 値リスト
		foreach($data as $ent){
			if(!empty($ent[$field])){
				$values[] = $ent[$field];
			}
		}

		$values = array_filter($values, "strlen");// 空白行を除去(indexの降り直しは行わない）
		$values = array_unique($values); // 重複を除去
		
		return $values;
	}
	
	
	/**
	 * 次順番を取得する
	 * @param string $table_name テーブル名
	 * @return int 次順番
	 */
	private function getNextSortNo($table_name){
		$sql = "SELECT MAX(sort_no) AS next_sort_no FROM {$table_name}";
		
		$res = $this->dao->sqlExe($sql);
		$next_sort_no = 0; // 次順番
		if(!empty($res)){
			$next_sort_no = $this->getValueFromAryDepth($res);
			$next_sort_no ++;
		}

		return $next_sort_no;
	}
	
	
	/**
	 * 配列の深みにある値を取得する(先頭行のみ）
	 * @param array $ary 対象配列
	 * @
	 */
	private function getValueFromAryDepth(&$ary){
		if(is_array($ary)){
			$first = current($ary);
			return $this->getValueFromAryDepth($first);
		}else{
			return $ary;
		}
	}
	
	
	/**
	 * DBから値リストに紐づくIDを含むデータをマスタデータとして取得する
	 * @param array $box マスタボックス
	 */
	private function getMasterDataFromDb(&$box){
		
		$values = $box['values'];
		if(empty($values)) return [];
		
		// テーブル名を取得
		$table_name = $box['table_name'];
		
		$field = $box['field'];
		
		// IN句部分を組み立て
		$j_str = "'" . implode("','", $values) . "'";
		
		// SQLを実行
		$sql = "SELECT * FROM {$table_name} WHERE {$field} IN($j_str)";
		$res = $this->dao->sqlExe($sql);
		
		// DBデータ
		$dbData = [];
		if(!empty($res)){
			foreach($res as $i => $ary){
				$dbData[] = $ary[$table_name];
			}
		}
		
		$next_sort_no = $box['next_sort_no'];
		
		
		$masterData=[];// マスターデータを作成
		
		foreach($values as $value){
			$ent = $this->getEntByValue($dbData, $field, $value);
			
			// DBに存在しない
			if(empty($ent)){
				$ent['csv_exin_reg_type'] = 'add';
				$ent[$field] = $value;
				$ent['sort_no'] = $next_sort_no;
				$ent['delete_flg'] = 0;
				$ent['update_user'] = $this->update_user;
				$ent['ip_addr'] = $this->ip_addr;
				$ent['created'] = $this->created;
				
				$next_sort_no ++;
			}
			
			// 削除フラグONである場合
			else if(!empty($ent['delete_flg'])){
				$ent['csv_exin_reg_type'] = 'update';
				$ent['delete_flg'] = 0;
				$ent['update_user'] = $this->update_user;
				$ent['ip_addr'] = $this->ip_addr;
			}
			
			// 既存データ有
			else{
				$ent['csv_exin_reg_type'] = 'none';
			}
			$masterData[] = $ent;
		}
		
		return $masterData;
	}
	
	
	/**
	 * DBから取得したデータから、値に紐づくエンティティ
	 * @param array $dbData DBから取得したデータ
	 * @param string $field フィールド
	 * @param string $value 値
	 * @param array エンティティ
	 */
	private function getEntByValue(&$dbData, $field, $value){
		$rEnt = [];
		foreach($dbData as &$ent){
			if($ent[$field] == $value){
				$rEnt = $ent;
				break;
			}
		}
		unset($ent);
		return $rEnt;
	}
	
	
	/**
	 * マスターデータをDB登録
	 * @param array $masterBoxs マスターボックスリスト
	 * @return array idセット後のマスターボックスリスト
	 */
	private function regMasterData(&$masterBoxs){
		
		foreach($masterBoxs as &$box){
			
			$masterData = $box['masterData'];
			
			// 追加、または更新の対象データだけ取得
			$masterData2 = $this->filterMasterData($masterData);
			if(empty($masterData2)) continue;
			
			// INSERTとUPDATEのSQLを作成
			$table_name = $box['table_name'];
			$res = $this->createInsertAndUpdate($table_name, $masterData2);
			
			// UPDATEを実行
			$updates = $res['updates'];
			foreach($updates as $sql){
				$this->dao->sqlExe($sql);
			}
			
			// INSERTを実行
			$inserts = $res['inserts'];
			$newIds=[];
			foreach($inserts as $sql){
				$this->dao->sqlExe($sql);
				$newIdRes = $this->dao->sqlExe("SELECT LAST_INSERT_ID()");
				$newIds[] = $this->getValueFromAryDepth($newIdRes);
			}
			
			// ボックスのマスターデータに新しく追加したレコードをセットする。
			if(!empty($newIds)){
				$box['masterData'] = $this->setNewEntToMasterData($newIds, $box);
			}
			
		}
		unset($box);
		
		return $masterBoxs;
	}
	
	
	/**
	 * 追加、または更新の対象データだけ取得
	 * @param array $masterData マスターデータ
	 * @return array 登録対象のマスターデータ
	 */
	private function filterMasterData(&$masterData){
		$data2 = [];
		foreach($masterData as $ent){
			if($ent['csv_exin_reg_type']!='none'){
				unset($ent['csv_exin_reg_type']);
				$data2[] = $ent;
			}
		}
		return $data2;
	}
	
	
	/**
	 * データからINSERTとUPDATEのSQL文を生成する
	 * @param string $tbl_name テーブル名
	 * @param array $data エンティティ配列型のデータ
	 * @return array|string[][]
	 */
	private function createInsertAndUpdate($tbl_name, $data){
		if(empty($data)) return array();
		
		// 列名群文字列を組み立て
		$ent0 = current($data);
		$keys = array_keys($ent0);
		$clms_str = implode(',', $keys); // 列名群文字列
		
		$inserts = array(); // INSERT SQLリスト
		$updates = array(); // UPDATE SQLリスト
		foreach($data as &$ent){
			
			
			// IDが空ならINSERT文を組み立て
			if(empty($ent['id'])){
				$inserts[] = $this->makeInsertSql($tbl_name, $ent); // INSERT文を作成する
			}
			
			// IDが存在すればUPDATE文を組み立て
			else{
				$updates[] = $this->makeUpdateSql($tbl_name, $ent); // UPDATE文を作成する
			}
		}
		unset($ent);
		
		$res = [
				'inserts' => $inserts,
				'updates' => $updates,
		];
		return $res;
	}
	
	
	/**
	 * INSERT文を作成する
	 * @param string $tbl_name テーブル名
	 * @param array $ent 登録データのエンティティ
	 * @return string INSERT文
	 */
	private function makeInsertSql($tbl_name, &$ent){
		
		$clms_str = '';
		$vals_str = '';
		foreach($ent as $field => $value){
			if($value === null) continue;
			$clms_str .= $field . ',';
			$vals_str .= "'{$value}',";
		}
		
		// 末尾の一文字であるコンマを削る
		$clms_str = mb_substr($clms_str,0,mb_strlen($clms_str)-1);
		$vals_str = mb_substr($vals_str,0,mb_strlen($vals_str)-1);
		
		$insert_sql = "INSERT INTO {$tbl_name} ({$clms_str}) VALUES ({$vals_str});";
		return $insert_sql;
	}
	
	
	/**
	 * UPDATE文を作成する
	 * @param string $tbl_name テーブル名
	 * @param array $ent 登録データのエンティティ
	 * @return string UPDATE文
	 */
	private function makeUpdateSql($tbl_name, &$ent){
		if(empty($ent['id'])) throw new Exception('makeUpdateSql: idが空です。');
		
		$vals_str = '';
		foreach($ent as $field => $value){
			if($value === null) continue;
			$vals_str .= "{$field}='{$value}',";
		}
			
		$vals_str = mb_substr($vals_str,0,mb_strlen($vals_str)-1);// 末尾の一文字であるコンマを削る
		
		$update_sql = "UPDATE {$tbl_name} SET {$vals_str} WHERE id={$ent['id']}";
		
		return $update_sql;
	}

	
	/**
	 * ボックスのマスターデータに新しく追加したレコードをセットする。
	 * @param array $box マスターボックス
	 * @return array マスターデータ
	 */
	private function setNewEntToMasterData($newIds, $box){
		$table_name = $box['table_name'];
		
		// IN句部分を組み立て
		$j_str = "'" . implode("','", $newIds) . "'";
		
		// SQLを実行
		$sql = "SELECT * FROM {$table_name} WHERE id IN($j_str)";
		$res = $this->dao->sqlExe($sql);
		
		if(empty($res)) return $box;
		
		// 新規追加ばかりのDBデータ
		$dbData = [];
		if(!empty($res)){
			foreach($res as $i => $ary){
				$dbData[] = $ary[$table_name];
			}
		}
		
		// マスターデータにDBデータをセットする。
		$masterData = &$box['masterData'];
		$field = $box['field'];
		foreach($masterData as $i=>$ent){
			$value = $ent[$field];
			$newEnt = $this->getEntByValue($dbData, $field, $value);
			if(!empty($newEnt)){
				$masterData[$i] = $newEnt;
			}
		}

		return $masterData;
		
	}
	
	
	/**
	 * IDマッピングを作成
	 * @param array $masterBoxs マスターボックスリスト
	 * @return array IDマッピングをセットしたマスターボックスリスト
	 */
	private function makeIdMap(&$masterBoxs){
		foreach($masterBoxs as &$box){
			$masterData = $box['masterData'];
			$field = $box['field'];
			$box['idMap'] = $this->makeIdMapD2($masterData, $field); // IDマッピングを作成D2
		}
		unset($box);
		
		return $masterBoxs;
	}
	
	
	/**
	 * IDマッピングを作成D2
	 * @param array $masterData マスターデータ
	 * @param string $field フィールド
	 */
	private function makeIdMapD2($masterData, $field){
		
		$idMap = []; // IDマッピング
		foreach($masterData as &$mEnt){
			if(empty($mEnt['id'])) continue;
			$id = $mEnt['id'];
			$value = $mEnt[$field];
			$idMap[$id] = $value;
		}
		unset($mEnt);

		return $idMap;
	}
	
	
	/**
	 * 登録メインデータを作成
	 * @param array $masterBoxs マスターボックスリスト
	 * @param array $csvFieldData CSVフィールドデータ
	 */
	private function createMainData($data, &$masterBoxs, &$csvFieldData){

		$mainData = [];
		foreach($data as $ent){
			$mainEnt = [];
			foreach($csvFieldData as $cfEnt){
				$field = $cfEnt['field'];
				
				// マスタテーブルからIDを取ってくるケース
				if(!empty($cfEnt['master'])){
					$master = $cfEnt['master'];
					$idMap = $masterBoxs[$master]['idMap'];
					$value = null;
					if(!empty($ent[$field])) $value = $ent[$field];
					$x_id = array_search($value, $idMap);
					$id_field = $cfEnt['id_field'];
					$mainEnt[$id_field] = $x_id;
					
				}
				
				// IDマップがフィールドデータに定義されているケース
				elseif(!empty($cfEnt['idMap'])){
					$value = null;
					if(!empty($ent[$field])) $value = $ent[$field];
					$x_id = array_search($value, $cfEnt['idMap']);
					$id_field = $cfEnt['id_field'];
					$mainEnt[$id_field] = $x_id;
					unset($mainEnt[$field]);
					
				}
				
				// 「〇〇_id」系ではないケース
				else{
					$value = null;
					if(!empty($ent[$field])) $value = $ent[$field];
					$mainEnt[$field] = $value;
				}
				
			}
			
			$mainData[] = $mainEnt;
		}
		
		return $mainData;
	}
	

	/**
	 * 登録メインデータ加工：追加と上書きに分ける。ついでに共通情報もセット。
	 * @param array $mainData メインデータ
	 * @param string $main_table_name メインテーブル名
	 * @return array 登録メインデータ
	 */
	private function prosMainData(&$mainData, $main_table_name){
		
		// 次順番を取得する
		$next_sort_no = $this->getNextSortNo($main_table_name);
		
		// 追加データと上書きデータを作成
		foreach($mainData as $i=>$mEnt){
			
			$exiEnt=[]; // 既存エンティティ
			
			$reg_type = ''; // 登録タイプ  ins:追加, upd:上書き
			if(empty($mEnt['id'])){
				$reg_type = 'ins';
			}else{
				
				// DBにidに紐づくレコード（既存エンティティ）が存在するか調べ、存在するなら「上書き」
				$sql = "SELECT * FROM {$main_table_name} WHERE id = {$mEnt['id']}";
				$res = $this->dao->sqlExe($sql);
				if(empty($res)){
					$reg_type = 'ins';
					
				}else{
					$reg_type = 'upd';
					$exiEnt = $res[0][$main_table_name];
				}
			}
			
			// 「追加」である場合の値セット
			if($reg_type == 'ins'){
				unset($mEnt['id']); // ID列を除去することで「追加」扱いにする
				$mEnt['sort_no'] = $next_sort_no;
				$next_sort_no++;
				$mEnt['delete_flg'] = 0;
				$mEnt['update_user'] = $this->update_user;
				$mEnt['ip_addr'] = $this->ip_addr;
				$mEnt['created'] = $this->created;
				
			}
			
			//  「上書き」である場合の値セット
			elseif($reg_type == 'upd'){
				$mEnt = array_merge($exiEnt, $mEnt);// 既存エンティティへメインエンティティを上書きする。
				$mEnt['delete_flg'] = 0;
				$mEnt['update_user'] = $this->update_user;
				$mEnt['ip_addr'] = $this->ip_addr;
				
			}
			
			$mainData[$i] = $mEnt;
		}

		return $mainData;

	}
	
	/**
	 * XSSエスケープ（XSSサニタイズ）
	 *
	 * @note
	 * XSSサニタイズ
	 * 記号「<>」を「&lt;&gt;」にエスケープする。
	 * 高速化のため、引数は参照（ポインタ）にしており、返値もかねている。
	 *
	 * @param mixed $data 対象データ | 値および配列を指定
	 * @return void
	 */
	private function xss_escape(&$data){
		
		if(is_array($data)){
			foreach($data as &$val){
				$this->xss_escape($val);
			}
			unset($val);
		}elseif(gettype($data)=='string'){
			$data = str_replace(array('<','>'),array('&lt;','&gt;'),$data);
		}else{
			// 何もしない
		}
	}
	
	
	/**
	 * テーブルフィールドフィルター: テーブルに存在しないフィールドをデータから除去する
	 * @param string $table_name テーブル名
	 * @param array $data
	 */
	private function tableFieldFilter($table_name, $data){
		
		// テーブルからフィールド情報を取得する
		$res = $this->dao->sqlExe("SHOW FULL COLUMNS FROM {$table_name}");
		
		// フィールド情報からフィールド配列を取得する
		$fields = []; // フィールド配列
		foreach($res as $box){
			$field = $box['COLUMNS']['Field'];
			$fields[] = $field;
		}
		
		// テーブルに存在しないフィールドをデータから除去する
		$data2 = [];
		foreach($data as &$ent){
			$ent2 = [];
			foreach($ent as $field => $val){
				if(in_array($field, $fields)){
					$ent2[$field] = $val;
				}
			}
			$data2[] = $ent2;
		}
		unset($ent);
		
		return $data2;
		
	}
	
	
}