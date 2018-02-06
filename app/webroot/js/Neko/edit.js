$(function() {

	init();//初期化

});


/**
 * ネコ・入力画面の初期化
 * 
 * 日付系の入力フォームにjQueryカレンダーを組み込みます。
 * 
 * @date 2015-09-17 新規作成
 * @author k-uehara
 */
function init(){
	
	// --- Start js_edit_date
	//jQuery UIカレンダーの組み込みと日本語化(Layouts/default.js)
	datepicker_ja();
	
	//日付系の検索入力フォームにJQueryカレンダーを組み込む。
	$("#neko_date").datepicker({
		dateFormat:'yy-mm-dd'
	});
	// --- End js_edit_date
}















