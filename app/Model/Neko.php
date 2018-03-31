<?php
App::uses('Model', 'Model');
App::uses('CrudBase', 'Model');

/**
 * ネコのモデルクラス
 *
 * ネコ画面用のDB関連メソッドを定義しています。
 * ネコテーブルと関連付けられています。
 *
 * @date 2015-9-16	新規作成
 * @author k-uehara
 *
 */
class Neko extends AppModel {


	/// ネコテーブルを関連付け
	public $name='Neko';


	/// バリデーションはコントローラクラスで定義
	public $validate = null;
	
	/**
	 * ネコエンティティを取得
	 *
	 * ネコテーブルからidに紐づくエンティティを取得します。
	 *
	 * @param int $id ネコID
	 * @return array ネコエンティティ
	 */
	public function findEntity($id){

		$conditions='id = '.$id;

		//DBからデータを取得
		$data = $this->find(
				'first',
				Array(
						'conditions' => $conditions,
				)
		);

		$ent=array();
		if(!empty($data)){
			$ent=$data['Neko'];
		}
		



		return $ent;
	}

	/**
	 * ネコ画面の一覧に表示するデータを、ネコテーブルから取得します。
	 * 
	 * @note
	 * 検索条件、ページ番号、表示件数、ソート情報からDB（ネコテーブル）を検索し、
	 * 一覧に表示するデータを取得します。
	 * 
	 * @param array $kjs 検索条件情報
	 * @param int $page_no ページ番号
	 * @param int $row_limit 表示件数
	 * @param string sort ソートフィールド
	 * @param int sort_desc ソートタイプ 0:昇順 , 1:降順
	 * @return array ネコ画面一覧のデータ
	 */
	public function findData($kjs,$page_no,$row_limit,$sort_field,$sort_desc){

		//条件を作成
		$conditions=$this->createKjConditions($kjs);
		
		// オフセットの組み立て
		$offset=null;
		if(!empty($row_limit)) $offset = $page_no * $row_limit;
		
		// ORDER文の組み立て
		$order = $sort_field;
		if(empty($order)) $order='sort_no';
		if(!empty($sort_desc)) $order .= ' DESC';
		
		$option=array(
            'conditions' => $conditions,
            'limit' =>$row_limit,
            'offset'=>$offset,
            'order' => $order,
        );
		
		//DBからデータを取得
		$data = $this->find('all',$option);

		//データ構造を変換（2次元配列化）
		$data2=array();
		foreach($data as $i=>$tbl){
			foreach($tbl as $ent){
				foreach($ent as $key => $v){
					$data2[$i][$key]=$v;
				}
			}
		}
		
		return $data2;
	}
	
	
	/**
	 * 一覧データを取得する
	 */
	public function findData2(&$crudBaseData){

		$kjs = $crudBaseData['kjs'];//検索条件情報
		$pages = $crudBaseData['pages'];//ページネーション情報

		$data = $this->findData($kjs,$pages['page_no'],$pages['row_limit'],$pages['sort_field'],$pages['sort_desc']);
		
		return $data;
	}

	
	
	/**
	 * SQLのダンプ
	 * @param  $option
	 */
	private function dumpSql($option){
		$dbo = $this->getDataSource();
		
		$option['table']=$dbo->fullTableName($this->Neko);
		$option['alias']='Neko';
		
		$query = $dbo->buildStatement($option,$this->Neko);
		
		Debugger::dump($query);
	}



