<?php

/**
 * ページネーション制御クラス
 * 
 * ページネーションの目次や列名ソートに必要な情報を作成します。
 * 
 * Cake PHP用であるが、ネイティブのPHPにも使用可能です。
 *
 * ◇主な機能
 * - DB検索に必要なLIMIT,ORDER BYを生成する。
 * - ページネーション情報としてページ目次、ソート用リンク、データ件数等を出力する。
 * 
 * @author k-uehara
 * @version 1.4
 * @date 前へリンクと戻りリンクを取得
 *
 */
class PagenationForCake{

	///リクエスト情報
	var $m_reqs;



	/**
	 * DB検索に必要なLIMIT,ORDER BYを検索オプション情報として取得
	 *
	 * @param  array $req GETリクエストなど(page_no,limit,sort,sort_typeを利用する)
	 * @return array $data 検索オプション情報
	 *
	 * ◇検索オプション情報
	 * - $data['find_limit'] SQLのlimitの部分。例:'10,12'
	 * - $data['find_order'] SQLのorder部分。例：'title desc'
	 */
	public function createLimitAndOrder($req){

		//リクエストからデータを取得。サニタイズや空ならデフォルト値のセットも行う。
		$data=$this->_getDataFromRequest($req);

		//メンバにセット
		$this->m_reqs=$data;

		//find用のlimitとorderを作成する。
		$rtn['find_limit']=$this->_createFindLimit($data['page_no'],$data['limit']);


		//find用のorderを作成する。
		$rtn['find_order']=$this->_createFindOrder($data['sort'],$data['sort_type']);

		return $rtn;

	}

	/**
	 *
	 * ページネーション関連のデータを取得する
	 * 
	 * @param  int $allDataCnt	データ件数（limitをかけていない、検索条件を含めたデータの件数）
	 * @param  string $path			基本的なURLを指定。例:「proj/list.php」。
	 * @param  array $params		ページ関連外のその他のパラメータをURLに付加する場合。例：「array('xxx'=>'1','flg',true)」
	 * @param  array $fields		HTMLテーブルのキーはDBフィールド、値はフィールド和名にする。例：「array('title'=>'タイトル')」
	 * @param  array $kjs           検索条件情報
	 * @return array $data ページネーションデータ
	 *
	 * ◇ページネーションデータの中身
	 * - $data['page_index_html'] ページ目次を生成するHTML
	 * - $data['page_prev_link'] 前へリンク
	 * - $data['page_next_link'] 戻りリンク
	 * - $data['sorts'][フィールド名] HTMLテーブルをソートするリンク
	 * - $data['page_no'] 現在ページ番号
	 * - $data['all_data_cnt'] 検索データ件数
	 * - $data['all_page_cnt'] ページ数
	 */
	public function createPagenationData($allDataCnt,$path,$params,$fields,$kjs){

	    // 検索条件ＵＲＬクエリを生成する。
	    $kjs_uq = $this->createKjsUrlQuery($kjs);
	    
		//　ソートＵＲＬリンクHTMLのリストを生成する。
	    $sorts=$this->_createSorts2($allDataCnt,$path,$params,$fields,$kjs_uq);
		
		//　ページ目次用のHTMLコードを生成する。
	    $res = $this->_createIndexHtml2($allDataCnt,$path,$params,$kjs_uq);

		$rtn['page_index_html'] = $res['mokuji'];;
		$rtn['page_prev_link'] = $res['page_prev_link'];
		$rtn['page_next_link'] = $res['page_next_link'];
		$rtn['sorts']=$sorts;
		$rtn['page_no']=$this->m_reqs['page_no'];//現在ページ
		$rtn['all_data_cnt']=$allDataCnt;//全データ数
		if(isset($this->m_reqs['limit'])){
			$rtn['all_page_cnt']=ceil($rtn['all_data_cnt'] / $this->m_reqs['limit']);//全ページ数
			$rtn['limit'] = $this->m_reqs['limit'];
		}else{
			$rtn['all_page_cnt']=1;
			$rtn['limit'] = $rtn['all_data_cnt'];
		}
		$rtn['sort'] = $this->m_reqs['sort'];
		$rtn['sort_type'] = $this->m_reqs['sort_type'];

		return $rtn;
	}
	
	/**
	 * 検索条件ＵＲＬクエリを生成する。
	 * @param  array $kjs 検索条件情報
	 * @return string 検索条件ＵＲＬクエリ
	 */
	private function createKjsUrlQuery($kjs){
	    
	    $str = "";
	    foreach($kjs as $field => $value){
	        if($value !== "" && $value !==null){
	            if($str != ""){
	                $str .= '&';
	            }
	            $value = urlencode($value);// URLエンコード
	            $str .= $field . "=" . $value;
	        }
	    }
	    
	    return $str;
	}
	
