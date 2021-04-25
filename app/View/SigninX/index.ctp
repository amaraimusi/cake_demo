
<?php 
	$cssList = [
		'bootstrap.min',
		'CrudBase/dist/CrudBase.min',
	];
	$this->assign('css', $this->Html->css($cssList));
	
	$jsList[] = [
		'jquery.min',
		'bootstrap.min',
		'jquery.validate.min',
		'vue.min',
		'CrudBase/dist/CrudBase.min.js',
		'SigninX/index.js?v=1.0.0',
	];
	$this->assign('script', $this->Html->script($jsList,['charset'=>'utf-8']));
	
?>
<style>

</style>



<input type="button" value="テストデータを入力" class="btn btn-default" onclick="testDataInput()" /><br>
<br>
<div id="err" style="color:red"></div>

<!-- step1:メールアドレス入力画面表示の初期化 -->
<div id="app1" style="display:none">
	<form id="step1_form" v-if="form_visible">
		<div id="err" class="text-danger"></div>
		<div class="inp_w">
			<label for="email">Eメール</label>
			<input name="email" type="text" value="" v-model="email" placeholder="example@example.com" style="width:70%"/>
		</div>
		<div class="inp_w">
			<button type="button" v-on:click="tempRegAction" class="btn btn-success">確認</button>
		</div>
	</form>
	<div class="text-success" v-if="send_mail_msg_visible">確認メールを送信しました。引き続き、メールからお手続きをすすめてください。</div>
	<div v-if="repw_visible" class="text-danger" style="margin-top:20px">
		このメールアドレスはすでに登録されています。パスワードを忘れた場合は、以下のボタンからパスワードの再発行を行ってください。<br>
		<a href="<?php echo CRUD_BASE_PROJECT_PATH; ?>/signin_x/repw" class="btn btn-info">パスワード再発行</a>
	</div>
	<pre id="dev_mailtext" style="border: solid 4px red;padding:20px;color:#343434;display:none">開発環境用のメッセージ</pre>
	
</div><!-- app1 -->

<input type="hidden" id="csrf_token" value="<?php echo $csrf_token; ?>" >
<?php CrudBaseU::hiddenOfCrudBaseConfigJson(); ?>




<div class="yohaku"></div>