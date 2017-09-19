<?php
require_once($PathLoc."/cls/avc_file.cls");
$gps=new avcFile();
$gps->GetGroups();
?>
<div class="page-header">
  <h1>Управление файлами</h1>
</div>
<div class="container-fluid">
<div class="row">
<div class="col-md-2 sidebar">
<h3>Группы</h3>
<ul class="gpss">
<?php
$cls="class='active'";
for($i=0;$i<count($gps->arr);$i++){
    $gps->GetItem($gps->arr[$i]);
    echo "<li $cls data-id='".$gps->id."'>".$gps->name."</li>";
    $cls="";
}
?>
</ul>
<button class="btn addgrp">Добавить группу</button>
<button class="btn delgrp">Удалить группу</button>
<button class="btn avgrp">AV Проверкa</button>
</div>
<div class="col-md-6 midbar">
<h3>Группа</h3>
<h4>Файлы группы</h4>
<div class="panel-files">
</div> 
</div>
    <div class="col-md-4 rtbar">
        <h3>Свойства</h3>
        <div class="panel_prop">
        <div class="panel_prop1">
        </div>
        <div class="panel_prop2">
            <button class="btn dwnfl">Скачать</button>
            <button class="btn delfl">Удалить</button>
            <?php
            if($user->role==1){
                $lus=new ShellUser();
                $lus->Select();
            ?>
            <button class="btn avfl">AV Проверка</button>
            <button class="btn copfl">Копировать юзеру</button>
            <select class="seluser">
            <?php
                for($i=1;$i<=count($lus->arr);$i++){
                    $lus->GetItem($lus->arr[$i]);
                    if($lus->role!=0){
                        if($lus->id != $user->id){
                           echo  "<option value='" . $lus->id . "'>" . $lus->login ."</option>";
                        }
                    }
                }
            ?>
                
            </select>
            <?php
            } 
            ?>
        </div>
        </div>
    </div>
</div>
</div>
<div id='addfrm'>
<h3>Добавление группы</h3>
<div class="frm_str"><span>Наименование:</span><input type='text' placeholder="Новая группа"></div>
<div class="frm_str"><button class="frmbtn btn" data-id="NO">Отмена</button><button class="frmbtn btn" data-id="OK">Сохранить</button></div>
</div>