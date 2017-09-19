<?php
require_once("avc_jobs.cls");
require_once("avc_resume.cls");
require_once("avc_param.cls");
require_once("avc_eng.cls");
class avcEngines{
var $id;
var $idkey;
var $enkey;
var $name;
var $descr;
var $script;
var $class;
 
private $LastErr;
private $Err_Descr;
public $arr;
private $tbl;
function __construct(){
    $this->_clean();
    $this->tbl="avc_engs";
    foreach (glob(__DIR__."/eng*.cls") as $lfile){
        require_once($lfile);
    }
}
function __destruct() {
}
private function _clean(){
    $this->id=0;
    $this->enkey="";
    $this->name="";
    $this->descr="";
    $this->script="";
    $this->class="";
}
function SelectEngines(){
    global $mdb;
    $this->arr=array();
    $this->LastErr=0;
    $lsql="SELECT id,idkey,enkey,class FROM ".$this->tbl;
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        while($ret=$mdb->GetRow()){            
            $this->arr[$ret["idkey"]]=new $ret["class"]();
        };
    }else $this->LastErr=2;
}
function GetEngine($anykey){
    return($this->arr[$anykey]);
}
function ExecuteJob(avcJobs $ljob){
    $leng=$this->GetEngine($ljob->engine);
    $leng->SetTypeObject($ljob->type);
    $leng->SetObject($ljob->object);
    $leng->ReadParam();
    $leng->Check();
    return($leng->CreateResume());
}
function GetEngsName(){
    global $mdb;
    $this->arr=array();
    $this->LastErr=0;
    $lsql="SELECT * FROM ".$this->tbl;
    $mdb->do_query($lsql);
    $arr=array();
    if($mdb->LastErr){
        while($ret=$mdb->GetRow()){
            $arr[]=$ret;
        };
    }else $this->LastErr=2;
    return($arr);
}
}
