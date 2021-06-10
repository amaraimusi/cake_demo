<?php
App::uses('AppController', 'Controller');

/**
 * 管理者トップ
 * 
 * @since 2021-6-11
 *
 */
class PagesController extends AppController {
	public $name = 'Pages';
	public $uses = false;
	public $components=null;//ログイン認証不要
	public $logout_flg=false;//ログアウトリンクを非表示

    public function index() {
    	$this->autoRender = false;//ビューを使わない。
    	$home_url = $this->webroot . '?a=1';
    	echo 'Logout.<br>';
    	echo "<a href='{$home_url}'>To system home.</a>";
    }


}