<?php
class avcObject{
var $id;
var $name;
var $descr;
var $owner;
var $is_grp;
var $parent;

var $LastErr;
var $Err_Descr;
var $arr;
var $row;
var $tbl;
var $filter;
function __construct(){
    $this->id=0;
    $this->name="";
    $this->descr="";
    $this->owner=0;
    $this->is_grp=0;
    $this->parent=0;
    
    $this->LastErr=0;
    $this->Err_Descr="";
    $this->filter="";
    $this->row="";
}
function __destruct() {
}
function isName($lName,$uid=0){
    global $mdb;
    global $user;
    if($uid==0)$uid=$user->id;
    $this->LastErr=0;
    $lsql="SELECT id FROM ".$this->tbl." WHERE name='$lName' AND owner= ".$uid;
    $mdb->do_query($lsql);
    if($ret=$mdb->GetRow()){
        return($ret['id']);
    }else return(0);
}
function Select(){
    global $mdb;
    $this->LastErr=0;
    $lsql="SELECT id FROM ".$this->tbl;
    if($this->filter)$lstr.=" WHERE ".$this->filter;
    $mdb->do_query($lsql);
    $this->arr=array();
    while($ret=$mdb->GetRow()){
        $this->arr[]=$ret['id'];
    }
    return(count($this->arr));
}
function SelectByGroup($lgrp,$fuser=1){
    global $mdb;
    global $user;
    $uid=$user->id;
    $extsql="";
    if($fuser==1){
        $extsql=" AND owner=$uid ";
    }
    $this->LastErr=0;
    $lsql="SELECT id FROM ".$this->tbl." WHERE is_grp='N' $extsql AND parent = $lgrp ORDER BY name";
    $mdb->do_query($lsql);
    $this->arr=array();
    while($row=$mdb->GetRow()){
        $this->arr[]=$row['id'];
    }
    return(count($this->arr));
}
function GetItem($lid){
    global $mdb;
    $this->LastErr=0;
    $this->name=$ret["name"];
    $this->descr="";
    $this->owner=0;
    $this->parent=0;
    $lsql="SELECT * FROM ".$this->tbl." WHERE id=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $ret=$mdb->GetRow();
        if($ret){
            $this->id=(+$ret["id"]);
            $this->name=$ret["name"];
            $this->descr=$ret["descr"];
            $this->owner=$ret["owner"];
            $this->is_grp=$ret["is_grp"];
            $this->parent=$ret["parent"];
            $this->row=$ret;
            $this->LastErr=0;
        }else 
        $this->LastErr=2;    
    }
}
function GetNameById($lid){
    global $mdb;
    $this->LastErr=0;
    $lsql="SELECT name FROM ".$this->tbl." WHERE id=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    $ret="";
    if($mdb->LastErr){
        $row=$mdb->GetRow();
        if($row){
            $ret=$row["name"];
        }
    }
    return($ret);
}
function GetGroups($owner=1){
    global $mdb;
    global $user;
    $dsql="";
    $this->LastErr=0;
    if($owner==1)$dsql=" AND owner = ".$user->id;
    $lsql="SELECT id FROM ".$this->tbl." WHERE is_grp='Y'".$dsql." ORDER BY name";
    $mdb->do_query($lsql);
    $this->arr = array();
    while($row=$mdb->GetRow()){
        $this->arr[]=$row["id"];
    }
    return(count($this->arr));
}
function GetGroupsItem($lgrp){
    global $mdb;
    $this->LastErr=0;
    $gid=$lgrp->id;
    $lsql="SELECT id FROM ".$this->tbl." WHERE parent=$gid ORDER BY name";
    $mdb->do_query($lsql);
    $this->arr = array();
    while($row=$mdb->GetRow()){
        $this->arr[]=$row["id"];
    }
    return(count($this->arr));
}
function NewItem($nName,$uid=0){
    global $mdb;
    global $user;
    if($uid==0)$uid=$user->id;
    $this->id=0;
    $this->LastErr=0;
    if($this->id=$this->isName($nName,$uid)){
        $this->GetItem($this->id);
        return;
    }
    $this->name=$nName;
    $this->descr="";
    $this->owner=$uid;
    $lsql="INSERT INTO ".$this->tbl."(name,owner) VALUES('".$nName."',".$this->owner.")";
    $mdb->do_query($lsql);
    if(!$mdb->LastErr)$this->LastErr=1;
    else $this->id=mysqli_insert_id($mdb->lCon);
}
function NewGrp($nName){
    global $mdb;
    global $user;
    $this->id=0;
    $this->name=$nName;
    $this->descr="";
    $this->owner=$user->id;
    $uid=$user->id;
    $this->LastErr=0;
    $lsql="INSERT INTO ".$this->tbl."(name,owner,is_grp) VALUES('".$nName."',".$uid.",'Y')";
    $mdb->do_query($lsql);
    if(!$mdb->LastErr)return(0);
    else return(mysqli_insert_id($mdb->lCon));
}
function DeleteGrp($lid){
    global $mdb;
    global $user;
    $lsql="UPDATE ".$this->tbl." SET parent=0 WHERE parent = $lid";
    $mdb->do_query($lsql);
    $lsql="DELETE FROM ".$this->tbl." WHERE id = $lid";
    $mdb->do_query($lsql);
}
function Delete(){
    global $mdb;
    $this->LastErr=0;
    if(!$this->id){$this->LastErr=1;return;}
    $lid=$this->id;
    $lsql="DELETE FROM ".$this->tbl." WHERE id=".$lid;
    $mdb->do_query($lsql);
    if(!$mdb->LastErr)$this->LastErr=1;
}
function SetOwner($lid){
    global $mdb;
    $this->LastErr=0;
    $lsql="UPDATE ".$this->tbl." SET owner=".$lid." WHERE id=".$this->id;
    $mdb->do_query($lsql);
    $this->LastErr=$mdb->LastErr;
}
function SetParent($lid){
    global $mdb;
    $this->LastErr=0;
    $lsql="UPDATE ".$this->tbl." SET parent=".$lid." WHERE id=".$this->id;
    $mdb->do_query($lsql);
    $this->LastErr=$mdb->LastErr;
}
}

