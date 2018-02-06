<?php
App::uses('FormHelper', 'View/Helper');

/**
 * CrudBase用ヘルパー
 * 
 * @note
 * 検索条件入力フォームや、一覧テーブルのプロパティのラッパーを提供する
 * 
 * 
 * @version 1.4.9 tdIdのoptionにcheckbox_nameを追加
 * @date 2016-7-27 | 2016-12-5
 * @author k-uehara
 *
 */

class CrudBaseHelper extends FormHelper {


	
	private $_mdl=""; // モデル名
	private $_mdl_snk=""; // モデル名（スネーク記法）
	private $_dateTimeList=array(); // 日時選択肢リスト
	private $param; // 各種パラメータ
	
	// 列並びモード用
	private $_clmSortTds = array(); // 列並用TD要素群
	private $_clmSortMode = 0;		// 列並モード
	private $_field_data;			// フィールドデータ
	
	/**
	 * モデル名のセッター
	 * 
	 * input系メソッドに影響します。
	 * 
	 * @param string $modelName モデル名
	 */
	public function setModelName($modelName){
		$this->_mdl = $modelName.'.';
		$this->_mdl_snk = $this->snakize($modelName); //スネーク記法に変換
		
	}
	
	/**
	 * スネーク記法のモデル名を取得する
	 * @return スネーク記法のモデル名
	 */
	public function getModelNameSnk(){
		return $this->_mdl_snk;
	}
	
	/**
	 * 各種パラメータのセッター
	 * 
	 * @param array $param パラメータ
	 */
	public function setParam($param){
		$this->param = $param;
	}
	
	
	/**
	 * 新規入力ボタンを作成
	 * @param array $option オプション【省略可】
	 * - class クラス属性の値
	 * - onclick onclickイベントにセットするJS関数（CRUDタイプがajax型である場合のみ有効)
	 * - display_name ボタンの表示名
	 */
	public function newBtn($option){
	
		if(empty($option)){
			$option = array();
		}
		
		if(empty($option['class'])){
			$option['class'] = 'btn btn-warning btn-sm';
		}
		
		if(empty($option['onclick'])){
			$option['onclick'] = 'ajaxCrud.newInpShow(this);';
		}
		
		if(empty($option[$this->_mdl_snk])){
			$option[$this->_mdl_snk] = '新規入力';
		}
		
		$crudType = $this->param['crudType'];
		$class = $option['class'];
		$btn_name = $option[$this->_mdl_snk];
		
		// CRUDタイプがajax型である場合
		if(empty($crudType)){
			$onclick = $option['onclick'];
			echo "<button type='button' class='{$class}' onclick='{$onclick}' />{$btn_name}</button>";
			
		}
		
		// CRUDタイプがsubmit型である場合
		else{
			$path = $this->Html->webroot.$this->_mdl_snk;
			echo "<a href='{$path}/edit' class='{$class}'>{$btn_name}</a>";
		}

	}
	
	/**
	 * 検索用のid入力フォームを作成
	 * 
	 * @param array $kjs 検索条件データ
	 */
	public function inputKjId($kjs){

		echo "<div class='kj_div'>\n";
		echo $this->input($this->_mdl.'kj_id', array(
				'id' => 'kj_id',
				'value' => $kjs['kj_id'],
				'type' => 'text',
				'label' => false,
				'placeholder' => '-- ID --',
				'style'=>'width:100px',
				'title'=>'IDによる検索',
		));
		
		echo "</div>\n";
				
	}
	
	
	/**
	 * 検索用のテキスト入力フォームを作成
	 * 
	 * @param array $kjs 検索条件データ
	 * @param string $field フィールド名
	 * @param string $wamei フィールド和名
	 * @param int $width 入力フォームの横幅（省略可）
	 * @param string $title ツールチップメッセージ（省略可）
	 */
	public function inputKjText($kjs,$field,$wamei,$width=200,$title=null){
		
		if($title==null){
			$title = $wamei."で検索";
		}

		echo "<div class='kj_div'>\n";
		echo $this->input($this->_mdl.$field, array(
				'id' => $field,
				'value' => $kjs[$field],
				'type' => 'text',
				'label' => false,
				'placeholder' => $wamei,
				'style'=>"width:{$width}px",
				'title'=>$title,
		));
		echo "</div>\n";
	}
	
	
	/**
	 * 検索用のhiddenフォームを作成
	 *
	 * @param array $kjs 検索条件データ
	 * @param string $field フィールド名
	 */
	public function inputKjHidden($kjs,$field){
	

		echo $this->input($this->_mdl.$field, array(
				'id' => $field,
				'value' => $kjs[$field],
				'type' => 'hidden',
		));
		
	}
	
	
	
	
	
