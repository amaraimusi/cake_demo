/**
 * CrudBase:indexページのJavaScript
 * 
 * @version 1.1
 */

/**
 * 列並替画面に遷移する
 * @param page_code ページコード (モデル名のスネーク表示）
 */
function moveClmSorterBase(page_code){
	
	//列表示配列を取得して、URLクエリ用にエンコードする。
	var csh_ary=csh.getCshAry();
	
	var csh_json = null;
	if(csh_ary.length == 0){
		csh_json = $('#csh_json').val();
	}else{
		csh_json = JSON.stringify(csh_ary);
	}
	
	var csh_u=encodeURIComponent(csh_json);

	//列並替画面に遷移する。
	var webroot = $('#webroot').val();
	var url = webroot + 'clm_sorter?p=' + page_code + '&csh_u=' + csh_u;
	location.href=url;
	
}