<?php
class ImgFileUpload extends FileUploadBase{

	/**
	 * 一括作業
	 * @param array $files $_FILES
	 * @param array $param パラメータ
	 */
	public function workAllAtOnce($files = null,$param = null){
		
		// ファイルチェック
		$errs = $this->checkFile();
	}
	
	/**
	 * ファイルチェック
	 */
	public function checkFile(){
		// アップロードファイルのバリデーションを行い、エラーがあればエラーリストに追加する。
		$upFileValid = new UploadFileValidation();
		
		var_dump('test=');//■■■□□□■■■□□□■■■□□□)
// 		$uf_err = $upFileValid->checkFiles($_FILES,array('png','jpg','jpeg'),array('image/png','image/jpeg'),'背景画像ファイル');
// 		if(!empty($uf_err)){
// 			$errs = array_merge($errs,$uf_err);
// 		}
	}
	
	/**
	 * ファイル情報を取得
	 */
	public function getFileInfo(){
		
	}
	
	/**
	 *  ファイル配置
	 */
	public function putFile(){
		
	}
}