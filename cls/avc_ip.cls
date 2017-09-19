<?php
require_once("avc_object.cls");
class avcIP extends avcObject{
var $oname;
var $type;
var $path;
var $time;

function __construct(){
    parent::__construct();
    $this->oname="";
    $this->type="";
    $this->tbl="avc_file";
    $this->path=$PathLoc."/files/";
}
function __destruct() {
}
function GetItem($lid){
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
}

