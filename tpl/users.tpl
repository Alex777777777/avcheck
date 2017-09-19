<div class="page-header">
  <h1>Пользователи системы</h1>
</div>

 <div class="container-fluid"> 
 <div class="row">
 <div class="col-md-2 sidebar">
 <ul class="nav nav-sidebar">
 <li class="active2" data-id="-1"><a href="#">Все пользователи</a></li>
 <li data-id="1"><a href="#">Администраторы</a></li>
 <li data-id="9"><a href="#">Пользователи</a></li>
 <li data-id="0"><a href="#">Заблокированные</a></li>
 </ul>
 </div>
 <div class="col-md-7 main">
 <div class="panel panel-default"  style="width:500px;">
  <div class="panel-body">
     <table class='table table-striped'>
     <thead><tr><th style="width:35px;">#</th><th style="width:150px;">Логин</th><th  style="width:150px;">Роль</th><th style="width:150px;">Инструменты</th></tr></thead>
     <tbody>
 <?php
$suser=new ShellUser();
$suser->Select();
for($i=1;$i<=$suser->arr[0];$i++){
    $suser->GetItem($suser->arr[$i]);
?>
     <tr data-id="<?= $suser->role;?>"><td><span class="glyphicon glyphicon-user"></span></td>
     <td><?= $suser->login?></td>
     <td><?= $suser->GetRole()?></td>
     <td><div data-id="<?= $suser->id;?>">
     <span class="tbtools glyphicon glyphicon-asterisk" data-id="frozen"></span>
     <span class="tbtools glyphicon glyphicon-eye-open" data-id="open"></span>
     <span class="tbtools glyphicon glyphicon-remove" data-id="dell"></span>
     </div></td>
     </tr>
     <?php } ?>
     <tr><td><span class="tbtools glyphicon glyphicon-user" data-id="frozen"></span></td>
     <td id="btn_newuser"><span>Новый</span></td>
     </tr>
     </tbody>
     </table>
</div>
</div>
</div></div></div>
<div class="sd_ft"></div>