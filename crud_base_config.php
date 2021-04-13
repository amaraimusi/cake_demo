<?php
/**
 * CrudBase設定ファイル
 *
 * @version 2.0
 * @date 2020-4-13 crud_base_const.phpとCrudBaseConfig.phpを統合してcrud_base_config.phpを作成
 * @date 2016-2-5 新規作成
 *
 */
global $crudBaseConfig;


// 値種別定数    この定数を主に利用しているファイルと関数 → 「app/View/Helper/AppHelper.php : ent_show_x」
define('CB_FLD_SANITAIZE','1'); // サニタイズ
define('CB_FLD_MONEY','2'); // 金額表記
define('CB_FLD_DELETE_FLG','3'); // 有無フラグ
define('CB_FLD_BR','4'); // 改行brタグ化
define('CB_FLD_BOUTOU','5'); // 長文字の冒頭
define('CB_FLD_TEXTAREA','6'); // テキストエリア用（改行対応）
define('CB_FLD_NULL_ZERO','7');// nullは0表記
define('CB_FLD_TA_CSV','8');// テキストエリアCSV出力用


$crud_base_root = dirname(__FILE__) . '/';
$crud_base_app_path = $crud_base_root . 'app/';
$crud_base_path = $crud_base_app_path . 'Vendor/CrudBase/';
$project_path = '/cake_demo'; // 例：「/animal/mng」

$CRUD_BASE_JS = "{$project_path}/js/CrudBase/dist/CrudBase.min.js";
$CRUD_BASE_CSS = "{$project_path}/css/CrudBase/dist/CrudBase.min.css";
define('CRUD_BASE_ROOT',$crud_base_root);// テキストエリアCSV出力用
define('CRUD_BASE_APP_PATH',$crud_base_app_path);
define('CRUD_BASE_PROJECT_PATH',$project_path);
define('CRUD_BASE_PATH',$crud_base_path);
define('CRUD_BASE_JS',$CRUD_BASE_JS);
define('CRUD_BASE_CSS',$CRUD_BASE_CSS);


$crudBaseConfig = [
	'fw_type'=>'cake_php',
	'env'=>'localhost', // 環境種別 localhost, amaraimusi, product
	
	'crud_base_root'=>CRUD_BASE_ROOT, // プロジェクトのルートパス（絶対パス）
	'crud_base_app_path'=>CRUD_BASE_APP_PATH, // appディレクトリの絶対パス
	'crud_base_project_path'=>CRUD_BASE_PROJECT_PATH, // プロジェクト名もしくはプロジェクトの相対パス→（例: animal_park/public)
	'crud_base_path'=>CRUD_BASE_PATH, // Vendor側のCrudBaseライブラリへの絶対パス
	'crud_base_js'=>CRUD_BASE_JS, // jsのCrudBaseライブラリパス（相対パス）
	'crud_base_css'=>CRUD_BASE_CSS, // cssのCrudBaseライブラリパス（相対パス）
];

// DB設定情報を取得する
$crudBaseConfig['dbConfig'] = getDbConfigForCrudBase($crudBaseConfig['env']);

/**
 * DB設定
 * @return string[] DB設定情報
 */
function getDbConfigForCrudBase($env = null){
	
	if($env == null){
		global $crudBaseConfig;
		$env = $crudBaseConfig['env'];
	}
	
	switch ($env){
		case 'localhost':
			$dbConfig = [
				'host'=>'localhost',
				'db_name'=>'cake_demo',
				'user'=>'root',
				'pw'=>'',
			];
			break;

		default:
			throw new Error("DB設定の不備 env={$env}");
			break;
		
	}
	
	return $dbConfig;
}



/**
 * ログB
 * @param mixed $val
 */
function logB($val){
	if(is_array($val)){
		error_log(print_r($val, true), 3, 'log_b.log');
	}else{
		error_log($val, 3, 'log_b.log');
	}
	error_log("\n", 3, 'log_b.log');
}
