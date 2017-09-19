<?php
class avcJobs{
var $id;
var $time;
var $type;
var $object;
var $engine;
var $user;

var $LastErr;
var $Err_Descr;
var $arr;
var $tbl;

function __construct(){
    $this->id=0;
    $this->time=0;
    $this->type="";
    $this->object=0;
    $this->engine=0;
    
    $this->LastErr=0;
    $this->tbl="avc_jobs";
}
function __destruct() {
}

function Select(){
    global $mdb;
    $this->LastErr=0;
    $lsql="SELECT id FROM ".$this->tbl;
    $mdb->do_query($lsql);
    $this->arr=array();
    while($ret=$mdb->GetRow()){
        $this->arr[]=$ret['id'];
    }
    return(count($this->arr));
}
function SelectByObj($pid,$ltp,$leng){
    global $mdb;
    $this->LastErr=0;
    $lsql="SELECT * FROM ".$this->tbl . " WHERE (type='$ltp') AND (object=$pid)AND(engine=$leng)";
    $mdb->do_query($lsql);
    $this->arr=array();
    while($ret=$mdb->GetRow()){
        $this->arr[]=$ret;
    }
    return(count($this->arr));
}
function GetItem(){
    $this->LastErr=1;
    if(count($this->arr)){
        $this->GetItemByID($this->arr[0]);
    }
}
function GetItemByID($lid){
    global $mdb;
    $this->id=0;   
    $lsql="SELECT * FROM ".$this->tbl." WHERE id=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $ret=$mdb->GetRow();
        if($ret){
            $this->id=$ret["id"];
            $this->time=$ret["time"];
            $this->type=$ret["type"];
            $this->object=$ret["object"];
            $this->engine=$ret["engine"];
            $this->user=$ret["user"];
            $this->LastErr=0;
        }else $this->LastErr=2;    
    }
}
function NewJob(){
    global $mdb;
    $this->LastErr=0;
    $lsql="INSERT INTO ".$this->tbl."(type,object,engine,user) VALUES('".$this->type."',".$this->object.",".$this->engine.",".$this->user.")";
    $mdb->do_query($lsql);
    if(!$mdb->LastErr)$this->LastErr=1;
    else $this->id=mysqli_insert_id($mdb->lCon);
}
function DeleteJob(){
    global $mdb;
    $this->LastErr=0;
    $lsql="DELETE FROM ".$this->tbl." WHERE id=".$this->id;
    $mdb->do_query($lsql);
    if(!$mdb->LastErr)$this->LastErr=1;
}
}
?>