	/**
	 * 検索条件情報からWHERE情報を作成。
	 * @param array $kjs	検索条件情報
	 * @return string WHERE情報
	 */
	private function createKjConditions($kjs){

		$cnds=null;
		
		// --- Start kjConditions
		
		if(!empty($kjs['kj_id'])){
			$cnds[]="Neko.id = {$kjs['kj_id']}";
		}
		
		if(!empty($kjs['kj_neko_val1'])){
			$cnds[]="Neko.neko_val >= {$kjs['kj_neko_val1']}";
		}
		
		if(!empty($kjs['kj_neko_val2'])){
			$cnds[]="Neko.neko_val <= {$kjs['kj_neko_val2']}";
		}
		
		if(!empty($kjs['kj_neko_name'])){
			$cnds[]="Neko.neko_name LIKE '%{$kjs['kj_neko_name']}%'";
		}
		
		if(!empty($kjs['kj_neko_date1'])){
			$cnds[]="Neko.neko_date >= '{$kjs['kj_neko_date1']}'";
		}
		
		if(!empty($kjs['kj_neko_date2'])){
			$cnds[]="Neko.neko_date <= '{$kjs['kj_neko_date2']}'";
		}
		
		if(!empty($kjs['kj_neko_group'])){
			$cnds[]="Neko.neko_group = {$kjs['kj_neko_group']}";
		}
		
		if(!empty($kjs['kj_neko_dt'])){
		    
		    if(empty($this->CrudBase)) $this->CrudBase = new CrudBase();
		    $kj_neko_dt = $kjs['kj_neko_dt'];
		    $dtInfo = $this->CrudBase->guessDatetimeInfo($kj_neko_dt);
		    $cnds[]="DATE_FORMAT(Neko.neko_dt,'{$dtInfo['format_mysql_a']}') = DATE_FORMAT('{$dtInfo['datetime_b']}','{$dtInfo['format_mysql_a']}')";
		   
		}

		if(!empty($kjs['kj_note'])){
			$cnds[]="Neko.note LIKE '%{$kjs['kj_note']}%'";
		}
		
		if(!empty($kjs['kj_sort_no']) || $kjs['kj_sort_no'] ==='0' || $kjs['kj_sort_no'] ===0){
			$cnds[]="Neko.sort_no = {$kjs['kj_sort_no']}";
		}
		
		$kj_delete_flg = $kjs['kj_delete_flg'];
		if(!empty($kjs['kj_delete_flg']) || $kjs['kj_delete_flg'] ==='0' || $kjs['kj_delete_flg'] ===0){
			if($kjs['kj_delete_flg'] != -1){
			   $cnds[]="Neko.delete_flg = {$kjs['kj_delete_flg']}";
			}
		}

		if(!empty($kjs['kj_update_user'])){
			$cnds[]="Neko.update_user = '{$kjs['kj_update_user']}'";
		}

		if(!empty($kjs['kj_ip_addr'])){
			$cnds[]="Neko.ip_addr = '{$kjs['kj_ip_addr']}'";
		}
		
		if(!empty($kjs['kj_user_agent'])){
			$cnds[]="Neko.user_agent LIKE '%{$kjs['kj_user_agent']}%'";
		}

		if(!empty($kjs['kj_created'])){
			$kj_created=$kjs['kj_created'].' 00:00:00';
			$cnds[]="Neko.created >= '{$kj_created}'";
		}
		
		if(!empty($kjs['kj_modified'])){
			$kj_modified=$kjs['kj_modified'].' 00:00:00';
			$cnds[]="Neko.modified >= '{$kj_modified}'";
		}
		
		// --- End kjConditions
		
		$cnd=null;
		if(!empty($cnds)){
			$cnd=implode(' AND ',$cnds);
		}

		return $cnd;

	}

	/**
	 * エンティティをDB保存
	 *
	 * ネコエンティティをネコテーブルに保存します。
	 *
	 * @param array $ent ネコエンティティ
	 * @return array ネコエンティティ（saveメソッドのレスポンス）
	 */
	public function saveEntity($ent){

		//DBに登録('atomic' => false　トランザクションなし）
		$ent = $this->save($ent, array('atomic' => false,'validate'=>false));

		//DBからエンティティを取得
		$ent = $this->find('first',
				array(
						'conditions' => "id={$ent['Neko']['id']}"
				));

		$ent=$ent['Neko'];
		if(empty($ent['delete_flg'])) $ent['delete_flg'] = 0;

		return $ent;
	}




