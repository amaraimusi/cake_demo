


<!DOCTYPE html>
<html lang="ja">
<head>
	<?php echo $this->Html->charset("utf-8"); ?>
	<title>CrudBase 見本</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<?php
		echo $this->Html->meta('icon');

		echo $this->Html->css(array(
			'bootstrap.min',
			'CrudBase/common',
		));


		echo $this->Html->script(array(
			'jquery.min',
			'bootstrap.min',
			'Layouts/default',
			));
		
		echo $this->fetch('meta');
		echo $this->fetch('css');
		echo $this->fetch('script');
	?>


</head>

<body>

<?php  echo $this->element('header_plain');?>

<div class="container">
	<div style="text-align:center;padding:100px;">
		<h2 class="text-danger">CrudBase 見本</h2>
		
		<?php if($err == ''){?>
		<a href="<?php echo CRUD_BASE_PROJECT_PATH;?>" class="btn btn-info btn-lg">HOME</a>
		<?php }else{ ?>
		<div class='text-danger'><?php echo $err; ?></div>
		<a href="<?php echo CRUD_BASE_PROJECT_PATH;?>/users/login" class="btn btn-info btn-lg">ログイン画面に戻る</a>
		<?php } ?>
	</div>
</div>
</body>