	/**
	 * 検索用のセレクトフォームを作成
	 * 
	 * @param array $kjs 検索条件データ
	 * @param string $field フィールド名
	 * @param string $wamei フィールド和名
	 * @param string $list 選択肢リスト
	 * @param int $width 入力フォームの横幅（省略可）
	 * @param string $title ツールチップメッセージ（省略可）
	 */
	public function inputKjSelect($kjs,$field,$wamei,$list,$width=150,$title=null){
		
		if($title==null){
			$title = $wamei."で検索";
		}
		
		echo "<div class='kj_div'>\n";
		echo $this->input($this->_mdl.$field, array(
				'id' => $field,
				'type' => 'select',
				'options' => $list,
				'empty' => "-- {$wamei} --",
				'default' => $kjs[$field],
				'label' => false,
				'style'=>"width:{$width}px",
				'title'=>$title,
		));	
		echo "</div>\n";
	}


	
	
	
	/**
	 * 検索用の更新日時セレクトフォームを作成
	 * @param array $kjs 検索条件データ
	 */
	public function inputKjModified($kjs){
	
		$this->inputKjDateTimeA($kjs,'kj_modified','更新日時');
	}

	
	
	
	
	/**
	 * 検索用の生成日時セレクトフォームを作成
	 * @param array $kjs 検索条件データ
	 */
	public function inputKjCreated($kjs){
	
		$this->inputKjDateTimeA($kjs,'kj_created','生成日時');
	}
	

	
	
	
	/**
	 * 検索用の日時セレクトフォームを作成
	 *
	 * @param array $kjs 検索条件データ
	 * @param string $field フィールド名
	 * @param string $wamei フィールド和名
	 * @param string $list 選択肢リスト（省略可）
	 * @param int $width 入力フォームの横幅（省略可）
	 * @param string $title ツールチップメッセージ（省略可）
	 */
	public function inputKjDateTimeA($kjs,$field,$wamei,$list=array(),$width=200,$title=null){
	
		if($title==null){
			$title = $wamei."で検索";
		}
		
		if(empty($list)){
			$list = $this->getDateTimeList();
		}
	
		echo "<div class='kj_div'>\n";
		echo $this->input($this->_mdl.$field, array(
				'id' => $field,
				'type' => 'select',
				'options' => $list,
				'empty' => "-- {$wamei} --",
				'default' => $kjs[$field],
				'label' => false,
				'style' => "width:{$width}px",
				'title' => $title,
		));
		echo "</div>\n";
	}
	
	
	
	
	
	/**
	 * 検索用の削除フラグフォームを作成
	 *
	 * @param array $kjs 検索条件データ
	 * 
	 */	
	public function inputKjDeleteFlg($kjs){
		echo "<div class='kj_div'>\n";
		echo $this->input($this->_mdl.'kj_delete_flg', array(
			'id' => 'kj_delete_flg',
			'type' => 'select',
			'options' => array(
				0=>'有効',
				1=>'無効',
			),
			'empty' => 'すべて表示',
			'default' => $kjs['kj_delete_flg'],
			'label' => false,
		));
		echo "</div>\n";
	}
	
	
	
	
	
