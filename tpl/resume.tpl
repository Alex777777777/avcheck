<?php
require_once($PathLoc."/cls/avc_file.cls");
require_once($PathLoc."/cls/avc_domine.cls");
require_once($PathLoc."/cls/avc_engs.cls");
require_once($PathLoc."/cls/avc_resume.cls");
$flag=0;
$fitem=0;
$obj="";
if(isset($_GET["f"])){
    $flag=1;
    $fitem=$_GET["f"];
    $obj=new avcFile();
    $obj->GetItem($fitem);
    $apar=$obj->parent;
}
if(isset($_GET["d"])){
    $flag=2;
    $fitem=$_GET["d"];
    $obj=new avcDomine();
    $obj->GetItem($fitem);
    $apar=$obj->parent;
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
 $grp=new avcFile();
 $grp->GetGroups();
 $item= new avcFile();
 for($i=0;$i<count($grp->arr);$i++){
     $subclass="grp_close";
     $grp->GetItem($grp->arr[$i]);
     $lname=$grp->name;
     $lid=$grp->id;
     $kvo=$item->GetGroupsItem($grp);
     if($kvo==0)continue;
     if($flag==1){
         if($grp->id==$apar)$subclass="grp_open";
     }
     if(!$obj)$subclass="grp_open";
     echo "<div class='sb_grp $subclass' data-id='$lid'><span class='glyphicon glyphicon-circle-arrow-down'></span>$lname</div>\n<ul>\n";
     $subclass="grp_close";
     for($ii=0;$ii<$kvo;$ii++){
         $item->GetItem($item->arr[$ii]);
         if(!$obj){
             $obj=new avcFile();
             $obj->GetItem($item->arr[$ii]);
         }
         $fid=$item->id;
         $fname=$item->name;
         echo "<li data-id='$fid' data-tp='f'><a href='#'>$fname</a></li>";
     }
     echo "</ul>\n";
 }
 ?>
 <h4>Мои Domin/IP</h4>
 <?php
 $grp=new avcDomine();
 $grp->GetGroups();
 $item= new avcDomine();
 for($i=0;$i<count($grp->arr);$i++){
     $grp->GetItem($grp->arr[$i]);
     $lname=$grp->name;
     $lid=$grp->id;
     $kvo=$item->GetGroupsItem($grp);
     if($kvo==0)continue;
     $subclass="grp_close";
     if($flag==2){
         if($grp->id==$apar)$subclass="grp_open";
     }
     echo "<div class='sb_grp $subclass' data-id='$lid'><span class='glyphicon glyphicon-circle-arrow-down'></span>$lname</div>\n<ul>\n";
     
     for($ii=0;$ii<$kvo;$ii++){
         $item->GetItem($item->arr[$ii]);
         $fid=$item->id;
         $fname=$item->name;
         echo "<li data-id='$fid' data-tp='d'><a href='#'>$fname</a></li>";
     }
     echo "</ul>\n";
 }
 ?> 
 </div>
 <div class="col-md-10 res-panel" data-id='<?= $obj->id ?>' data-class='<?= get_class($obj) ?>'>
 <?php
     if($obj){
         $lstr="Домен/IP";
         if(get_class($obj)=="avcFile")$lstr="Файл";
         echo "<h4>$lstr : '".$obj->name."' (".$obj->descr.")</h4>";
     }
 ?>
 <div class="midmenu">
 <ul class="tabs">
 <?php
 foreach($tabs as $tb){
     echo "<li class='tab' data-id ='".$tb['id']."'>".$tb['name']."</li>";
 }
 ?>
 </ul>
 </div>
 <div class="row">
 <div class="col-md-8 mside"></div>
 <div class="col-md-4 rside" >
  <h4>Варианты проверок</h4>
<?php
      $rez=new avcResume();
      $kvo=$rez->Select($obj,1);
      for($i=0;$i<$kvo;$i++){
          $rez->GetItem($rez->arr[$i]);
          $rez->Parse();
          $lurl=$rez->url;
          if($i+1<$kvo)$rez->Compare($rez->arr[$i+1]);
          $data=$rez->time;
          if($rez->iserror=='Y'){
            $eng_all='error';
            $eng_det='error';
            $eng_new='error';
          }else{
            $eng_all=$rez->detecta;
            $eng_det=$rez->detect;
            $eng_new=$rez->detectn;
          }
?>
<div class="rezitem" data-id='<?= $rez->id ?>'>
<div class="str"><div class='caps'>Дата проверки:</div><div class='vals'><?= $data ?></div></div>
<div class="str"><div class='caps'>Используемые AVEng:</div><div class='vals'><?= $eng_all ?></div></div>
<div class="str"><div class='caps'>К-во детектов/новых:</div><div class='vals'><?= $eng_det ?>/<span><?= $eng_new ?></span></div></div>
<div class="str"><div class='caps'>Ссылка на ресурс:</div><div class='vals'><a href='<?= $lurl ?>' target='_blank'><?= $lurl ?></a></span></div></div>
</div>
<?php
      }
      
  ?>
 </div>
 </div>
 </div>
 </div>
</div>