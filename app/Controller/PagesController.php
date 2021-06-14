<?php
App::uses('AppController', 'Controller');

/**
 * Pages
 * 
 * @version 3.0
 * @since 2014-8-21 | 2021-6-14
 * @author k-uehara
 *
 */
class PagesController extends AppController {
	public $name = 'Pages';
	public $uses = false;
	//public $components=null;//ログイン認証不要
	public $logout_flg=false;//ログアウトリンクを非表示
	
	public function beforeFilter() {
		
		// 未ログイン中である場合、未認証モードの扱いでページ表示する。
		if($this->login_flg == 0 && empty($this->Auth->user())){
			$this->Auth->allow(); // 未認証モードとしてページ表示を許可する。
		}
		
		parent::beforeFilter();
		
	}

	public function index() {
		//$userInfo = $this->Auth->user();
		$userInfo = $this->getUserInfo();
		
		
		$err = '';
		if(empty($userInfo['id'])){
			$err = 'ログインされてません。';
		}else{
			
			$role_level = $userInfo['authority']['level'];
			if($role_level < 0){
				$err = 'ログインできません。';
			}
		}
		
		$this->set(['err'=>$err]);
		
	}


}