	//リクエストからデータを取得。サニタイズや空ならデフォルト値のセットも行う。
	private function _getDataFromRequest($req){
		App::uses('Sanitize', 'Utility');

		if(empty($req['page_no'])){
			$data['page_no']=0;
		}else{
			$data['page_no']=Sanitize::escape($req['page_no']);//SQLインジェクションのサニタイズ
		}

		if(empty($req['limit'])){
			$data['limit']=null;
		}else{
			$data['limit']=Sanitize::escape($req['limit']);//SQLインジェクションのサニタイズ
		}

		if(empty($req['sort'])){
			$data['sort']=null;
		}else{
			$data['sort']=Sanitize::escape($req['sort']);//SQLインジェクションのサニタイズ
		}

		if(empty($req['sort_type'])){
			$data['sort_type']=0;
		}else{
			$data['sort_type']=Sanitize::escape($req['sort_type']);//SQLインジェクションのサニタイズ
		}

		return $data;
	}



	//find用のlimitとorderを作成する。
	private function _createFindLimit($nowPageNo,$limit){

		if(!isset($limit)){
			return null;
		}

		$lm1=$nowPageNo * $limit;
		$findLimit=$lm1.','.$limit;
		return $findLimit;
	}


	//find用のorderを作成する。
	private function _createFindOrder($sort,$sortType){

		if(empty($sort)){
			return null;
		}

		$findSort=$sort;
		if($sortType==1){
			$findSort.=' desc';
		}

		return $findSort;
	}



	/////////////////////////////////////////////////////////////////////////



    /**
     * ページ目次用のHTMLコードを生成する。
     * 
	 * @param  int $allDataCnt	データ件数（limitをかけていない、検索条件を含めたデータの件数）
	 * @param  string $path			基本的なURLを指定。例:「proj/list.php」。
	 * @param  array $params		ページ関連外のその他のパラメータをURLに付加する場合。例：「array('xxx'=>'1','flg',true)」
	 * @param  string $kjs_uq       検索条件ＵＲＬクエリ文字列
	 * @param  array ページ目次用のHTMLコードデータ
     * 
     */
	private function _createIndexHtml2($allDataCnt,$path,$params,$kjs_uq){

		$nowPageNo=$this->m_reqs['page_no'];
		$limitCnt=$this->m_reqs['limit'];
		$midasiCnt=30;
		$params['limit']=$limitCnt;
		$params['sort']=$this->m_reqs['sort'];
		$params['sort_type']=$this->m_reqs['sort_type'];

		//ページ目次用のHTMLコードを生成する。
		$res=$this->_createIndexHtml($nowPageNo,$params,$allDataCnt,$limitCnt,$midasiCnt,$path,$kjs_uq);

		return $res;
	}

	/**
	 * ページ目次用のHTMLコードを生成する。
	 * @param  $nowPageNo	現在のページ番号（０から開始）
	 * @param  $params		リンクのURLに付加するパラメータ（キー、値）
	 * @param  $dtCnt			データ数
	 * @param  $limitCnt	限界表示行数（最大表示行数）
	 * @param  $midasiCnt	表示する見出し数
	 * @param  string $kjs_uq       検索条件ＵＲＬクエリ文字列
	 * @return array ページ目次用のHTMLコードデータ
	 */
	private function _createIndexHtml($nowPageNo,$params,$dtCnt,$limitCnt,$midasiCnt=8,$pageName="list.php",$kjs_uq){

		if($dtCnt==0) return null;
		if(!isset($limitCnt)) return null;
		if(empty($pageName)) $pageName="list.php";
		
		//▼ページネーションを構成する総リンク数をカウントする。
		$allMdCnt=ceil($dtCnt/$limitCnt);
		$md2=$allMdCnt;
		if($md2>$midasiCnt){
			$md2=$midasiCnt;
		}
		$linkCnt=4+$md2;

		//▼最終ページ番号を取得
		if($md2>0){
			$lastPageNo=$allMdCnt-1;
		}

		$strParams='';
		if(!empty($params)){
			//▼その他パラメータコードを作成する。
			foreach($params as $key=>$val){
				if($val!==null && $val!=='')
					$strParams=$strParams.'&'.$key.'='.$val;
			}
		}

		//▼最戻リンクを作成
		$rtnMax='&lt&lt';
		if($nowPageNo>0){
		    $url = "{$pageName}?page_no=0{$strParams}&{$kjs_uq}";
			$rtnMax="<a href='{$nowPageNo}'>{$rtnMax}</a>";
		}

		//▼単戻リンクを作成
		$rtn1='&lt';
		$page_prev_link="";
		if($nowPageNo>0){
			$p=$nowPageNo-1;
			$url = "{$pageName}?page_no={$p}{$strParams}&{$kjs_uq}";
			$rtn1="<a href='{$url}'>{$rtn1}</a>";
		}

		//▼単進リンクを作成
		$page_next_link="";
		$next1='&gt';
		if($nowPageNo<$lastPageNo){
			$p=$nowPageNo+1;
			$url = "{$pageName}?page_no={$p}{$strParams}&{$kjs_uq}";
			$next1="<a href='{$url}'>{$next1}</a>";
		}

		//▼最進リンクを作成
		$nextMax='&gt&gt';
		if($nowPageNo<$lastPageNo){
			$p=$lastPageNo;
			$url = "{$pageName}?page_no={$p}{$strParams}&{$kjs_uq}";
			$nextMax="<a href='$url'>{$nextMax}</a>";
		}

		//▼見出し配列を作成
		$fno=$lastPageNo-$md2+1;
		if($nowPageNo<$fno){
			$fno=$nowPageNo;
		}
		$lno=$fno+$md2-1;

		for($i=$fno;$i<=$lno;$i++){
			$pn=$i+1;
			if($i!=$nowPageNo){
			    $url = "{$pageName}?page_no={$i}{$strParams}&{$kjs_uq}";
			    $midasiList[]="<a href='$url'>{$pn}</a>";
			}else{
				$midasiList[]=$pn;
			}
		}

		//▼HTML組み立て

		$html="<div id='page_index'>";
		$html.="{$rtnMax}&nbsp;\n";
		$html.="{$rtn1}&nbsp;\n";
		foreach($midasiList as $key=>$val){
			$html.="{$val}&nbsp;\n";
		}
		$html.="{$next1}&nbsp;\n";
		$html.="{$nextMax}&nbsp;\n";
		$html.="</div>\n";
		
		$res=array(
				'mokuji'=>$html,
				'page_prev_link'=>$page_prev_link,
				'page_next_link'=>$page_next_link,
				
		);

		return $res;
	}

