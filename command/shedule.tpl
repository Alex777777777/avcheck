<?php
if(!isset($_POST["type"])){echo "ERR: Wrong requwest";exit;}
require_once($PathLoc."/cls/avc_shedule.cls");
$sh=new avcShedule();
$sh->Init();
switch($_POST["type"]){
    case "set":
        $sh->GetItem($_POST["tz"]);
        $itype="avcFile";
        if($_POST["item-t"]=="d")$itype="avcDomine";
        $item=$_POST["item"];
        $val=$_POST["val"];
        if($val)$val=$sh->SetItem($itype,$item);
        else $val=$sh->UnSetItem($itype,$item);
        if($val)echo "OK: All rigth!";
        else echo "ERR:Error!";
        exit;
    break;
    case "save":
        $sh->GetItem($_POST["id"]);
        $sh->name=$_POST["name"];
        $sh->descr=$_POST["descr"];
        $sh->shed=$_POST["shed"];
        $sh->time=$_POST["time"];
        $sh->SetName();
        $sh->SetTime();
        $sh->SetShed();
        echo "OK: All rigth!";
        exit;
    break;
    case "add":
        $sh->NewTask();
        $sh->SaveTask();
        echo "OK:";
    break;
    case "delete":
        $sh->DelItem($_POST["id"]);
        echo "OK:";
    break;
}
?>