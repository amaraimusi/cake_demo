
<?php 

	$cssList = CrudBaseU::getCssList();
	$cssList[] = 'SigninX/index.css?v=1.0.0';
	$this->assign('css', $this->Html->css($cssList));
	
	$jsList = CrudBaseU::getJsList();
	$jsList[] = 'jquery.validate.min';
	$jsList[] = 'SigninX/index.js?v=1.0.0';
	$this->assign('script', $this->Html->script($jsList,['charset'=>'utf-8']));
	
?>

<?php  echo $this->element('header_plain');?>

<div class="container-fluid">

<div id="err" style="color:red"></div>

<div class="form_w" >
	<div class="card card_ex" >
		<div class="card-header bg-success text-light">
			新規会員登録
		</div>
		<div class="card-body">
			<!-- step1:メールアドレス入力画面表示の初期化 -->
			<div id="app1" style="display:none;" >
				<form id="step1_form" v-if="form_visible">
					<div class="form-group">
						<label for="email">メールアドレス</label>
						<input id="email" name="email" type="text" value="" v-model="email" class="form-control" placeholder="example@example.com" />
					</div>
					<div class="form-group">
						<button type="button" v-on:click="tempRegAction" class="btn btn-primary">確認</button>
					</div>
				</form>
				<div class="text-success" v-if="send_mail_msg_visible">確認メールを送信しました。引き続き、メールからお手続きをすすめてください。</div>
				<div v-if="repw_visible" class="text-danger" style="margin-top:20px">
					このメールアドレスはすでに登録されています。パスワードを忘れた場合は、以下のボタンからパスワードの再発行を行ってください。<br>
					<a href="<?php echo CRUD_BASE_PROJECT_PATH; ?>/signin_x/repw" class="btn btn-info">パスワード再発行</a>
				</div>
				<pre id="dev_mailtext" >開発環境用のメッセージ</pre>
				
			</div><!-- app1 -->
		</div><!-- card-body -->
	</div><!-- card -->
</div><!-- form_w -->

<input type="hidden" id="csrf_token" value="<?php echo $csrf_token; ?>" >
<?php CrudBaseU::hiddenOfCrudBaseConfigJson(); ?>


<?php echo $this->element('footer'); ?>
</div><!-- container-fluid -->