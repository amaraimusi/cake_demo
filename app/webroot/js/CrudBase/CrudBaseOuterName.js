/**
 * 外部名称クラス： 外部idに紐づく外部テーブルの名前要素を制御
 * @since 2021-6-2
 * @license MIT
 * @version 1.0.0
 */
class CrudBaseOuterName{
	
	init(crudBaseData){
		this.crudBaseData = crudBaseData;
		this.csrf_token = crudBaseData.csrf_token;

	}
	
	/**
	 * 外部idに紐づく外部テーブルの名前フィールドを取得する
	 */
	getOuterName(thisElm){
		thisElm = jQuery(thisElm);
		let parElm = thisElm.parents('.OuterName');
		let inpIdElm = parElm.find('.OuterName-id');
		let outerNameElm = parElm.find('.OuterName-name');
		let outer_id = inpIdElm.val();
		
		console.log(this.crudBaseData);//■■■□□□■■■□□□
		let model_name_s = this.crudBaseData.model_name_s;
		let crud_base_project_path = this.crudBaseData.crud_base_project_path;
		let ajax_url = crud_base_project_path + '/' + model_name_s + '/getOuterName'
		console.log('ajax_url＝' + ajax_url);//■■■□□□■■■□□□
		
		console.log('C2');//■■■□□□■■■□□□
		console.log(outer_id);//■■■□□□■■■□□□
	}
	
}