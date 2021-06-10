<?php
App::uses('Model', 'Model');

/**
 * サインインXのモデル
 *
 * @since 2021-6-11
 * @version 1.0.0
 *
 */
class SigninX extends AppModel {

	public $name='SigninX';
	
	// 関連付けるテーブル
	public $useTable = 'users';

	public $validate = null;
	

	public function __construct() {
		parent::__construct();
		
	}
	



}