<?php

class PdoDao
{
	
	/**
	 * DAO(データベースアクセスオブジェクト）を取得する
	 * @return \dev_tool\model\PDO
	 */
	public function getDao(){
		
		require_once 'CrudBaseConfig.php';
		
		$cbf = new CrudBaseConfig();
		$dbConf = $cbf->getDbConfig();
		
		
		$dao = null;
		try {
			$dao = new PDO('mysql:host=localhost;dbname=uwatemp;charset=utf8',$dbConf['user'],$dbConf['pw'],
				array(PDO::ATTR_EMULATE_PREPARES => false));

		} catch (PDOException $e) {
			exit('データベース接続失敗。'.$e->getMessage());
			die;
		}

		return $dao;
	}
}

