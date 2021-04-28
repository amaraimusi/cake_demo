
/**
 * 初期化
 */
let signinX; // SigninX.js サインインX
$(() => {
	
	signinX = new SigninX();
	
	let param = {
		def_role: 'oparator', // デフォルト権限
		roleOptions: [
			{ text: 'オペレータ', value: 'oparator' },
			{ text: 'クライアント', value: 'client' },
		]
	};
	
	signinX.step2(param); // step2:本登録アクション
	
});


function inputTestData(){
	$("[name='nickname']").val('山田　耕作');
	$("[name='nickname']")[0].dispatchEvent(new Event('input')); // vue.js側に変更をイベント発信する
	$("[name='password']").val('abcd1234');
	$("[name='password']")[0].dispatchEvent(new Event('input')); // vue.js側に変更をイベント発信する
	$("[name='password_confirm']").val('abcd1234');
}