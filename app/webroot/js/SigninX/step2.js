
/**
 * 初期化
 */
let signinX; // SigninX.js サインインX
$(() => {
	
	signinX = new SigninX();
	
	signinX.step2(); // step2:本登録アクション
	
});


function inputTestData(){
	$("[name='nickname']").val('山田　耕作');
	$("[name='nickname']")[0].dispatchEvent(new Event('input')); // vue.js側に変更をイベント発信する
	$("[name='password']").val('abcd1234');
	$("[name='password']")[0].dispatchEvent(new Event('input')); // vue.js側に変更をイベント発信する
	$("[name='password_confirm']").val('abcd1234');
}