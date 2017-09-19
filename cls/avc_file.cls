<?php
require_once("avc_object.cls");
class avcFile extends avcObject{
var $oname;
var $type;
var $path;
var $time;

function __construct(){
    parent::__construct();
    $this->oname="";
    $this->type="";
    $this->tbl="avc_file";
    $this->path=$PathLoc."files/";
}
function __destruct() {
}
function GetItem($lid){
    $this->oname="";
    $this->type="";
    $this->time=0;
    parent::GetItem($lid);
    $this->oname=$this->row["oname"];
    $this->type=$this->row["type"];
    $this->time=$this->row["time"];
}
function Update(){
    global $mdb;
    $this->LastErr=0;
    $lsql="UPDATE ".$this->tbl." SET oname='".$this->oname."', descr='".$this->descr."', type='".$this->type."' WHERE id=".$this->id;
    $mdb->do_query($lsql);
    $this->LastErr=$mdb->LastErr;
}
function GetOwnerFiles($fl=1){
    global $mdb;
    global $user;
    $this->LastErr=0;
    $extsql="";
    if($fl==1)$extsql=" WHERE owner=". $user->id ." ";
    if($fl==2)$extsql=" WHERE owner=0 ";
    $lsql="SELECT id,name,parent FROM " . $this->tbl .  $extsql ." AND is_grp='N'  ORDER BY parent DESC, name, `time` DESC;";
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
function GetSubFiles($lname){
    global $mdb;
    $this->LastErr=0;
    $extsql="";
    $lsql="SELECT * FROM " . $this->tbl . " WHERE name='$lname' ORDER BY time DESC";
    $mdb->do_query($lsql);
    $arr=array();
    if($mdb->LastErr){
        while($ret=$mdb->GetRow()){
            $arr[]=$ret;
        }
    }
    return($arr);
}
function GetOName($lstr){
    $tmp=$lstr;
    $pos=strpos($tmp,"_");
    if($pos)$tmp=substr($tmp,0,$pos);
    return($tmp);
}
function HesUserFile($fl,$usr){
    global $mdb;
    $this->LastErr=0;
    $lname=$fl->name;
    $uid=$usr;
    $lsql="SELECT id FROM " . $this->tbl . " WHERE name='$lname' AND owner=$uid";
    $mdb->do_query($lsql);
    $cnt=0;
    if($mdb->LastErr){
        while($row=$mdb->GetRow()){
            $cnt++;
        }
    }
    return($cnt);
}
function HesUserOFile($fl,$usr){
    global $mdb;
    $this->LastErr=0;
    $lname=$fl->oname;
    $uid=$usr;
    $lsql="SELECT id FROM " . $this->tbl . " WHERE oname='$lname' AND owner=$uid";
    $mdb->do_query($lsql);
    $cnt=0;
    if($mdb->LastErr){
        while($row=$mdb->GetRow()){
            $cnt++;
        }
    }
    return($cnt);    
}
}

