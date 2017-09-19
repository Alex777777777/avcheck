<?php
class eng_s4u extends avc_eng{
function __construct(){
    parent::__construct();
    $this->base_url='http://scan4you.net/remote.php';
    $this->type="avcFile";//`file', `url', or `domain, iP'
    $this->name_key="s4y";
    $this->idkey="2";
    $this->resp="";
    $this->param->parent=2;
    $this->param->ptype=$this->name_key;
}
function __destruct() {
}
function Check(){
    global $PathLoc;
    $this->resp="";
    $type="file";
    if($this->type!="avcFile")$type="url";
    //echo "\n".date("d-m-Y H:i:s");
    //echo "\nStart scan: engine=sc4, type= $type , target= ".$this->obj->name;
    $options=array();
    $options['link'] = 1;
    $options['debug']=1;
    $options['av_enabled'] = "all";
    $options['frmt']="json";
    $options['pooling'] = 0;
    $options['id'] = $this->apikey;
    $options['token'] = $this->apiuser;
    $options['action'] =$type; 
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_VERBOSE, $options['debug']);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_URL, $this->base_url);
    curl_setopt($ch, CURLOPT_POST, true);
    //curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0); // Try this if you have problem with certificates
    //curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0); // Try this if you have problem with certificates
    $fl=1;
    if (!in_array($type,array('file','run'))) $options[$type]=$this->obj->name;
    else {
        $filename = realpath($PathLoc."/files/".$this->obj->name."/".$this->obj->oname);
        if (file_exists($filename)){
            $cfile = new CURLFile($filename,$this->obj->type,$this->obj->name);
            $this->options['uppload']=$cfile;
        }else{
            $fl=0;
            $parr=array();
            $parr["~~eng"]="s4u";
            $parr["~~error"]=1;
            $parr["~~errdescr"]="Out of file";
            $response=json_encode($parr);
        }
    }
    if($fl==1){
        curl_setopt($ch, CURLOPT_POSTFIELDS, $this->options);
        $response = curl_exec($ch);
    }
    if (!$response){
        $parr=array();
        $parr["~~eng"]="s4u";
        $parr["~~error"]=1;
        $parr["~~errdescr"]="Out responce";
        $response=json_encode($parr);
    }
    if(substr($response,0,5)=="ERROR"){
        $parr=array();
        $parr["~~eng"]="s4u";
        $parr["~~error"]=1;
        $parr["~~errdescr"]=substr($response,6);
        $response=json_encode($parr);
    }
    if(substr($response,0,9)=="<!doctype"){
        file_put_contents("ret.out",$response);
        $parr=array();
        $parr["~~eng"]="s4u";
        $parr["~~error"]=1;
        $parr["~~errdescr"]=substr($response,6);
        $response=json_encode($parr);
        
        
    }
    
    curl_close($ch);
    $this->ParseResponce($response);
}

private function ParseResponce($parstr){
    $arr=json_decode($parstr,true);
    $parr= array();
    if($arr){
        if($arr["~~error"]==0){
        $tmp="";
        foreach($arr as $key=>$val){
            $key=trim($key);
            $val=trim($val);
            if($key=="LINK"){
                $pos=strpos($val,"http://");
                $val=substr($val,$pos);
                $parr["~~link"]=$val;
            }else{
                $parr[$key]=$val;
            }
        }
        $parr["~~eng"]="s4u";
        $parr["~~error"]=0;
        }else{
            $parr=$arr;
        }
    }else{
        $parr=array();
        $parr["~~eng"]="s4u";
        $parr["~~error"]=1;
    }
    $avf=new avc_filters();
    $avf->Select($this->name_key,$this->type);
    $ret=array();
    if($parr["~~error"]==0){
        foreach($parr as $key=>$val){            
            if(substr($key,0,2)=="~~")$ret[$key]=$val;
            else{
                $avf->Open($key);
                $ret[$avf->avkey]=$val;
            }
        }
    }else $ret=$parr;
    $this->resp=json_encode($ret);
}

}

?>
