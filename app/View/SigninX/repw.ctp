
<?php 
$cssList = CrudBaseU::getCssList();
$cssList[] = 'SigninX/repw.css?v=1.0.0';
$this->assign('css', $this->Html->css($cssList));

$jsList = CrudBaseU::getJsList();
$jsList[] = 'jquery.validate.min';
$jsList[] = 'SigninX/repw.js?v=1.0.0';
$this->assign('script', $this->Html->script($jsList,['charset'=>'utf-8']));
?>

<?php  echo $this->element('header_plain');?>

<div class="container-fluid">

<div id="err" style="color:red"></div>

<div class="form_w" >
	<div class="card card_ex" >
		<div class="card-header bg-success text-light">
			パスワード再発行
		</div>
		<div class="card-body">
			<!-- step1:メールアドレス入力画面表示の初期化 -->
			<div id="app1" style="display:none">
				<form id="form1" v-if="form_visible">
					<div class="form-group">
						<label for="email">メールアドレス</label>
						<input id="email" name="email" type="text" value="" v-model="email" class="form-control" placeholder="example@example.com" />
					</div>
					<div class="form-group">
						<button type="button" v-on:click="tempRegActionForRepw" class="btn btn-warning btn-sm">パスワード再発行確認</button>
					</div>
				</form>
				<div class="text-success" v-if="send_mail_msg_visible">確認メールを送信しました。引き続き、メールからお手続きをすすめてください。</div>

				<pre id="dev_mailtext" >開発環境用のメッセージ</pre>
	
			</div><!-- app1 -->
		</div><!-- card-body -->
	</div><!-- card -->
</div><!-- form_w -->

<input type="hidden" id="csrf_token" value="<?php echo $csrf_token; ?>" >
<?php CrudBaseU::hiddenOfCrudBaseConfigJson(); ?>



<?php echo $this->element('footer'); ?>
</div><!-- container-fluid -->