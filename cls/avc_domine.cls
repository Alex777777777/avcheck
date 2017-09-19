<?php
require_once("avc_object.cls");
class avcDomine extends avcObject{

function __construct(){
    parent::__construct();
    $this->tbl="avc_domine";
}
function __destruct() {
}
function GetItem($lid){
    parent::GetItem($lid);
}
function Update(){
    global $mdb;
    $this->LastErr=0;
    $lsql="UPDATE ".$this->tbl." SET descr='".$this->descr."' WHERE id=".$this->id;
    $mdb->do_query($lsql);
    $this->LastErr=$mdb->LastErr;
}
function GetOwnerDomine($fl=1){
    global $mdb;
    global $user;
    $this->LastErr=0;
    $extsql="";
    if($fl==1)$extsql=" WHERE owner=". $user->id ." ";
    if($fl==2)$extsql=" WHERE owner=0 ";
    $lsql="SELECT id,name,parent FROM " . $this->tbl .  $extsql ." AND is_grp='N'  ORDER BY parent DESC, name;";
    $mdb->do_query($lsql);
    $arr=array();
    $lstr="";
    if($mdb->LastErr){
        while($row=$mdb->GetRow()){
            if($lstr!=$row['name']){
                $arr[]=[$row['id'],$row['name'],$row['parent']];
                $lstr=$row['name'];
            }
        }
    }
    return($arr);
}
}

