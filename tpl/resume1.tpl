<?php
require_once($PathLoc."/cls/avc_file.cls");
require_once($PathLoc."/cls/avc_domine.cls");
require_once($PathLoc."/cls/avc_engs.cls");
require_once($PathLoc."/cls/avc_resume.cls");
$sfile="";
$sdomin="";
if(isset($_GET["f"])){
    $sfile=$_GET["f"];
}
if(isset($_GET["d"])){
    $sdomin=$_GET["d"];
}
$emgr=new avcEngines();
$tabs=$emgr->GetEngsName();
?>
<div class="page-header">
  <h1>Результаты проверок</h1>
</div>
<div class="container-fluid">
<div class="row">
 <div class="col-md-2 sidebar">
 <h4>Мои Файлы</h4>
 <?php
 $files=new avcFile;
 $menu=$files->GetOwnerFiles(1); 
 $lgrp_id=-1;
 $cgrp_id=0;
 if(isset($_GET['g']))$cgrp_id=$_GET['g'];
 $fflag=0;
 if(isset($_GET['f']))$fflag=1;
 $lfile="";
 $sclass="";
 $lstr="";
 for($i=0;$i<count($menu);$i++){     
     if(!$sdomin){
         if(!$sfile){
             $sfile=$menu[$i][1];
             $cgrp_id=$menu[$i][2];
             $fflag=1;
         }
     }
     if($lgrp_id!=$menu[$i][2]){
         if($lstr)echo "</ul>";
         if($menu[$i][2]==0)$lstr="Без Группы";
         else $lstr=$files->GetNameById($menu[$i][2]);
         if($fflag==1){
         if($cgrp_id==$menu[$i][2])$sclass="grp_open";
         else $sclass="grp_close";
         }else $sclass="grp_close";
         echo "<div class='sb_grp $sclass'><span class='glyphicon glyphicon-circle-arrow-down'></span>$lstr</div><ul>\n";
         $lgrp_id=$menu[$i][2];
     }
     if($lfile==$menu[$i][1]) continue;
     $lfile=$menu[$i][1]
 ?>
 <li data-id="<?=$menu[$i][1]?>" data-gp="<?= $lgrp_id ?>" data-tp="f"><a href="#"><?=$menu[$i][1]?></a></li>
 <?php
 }
 ?>
 </ul>
 <h4>Мои Домены</h4>
 <?php
 $dom=new avcDomine;
 $menu=$dom->GetOwnerDomine(1); 
 $dflag=0;
 if(isset($_GET['d']))$dflag=1;
 $lgrp_id=-1;
 $lstr="";
 for($i=0;$i<count($menu);$i++){
     if($lgrp_id!=$menu[$i][2]){
         if($lstr)echo "</ul>";
         if($menu[$i][2]==0)$lstr="Без Группы";
         else $lstr=$dom->GetNameById($menu[$i][2]);
         if($dflag==1){
         if($cgrp_id==$menu[$i][2])$sclass="grp_open";
         else $sclass="grp_close";
         }else $sclass="grp_close";
         echo "<div class='sb_grp $sclass'><span class='glyphicon glyphicon-circle-arrow-down'></span>$lstr</div><ul>\n";
         $lgrp_id=$menu[$i][2];
     }
 ?>
 <li data-id="<?=$menu[$i][0]?>" data-gp="<?= $lgrp_id ?>" data-tp="d"><a href="#"><?=$menu[$i][1]?></a></li>
 <?php
 }
 ?>
 </ul>
 </div>
 <div class="col-md-10 midbar">
 <h3>
 <?php
 if($ffile==1) echo "Файл ".$sfile;
 else {
 $ndomin=$dom->GetNameById($sdomin);    
 echo "Домен/IP ".$ndomin;     
 }
 ?>
 </h3>
 <div class="midmenu">
 <ul>
 <?php
 foreach($tabs as $tb){
     echo "<li data-id ='".$tb['id']."'>".$tb['name']."</li>";
 }
 ?>
 </ul>
 </div>
 <div class="row">
 <div class="col-md-6 lresult">
<?php
 $obj="";
 if($ffile==1){
 $obj=new avcFile();
 $arr=$obj->GetSubFiles($sfile);
 $obj->GetItem($arr[0]["id"]);
 } else {
 $obj=new avcDomine();
 $obj->GetItem($sdomin);
 }
 $res=new avcResume();
 $ret=$res->Select($obj,1);
 if($ret){
     $res->GetItem($res->arr[0]);
     $status="ОК";
     if($res->iserror=="Y")$status="Ошибка";
?>
    <div class="str"><div class="caps">Дата проверки:</div><div class="vals"><? $res->time ?></div></div>
    
    <div class="str"><div class="caps">Статус:</div><div class="vals"><? $status ?></div></div>
<?php     
     
 }else{    
 ?>
 <div>Нет данных для отображения</div>
 <?php
 }    
  ?> 
 </div>
 <div class="col-md-6 rresult">
 
 </div>
 </div>
 </div>
</div>
</div>