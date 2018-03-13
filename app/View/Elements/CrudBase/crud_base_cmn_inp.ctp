<?php

$this->CrudBase->hiddenX('act_flg',1);
$this->CrudBase->hiddenX('page_no',$pages['page_no'] );
$this->CrudBase->hiddenX('limit',$pages['limit'] );
$this->CrudBase->hiddenX('sort',$pages['sort'] );
$this->CrudBase->hiddenX('sort_type',$pages['sort_type'] );
$this->CrudBase->hiddenX('iniFlg',$iniFlg );
$this->CrudBase->hiddenX('crudType',$crudType );
$this->CrudBase->hiddenX('webroot',$this->Html->webroot );
$this->CrudBase->hiddenX('csh_json',$csh_json );
$this->CrudBase->hiddenX('bigDataFlg',$bigDataFlg );
$this->CrudBase->hiddenX('debug_mode',$debug_mode );
$this->CrudBase->hiddenX('defKjsJson',$defKjsJson );
$this->CrudBase->hiddenX('row_exc_flg',$row_exc_flg );

?>