<?php
require_once($PathLoc."/cls/avc_domine.cls");
$gps=new avcDomine();
$gps->GetGroups();
?>
<div class="page-header">
  <h1>Управление domen/ip</h1>
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
<div class="col-md-8 midbar">
<h3>Группа</h3>
<h4>Елементы группы</h4>
<div class="panel-files">
</div> 
</div>
<div class="col-md-4 rtbar">
        <h3>Действия</h3>
        <div class="panel_prop">
        <div class="panel_prop1">
        </div>
        <div class="panel_prop2">
            <button class="btn delfl">Удалить</button>
            <button class="btn avfl">AV Проверка</button>
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