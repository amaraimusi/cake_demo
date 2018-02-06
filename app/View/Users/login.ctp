
<!DOCTYPE html>
<html>
<head>
    <?php echo $this->Html->charset(); ?>
    <title>login</title>
    <?php echo $this->Html->css(array('bootstrap.min', 'bootstrap-responsive.min', 'style')); ?>
    <?php echo $this->Html->script(array('bootstrap', 'smoothScroll', 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.js')); ?>
    <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }
    </style>
<body data-spy="scroll">
    <div class="container">

	<div>
	デモ用のシステムです。以下のアカウントでログインできます。<br>
	ユーザー名:test<br>
	パスワード:test<br>
	</div>
<div class="well" style="width: 200px">

    <?php
    echo $this->Form->create('User', array(
        'inputDefaults' => array('label' => false, 'div' => false, 'legend' => false),
        'class' => 'bs-example form-horizontal'
    ));
    ?>
        <fieldset>
            <?php
            echo $this->Form->input('username', array(
                'div'   => false,
                'label' => false,
                'class' => 'form-control',
            ));
            echo $this->Form->input('password', array(
                'div'   => false,
                'label' => false,
                'class' => 'form-control',
            ));
        ?>
        </fieldset>
    <?php
    echo $this->Form->submit('login', array('div' => false, 'class' => 'btn btn-primary'));
    echo $this->Form->end();
    ?>
</div>

    </div>
</body>
</html>