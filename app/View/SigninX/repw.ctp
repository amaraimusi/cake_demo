
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
		'SigninX/repw.js?v=1.0.0',
	];
	$this->assign('script', $this->Html->script($jsList,['charset'=>'utf-8']));
	
?>
<style>

</style>


<br>
<div id="err" style="color:red"></div>

<!-- step1:メールアドレス入力画面表示の初期化 -->
<div id="app1" style="display:none">
	<form id="form1" v-if="form_visible">
		<div id="err" class="text-danger"></div>
		<div class="inp_w">
			<label for="email">Eメール</label>
			<input name="email" type="text" value="" v-model="email" placeholder="example@example.com" style="width:70%"/>
		</div>
		<div class="inp_w">
			<button type="button" v-on:click="tempRegActionForRepw" class="btn btn-warning btn-sm">パスワード再発行確認</button>
		</div>
	</form>
	<div class="text-success" v-if="send_mail_msg_visible">確認メールを送信しました。引き続き、メールからお手続きをすすめてください。</div>

	<pre id="dev_mailtext" style="border: solid 4px red;padding:20px;color:#343434;display:none">開発環境用のメッセージ</pre>
	
</div><!-- app1 -->

<input type="hidden" id="csrf_token" value="<?php echo $csrf_token; ?>" >
<?php CrudBaseU::hiddenOfCrudBaseConfigJson(); ?>




<div class="yohaku"></div>