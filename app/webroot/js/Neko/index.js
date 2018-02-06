

$(function() {

	init();//初期化
	
});

// --- Start ex1
///ネコ数値の数値範囲入力スライダー
var nusrNekoVal = new NoUiSliderRap();
// --- End ex1

var csh=new ClmShowHide();//列表示切替

var ajaxCrud;//AjaxによるCRUD

var pwms; // ProcessWithMultiSelection.js | 一覧のチェックボックス複数選択による一括処理

/**
 *  ネコ画面の初期化
 * 
  * ◇主に以下の処理を行う。
 * - 日付系の検索入力フォームにJQueryカレンダーを組み込む
 * - 列表示切替機能の組み込み
 * - 数値範囲系の検索入力フォームに数値範囲入力スライダーを組み込む
 * 
 * @version 1.1
 * @date 2016-1-22 列並替機能に対応
 * @date 2015-09-16 新規作成
 * @author k-uehara
 */
function init(){
	
	//AjaxによるCRUD
	
	// ■■■□□□■■■□□□■■■□□□
	//var field_data = ['id','neko_val','neko_name','neko_date','neko_group','neko_dt','note','delete_flg','update_user','ip_addr','created','modified',];
	
	ajaxCrud = new AjaxCRUD({
			'tbl_slt':'neko_tbl',
			'edit_reg_url':'neko/ajax_reg',
			'new_reg_url':'neko/ajax_reg',
			'delete_reg_url':'neko/ajax_delete',
		});

	
	// 列表示切替機能の初期化
	var csh_json = $('#csh_json').val();
	var iniClmData = JSON.parse(csh_json);//列表示配列  1:初期表示   0:初期非表示
	csh.init('neko_tbl','clm_cbs',iniClmData,'rkt_neko_index');

	//列並替変更フラグがON（列並べ替え実行）なら列表示切替情報をリセットする。
	if(localStorage.getItem('clm_sort_chg_flg') == 1){
		csh.reset();//列表示切替情報をリセット
		localStorage.removeItem('clm_sort_chg_flg');
	}
	
	
	// --- Start js_index_date
	
	//jQuery UIカレンダーを日本語化する(Layouts/default.js)
	datepicker_ja();
	
	//日付系の検索入力フォームにJQueryカレンダーを組み込む。
	$("#kj_neko_date1").datepicker({
		dateFormat:'yy-mm-dd'
	});
	$("#kj_neko_date2").datepicker({
		dateFormat:'yy-mm-dd'
	});

	// 年月選択により月初日、月末日らのテキストボックスを連動させる。
	ympicker_tukishomatu('kj_neko_date_ym','kj_neko_date1','kj_neko_date2');
	
	//noUiSliderの初期化（数値範囲入力スライダー）
	nusrNekoVal.init(nusrNekoVal,{
			'slider':'#neko_val_slider',
			'tb1':'#kj_neko_val1',
			'tb2':'#kj_neko_val2',
			'value_preview':'#neko_val_preview',
			'step':5,
			'min':0,
			'max':200,
		});
	
	
	// 一覧のチェックボックス複数選択による一括処理
	pwms = new ProcessWithMultiSelection({
		'tbl_slt':'#neko_tbl',
		'ajax_url':'neko/ajax_pwms',
			});
	// --- End js_index_date
}


/**
 * 詳細検索フォーム表示切替
 * 
 * 詳細ボタンを押した時に、実行される関数で、詳細検索フォームなどを表示します。
 */
function show_kj_detail(){
	$("#kjs2").fadeToggle();
}



/**
 * 検索条件をリセット
 * 
 * すべての検索条件入力フォームの値をデフォルトに戻します。
 * リセット対象外を指定することも可能です。
 * @param array exempts リセット対象外フィールド配列（省略可）
 */
function resetKjs(exempts){
	
	if(exempts==null){
		exempts=[];
	}
	
	//デフォルト検索条件JSONを取得およびパースする。
	var defKjsJson=$('#defKjsJson').html();
	var defKjs=$.parseJSON(defKjsJson);
	
	for(var key in defKjs){
		
		//リセット対象外でなければ、検索条件入力フォームをリセットする。
		if(exempts.indexOf(key) < 0){
			$('#' + key).val(defKjs[key]);
		}
		
	}
	
	// --- Start ex2
	//数値範囲入力スライダー・noUiSliderの再表示(nouislider_rap.js)
	nusrNekoVal.reload();
	// --- End ex2
	
}




/**
 * 列並替画面に遷移する
 */
function moveClmSorter(){
	
	//列並替画面に遷移する <CrudBase:index.js>
	moveClmSorterBase('neko');
	
}





////新規入力登録
//function newInpReg(){
//	
//	// DBへ登録。DB登録後、画像アップロードを行う。
//	ajaxCrud.newInpReg(afterRegNew);
//}
//
//
//
///**
// * アイコン画像をAjaxアップロードした後のイベント。（新規入力フォーム用）
// * 
// * フォームおよび一覧にアップロードしたアイコン画像やファイル名を表示させる。
// * 
// * @param fn アップロードされたファイル名
// */
//function afterRegNew(ent){
//	
//
////	var fn = ent.icon_fn;
////
////	var ent = ajaxCrud.getEntity(-1);
////	var app_id = ent.id;
//	
//
//	// 現在新規入力中の行から、指定したフィールドに紐づくTD要素を取得する
//	var td = ajaxCrud.getTd(-1,'icon_fn');
//	
////	// TD要素内の各要素へアイコン画像やファイル名などをセットする。
////	var icon_img = td.find('.icon_img');
////	var path = "game_rs/app" + app_id + "/app_icon/" + fn;
////	icon_img.attr('src',path);
////	icon_img.attr('title',fn);
////	var icon_span = td.find('span');
////	icon_span.html(fn);
//	
//
//	
//}





