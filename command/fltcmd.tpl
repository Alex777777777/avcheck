<?php
require_once($PathLoc."/cls/avc_eng.cls");

if(!isset($_POST["do"])){echo "1"; exit;}
$ldo=$_POST["do"];
if($ldo=="flag"){
    if(!isset($_POST["flag"])){echo "1"; exit;}
    if(!isset($_POST["eng"])){echo "2"; exit;}
    $lflag=$_POST["flag"];
    $leng=$_POST["eng"];
    $flt=new avc_filters();
    $flt->SetUserFlag($leng,$lflag);
}
if($ldo=="name"){
    if(!isset($_POST["name"])){echo "1"; exit;}
    if(!isset($_POST["id"])){echo "2"; exit;}
    $lname=$_POST["name"];
    $lid=$_POST["id"];
    $flt=new avc_filters();
    $flt->id=$lid;
    $flt->UpdateName($lname);
}

