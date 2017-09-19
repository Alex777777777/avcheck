<?php
require_once($PathLoc."/cls/avc_engs.cls");
if(!isset($_POST["type"])){echo "ERR: Wrong Parametr list"; exit;}
switch($_POST["type"]){
    case "set":
    $lid=$_POST["item"];
    $ldescr=$_POST["descr"];
    $lapik=$_POST["lapik"];
    $lapiu=$_POST["lapiu"];
    $engs=new avcEngines();
    $engs->SelectEngines();
    $leng=$engs->arr[$lid];
    $leng->SetParam("APIKEY",$lapik);
    $leng->SetParam("APIUSER",$lapiu);
    echo "OK";
    break;
}
?>