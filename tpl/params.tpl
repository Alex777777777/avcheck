<?php
require_once($PathLoc."/cls/avc_engs.cls");
$engs=new avcEngines();
$param=new avc_param();
?>
<div class="page-header">
  <h1>Параметры движков проверки</h1>
</div>
<div class="container-fluid">
<?php
$arr=$engs->GetEngsName();
foreach($arr as $leng){
    $param->parent=$leng["idkey"];
    $param->ptype=$leng["enkey"];
?>
<div class="item" data-id="<?= $leng["idkey"] ?>">
<div class="lside">
<div class="i_str"><div class="caps">Наименование движка:</div><div class="vals iname"><?= $leng["name"] ?></div></div>
<div class="i_str"><div class="caps">Скрипт:</div><div class="vals"><?= $leng["script"] ?></div></div>
<div class="i_str"><div class="caps">Класс:</div><div class="vals"><?= $leng["class"] ?></div></div>
<div class="i_str"><div class="caps">Описание:</div><div class="vals"><textarea data-id="<?= $leng["id"] ?>"><?= $leng["descr"] ?></textarea></div></div>
</div>
<div class="mside">
<div class="i_str"><div class="caps">Api key:</div><div class="vals"><input type="text" class="parval" data-name="apikey" data-id="<? $leng["id"]?>" value="<?= $param->GetByName("APIKEY")?>"></div></div>
<div class="i_str"><div class="caps">Api user:</div><div class="vals"><input type="text" class="parval" data-name="apiuser" data-id="<? $leng["id"]?>" value="<?= $param->GetByName("APIUSER") ?>"></div></div>
<div class="i_str"><button class="btn saveprm" data-id="<?= $leng["idkey"]?>">Сохранить</button></div>
</div>
</div>
<?php        
}    
?>


</div>
