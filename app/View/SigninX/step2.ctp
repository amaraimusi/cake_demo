
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
		'SigninX/SigninX.js?v=1.0.0',
		'SigninX/step2.js?v=1.0.0',
	];
	$this->assign('script', $this->Html->script($jsList,['charset'=>'utf-8']));
	
?>

<input type="button" value="テストデータを入力" class="btn btn-secondary" onclick="inputTestData()" /><br>
<br>
<div id="err" style="color:red"></div>

<div id="app1" style="display:none">
	<?php if($limit_over_flg==1){ ?>
	<div class="text-danger">
		制限時間を超過しました。お手数ですがメール入力からやり直しをお願いします。<br>
		<a href="<?php echo CRUD_BASE_PROJECT_PATH; ?>/signin_x" class="btn btn-info">やり直す</a>
	</div>
	<?php } else { ?>
	<form id="step2_form" v-if="form_visible">
		<input type="hidden" id="repw_flg" value="<?php echo $repw_flg; ?>">
		<input type="hidden" id="user_json" value='<?php echo $user_json; ?>'>
		<div class="inp_w">
			<label for="password">パスワード</label><br>
			<input type="password" name="password" v-model="password" class="password" placeholder="パスワード"/><br>
			<input type="password" name="password_confirm" class="password"  placeholder="パスワード(もう一度)" />
			
		</div>
		<div class="inp_w">
			<label for="nickname">名前</label>
			<input name="nickname" type="text" value="" v-model="nickname" placeholder="農業 好太郎" />
		</div>
		<div class="inp_w">
			<label for="role" v-mode="role">種別</label>
			<select name="role">
				<option value="operator">オペレータ</option>
				<option value="client">クライアント</option>
			</select>
		</div>
		<div class="inp_w">
			<button type="button" v-on:click="pwReg" class="btn btn-success">登録</button>
		</div>
	</form>
	<?php } ?>
	
	<div v-if="success">
		<div class="text-success">登録完了しました。</div>
		以上で全てのお手続きは終了です。<br>
		ログインしてシステムをご利用いただけます。<br>
		<a href="<?php echo CRUD_BASE_PROJECT_PATH; ?>/neko" class="btn btn-primary">ログイン</a>
	</div>
	
	<pre id="dev_mailtext" style="border: solid 4px red;padding:20px;color:#343434;display:none">開発環境用のメッセージ</pre>
</div><!-- app1 -->

<input type="hidden" id="csrf_token" value="<?php echo $csrf_token; ?>" >
<?php CrudBaseU::hiddenOfCrudBaseConfigJson(); ?>


<div class="yohaku"></div>