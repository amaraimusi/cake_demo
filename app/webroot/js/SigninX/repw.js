
/**
 * 初期化
 */
let signinX; // SigninX.js サインインX
$(() => {
	
	signinX = new SigninX();
	
	signinX.repw(); // パスワード再発行・メール入力画面の初期化
	
});
