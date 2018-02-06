	<div class="navbar navbar-default navbar-fixed-top">
	  <div class="container">
		<div class="navbar-header">
		  <?php echo $this->Html->link('CakeDemo', '/', array('class' => 'navbar-brand', 'escape' => false)); ?>
		  <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		  </button>
		</div>
		<div class="navbar-collapse collapse" id="navbar-main">

			<ul class="nav navbar-nav ">
				<li class="top_menu_pull" style="z-index:2;">
					<a href="#" >設定</a>
					<ul>
						<li>XXX</li>
						<li>XXX</li>
					</ul>
				</li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li><a href="#">
					<?php 
						$update_user="";
						if(!empty($userInfo)){
							$update_user = $userInfo['update_user'];
						}
						echo $update_user;
					?>
				</a></li>
				<li><?php echo $this->Html->link('ログアウト', '/users/logout'); ?></li>
			</ul>
		</div>
	  </div>
	</div>
