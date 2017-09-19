<?php
require_once($PathLoc."/cls/avc_engs.cls");
require_once($PathLoc."/cls/avc_file.cls");
require_once($PathLoc."/cls/avc_jobs.cls");
if(!isset($_POST["do"])){echo "1"; exit;}
if($_POST["do"]=="del"){
    if(!isset($_POST["resid"])){echo "2"; exit;}
}
if(!isset($_POST["engine"])){echo "3"; exit;}
if(!isset($_POST["type"])){echo "4"; exit;}

$engs=new avcEngines();
$engs->SelectEngines();
$leng=$engs->GetEngine($_POST["engine"]);
$ltype=$_POST["type"];
if($_POST["do"]=="del"){
    $lres=new avcResume();
    $lres->Delete($_POST["resid"]);
    if($lres->LastErr)$ret="Ошибка удаления.";
    else $ret="Элемент удален успешно.";
    echo $ret;
    die;
}
if($_POST["do"]=="send"){
    if($_POST["resid"]){
        $lres=new avcResume();
        $lres->Delete($_POST["resid"]);
    }
    $jobs=new avcJobs();
    $jobs->user=$user->id;
    $jobs->type=$_POST["type"];
    $jobs->object=$_POST["id"];
    $jobs->engine=$leng->idkey;
    $jobs->NewJob();
    if($jobs->id)$ret="Установка в очередь произведена.";
    else $ret="Ошибка установки в очередь.";
    echo $ret;
    die;
}