	/**
	 * 検索用の表示件数セレクトを作成
	 *
	 * @param array $kjs 検索条件データ
	 * 
	 */	
	public function inputKjLimit($kjs){
		echo "<div class='kj_div'>\n";
		echo $this->input($this->_mdl.'kj_limit', array(
				'id' => 'kj_limit',
				'type' => 'select',
				'options' => array(
						5=>'5件表示',
						10=>'10件表示',
						20=>'20件表示',
						50=>'50件表示',
						100=>'100件表示',
						200=>'200件表示',
						500=>'500件表示',
				),
				'default' => $kjs['kj_limit'],
				'label' => false,
				'style' => 'height:27px'
		));
		echo "</div>\n";
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * 検索用の年月入力フォームを作成
	 * 
	 * @param array $kjs 検索条件データ
	 * @param string $field フィールド名
	 * @param string $wamei フィールド和名
	 */
	public function inputKjNengetu($kjs,$field,$wamei){


		$kj_date_ym = $field.'_ym';
		$kj_date1 = $field.'1';
		$kj_date2 = $field.'2';
		$kj_dates = $field.'s';
		
		$kj_ym_value = $kjs[$kj_date1];
		if(!empty($kj_ym_value)){
			$kj_ym_value=date('Y/m',strtotime($kj_ym_value));
		}
		
		echo "<div class='kj_div' style='margin-right:2px'>";
		echo $this->input($kj_date_ym, array(
				'id' => $kj_date_ym,
				'value' => $kj_ym_value,
				'type' => 'text',
				'label' => false,
				'placeholder' => '-- '.$wamei.'年月 --',
				'style'=>'width:100px;',
		));
		echo "</div>";
		
		
		
		
		echo "<div class='kj_div'>";
		echo "	<input type='button' class='ympicker_toggle_btn' value='' onclick=\"$('.{$kj_dates}').fadeToggle()\" title='日付範囲入力を表示します' />";
		echo "</div>";
		
		
		
		
		echo "<div class='kj_div {$kj_dates}' style='display:none'>";
		echo $this->input($this->_mdl.$kj_date1, array(
				'id' => $kj_date1,
				'value' => $kjs[$kj_date1],
				'type' => 'text',
				'label' => false,
				'placeholder' => '-- '.$wamei.'【範囲1】--',
				'style'=>'width:150px',
				'title'=>'入力日以降を検索',
		));
		echo "</div>";
		
		
		
		echo "<div class='kj_div {$kj_dates}' style='display:none'>";
		echo $this->input($this->_mdl.$kj_date2, array(
				'id' => $kj_date2,
				'value' => $kjs[$kj_date2],
				'type' => 'text',
				'label' => false,
				'placeholder' => '-- '.$wamei.'【範囲2】--',
				'style'=>'width:150px',
				'title'=>'入力日以前を検索',
		));
		echo "</div>";
		

		
	}
	
	
	
	
	
	
	
	
	/**
	 * 
	 * 検索用の年月入力フォームを作成
	 * 
	 * @param array $kjs 検索条件データ
	 * @param string $field フィールド名（ kj_ を付けないこと）
	 * @param string $wamei フィールド和名
	 */
	public function inputKjNouislider($kjs,$field,$wamei){
		//<!-- 数値範囲入力スライダー・noUiSlider -->
		$detail_noui = $field.'_detail';
		
		
		echo "<table class='nouislider_rap'><tr><td>";
		echo "		<span class='nusr_label'><{$wamei}による範囲検索</span>&nbsp;";
		echo "		<span id='{$field}_preview' class='nusr_preview'></span>";
		echo "	</td></tr>";
		
		
		echo "	<tr><td><div id='{$field}_slider' title='{$wamei}による範囲検索'></div></td>";
		echo "	<td><input type='button' class='nusr_toggle_btn' value='' onclick=\"$('#{$detail_noui}').fadeToggle()\" title='日付範囲入力を表示します'></td>";
		echo "	</tr>";
		
		
		
		echo "	<tr id='{$detail_noui}' class='nusr_detail'><td>";
		echo "	<div class='kj_div'>";
			
		$key='kj_'.$field.'1';
		echo $this->input($this->_mdl.$key, array(
			'id' => $key,
			'value' => $kjs[$key],
			'type' => 'number',
			'label' => false,
			'style'=>'width:50px',
			'title'=>$wamei.'による範囲検索',
		));
			
		echo "	</div><div class='kj_div'>～</div><div class='kj_div'>";
		
		$key='kj_'.$field.'2';
		echo $this->input($this->_mdl.$key, array(
			'id' => $key,
			'value' => $kjs[$key],
			'type' => 'number',
			'label' => false,
			'style'=>'width:50px',
			'title'=>$wamei.'による範囲検索',
		));
		
		echo "	</div></td><td></td></tr></table>";
		
		
	}
	
	
	
	
	
	/**
	 * 検索入力保存の入力要素を作成する
	 * @param bool $saveKjFlg
	 * @param string $hidden true:Hidden要素 , false:チェックボックス
	 */
	public function inputKjSaveFlg($saveKjFlg,$hidden=false){
	
		if(!empty($hidden)){
			echo $this->input($this->_mdl."saveKjFlg", array('value' => $saveKjFlg,'type' => 'hidden',));
			return;
		}
		
		echo "<div class='kj_div' style='margin-top:4px;'>";
		echo $this->input($this->_mdl."saveKjFlg",array(
				'type'=>'checkbox',
				'value' => 1,
				'checked'=>$saveKjFlg,
				'label'=>'検索入力保存',
				'div'=>false,
		));
		echo '</div>';
		

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * プロパティをtdタグを付加して出力する
	 * 
	 */
	public function tdPlain($v,$field=''){
		
		if(is_array($v)){
			$v = $v[$field];
		}
		
		$td = "<td><span class='{$field}' >{$v}</span></td>\n";
		$this->setTd($td,$field);
	}
	public function tpPlain($v,$wamei){
		$this->tblPreview($v,$wamei);
	}
	

	

	public function tdStr($v,$field=''){
		
		if(is_array($v)){
			$v = $v[$field];
		}
		
		$v = h($v);
		$td = "<td><span class='{$field}' >{$v}</span></td>\n";
		$this->setTd($td,$field);
	
	}
	public function tpStr($v,$wamei){
		$v = h($v);
		$this->tblPreview($v,$wamei);
	}
	
	
	
	
	/**
	 * idを詳細ページリンク付のコードに変換する
	 *
	 * @param unknown $v ID
	 */
	public function propId($v){
		$this->_check1();
		
		$detalUrl=$this->Html->webroot.$this->_mdl_snk.'/detail?id='.$v;
		$v = "<a href='{$detalUrl}' >{$v}</a>";
	
		return $v;
	}
	
	/**
	 * ID用のTD用をを作成する
	 * @param unknown $v 表示する値
	 * @param string $field フィールド名
	 * @param array $option オプション
	 *  - checkbox_name チェックボックス名プロパティ   このプロパティに値をセットすると、複数選択による一括処理用のチェックボックスが作成される。
	 */
	public function tdId($v,$field='id',$option=array()){
		
		if(is_array($v)){
			$v = $v[$field];
		}
		
		
		// 複数選択による一括処理用のチェックボックスHTMLを組み立てる
		$cbHtml = ''; // チェックボックスHTML
		if(!empty($option['checkbox_name'])){
			$cbHtml = "<input type='checkbox' name='{$option['checkbox_name']}' /> ";
		}
		
		
		// TD要素を組み立てる
		$td = "<td>{$cbHtml}<span class='{$field}' >{$v}</span></td>\n";
		
		$this->setTd($td,$field);
		

	}
	

	
	public function tpId($v,$wamei='ID'){
		$v = $this->propId($v);
		$this->tblPreview($v,$wamei);
	}	
	

	
	
	
	/**
	 * プロパティをリスト内の値に置き換える
	 *
	 * @param unknown $v プロパティ
	 * @param array $list リスト
	 */
	public function propList($v,$list){
	
		if(isset($list[$v])){
			$v = $list[$v];
		}else{
			$v="";
		}
	
		return $v;
	
	}
	public function tdList($v,$field="",$list=array()){
		
		if(is_array($v)){
			$v = $v[$field];
		}

		$v2 = $this->propList($v,$list);
		
		$td = "<td><span class='{$field}' style='display:none'>{$v}</span><span class='{$field}_display' >{$v2}</span></td>\n";
		$this->setTd($td,$field);
	
	}
	public function tpList($v,$wamei,$list){
		$v = $this->propList($v,$list);
		$this->tblPreview($v,$wamei);
	
	}
	
	
	
	
	
	
	
	
	/**
	 * プロパティを日本円表記に変換する。
	 * 
	 * @param unknown $v プロパティ
	 */
	public function propMoney($v){
		if(!empty($v) || $v===0){
			$v= '&yen'.number_format($v);
		}
		
		return $v;
	}
	public function tdMoney($v,$field=''){
		
		if(is_array($v)){
			$v = $v[$field];
		}
		
		$v2 = $this->propMoney($v);
		
		$td = "<td><span class='{$field}' style='display:none'>{$v}</span><span class='{$field}_display' >{$v2}</span></td>\n";
		$this->setTd($td,$field);
	}
	public function tpMoney($v,$wamei){
		$v = $this->propMoney($v);
		$this->tblPreview($v,$wamei);

	}
	
	
	
	/**
	 * ノートなどの長文を冒頭だけ表示する
	 *
	 * @param unknown $v プロパティまたはエンティティ
	 * @param string $field フィールド名
	 * @param int $strLen 表示文字数（バイト）
	 */
	public function tdNote($v,$field='',$strLen = 30){
		
		if(is_array($v)){
			$v = $v[$field];
		}
		

		$v2="";
		if(!empty($v)){
			$v = h($v);
			$v2=mb_strimwidth($v, 0, $strLen, "...");
			$v2= str_replace('\\r\\n', ' ', $v2);
			$v2= str_replace('\\', '', $v2);
		}

		$td = "<td><span class='{$field}' style='display:none'>{$v}</span><span class='{$field}_display' >{$v2}</span></td>\n";
		$this->setTd($td,$field);
	}
	
	
	public function tpNote($v,$wamei){
	
		if(!empty($v)){
			$v= str_replace('\\r\\n', '<br>', h($v));
			$v= str_replace('\\', '', $v);
		}
	
		$this->tblPreview($v,$wamei);
	
	}
	
	
	/**
	 * テキストエリア用の文字列変換
	 * @param string $v 文字列（改行OK)
	 * @return string テキストエリア用に加工した文字列
	 */
	public function convNoteForTextarea($v){
		if(!empty($v)){
		
			//サニタイズされた改行コードを「&#13;」に置換
			$v = str_replace('\\r\\n', '&#13;', h($v));
			$v = str_replace('\\', '', $v);
		
		}
		
		return $v;
	}
	
	
	
	/**
	 * 削除フラグの表記を変換する
	 * 
	 * @param unknown $v 削除フラグ
	 */
	public function propDeleteFlg($v){
		
		if($v==0){
			$v="<span style='color:#23d6e4;'>有効</span>";
		}elseif($v==1){
			$v="<span style='color:#b4b4b4;'>無効</span>";
		}
		
		return $v;
	}
	
	
	public function tdAdd($html,$field){
		$this->setTd($html,$field);
	}
	
	public function tdDeleteFlg($v,$field=''){
		
		if(is_array($v)){
			$v = $v[$field];
		}
		if(empty($v)){
			$v = 0;
		}
		
		$v2 = $this->propDeleteFlg($v);
		$td = "<td><span class='{$field}' style='display:none'>{$v}</span><span class='{$field}_display' >{$v2}</span></td>\n";
		$this->setTd($td,$field);
	}
	public function tpDeleteFlg($v,$wamei='無効フラグ'){
		$v = $this->propDeleteFlg($v);
		
		$this->tblPreview($v,$wamei);

	}
	
	/**
	 * プロパティのプレビュー表示
	 * @param unknown $v プロパティの値
	 * @param string $wamei プロパティ和名
	 */
	public function tblPreview($v,$wamei){
		echo "<tr>\n";
		echo "	<td>{$wamei}</td>\n";
		echo "	<td>{$v}</td>\n";
		echo "</tr>\n";
	}
	
	
	
	
	
	/**
	 * 編集用のテキストボックスを作成
	 * @param array $ent エンティティ
	 * @param string $field フィールド名
	 * @param string $wamei 和名
	 * @param int $width 入力フォーム幅
	 * @param string $title ツールチップ（省略可）
	 */
	public function editText($ent,$field,$wamei,$width=200,$title=null){
		
		
		echo 
			"<tr>".
			" 	<td>{$wamei}</td>".
			" 	<td>";
		
		$option = array(
				'id'=>$field,
				'value' => $ent[$field],
				'type' => 'text',
				'label' => false,
				'div' =>false,
				'placeholder' => "-- {$wamei} --",
				'style'=>"width:{$width}px;",
		);
		
		if(!empty($title)){
			$option['title'] = $title;
		}
		
		echo $this->input($this->_mdl.$field,$option);

		echo
			" 	</td>".
			" </tr>";
	}
	
	
	
	
	
	/**
	 * 編集用のセレクトボックスを作成
	 * @param array $ent エンティティ
	 * @param string $field フィールド名
	 * @param string $wamei 和名
	 * @param array $list 選択肢リスト
	 * @param int $width 入力フォーム幅
	 * @param string $title ツールチップ（省略可）
	 */
	public function editSelect($ent,$field,$wamei,$list,$width=200,$title=null){
		
		
		echo 
			"<tr>".
			" 	<td>{$wamei}</td>".
			" 	<td>";
		

		$option = array(
				'id'=>$field,
		 		'type' => 'select',
		 		'options' => $list,
				'default' => $ent[$field],
				'label' => false,
				'div' =>false,
		 		'empty' => "-- {$wamei} --",
				'style'=>"width:{$width}px;",
		);
		
		if(!empty($title)){
			$option['title'] = $title;
		}
		
		echo $this->input($this->_mdl.$field,$option);

		echo
			" 	</td>".
			" </tr>";
	}
	
	
	
	
	
	/**
	 * 編集用のテキストエリアを作成
	 * @param array $ent エンティティ
	 * @param string $field フィールド名
	 * @param string $wamei 和名
	 * @param int $width 入力フォーム横幅
	 * @param int $height 入力フォーム縦幅
	 * @param string $title ツールチップ（省略可）
	 */
	public function editTextArea($ent,$field,$wamei,$width=400,$height=100,$title=null){
		
		// テキストエリア用に改行やサニタイズを施す
		$note = $this->convNoteForTextarea($ent[$field]);
		
		echo 
			"<tr>".
			" 	<td>{$wamei}</td>".
			" 	<td>";
		
		$option = array(
				'id'=>$field,
				'value' => $note,
				'type' => 'textarea',
				'placeholder' => "-- {$wamei} --",
				'label' => false,
				'div'=>false,
				'escape'=>false,
				'style'=>"width:{$width}px;height:{$height}px;",
		);
		
		
		if(!empty($title)){
			$option['title'] = $title;
		}
		
		echo $this->input($this->_mdl.$field,$option);

		echo
			" 	</td>".
			" </tr>";
	}
	
	
	
	
	/**
	 * 編集用の無効フラグチェックボックスを作成
	 * @param array $ent エンティティ
	 * @param string $mode モード    new:新規モード , edit:編集モード
	 */
	public function editDeleteFlg($ent,$mode){

		
		$wamei = "";
		if($mode=='edit'){
			$wamei = "無効";
		}
			
		echo
		"<tr>".
		" 	<td>{$wamei}</td>".
		" 	<td>";
		
		if($mode=='edit'){
			echo $this->input($this->_mdl.'delete_flg', array(
					'checked'=>$ent['delete_flg'],
					'type' => 'checkbox',
					'label' => false,
					'div' =>false,
					'title' => '無効にすると表示されません。',
			));
		}else{
			echo $this->input('delete_flg', array('value' => $ent['delete_flg'],'type' => 'hidden',));
		}
		
		
		
		echo
		" 	</td>".
		" </tr>";
	}
	
	
	
	
	
	
	/**
	 * 行の編集ボタンを作成する
	 * @param int $id ID
	 * @param string $css_class CSSスタイル（省略可）
	 * @param $onclick 編集フォームを呼び出すjs関数（CRUDタイプがajax型である場合。省略可)
	 */
	public function rowEditBtn($id,$css_class=null,$onclick=null){
		
		
		if(empty($css_class)){
			$css_class='btn btn-warning btn-xs';
		}
		
		if(empty($onclick)){
			$onclick="ajaxCrud.editShow(this);";
		}
		
		$crudType = $this->param['crudType'];
		
		// CRUDタイプがajax型である場合
		if(empty($crudType)){
			echo "<input type='button' value='編集'  class='{$css_class}' onclick='{$onclick}' />";
				
		}
		
		// CRUDタイプがsubmit型である場合
		else{
			$url=$this->Html->webroot.$this->_mdl_snk.'/edit?id='.$id;
			echo "<a href='{$url}' class='{$css_class}'>編集</a>";
		}
		
		
		
	}
	
	
	
	
	
	
	/**
	 * 行のプレビューボタンを作成する
	 * @param int $id ID
	 * @param string $css_class CSSスタイル（省略可）
	 */
	public function rowPreviewBtn($id,$css_class=null){
		
		if(empty($css_class)){
			$css_class='btn btn-info btn-xs';
		}
		
		
		$crudType = $this->param['crudType'];
		
		// CRUDタイプがajax型である場合
		if(empty($crudType)){
			// ajax型にはプレビュー表示の概念が存在しないのでプレビューボタンを作成しない。
				
		}
		
		// CRUDタイプがsubmit型である場合
		else{
			$url=$this->Html->webroot.$this->_mdl_snk.'/detail?id='.$id;
			echo "<a href='{$url}' class='{$css_class}'>詳細</a>";
		}
		
		
		
	}
	
	
	
	
	
	
	/**
	 * 行の削除ボタンを作成する
	 * @param int $id ID
	 * @param string $css_class CSSスタイル（省略可）
	 * @param $onclick 削除フォームを呼び出すjs関数（CRUDタイプがajax型である場合。省略可)
	 */
	public function rowDeleteBtn($id,$css_class=null,$onclick=null){
		
		
		if(empty($css_class)){
			$css_class='btn btn-danger btn-xs';
		}
		if(empty($onclick)){
			$onclick="ajaxCrud.deleteShow(this);";
		}
		
		
		
		$crudType = $this->param['crudType'];
		
		// CRUDタイプがajax型である場合
		if(empty($crudType)){
			echo "<input type='button' value='削除'  class='{$css_class}' onclick='{$onclick}' />";
				
		}
		
		// CRUDタイプがsubmit型である場合は削除ボタンは作成しない。
		else{
			
		}
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * 更新情報を表示する
	 * @param array $ent エンティティ
	 */
	public function updateInfo($ent){
		
		echo "<table class='tbl_sm'><tbody>\n";
		

		$this->_updateInfoTr($ent,'id','ID');
		$this->_updateInfoTr($ent,array('update_user','user_name','user','updater','modified_user'),'前回更新者');
		$this->_updateInfoTr($ent,array('update_ip_addr','ip_addr','user_ip_addr'),'前回更新IPアドレス');
		$this->_updateInfoTr($ent,'created','生成日時');
		$this->_updateInfoTr($ent,'modified','前回更新日時');
		
		echo "</tbody></table>\n";
	}
	private function _updateInfoTr($ent,$field,$fieldName){
		
		$ary = array();
		if (!is_array($field)){
			$ary[] = $field;
		}else{
			$ary = $field;
		}
		
		foreach($ary as $f){
			if(!empty($ent[$f])){
				echo "<tr><td>{$fieldName}</td><td>{$ent[$f]}</td></tr>\n";
				break;
			}
		}
	}
	
	
	
	
	
	/**
	 * 日時選択肢リストを取得する
	 * 
	 * @return array 日時選択肢リスト
	 */
	private function getDateTimeList(){

		
		if(!empty($this->_dateTimeList)){
			return $this->_dateTimeList;
		}
			
		$d1=date('Y-m-d');//本日
		$d2=$this->getBeginningWeekDate($d1);//週初め日付を取得する。
		$d3 = date('Y-m-d', strtotime("-10 day"));//10日前
		$d4 = $this->getBeginningMonthDate($d1);//今月一日を取得する。
		$d5 = date('Y-m-d', strtotime("-30 day"));//30日前
		$d6 = date('Y-m-d', strtotime("-50 day"));//50日前
		$d7 = date('Y-m-d', strtotime("-100 day"));//100日前
		$d8 = date('Y-m-d', strtotime("-180 day"));//180日前
		$d9 = $this->getBeginningYearDate($d1);//今年元旦を取得する
		$d10 = date('Y-m-d', strtotime("-365 day"));//365日前
			
		$list= array(
				$d1=>'本日',
				$d2=>'今週（日曜日から～）',
				$d3=>'10日以内',
				$d4=>'今月（今月一日から～）',
				$d5=>'30日以内',
				$d6=>'50日以内',
				$d7=>'100日以内',
				$d8=>'半年以内（180日以内）',
				$d9=>'今年（今年の元旦から～）',
				$d10=>'1年以内（365日以内）',
		);
		
		$this->_dateTimeList = $list;
	
		return $list;
			
	}
	
	/**
	 * 引数日付の週の週初め日付を取得する。
	 * 週初めは日曜日とした場合。
	 * @param $ymd
	 * @return 週初め
	 */
	private function getBeginningWeekDate($ymd) {
			
		$w = date("w",strtotime($ymd));
		$bwDate = date('Y-m-d', strtotime("-{$w} day", strtotime($ymd)));
		return $bwDate;
			
	}
	
	/**
	 * 引数日付から月初めの日付を取得する。
	 * @param $ymd
	 */
	private function getBeginningMonthDate($ymd) {
	
		$ym = date("Y-m",strtotime($ymd));
		$d=$ym.'-01';
			
		return $d;
	
	}
	
	/**
	 * 引数日付から元旦日を取得する。
	 * @param $ymd
	 */
	private function getBeginningYearDate($ymd) {
	
		$y = date("Y",strtotime($ymd));
		$d=$y.'-01-01';
			
		return $d;
	
	}
	
	
	/**
	 * スネークケースにキャメルケースから変換
	 * @param string $str キャメルケース
	 * @return string スネークケース
	 */
	private function snakize($str) {
		$str = preg_replace('/[A-Z]/', '_\0', $str);
		$str = strtolower($str);
		return ltrim($str, '_');
	}
	
	
	
	private function _check1(){
		if(empty($this->_mdl)){
			throw new Exception('setModelNameの呼出しが事前に必要です。');
		}
	}
	
	
	/**
	 * td要素出力を列並モードに対応させる
	 * @param array $field_data フィールドデータ
	 */
	public function startClmSortMode($field_data){
		$this->_clmSortMode = 1; // 列並モード ON
		$this->_field_data = $field_data; // フィールドデータをセット
		
	}
	
	
	/**
	 * 列並に合わせてTD要素群を出力する
	 */
	public function tdsEchoForClmSort(){

		foreach($this->_field_data as $f_ent){
			$field = $f_ent['id'];
			if(!empty($this->_clmSortTds[$field])){
				echo $this->_clmSortTds[$field];
			}
		}
		
		// クリア
		$this->_clmSortTds = array();
		
	}
	
	/**
	 * 列並用TD要素群にTD要素をセット
	 * 
	 * 列並モードがOFFならTD要素をそのまま出力する。
	 * 
	 * @param string $td TD要素文字列
	 * @param string $field フィールド名
	 */
	private function setTd($td,$field){
		if($this->_clmSortMode && !empty($field) ){
			$this->_clmSortTds[$field] = $td;
		}else{
			echo $td;
		}
	}
	
	
	/**
	 * シンプルなSELECT要素を作成
	 * @param string $name SELECTのname属性
	 * @param primitive $value 初期値
	 * @param array $list 選択肢
	 * @param array $option オプション  要素の属性情報
	 * @param array $empty 未選択状態に表示する選択肢名。nullをセットすると未選択項目は表示しない
	 * 
	 */
	public function selectX($name,$value,$list,$option=null,$empty=null){
		
		// オプションから各種属性文字を作成する。
		$optionStr = "";
		if(!empty($option)){
			foreach($option as $attr_name => $v){
				$str = $attr_name.'="'.$v.'" ';
				$optionStr.= $str;
			}
		}
		
		
		$def_op_name = '';
		
		echo "<select  name='{$name}' {$optionStr} >\n";
		
		if($empty!==null){
			$selected = '';
			if($value===null){
				$selected='selected';
			}
			echo "<option value='' {$selected}>{$empty}</option>\n";
		}
		
		foreach($list as $v=>$n){
			$selected = '';
			if($value===$v){
				$selected='selected';
			}
			echo "<option value='{$v}' {$selected}>{$n}</option>\n";
			
		}
		
		echo "</select>\n";
	}
	
	
	/**
	 * シンプルなCHECKBOX要素を作成
	 * @param string $name CHECKBOXのname属性
	 * @param primitive $value 初期値
	 * @param array $option オプション  要素の属性情報
	 * 
	 */
	public function checkboxX($name,$value,$option=null){
		
		// オプションから各種属性文字を作成する。
		$optionStr = "";
		if(!empty($option)){
			foreach($option as $attr_name => $v){
				$str = $attr_name.'="'.$v.'" ';
				$optionStr.= $str;
			}
		}
		
		$checked = '';
		if(!empty($value)){
			$checked = 'checked';
		}
		
		echo "<input type='checkbox' name='{$name}' {$checked} {$optionStr} />\n";
		
	}
	
	
	/**
	 * 配列型用RADIO要素を作成
	 * @param string $name RADIOのname属性
	 * @param primitive $value 初期値
	 * @param array $list 選択肢
	 * @param array $option オプション  要素の属性情報
	 * 
	 */
	public function radioForMult($name,$value,$list,$option=null){
		// ■■■□□□■■■□□□■■■□□□保留
		// オプションから各種属性文字を作成する。
		$optionStr = "";
		if(!empty($option)){
			foreach($option as $attr_name => $v){
				$str = $attr_name.'="'.$v.'" ';
				$optionStr.= $str;
			}
		}
		
		
		$def_op_name = '';
		
		echo "<select name='{$name}' {$optionStr} >\n";
		

		
		foreach($list as $v=>$n){
			$selected = '';
			if($value===$v){
				$selected='selected';
			}
			echo "<option value='{$v}' {$selected}>{$n}</option>\n";
			
		}
		
		echo "</select>\n";
	}
	
	
	
	
}