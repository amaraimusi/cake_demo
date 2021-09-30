<?php
require_once 'IDao.php';

/**
 * PDOのDAO（データベースアクセスオブジェクト）
 * 
 * @date 2019-10-26 | 2021-7-28
 * @version 1.2.1
 * @license MIT
 * @author Kenji Uehara
 *
 */
class PdoDao implements IDao
{
	
	var $dao;
	
	/**
	 * DAO(データベースアクセスオブジェクト）を取得する
	 * @param [] $dbConf
	 *  - host
	 *  - db_name
	 *  - user
	 *  - pw
	 * @return object Dao
	 */
	public function getDao($dbConf=[]){
		
		if($this->dao) return $this->dao;
		
		if(empty($dbConf)){
			global $crudBaseConfig;
			$dbConf = $crudBaseConfig['dbConfig'];
		}

		try {
			$dao = new PDO("mysql:host={$dbConf['host']};dbname={$dbConf['db_name']};charset=utf8",$dbConf['user'],$dbConf['pw'],
				array(PDO::ATTR_EMULATE_PREPARES => false));

		} catch (PDOException $e) {
			exit('データベース接続失敗。'.$e->getMessage());
			die;
		}
		
		$this->dao = $dao;

		return $dao;
	}
	
	/**
	 * SQLを実行してデータを取得する
	 * @return boolean|PDOStatement[][]
	 */
	public function getData($sql){
		$dao = $this->getDao();
		$stmt = $dao->query($sql);
		if($stmt === false) {
			var_dump('SQLエラー→' . $sql);
			return false;
		}
		
		$data = [];
		foreach ($stmt as $row) {
			$ent = [];
			foreach($row as $key => $value){
				if(!is_numeric($key)){
					$ent[$key] = $value;
				}
			}
			$data[] = $ent;
		}
		
		return $data;
	}
	
	/**
	 * 単純なクエリー実行（SELECT用ではない）
	 * @param string $sql
	 * {@inheritDoc}
	 * @see IDao::sqlExe()
	 */
	public function sqlExe($sql){
		return $this->dao->query($sql);
	}
	
	/**
	 * 単純なクエリー実行（SELECT用ではない）
	 * @param string $sql
	 * @return string エラーメッセージ
	 */
	public function query($sql){
		$err_msg = '';
		$res = $this->dao->query($sql);
		if($res === false){
			$errInfo = $this->dao->errorInfo();
			$err_msg = "
				<pre>
					SQLエラー→{$sql}
					$errInfo[0]
					$errInfo[1]
					$errInfo[2]
				</pre>
			";
			var_dump($err_msg);
		}
		return $err_msg;
	}
	
	
	
	public function begin(){
		$dao = $this->getDao();
		$stmt = $dao->query('BEGIN');
	}
	
	public function rollback(){
		$dao = $this->getDao();
		$stmt = $dao->query('ROLLBACK');

	}
	
	public function commit(){
		$dao = $this->getDao();
		$stmt = $dao->query('COMMIT');

	}
}

