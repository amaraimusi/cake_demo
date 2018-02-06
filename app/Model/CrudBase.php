<?php
App::uses('Model', 'Model');

/**
 * 基本CRUD用のモデルクラス
 * 
 * 
 * 
 * @date 2016-1-21	新規作成
 * @author k-uehara
 *
 */
class CrudBase extends Model {

	///データベースのテーブルを使用しない
	public $useTable = false; 

	/// バリデーションなし
	public $validate = null;



	
	/**
	 * 列並替アクティブデータの昇順ソートと構造変換を行う。
	 * 
	 *  列並替アクティブデータはフィールデータに含まれており、現在の列並び状態を表す。
	 * 
	 * @param array $active	列並替アクティブデータ
	 * @return 列並替アクティブ(昇順ソート適用、構造変換後）
	 */
	public function sortAndCombine($active){
	
		//構造変換
		$data=array();
		foreach($active as $id=>$ent){
			$ent['id']=$id;
			$data[]=$ent;
		}
	
		//列並番号でデータを並び替える
		$sorts=Hash::extract($data, '{n}.clm_sort_no');
		array_multisort($sorts,SORT_ASC,$data);
	
		return $data;
	}
	
	
	/**
	 * フィールドデータが空でなければ、フィールドデータから一覧列情報を作成する。
	 * @param array $field_data フィールドデータ
	 * @return array 一覧列情報
	 */
	public function makeTableFieldFromFieldData($field_data){
		$fields=array();
		$clms=$field_data['active'];
	
		foreach($clms as $clm){
			$row_order = $clm['row_order'];
			$name = $clm['name'];
			$fields[$row_order] = $name;
		}
	
		return $fields;
	}
	
	/**
	 * nullでないかチェック(フラグ用）
	 *
	 * @note
	 * false : null,空文字,未セット
	 * true : TRUE系値,0,false
	 * @param array $kjs
	 * @param string $field
	 * @return boolean
	 */
	protected function isnotNull($kjs,$field){
		if(isset($kjs[$field])){
			if(empty($kjs[$field])){
				if($kjs[$field] ==='0' || $kjs[$field] ===0 || $kjs[$field] ===false){
					return true;
				}else{
					return false;
				}
			}else{
				return true;
			}
		}else{
			return false;
		}
	}

}