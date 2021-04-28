<?php
require_once CRUD_BASE_PATH . 'Signin.php';
App::uses('AppController', 'Controller');
/**
 * サインインXのコントローラ
 */
class SigninXController extends AppController {
	
	public $uses = ['SigninX', 'ConfigX'];
	
	// ■■■□□□■■■□□□
	//public $components = null;//ログイン認証不要
	
	
	public function beforeFilter() {
		// 未ログイン中である場合、未認証モードの扱いでページ表示する。
		if(empty($this->Auth->user())){
			$this->Auth->allow(); // 未認証モードとしてページ表示を許可する。
		}

		parent::beforeFilter();
		
	}

	
	/**
	 * step1:メールアドレス入力画面の初期表示
	 */
	public function index(){
		
		// CSRFトークンを取得
		if(empty($_SESSION)) session_start();
		$csrf_token = CrudBaseU::getCsrfToken('signin_x');

		$this->set([
			'title_for_layout'=>'サインイン',
			'header'=> 'header_plain',
			'csrf_token' => $csrf_token,
		]);
	}
	
	
	/**
	 * Ajax 仮登録アクション
	 * @return string
	 */
	public function tempRegAction(){
		$this->autoRender = false;//ビュー(ctp)を使わない。
		
		// 通信元から送信されてきたパラメータを取得する。
		$param_json = $_POST['key1'];
		$param = json_decode($param_json,true);//JSON文字を配列に戻す
		
		$signin = new Signin($this, $this->SigninX);
		$res = $signin->tempRegAction($param);
		
		// JSONに変換し、通信元に返す。
		$json_str = json_encode($res,JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS);
		return $json_str;
		
	}
	
	
	/**
	 * 本登録アクション 
	 */
	public function step2(){

		$signin = new Signin($this, $this->SigninX);
		$res = $signin->step2();
		
		$res['title_for_layout'] = 'サインイン';
		$res['header'] = 'header_plain';
		
		$this->set($res);
	}
	
	
	/**
	 * Ajax パスワード登録アクション
	 * @return string
	 */
	public function pwReg(){
		$this->autoRender = false;//ビュー(ctp)を使わない。

		// 通信元から送信されてきたパラメータを取得する。
		$param_json = $_POST['key1'];
		$param = json_decode($param_json,true);//JSON文字を配列に戻す
		
		$signin = new Signin($this, $this->SigninX);
		$res = $signin->pwReg($param);
		
		// パスワード登録に成功したら内部でログインする。（フォームなしログイン）
		if($res['success']){
			// 内ログイン
			$user_id = $res['user']['id'];
			$this->loginByInside($user_id);

		}
		
		// JSONに変換し、通信元に返す。
		$json_str = json_encode($res,JSON_HEX_TAG | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_HEX_APOS);
		return $json_str;
		
	}
	
	
	/**
	 * パスワード入力なしの自動ログイン（localhostのみ）
	 * @param int $user_id ユーザーID
	 * @return boolean true:ログイン成功, false:ログイン失敗
	 */
	private function loginByInside($user_id){

		// ユーザーエンティティ
		$user = $this->SigninX->find('first', [
			'conditions' => ['SigninX.id' => $user_id],
					'recursive' => -1
				]
			);
		
		
		// パスワードは削除
		unset($user['SigninX']['password']);
		
		// ログインする。
		if ($this->Auth->login($user['SigninX'])) {
			return true;
		}
		
		return false;
	}
	
	
	/**
	 * パスワード再発行・メール入力画面
	 */
	public function repw(){
		// CSRFトークンを取得
		if(empty($_SESSION)) session_start();
		$csrf_token = CrudBaseU::getCsrfToken('signin_x');
		
		$this->set([
			'title_for_layout'=>'サインイン',
			'header'=> 'header_plain',
			'csrf_token' => $csrf_token,
		]);
	}
	
	




}