<?php


/**
 * 汎用的なStaticメソッドを提供するクラス
 * @author kenji uehara
 * @license MIT
 * @since 2021-4-19
 *
 */
class CrudBaseU{
	
	/**
	 * CSRFトークンによるセキュリティチェック
	 * @return boolean true:無問題 , false:不正アクションを確認！
	 */
	public static function checkCsrfToken($page_code){
		
		// Ajaxによって送信されてきたCSRFトークンを取得。なければfalseを返す。
		$csrf_token = null;
		if(!empty($_POST['_token'])) $csrf_token = $_POST['_token'];
		
		if($csrf_token == null){
			if(!empty($_POST['csrf_token'])) $csrf_token = $_POST['csrf_token'];
		}
		
		if($csrf_token == null){
			if(!empty($_GET['_token'])) $csrf_token = $_GET['_token'];
		}
		
		if($csrf_token == null){
			if(!empty($_GET['csrf_token'])) $csrf_token = $_GET['csrf_token'];
		}
		
		if($csrf_token == null) return false;
		
		// セッションキーを組み立て
		$ses_key = $page_code . '_csrf_token';
		$ses_csrf_token = $_SESSION[$ses_key];

		if($csrf_token == $ses_csrf_token){
			return true;
		}
		
		return false;
	}
	
	
	/**
	 * CSRFトークンを取得
	 * セッションまわりの処理も行う。
	 * @return string CSRFトークン
	 */
	public static function getCsrfToken($page_code)
	{
		
		$ses_key = $page_code . '_csrf_token'; // セッションキーを組み立て
		$csrf_token = self::random();
		$_SESSION[$ses_key]  = $csrf_token;
		
		return $csrf_token;
	}
	
	
	private static function random($length = 8)
	{
		return base_convert(mt_rand(pow(36, $length - 1), pow(36, $length) - 1), 10, 36);
	}
	
	
	
}