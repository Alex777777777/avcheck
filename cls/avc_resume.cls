<?php
require_once($PathLoc."/cls/avc_file.cls");
require_once($PathLoc."/cls/avc_domine.cls");
require_once($PathLoc."/cls/avc_eng.cls");
class avcResume{
var $id;
var $type;
private $obj;
var $engine;
var $time;
var $resume;
var $user;
var $iserror;
var $errDescr;

var $LastErr;
var $arr;
var $tbl;
var $detect;
var $detecta;
var $detects;
var $detectn;

function __construct(){
    $this->_Clean();
    $this->LastErr=0;
    $this->tbl="avc_resume";
}
function __destruct() {
}
private function _Clean(){
    $this->id=0;
    $this->type=0;
    $this->engine="";
    $this->obj=0;
    $this->time="";
    $this->resume="";
    $this->user=0;
    $this->iserror="N";
    $this->errdescr="";
    
    $this->detect=0;
    $this->detecta=0;
    $this->detectn=0;
}
function Select($obj,$peng){
    global $mdb;
    $this->LastErr=0;
    $tmp=get_class($obj);
    $ltp="avcDomine";
    if($tmp=="avcFile")$ltp="avcFile";
    $pid=$obj->id;
    $leng="s4y";
    if($peng==1)$leng="vcm";
    $lsql="SELECT id FROM ".$this->tbl." WHERE (type='$ltp') AND (object=$pid)AND (engine='$leng') ORDER BY time DESC";
    $mdb->do_query($lsql);
    $this->arr=array();
    while($ret=$mdb->GetRow()){
        $this->arr[]=$ret['id'];
    }
    return(count($this->arr));
}
function GetItem($lid){
    global $mdb;
    $this->LastErr=1;   
    $this->_Clean();
    if(!$lid)return;
    $lsql="SELECT * FROM ".$this->tbl." WHERE id=$lid";
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        $ret=$mdb->GetRow();
        if($ret){
            $this->id=$ret["id"];
            $this->time=$ret["time"];
            $this->type=$ret["type"];
            $this->engine=$ret["engine"];
            $this->SetObject($ret["object"]);    
            $this->resume=trim($ret["resume"]);
            $this->user=$ret["user"];
            $this->iserror=$ret["iserror"];
            $this->LastErr=0;
        }else $this->LastErr=2;    
    }
    
}
function SetObject($lid){
    switch ($this->type){
        case "avcFile":
            $this->obj=new avcFile();
            break;
        case "avcIP":
            $this->obj=new avcDomine();
            break;
        case "avcDomine":
            $this->obj=new avcDomine();
            break;
    }
    $this->obj->GetItem($lid);
}

function Save(){
    global $mdb;
    $this->LastErr=1;
    $lpar="engine,type,object,resume,user,iserror";
    $ppar="'".$this->engine."','".$this->type."',".$this->obj->id.",'".$this->resume."',".$this->user.",'".$this->iserror."'";
    $lsql="INSERT INTO ".$this->tbl."($lpar) VALUES($ppar)";
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        $this->LastErr=0;
        $this->id=mysqli_insert_id($mdb->lCon);
        return(0);
    }
    return(2);
}
function DoMesage(){return(0);}
function GetMesage(){return("");}
function Delete($lpar){
    global $mdb;
    $this->LastErr=0;
    $lsql="DELETE FROM ".$this->tbl." WHERE id=$lpar";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr)$this->LastErr=0;    
}

function Parse(){
    $this->detecta=0;
    $this->detect=0;
    $this->detects=array();
    $this->url="";
    $flt=new avc_filters();
    $tmp=json_decode($this->resume,true);
    $flt->Select($this->engine,$this->type);
    $flt->ReadAV($tmp);
    if($tmp){
        if(isset($tmp["~~error"])){
            if($tmp["~~error"]==1){
                $this->errDescr=$tmp["~~errdescr"];
                $this->iserror="Y";
                return;
            };
        }
        foreach($tmp as $key=>$val){
            if($key=="~~link")$this->url=$val;
            if(substr($key,0,2)=="~~")continue;
            $flt->Open($key);
            if($flt->GetUserFlag()=="no")continue;
            $this->detecta++;
            $tmp1=array();
            $tmp1["key"]=$key;
            $tmp1["name"]=$val;
            $tmp1["flag"]=1;
            $tmp1["new"]=1;
            if($tmp1["name"]!="OK"){
                $this->detects[$key]=$tmp1;
                $this->detect++;
            }
            $this->detectn=$this->detect;
        }
    }
}
function Compare($lid=0){
    $this->detectn=0;
    if($lid!==NULL){
    if(($lid==0)&&(isset($this->arr[1]))){
        $lid=$this->arr[1];
    }}
    if($lid){
        $pre=new avcResume();
        $pre->GetItem($lid);
        $pre->Parse();
        foreach($pre->detects as $key=>$val){
            if(isset($this->detects[$key]))$this->detects[$key]["new"]-=1;
        }
    }
    foreach($this->detects as $key=>$val){
        if($this->detects[$key]["new"]==1)$this->detectn++;
    }
}
function Filtre(){
    global $user;
    global $mdb;
    $uid=$user->id;
    if(!is_array($this->detects))return(0);
    $lsql="SELECT aveng FROM vch_avfilter WHERE user=$uid AND sig_jaber=0";
    $mdb->do_query($lsql);
    while($row=$mdb->GetRow()){
        if(isset($this->detects[$row["aveng"]]))$this->detects[$row["aveng"]]["flag"]=0;
    };

    $ret=0;
    foreach($this->detects as $key=>$val){
        $ret++;
        if($this->detects[$key]["flag"]==0)$ret--;
    }
    return($ret);
}

function JabberMSG(){
    $newdtc=0;
    $visdtc=0;
    foreach($this->detects as $key=>$val){
        $tmp=$val;
        if($tmp["new"]==1){
            $newdtc++;
            if($tmp["flag"]==1){
                $visdtc++;
            }
        }        
    }
    $ret="";
    if($visdtc>0){
        if($newdtc>0){
            $avengs=$this->GetAVEngs();
            $retc="New detects - $newdtc \n";
            $rett="";
            foreach($this->detects as $key=>$val){
                $neng="";
                if($avengs[$key]["eng"]=="1")$neng="VirusCM";
                if($avengs[$key]["eng"]=="2")$neng="Scan4Y";
                if($val["new"]==1)$rett.="[".$neng.":".$avengs[$key][name]."]->".$val["name"]."\n";
                
            }
            $ret=$retc.$rett;
            $retc="\nOld detects\n";
            $rett="";
            foreach($this->detects as $key=>$val){
                $neng="";
                if($avengs[$key]["eng"]=="1")$neng="VirusCM";
                if($avengs[$key]["eng"]=="2")$neng="Scan4Y";
                if($val["new"]==0)$ret.="[".$neng.":".$avengs[$key][name]."]->".$val["name"]."\n";
                
            }
            if($rett)$ret=$retc.$rett;
            $retc.="\nErased detects\n";
            $rett="";
            foreach($this->detects as $key=>$val){
                $neng="";
                if($avengs[$key]["eng"]=="1")$neng="VirusCM";
                if($avengs[$key]["eng"]=="2")$neng="Scan4Y";
                if($val["new"]==(-1))$rett.="[".$neng.":".$avengs[$key][name]."]->".$val["name"]."\n";
            }
            if($rett)$ret=$retc.$rett;
        }
    }
    return($ret);    
}
}
?>
