
<?php 
	$cssList = [
		'bootstrap.min',
		'CrudBase/dist/CrudBase.min',
		'SigninX/step2.css?v=1.0.1',
	];
	$this->assign('css', $this->Html->css($cssList));
	
	$jsList[] = [
		'jquery.min',
		'bootstrap.min',
		'jquery.validate.min',
		'vue.min',
		'CrudBase/dist/CrudBase.min.js',
		'SigninX/step2.js?v=1.0.0',
	];
	$this->assign('script', $this->Html->script($jsList,['charset'=>'utf-8']));
	
?>

<?php  echo $this->element('header_plain');?>

<div class="container-fluid">

<div id="err" style="color:red"></div>

<div class="form_w" >
	<div class="card card_ex" >
		<div class="card-header bg-success text-light">
			パスワード入力
		</div>
		<div class="card-body">
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
					<div class="form-group">
						<label for="password">パスワード</label>
						<input type="password" name="password" v-model="password" class="password form-control" placeholder="パスワード"/><br>
						<input type="password" name="password_confirm" class="password form-control"  placeholder="パスワード(もう一度)" />
						
					</div>
					<div class="form-group">
						<label for="nickname">名前</label>
						<input name="nickname" type="text" value="" v-model="nickname" class="form-control" placeholder="農業 好太郎" />
					</div>
					<div class="form-group">
						<label for="role" >種別</label>
						<select id="role" name="role" v-model="role" class="form-control">
							<option v-for="option in roleOptions" v-bind:value="option.value">
								{{ option.text }}
							</option>
						</select>
					</div>
					<div class="form-group">
						<button type="button" v-on:click="pwReg" class="btn btn-success">登録</button>
					</div>
				</form>
				<?php } ?>
				
				<div v-if="success">
					<div class="text-success">登録完了しました。</div>
					以上で全てのお手続きは終了です。<br>
					ログインしてシステムをご利用いただけます。<br>
					<a href="<?php echo CRUD_BASE_PROJECT_PATH; ?>/" class="btn btn-primary">ログイン</a>
				</div>
				
				<pre id="dev_mailtext" style="border: solid 4px red;padding:20px;color:#343434;display:none">開発環境用のメッセージ</pre>
			</div><!-- app1 -->
		</div><!-- card-body -->
	</div><!-- card -->
</div><!-- form_w -->

<input type="hidden" id="csrf_token" value="<?php echo $csrf_token; ?>" >
<?php CrudBaseU::hiddenOfCrudBaseConfigJson(); ?>


<?php echo $this->element('footer'); ?>
</div><!-- container-fluid -->