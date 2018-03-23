/**
 * CrudBaseガシェット管理クラス（検索条件の入力要素用）
 * 
 * @date 2018-3-23
 * @version 1.0
 */
class CrudBaseGadgetKj{

	constructor(kjElms){
		this.kjElms = kjElms; // 検索条件要素リスト
		this.gadgets; // ガジェットオブジェクトリスト
	}
	
	
	/**
	 * ガシェットを各入力要素に組み込む
	 */
	onGadgetsToElms(){
 
		var gadgets = {};
		
		for(var field in this.kjElms){

			var kjElm = this.kjElms[field];
			var gadget_name = kjElm.attr('data-gadget');

			if(gadget_name == null) continue;
			
			if(gadgets[gadget_name] == null) gadgets[gadget_name] = {};

			if(gadget_name == 'nouislider'){
				gadgets[gadget_name][field] = this._initNouislider(field,kjElm);
			}

		}
		this.gadgets = gadgets;
	}
	
	/**
	 * Noスライダーを検索条件要素に組み込む
	 * @param string field フィールド
	 * @param jQuery_Object kjElm 検索条件要素
	 */
	_initNouislider(field,kjElm){
		
		field = this._removeKjHash(field); // フィールドから「kj_」部分を除去する
		
		var noUiSlider = new NoUiSliderWrap();///ネコ数値の数値範囲入力スライダー
		
		var slider = '#' + field + '_slider';
		var tb1 = '#kj_' + field + '1';
		var tb2 = '#kj_' + field + '2';
		var value_preview = '#' + field + '_preview';
		
		//noUiSliderの初期化（数値範囲入力スライダー）
		noUiSlider.init(noUiSlider,{
				'slider':slider,
				'tb1':tb1,
				'tb2':tb2,
				'value_preview':value_preview,
				'step':5,
				'min':0,
				'max':200,
			});
		
		return noUiSlider;
	}
	
	/**
	 * フィールドから「kj_」部分を除去する
	 * @param string field フィールド
	 * @return string 「kj_」部分を除去したフィールド
	 */
	_removeKjHash(field){
		 
		if(field==null) return field;
		if(field.length <= 3) return field;
		
		var s3=field.substring(0,3);
		if(s3 == 'kj_'){
			field = field.substring(3,field.length);
		}
		
		return field;
	}
	
	
	
	/**
	 * 各ガシェットのリセット
	 */
	reset(){
		
		// noUiSliderの再表示
		if (this.gadgets['nouislider']){
			var nouisliderList = this.gadgets['nouislider'];
			for(var i in nouisliderList){
				var nouislider = nouisliderList[i];
				console.log('test=Ａ６');//■■■□□□■■■□□□■■■□□□)
				nouislider.reload();//数値範囲入力スライダー・noUiSliderの再表示(nouislider_rap.js)
			}
		}
		
	}
}