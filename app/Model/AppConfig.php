<?php
App::uses('AppModel', 'Model');

/**
 * アプリ設定のCakePHPモデルクラス
 *
 * @date 2019-5-28
 * @version 1.0.0
 *
 */
class AppConfig extends AppModel {

	public $name='AppConfig';
	
	// 関連付けるテーブル CBBXS-1040
	public $useTable = 'app_configs';

	/// バリデーションはコントローラクラスで定義
	public $validate = null;
	
	
	public function __construct() {
		parent::__construct();
	}
	
	/**
	 * アプリ設定からコードに紐づく数値を取得する
	 * @param string $key_code キーコード
	 * @return int 数値
	 */
	public function getVal1($key_code){

		$conditions = "key_code='{$key_code}'";

		//DBからデータを取得
		$ent = $this->find(
				'first',
				Array(
						'conditions' => $conditions,
				)
		);
		
		$val1 = null;
		if(!empty($ent)) $val1 = $ent['AppConfig']['val1'];
		
		return $val1;
	}
	
	/**
	 * コードに紐づく数値をアプリ設定テーブルへ保存する
	 * @param string $key_code キーコード
	 * @param int $val1 数値
	 */
	public function saveVal1($key_code, $val1){

		//DBからデータを取得
		$conditions = "key_code='{$key_code}'";
		$ent = $this->find('first',['conditions' => $conditions]);
		
		if(empty($ent)) $ent = ['key_code'=>$key_code];
		$ent['AppConfig']['val1'] = $val1;
		
		$this->save($ent);
		
	}

}