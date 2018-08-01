<?php

require_once 'FileUploadBase.php';
require_once 'UploadFileValidation.php';
require_once 'ImgFileUpload.php';

/**
 * ファイルアップロードクラス
 * 
 * @note
 * 「<input type = 'file'>」であるファイルアップロードのフォーム要素から送られてきたファイルデータを指定場所に保存する。
 * ファイルチェックや、画像形式ならサムネイル画像作成も行う。
 * 
 * @date 2018-6-30
 * @version 1.0
 * @history
 * 2018-6-30 開発開始
 */
class FileUploadK{
	
	
	public $composit; // FileUploadBaseを継承した各種ファイルアップロードクラスのインスタンス
	
	/**
	 * コンストラクタ
	 * @param array $files $_FILES
	 * @param array $param パラメータ
	 * @parma FileUploadBase $composit 各種ファイルアップロードクラス
	 */
	public function __construct($files = array(),$param = array(),FileUploadBase $composit = null){
		
		
		// コンポジットが空であるなら、画像ファイルアップロードクラスをセット
		if($composit == null){
			$composit = new ImgFileUpload($files,$param);
		}
		$this->composit = $composit;

		
	}
	
	
	/**
	 * 一括作業
	 * @param array $files $_FILES
	 * @param array $param パラメータ
	 * - suppData 補足データ（Supplementary Data | 補足エンティティの配列 | 省略可）
	 *    構造 suppData = [{'wamei','mime_check_flg'},{...}];
	 *    補足エンティティ
	 *     - wamei:和名   エラーメッセージなどに用いる
	 *     - mime_check_flg: MIMEチェックフラグ: 0:MIMEチェックしない    1（デフォルト):MIMEチェックを行う
	 *
	 * @return $res
	 *  - errs エラーリスト
	 *
	 * @note
	 *  補足データ(suppData)の構造
	 *  suppData = [{'wamei','mime_check_flg'},{...}];
	 */
	public function workAllAtOnce($files = array(),$param = array()){
		return $this->composit->workAllAtOnce($files,$param);
	}
	
	/**
	 * ファイルチェック
	 */
	public function checkFile(){
		return $this->composit->checkFile();
	}
	
	/**
	 * ファイル情報を取得
	 */
	public function getFileInfo(){
		return $this->composit->getFileInfo();
	}
	
	/**
	 *  ファイル配置
	 */
	public function putFile(){
		return $this->composit->putFile();
	}
	
	/**
	 * コンポジットのセッター
	 * @param FileUploadBase $composit 各ファイルアップロードクラス（コンポジット）
	 */
	public function setComposit(FileUploadBase $composit){
		$this->composit = $composit;
	}
	
	/**
	 * ファイルデータのセッター
	 * @param array $files $_FILES
	 */
	public function setFiles($files){
		$this->composit->setFiles($files);
	}
	
	/**
	 * パラメータのセッター
	 * @param array $param
	 */
	public function setParam($param){
		$this->composit->setParam($param);
	}
}