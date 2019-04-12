/**
 * 住所緯度経度・編集機能
 * @date 2019-4-11
 * @version 1.0.0
 */
class AddrLatLng{
	
	/**
	 * コンストラクタ
	 * 
	 * @param object param
	 * - map_xid マップのID属性名
	 * - wrap_xid ラッパーのID属性名
	 * - address_tb_xid 住所テキストボックスのID属性
	 * - lat_tb_xid 緯度テキストボックスのID属性
	 * - lng_tb_xid 経度テキストボックスのID属性
	 * - err_xid エラー表示要素のID属性
	 * - zoom Mapsの初期ズーム
	 * 
	 */
	constructor(param){
		param = this._setParamIfEmpty(param);
		this.param = param;
		this.map; // Mapsオブジェクト
		this.infoWindow1; // 吹き出しウィンドウ
		this.marker; // マーカーオブジェクト
		this.geocoder; // ジオコーディングオブジェクト | google.maps.Geocoder(); | 住所から緯度経度取得に利用
		this.init_flg = false; // 初期化済みフラグ
		this.wrapElm = jQuery('#' + param.wrap_xid);
		this.addrElm = jQuery('#' + param.address_tb_xid);
		this.latElm = jQuery('#' + param.lat_tb_xid);
		this.lngElm = jQuery('#' + param.lng_tb_xid);
		this.errElm = jQuery('#' + param.err_xid);
	}
	
	
	/**
	 * If Param property is empty, set a value.
	 */
	_setParamIfEmpty(param){
		
		if(param == null) param = {};
		
		if(param['map_xid'] == null) throw new Error("Empty 'map_xid'!");
		if(param['wrap_xid'] == null) throw new Error("Empty 'wrap_xid'!");
		if(param['address_tb_xid'] == null) throw new Error("Empty 'address_tb_xid'!");
		if(param['lat_tb_xid'] == null) throw new Error("Empty 'lat_tb_xid'!");
		if(param['lng_tb_xid'] == null) throw new Error("Empty 'lng_tb_xid'!");
		if(param['err_xid'] == null) param['err_xid'] = 'err';
		
		if(param['def_lat'] == null) param['def_lat'] = 35.36063613713634; // デフォルト緯度： 富士山の位置がデフォルト
		if(param['def_lng'] == null) param['def_lng'] = 138.72732639312744;
		if(param['lat'] == null) param['lat'] = param.def_lat;
		if(param['lng'] == null) param['lng'] = param.def_lng;
		if(param['zoom'] == null) param['zoom'] = 15;
	
		return param;
	}
	
	
	/**
	 * 初期化
	 */
	init(){

		var param = this.param;
		
		var mapElm = jQuery('#' + param.map_xid)

		// 地図を作成
		var map = new google.maps.Map( mapElm[0], {
			center: new google.maps.LatLng(param.lat, param.lng ),
			zoom: param.zoom ,
		});
		this.map = map;
		
		// マーカーの作成
		var marker = new google.maps.Marker( {
			map: map ,
			position: new google.maps.LatLng( param.lat, param.lng ) ,
		}) ;
		this.marker = marker;
		
		// 地図のクリックイベント
		map.addListener( "click", ( argument ) => {
			this._clickOnMap(argument);
		}) ;
		
		
		this.init_flg = true; // 初期化済みにする
		
	}
	
	/**
	 * 地図のクリックイベント
	 * @param argument レスポンス
	 */
	_clickOnMap(argument){
		var latLng = argument.latLng;
		var lat = latLng.lat();
		var lng = latLng.lng();
		var place_id = argument.placeId;

		// テキストボックスに緯度経度をセットする
		this.latElm.val(lat);
		this.lngElm.val(lng);

		this.param.lat = lat;
		this.param.lng = lng;

	}
	
	
	/**
	 * 住所緯度経度・編集機能 :地図表示アクション
	 * @param jQuery btnElm ボタン要素
	 */
	addrLatLngShowMap(btnElm){
		this.wrapElm.show();
		this._errShow(''); // エラーメッセージをクリア
		
		if(this.init_flg == false){
			this.init();
		}
		

		var param = this.param;
		
		// 緯度経度を取得する
		var lat = this.latElm.val();
		var lng = this.lngElm.val();
		if(this._empty(lat)) lat = param.def_lat;
		if(this._empty(lng)) lng = param.def_lng;
		
		// 地図の中心位置を移動
		var latLng = new google.maps.LatLng( lat, lng );
		this.map.setCenter(latLng);
		
		// マーカーの位置移動
		this.marker.setPosition(latLng);
		
		this.param.lat = lat;
		this.param.lng = lng;
		
		
	}
	
	// Check empty.
	_empty(v){
		if(v == null || v == '' || v=='0'){
			return true;
		}else{
			if(typeof v == 'object'){
				if(Object.keys(v).length == 0){
					return true;
				}
			}
			return false;
		}
	}


	/**
	 * 住所緯度経度・編集機能 :住所から自動設定
	 * @param jQuery btnElm ボタン要素
	 */
	addrLatLngAutoSet(btnElm){

		this._errShow(''); // エラーメッセージをクリア

		// 住所、地名、ランドマークなどを入力
		var address_text = this.addrElm.val();
		
		if(this._empty(address_text)){
			this._errShow('住所を入力してください');
			return;
		}
		
		//ジオコーディングの取得、またはインスタンス生成
		if(this.geocoder == null){
			this.geocoder = new google.maps.Geocoder(); 
		}
		var geocoder = this.geocoder;
	
		// 住所、地名、ランドマークなどから正規住所、プレースID、緯度経度を取得する
		geocoder.geocode({address: address_text}, (results, status) => {
			if (status === 'OK' && results[0]){
				var result = results[0];

				// 住所の緯度経度を取得
				var lat = result.geometry.location.lat();
				var lng = result.geometry.location.lng();
				
				// 緯度経度テキストボックスへセット
				this.latElm.val(lat);
				this.lngElm.val(lng);
				
				// 地図が初期化済みならMapsにも位置をセットする
				if(this.init_flg){
					
					// 地図を住所の位置へ移動させる
					this.map.setCenter(result.geometry.location);
					
					// マーカーを住所の位置へ移動させる
					this.marker.setPosition(result.geometry.location);
				}

			}else{
				this._errShow('住所の場所は見つかりませんでした。'); // エラーメッセージをクリア
			}
		}); 
		
	}
	
	
	/**
	 * エラー表示
	 * @param string エラーメッセージ
	 */
	_errShow(err_msg){
		this.errElm.html(err_msg);
	}
	
	
	/**
	 * 編集フォーム表示時に呼び出される
	 */
	addrLatLngEditShow(){
		if(this.init_flg==false) return;
		
		var param = this.param;
		this._errShow(''); // エラーメッセージをクリア
		
		// 緯度経度を取得する
		var lat = this.latElm.val();
		var lng = this.lngElm.val();
		if(this._empty(lat)) lat = param.def_lat;
		if(this._empty(lng)) lng = param.def_lng;
		
		// 地図の中心位置を移動
		var latLng = new google.maps.LatLng( lat, lng );
		this.map.setCenter(latLng);
		
		// マーカーの位置移動
		this.marker.setPosition(latLng);
		
		this.param.lat = lat;
		this.param.lng = lng;
		
	}
	
	
}