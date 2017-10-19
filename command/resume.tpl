<?php
if(!isset($_POST["type"])){echo "ERR: Wrong requwest";exit;}
require_once($PathLoc."/cls/avc_resume.cls");
require_once($PathLoc."/cls/avc_eng.cls");
switch ($_POST["type"]){
    case "resdel":
        $obj=new avcResume();
        $obj->Delete($_POST["objid"]);
        echo "OK";
    break;
    case "get":
        $obj=new $_POST["objclass"]();
        $obj->GetItem($_POST["objid"]);
        $rez=new avcResume();
        $kvo=$rez->Select($obj,$_POST["engine"]);
        if(!$kvo){echo "ERR: No Data";exit;}
        for($i=0;$i<$kvo;$i++){
            if($rez->arr[$i]==$_POST["resid"]){
                $rez->GetItem($rez->arr[$i]);
                break;
            }
        }
        $rez->Parse();
        if($i+1<$kvo)$rez->Compare($rez->arr[$i+1]);
?>
<div class='resume'>
<div class='str'><div class='caps'>Дата проверки:</div><div class='vals'><?= $rez->time ?></div></div>
<div class='str'><div class='caps'>Задействовано антивирусов:</div><div class='vals'><?= $rez->detecta ?></div></div>
<div class='str'><div class='caps'>Зафиксировано детектов:</div><div class='vals'><?= $rez->detect ?></div></div>
<div class='str'><div class='caps'>Новых детектов:</div><div class='vals'><span><?= $rez->detectn ?></span></div></div>
<?php
    if($rez->detect){
?>
<div class='avsps'>
<div class="str header"><div class='caps'>Название AV </div><div class='vals'>Название детекта</div></div>
<?php
$flt=new avc_filters();
$flt->Select($_POST['engine'],$_POST["objclass"]);
foreach($rez->detects as $key => $val){
    $flt->Open($key);
    $subclass="";
    if($val["new"]==1) $subclass="avnew";
?>
<div class="str  <?= $subclass ?>"><div class='caps'><?= $flt->name ?></div>:<div class='vals'><?= $val["name"] ?></div></div>
<?php 
}
}
?>
</div>
</div>

<?php    
    exit;
    break;
}

?>