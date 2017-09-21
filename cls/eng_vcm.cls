<?php
class eng_vcm extends avc_eng{
function __construct(){
    parent::__construct();
    $this->base_url='http://viruscheckmate.com';
    $this->type="avcFile";
    $this->name_key="vcm";
    $this->idkey="1";
    $this->resp="";
    $this->param->parent=1;
    $this->param->ptype=$this->name_key;
}
function __destruct() {
}
function Check(){
    global $PathLoc;
    $path = "/api/v1/check/new/";
    $url = $this->base_url.$path;
    $this->resp="";
    $this->LastErr=1;
    $postdata = array(
        "apikey" => $this->apikey,
        "task_type" => "domain",
        "url" => $this->obj->name,
        "response_type" => "on_close"
        );
    if($this->type=="avcFile"){
        $filename = realpath($PathLoc."/files/".$this->obj->name."/".$this->obj->oname);
        if (!file_exists($filename)){return;};
        $cfile = new CURLFile($filename,$this->obj->type,$this->obj->name);
        $postdata["task_type"]="file";
        $postdata["file"]=$cfile;
    }
    $timeout = 60;
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postdata);
    $responce = curl_exec($ch);
    curl_close($ch);
    $this->ParseResponce($responce);
}

function ParseResponce($parstr){
    $arr=json_decode($parstr,true);
    $parr= array();
    if($arr){
        if(($arr["status"]>0)and(isset($arr["data"]["results"]))){
            foreach($arr["data"]["results"] as $key=>$val){
               $key=trim(substr(trim($key),0,10));
               foreach($val['objects'] as $key1=>$val1){
                   $tmp="OK";
                   if($val1["detect_name"])$tmp=trim($val1["detect_name"]);
                   $parr[$key]=$tmp;
               }
            }
            $tmp=$this->base_url."/id/".$arr["data"]["info"]["check_id"];
            $parr["~~link"]=$tmp;
            $parr["~~error"]=0;
        }else {
            global $PathLoc;
            $lf=$PathLoc."/log/".$this->type.date('Y-m-d-H-i-s').".log";
            file_put_contents($lf,$this->base_url."/id/".$arr["data"]["info"]["check_id"]);
            $parr["~~error"]=1;
        }
        $parr["~~eng"]="vcm";
        
    }else{
        $parr=array();
        $parr["~~eng"]="vcm";
        $parr["~~error"]=1;
        $parr["~~errdescr"]="Out of resume";
    }
    $this->resp=json_encode($parr);
}
}
?>
