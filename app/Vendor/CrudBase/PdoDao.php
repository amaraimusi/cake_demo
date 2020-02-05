<?php
require_once 'IDao.php';
/**
 * PDOのDAO（データベースアクセスオブジェクト）
 * 
 * @date 2019-10-26
 * @version 1.0.0
 * @license MIT
 * @author Kenji Uehara
 *
 */
class PdoDao implements IDao
{
	
	var $dao;
	
	/**
	 * DAO(データベースアクセスオブジェクト）を取得する
	 * @return \dev_tool\model\PDO
	 */
	public function getDao(){
		
		if($this->dao) return $this->dao;
		
		require_once 'CrudBaseConfig.php';
		
		$cbf = new CrudBaseConfig();
		$dbConf = $cbf->getDbConfig();

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
	
	public function sqlExe($sql){
		$dao = $this->getDao();
		$stmt = $dao->query($sql);
		if($stmt === false) {
			debug('SQLエラー→' . $sql);
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

