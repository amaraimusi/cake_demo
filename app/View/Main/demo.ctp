<?php



$ver_str = '?v=1.0.0';

// CSSファイルのインクルード
$cssList = CrudBaseU::getCssList();
$cssList[] = 'Main/demo.css' . $ver_str; // 当画面専用CSS
$this->assign('css', $this->Html->css($cssList));

// JSファイルのインクルード
$jsList = CrudBaseU::getJsList();
//$jsList[] = 'Main/demo.js' . $ver_str; // 当画面専用JavaScript
$this->assign('script', $this->Html->script($jsList,['charset'=>'utf-8']));

?>

<?php	echo $this->element('header_demo');?>

<div class="container-fluid">

	<div style="padding-top:20px;">
		<h1 class="text-dark">テスト農業セミナー</h1>
		<h2 class="text-secondary">開催日時：2021年4月27日 20:00</h2>
	</div>
	
	<div class="row">
		<div class="col-7">
			<img src="../img/Main/demo/demo1.jpg" style="width:100%"/><br>
			
			<div class="card" style="margin-top:20px">
				<div class="card-header">
					セミナー内容
				</div>
				<div class="card-body">
					人類はもともとはもっぱら狩猟採集を行って生きていたと考えられており（狩猟採集社会）、どこかの段階で農業を"始めた"と考えられている。
					農業の起源については諸説あるが、ハーバード大学、テルアビブ大学とハイファ大学の共同チームは、イスラエルのガリラヤ湖岸で、23,000年前の農耕の痕跡(オオムギ、ライムギ、エンバク、エンメル麦)を発見したと、ニューヨーク・タイムズなどで報道されている。<br><!--	-->
					<br>
					また、約10000年ほど前、中国の長江流域で稲作を中心とした農耕が始められていたことが発掘調査で確認されている。またレバント（シリア周辺、肥沃な三日月地帯の西半分）では、テル・アブ・フレイラ遺跡（11050BP, 紀元前9050年頃）で最古級の農耕の跡（ライムギ）が発見されている。
					イモ類ではパプアニューギニアにて9000年前の農業用灌漑施設の跡「クックの初期農耕遺跡」がオーストラリアの学術調査により発見されている。農耕の開始と同時期に牧畜も開始された。<br>
					<br>
					中緯度の狩猟民が定住化した後に農耕や牧畜を開始したことは「農業革命」と呼ばれており、その後の人類の社会に大きな影響を与えた。<br>
				</div>
			</div>
			
			<div style="margin-top:20px;">
				<video controls width="100%">
					<source src="../img/Main/demo/MVI_1021.MP4" type="video/mp4">
				</video>
			</div>
		</div>
		<div class="col-5" style="text-align:center:">
			<div class="card border-success">
				<div class="card-body">
					<h5 class="card-title">セミナーに参加します</h5>
					<div class="card-text">
						<div style="padding:12px">
							ログイン後に申込みができます。<br>
							<a href="#" class="btn btn-primary btn-sm">ログイン</a>
							<a href="#" class="btn btn-success btn-sm">新規会員登録</a>
						</div>
						<div><a href="#" class="btn btn-warning btn-lg btn-block text-light" >申込み</a></div>
					</div>
				</div>
			</div>

			<div class="card" style="font-size:1.2em;margin-top:20px">
				<div class="card-header">
					インフォメーション
				</div>
				<div class="card-body">
				<ul class="list-group list-group-flush">
					<li class="list-group-item">
						<span class="badge badge-secondary" >カテゴリ</span>
						農業
					</li>
					<li class="list-group-item">
						<span class="badge badge-secondary" >場所</span>
						ZOOM
					</li>
					<li class="list-group-item">
						<span class="badge badge-secondary" >時間</span>
						2時間
					</li>
				</ul>
				</div>
			</div>
			
			<div class="card" style="margin-top:20px">
				<div class="card-header">
					コミュニティボード
				</div>
				<div class="card-body">
					<h5 class="card-title">当セミナーの掲示板です。</h5>
					<div class="card-text">
						すべての会員が自由に閲覧および書き込みができるメッセージボードです。
						告知についてもこちらから確認できます。
					</div>
					<div style="padding:12px">
						<a href="#" class="btn btn-info" >ページへ移動</a>
						<aside>※ログイン後に利用できます。</aside>
					</div>
				</div>
			</div>
			<div class="card" style="margin-top:20px">
				<div class="card-header">
					問い合わせ
				</div>
				<div class="card-body">
					<h5 class="card-title">主催者へ質問します。</h5>
					<div class="card-text">
						主催者に個人的にでメッセージを送りたい場合はこちらをご利用ください。
						<aside>※一対一のメッセージやり取りです。</aside>
					</div>
					<div style="padding:12px">
						<a href="#" class="btn btn-info" >ページへ移動</a>
						<aside>※ログイン後に利用できます。</aside>
					</div>
				</div>
			</div>
		</div><!-- col-5 -->
	</div>
	




</div><!-- container-fluid -->
