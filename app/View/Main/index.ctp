<?php

// CSSファイルのインクルード
$cssList = CrudBaseU::getCssList();
$cssList[] = 'Main/index.css?v=1.0.0'; // 当画面専用CSS
$this->assign('css', $this->Html->css($cssList));

// JSファイルのインクルード
$jsList = CrudBaseU::getJsList();
$jsList[] = 'Main/index.js?v=1.0.0'; // 当画面専用JavaScript
$this->assign('script', $this->Html->script($jsList,array('charset'=>'utf-8')));

?>

<div class="bannar">
	<div class="bannar_text">
		CrudBase見本 Cake PHP2版
	</div>
</div>

<div style="margin-top:50px">

<div class="row">
	<div class="col-12 col-md-2"></div>
	<div class="col-12 col-md-8" style="text-align:center">
		<div style="display:inline-block">
			<h2 class="text-success">目次</h2>
			<ol style="font-size:1.6em;text-align:left;">
				<li><a href="neko" >基本システムの見本</a></li>
				<li><a href="signin_x" >サインインの見本</a></li>
				<li><a href="msg_board" >メッセージボードの見本</a></li>
			</ol>
		</div>
	</div>
	<div class="col-12 col-md-2"></div>
</div>

</div>


<div class="yohaku"></div>




















