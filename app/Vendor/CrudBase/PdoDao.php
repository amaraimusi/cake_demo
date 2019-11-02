<?php

/**
 * PDOのDAO（データベースアクセスオブジェクト）
 * 
 * @date 2019-10-26
 * @version 1.0.0
 * @license MIT
 * @author Kenji Uehara
 *
 */
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

		try {
			$dao = new PDO("mysql:host=localhost;dbname={$dbConf['db_name']};charset=utf8",$dbConf['user'],$dbConf['pw'],
				array(PDO::ATTR_EMULATE_PREPARES => false));

		} catch (PDOException $e) {
			exit('データベース接続失敗。'.$e->getMessage());
			die;
		}

		return $dao;
	}
}