    /**
     * ソートＵＲＬリンクHTMLのリストを生成する。
     *
	 * @param  int $allDataCnt	データ件数（limitをかけていない、検索条件を含めたデータの件数）
	 * @param  string $path			基本的なURLを指定。例:「proj/list.php」。
	 * @param  array $params		ページ関連外のその他のパラメータをURLに付加する場合。例：「array('xxx'=>'1','flg',true)」
	 * @param  array $fields		HTMLテーブルのキーはDBフィールド、値はフィールド和名にする。例：「array('title'=>'タイトル')」
	 * @param  string $kjs_uq       検索条件ＵＲＬクエリ文字列
	 * @param  array ソートＵＲＬリンクHTMLのリスト
     */
	private function _createSorts2($allDataCnt,$path,$params,$fields,$kjs_uq){
		

		//各種パラメータの取得
		$nowSortField=$this->m_reqs['sort'];
		$nowSortType=$this->m_reqs['sort_type'];
		$pageNo=$this->m_reqs['page_no'];
		$limit=$this->m_reqs['limit'];

		$sorts=$this->_createSorts($nowSortField, $nowSortType, $fields, $pageNo, $limit, $path, $params,$kjs_uq);

		return $sorts;
	}


	//ソートリンクリストを作成
	private function _createSorts($nowSortField,$nowSortType,$fields,$pageNo,$limit,$path,$params,$kjs_uq){

		//その他パラメータコードを作成する。
		$strParams='';
		if(!empty($params)){

			foreach($params as $key=>$val){
				if($val!==null && $val!=='')
					$strParams=$strParams.'&'.$key.'='.$val;
			}
		}

		//フィールドリストの件数分、以下の処理を繰り返す。
		$data=null;
		foreach($fields as $f=>$fName){
			//リンクを組み立てる。
			$url = "{$path}?page_no={$pageNo}&limit={$limit}&sort={$f}&sort_type=0{$strParams}&{$kjs_uq}";
			$link = "<a href='$url'>{$fName}</a>";

			//リンクをフィールド名をキーにしてソートリンクリストにセット
			$data[$f]=$link;
		}

		//現在ソートフィールドがnullでない場合、以下の処理を行う。
		if(!empty($nowSortField)){
			$fName=$fields[$nowSortField];//フィールド和名

			//現在ソート方法と逆順を取得。フィールド和名に並び順を示すアイコン文字を入れる。
			$revSortType=1;
			if($nowSortType==1){
				$revSortType=0;
				$fName='▼'.$fName;
			}else{
				$fName='▲'.$fName;
			}

			//リンクを組み立てる。
			$url = "{$path}?page_no={$pageNo}&limit={$limit}&sort={$nowSortField}&sort_type={$revSortType}{$strParams}&{$kjs_uq}";
			$link = "<a href='$url'>{$fName}</a>";

			//ソートリンクリストに現在ソートフィールドをキーにしてリンクをセットする。
			$data[$nowSortField]=$link;
		}

		return $data;
	}

}
?>