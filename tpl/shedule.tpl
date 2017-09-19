<?php
require_once($PathLoc."/cls/avc_shedule.cls");
function isCheck($lsh,$obj){
    $ret="";
    if($lsh->isSetItem($obj))$ret ="checked";
    return($ret);
}
$sh=new avcShedule();
$sh->Init();
?>
<div class="page-header">
  <h1>Задания на выполнение по рассписанию</h1>
</div>
<div class="container-fluid">
<div class="btmenu">
<button class='button addsvc'>Добавить задание</button>
</div>
<div class="items">
<?php
$sh->Select();
$kvo=count($sh->arr);
for($i=0;$i<$kvo;$i++){
    $sh->GetItem($sh->arr[$i]);
    $tmp="".$sh->time;
    $lhor="";
    if(strlen($tmp)==3){
        $lhor=substr($tmp,0,1);
        $lmin=substr($tmp,1);
    }else {
        $lhor=substr($tmp,0,2);
        $lmin=substr($tmp,2);
    };
?>
<div class="item" data-id="<?= $sh->id ?>">
<div class="caps">Задача № <?= $sh->id ?>; <?= $sh->name ?></div>
<div class="row">
<div class="lside">
<div class="str"><span>Описание:</span><input class='pl_name' value='<?= $sh->name ?>' data-id="<?= $sh->id ?>"></div>
<div class="str"><span>Описание:</span><textarea class='pl_descr' data-id="<?= $sh->id ?>"><?= $sh->descr ?></textarea></div>
<div class="str">
<table>
<thead><tr><th>Пн</th><th>Вт</th><th>Ср</th><th>Чт</th><th>Пт</th><th>Сб</th><th>Вс</th></tr></thead>
<tbody><tr data-id="<?= $sh->id ?>"> 
            <td><input data-id="1" type="checkbox" <?php if(substr($sh->shed,1,1)=="1") echo "checked";?>></td>
            <td><input data-id="2" type="checkbox" <?php if(substr($sh->shed,2,1)=="1") echo "checked";?>></td>
            <td><input data-id="3" type="checkbox" <?php if(substr($sh->shed,3,1)=="1") echo "checked";?>></td>
            <td><input data-id="4" type="checkbox" <?php if(substr($sh->shed,4,1)=="1") echo "checked";?>></td>
            <td><input data-id="5" type="checkbox" <?php if(substr($sh->shed,5,1)=="1") echo "checked";?>></td>
            <td><input data-id="6" type="checkbox" <?php if(substr($sh->shed,6,1)=="1") echo "checked";?>></td>
            <td><input data-id="0" type="checkbox" <?php if(substr($sh->shed,0,1)=="1") echo "checked";?>></td></tr></tbody>
</table>
</div>
<div class="str">
<table class="tb-time">
<thead><tr><th>Часы</th><th>+/-</th><th>Минуты</th><th>+/-</th></tr></thead>
<tbody><tr><td><input class='time-h' type='text' data-gid="<?= $sh->id ?>" value="<?= $lhor?>"></td><td><span class='scrl glyphicon glyphicon-chevron-up' data-id='h1' data-gid="<?= $sh->id ?>"></span><span class='scrl glyphicon glyphicon-chevron-down' data-id='h0' data-gid="<?= $sh->id ?>"></span></td><td><input class='time-m' type='text'  data-gid="<?= $sh->id ?>" value="<?= $lmin?>"></td><td><span class='scrl glyphicon glyphicon-chevron-up' data-id='m1' data-gid="<?= $sh->id ?>"></span><span class='scrl glyphicon glyphicon-chevron-down' data-id='m0' data-gid="<?= $sh->id ?>"></span></td></tr></tbody>
</table>
</div>
<button class="btn save-item" data-id="<?= $sh->id ?>">Сохранить</button>
</div>
<div class="mside" data-id="<?= $sh->id ?>">
<div class="caps">Файловые группы:</div>

<div class="sitems">
<?php
require_once($PathLoc."/cls/avc_file.cls");
$fls=new avcFile();
$fkvo=$fls->GetGroups();
for($ii=0;$ii<$fkvo;$ii++){
    $fls->GetItem($fls->arr[$ii]);
?>
<div class="sitem" data-id='<?= $fls->id ?>' data-type='f'><input type="checkbox" class="check" <?= isCheck($sh,$fls)?>><span><?= $fls->name?></span></div>
<?php
}    
?>
</div><br>

<div class="caps">Доменные группы</div>

<div class="sitems">
<?php
require_once($PathLoc."/cls/avc_domine.cls");
$fls=new avcDomine();
$fkvo=$fls->GetGroups();
for($ii=0;$ii<$fkvo;$ii++){
    $fls->GetItem($fls->arr[$ii]);
?>
<div class="sitem" data-id='<?= $fls->id ?>' data-type='d'><input type="checkbox" class="check"  <?= isCheck($sh,$fls)?>><span><?= $fls->name?></span></div>
<?php
}    
?>
</div>
</div>
<div class="rside">
<div class="icon" data-id="<?= $sh->id ?>" data-val="<?= $sh->valid ?>"><img class="sicon stop" src="img/stop.jpg"><img class="sicon run" src="img/run.png"></div>
<button class="button btn runsvc" data-id="<?= $sh->id ?>"></button><br><br>
<button class="button btn delsvc">УДАЛИТЬ</button>
</div>
</div>
</div>
<?php
}
?>
</div>
</div>