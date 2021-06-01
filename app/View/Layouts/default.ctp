<!DOCTYPE html>
<html lang="ja">
<head>
	<?php echo $this->Html->charset("utf-8"); ?>
	<title>
		<?php echo $title_for_layout; ?>
	</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<?php
		echo $this->Html->meta('icon');
		
		echo $this->fetch('meta');
		echo $this->fetch('css');
		echo $this->fetch('script');
	?>


</head>
<body style="padding-top:0px;">

	
	<?php 
	echo $this->Session->flash();
	echo $content_for_layout;
	?>

	<?php 
	// SQLダンプ
	if(!empty($sql_dump_flg)){
		echo $this->element('sql_dump'); 
	}
	?>
</body>
</html>
