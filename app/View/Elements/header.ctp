<?php 

debug(CRUD_BASE_PATH . 'CrudBaseX.php');//■■■□□□■■■□□□)
	require_once CRUD_BASE_PATH . 'CrudBaseX.php';
	//CrudBaseX::getUserInfo();


	$auth_level = 0; // 権限レベル
	$authority_wamei = ''; // 権限名
	$username = ''; // ユーザー名

	$userInfo = $crudBaseData['userInfo'];

	$project_path = CRUD_BASE_PROJECT_PATH;
	if(!empty($userInfo['authority'])){
		$auth_level = $userInfo['authority']['level'];
		$authority_wamei = $userInfo['authority']['wamei'];
		if(!empty($userInfo['username'])) $username = $userInfo['username'];
	}


?>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="<?php echo CRUD_BASE_PROJECT_PATH;?>">食と農業関連セミナー 管理画面</a>

	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
			<a class="nav-link" href="<?php echo CRUD_BASE_PROJECT_PATH;?>">Home <span class="sr-only">(current)</span></a>
			</li>
			<li class="nav-item">
				<?php 
		
				if($auth_level > 30){
					echo '<a href="user_mng" class="nav-link">ユーザー管理画面</a>';
				}
				?>
			</li>
	
		</ul>
		
		<ul class="navbar-nav">
			<li class="nav-item">
				<?php if(empty($username)){ 
					echo "<a href='{$project_path}/users/login' class='nav-link'>ログイン</a>";
				} else {
					echo "{$username} ($authority_wamei)";
					echo "<a href='{$project_path}/users/logout' class='nav-link'>ログアウト</a>";
					
				}
				?>
			</li>
		</ul>
	</div>
</nav>



	