	/**
	 * 全データ件数を取得
	 *
	 * limitによる制限をとりはらった、検索条件に紐づく件数を取得します。
	 *  全データ件数はページネーション生成のために使われています。
	 *
	 * @param array $kjs 検索条件情報
	 * @return int 全データ件数
	 */
	public function findDataCnt($kjs){

		//DBから取得するフィールド
		$fields=array('COUNT(id) AS cnt');
		$conditions=$this->createKjConditions($kjs);

		//DBからデータを取得
		$data = $this->find(
				'first',
				Array(
						'fields'=>$fields,
						'conditions' => $conditions,
				)
		);

		$cnt=$data[0]['cnt'];
		return $cnt;
	}
	
	// ■■■□□□■■■□□□■■■□□□
// 	/**
// 	 * 文字列から適切な日時のフォーマットを取得する
// 	 *
// 	 * @param string $str 日付文字列
// 	 * @param $format =  string フォーマット
// 	 * @param $option
// 	 *  - time＿priority 時刻優先フラグ    0:日付フォーマットを優先取得 , 1:時刻フォーマットを優先取得
// 	 *  - mysql_format_flg MySQLフォーマットフラグ 0:PHP型の日時フォーマット , 1:MySQL型の日時フォーマット
// 	 */
// 	protected function getDateFormatFromString($str,$option=array()){
	    
// 	    $time＿priority = 0;
// 	    if(!empty($option['time＿priority'])) $time＿priority = $option['time＿priority'];
	    
// 	    $mysql_format_flg = 0;
// 	    if(!empty($option['mysql_format_flg'])) $mysql_format_flg = $option['mysql_format_flg'];
	    
// 	    debug('$str＝'.$str);//■■■□□□■■■□□□■■■□□□)
	    
// 	    $format = '';
	    
// 	    if(preg_match('/^\d+$/', $str)){
	        
// 	        $len = strlen($str);
// 	        if($len == 14){
// 	            $format =  'Y-m-d H:i:s';
// 	        }else if($len == 8){
// 	            $format =  'Y-m-d';
// 	        }else if($len == 6){
// 	            if($time＿priority == 0){
// 	                $format =  'Y-m-d';
// 	            }else{
// 	                $format =  'H:i:s';
// 	            }
	            
// 	        }else if($len == 4){
// 	            if($time＿priority == 0){
// 	                if(preg_match('/^20\d[2](\/|-)([0-9]{1,2})/', $str)){
// 	                    $format =  'Y';
// 	                }else{
// 	                    $format =  'm-d';
// 	                }
// 	            }else{
// 	                $format =  'H:i';
// 	            }
// 	        }else if($len == 1 || $len == 2){
// 	            if($time＿priority == 0){
// 	                $format =  'd';
// 	            }else{
// 	                $format =  'h';
// 	            }
// 	        }
// 	    }
// 	    else if(preg_match('/^20\d[2](\/|-)([0-9]{1,2})(\/|-)([0-9]{1,2}) ([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2})/', $str)){
// 	        debug('test=A2');//■■■□□□■■■□□□■■■□□□)
// 	        $format =  'Y-m-d H:i:s';
// 	    }
// 	    else if(preg_match('/^20\d[2](\/|-)([0-9]{1,2})(\/|-)([0-9]{1,2}) ([0-9]{1,2}):([0-9]{1,2})/', $str)){
// 	        debug('test=A2ー1');//■■■□□□■■■□□□■■■□□□)
// 	        $format =  'Y-m-d H:i';
// 	    }
// 	    else if(preg_match('/^20\d[2](\/|-)([0-9]{1,2})(\/|-)([0-9]{1,2}) ([0-9]{1,2})/', $str)){
// 	        $format =  'Y-m-d H';
// 	    }
// 	    else if(preg_match('/^20\d[2](\/|-)([0-9]{1,2})(\/|-)([0-9]{1,2})/', $str)){
// 	        $format =  'Y-m-d';
// 	    }
// 	    else if(preg_match('/^20\d[2](\/|-)([0-9]{1,2})/', $str)){
// 	        $format =  'Y-m';
// 	    }
// 	    else if(preg_match('/^20\d[2]/', $str)){
// 	        $format =  'Y';
// 	    }
// 	    else if(preg_match('/([0-9]{1,2})(\/|-)([0-9]{1,2})/', $str)){
// 	        debug('test=A2－２');//■■■□□□■■■□□□■■■□□□)
// 	        $format =  'm-d';
// 	    }
// 	    else if(preg_match('/([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2})/', $str)){
// 	        $format =  'H:i:s';
// 	    }
// 	    else if(preg_match('/([0-9]{1,2}):([0-9]{1,2})/', $str)){
// 	        $format =  'H:i';
// 	    }
	    
	    
// 	    if(!empty($mysql_format_flg) && !empty($format)){
// 	        $format2='';
// 	        $ary = str_split($format);
// 	        for($i=0;$i<count($ary);$i++){
// 	            if($i % 2==0){
// 	                $format2 .= '%' . $ary[$i];
// 	            }else{
// 	                $format2 .= $ary[$i];
// 	            }
// 	        }
// 	        $format = $format2;
// 	    }
// 	    debug('$format='.$format);//■■■□□□■■■□□□■■■□□□)
// 	    return $format;
	    
// 	}
	
	
// 	/**
// 	 * 文字列から適切な日時のフォーマットを取得する
// 	 *
// 	 * @param string $str 日付文字列
// 	 * @param $option
// 	 *  - time＿priority 時刻優先フラグ    0:日付フォーマットを優先取得 , 1:時刻フォーマットを優先取得
// 	 * @return string フォーマット
// 	 */
// 	protected function convNumStr2date($str,$option = array()){
	    
// 	    if(empty($str)) return $str;
// 	    if(!preg_match('/^\d+$/', $str)) return null;
	    
// 	    $ary = str_split($str, 2);
// 	    $len = strlen($str);
// 	    if($len == 14){
	        
// 	        // Y-m-d H:i:s
// 	        return "{$ary[0]}{$ary[1]}-{$ary[2]}-{$ary[3]} {$ary[4]}:{$ary[5]}:{$ary[6]}";
// 	    }else if($len == 8){
// 	        // Y-m-d
// 	        return "{$ary[0]}{$ary[1]}-{$ary[2]}-{$ary[3]}";
	        
	        
// 	    }else if($len == 6){
// 	        if($time＿priority == 0){
// 	            if(preg_match('/^20\d[2](\/|-)([0-9]{1,2})/', $str)){
// 	                // Y-m-d
// 	                return "{$ary[0]}{$ary[1]}-{$ary[2]}";
// 	            }else{
// 	                // Y-m-d
// 	                return "20{$ary[0]}-{$ary[1]}-{$ary[2]}";
// 	            }
// 	        }else{
// 	            // H:i:s
// 	            return "{$ary[0]}:{$ary[1]}:{$ary[2]}";
// 	        }
	        
// 	    }else if($len == 4){
// 	        if($time＿priority == 0){
// 	            if(preg_match('/^20/', $str)){
// 	                // Y
// 	                return "{$ary[0]}{$ary[1]}";
// 	            }else{
// 	                // m-d
// 	                return "{$ary[0]}-{$ary[1]}";
// 	            }
// 	        }else{
// 	            // H:i
// 	            return "{$ary[0]}:{$ary[1]}:00";
// 	        }
// 	    }else if($len == 1 || $len == 2){
// 	        if($time＿priority == 0){
// 	            return "{$ary[0]}";
// 	        }else{
// 	            return "{$ary[0]}:00:00";
// 	        }
// 	    }
	    
	    
// 	    return null;
// 	}


}