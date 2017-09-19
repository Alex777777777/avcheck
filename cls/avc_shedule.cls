<?php
class avcShedule{
var $id;
var $name;
var $descr;
var $user;
var $shed;
var $time;
var $valid;
var $impl;

var $arr;
private $arr2;
private $LastRebuild;
private $CurRebuild;
private $CurTime;
private $CurShed;
private $tbl;
private $tbl2;
public  $LastError;
function __construct(){
    $this->tbl="avc_shedule";
    $this->tbl2="avc_shedule2";
}
function __destruct() {
}
function isSetItem($obj){
    global $mdb;
    $ltp=get_class($obj);
    $lit=$obj->id;
    $tbl=$this->tbl2;
    $tz=$this->id;
    $lsql="SELECT id FROM $tbl WHERE (sid=$tz) AND (itype='$ltp') AND (item=$lit)";
    $mdb->do_query($lsql);
    $ret=0;
    if($mdb->LastErr){
        if($mdb->GetRow())$ret=1;
    }
    return($ret);
}
function SetItem($ltp,$lit){
    global $mdb;
    $tbl=$this->tbl2;
    $tz=$this->id;
    $lsql="INSERT INTO $tbl(sid,itype,item) VALUES($tz,'$ltp',$lit)";
    $mdb->do_query($lsql);
    if($mdb->LastErr)return(1);
    else return(0);    
}
function UnSetItem($ltp,$lit){
    global $mdb;
    $tbl=$this->tbl2;
    $tz=$this->id;
    $lsql="DELETE FROM $tbl WHERE (sid=$tz) AND (itype='$ltp') AND (item=$lit)";
    $mdb->do_query($lsql);
    if($mdb->LastErr)return(1);
    else return(0);
}
function Select(){
    global $user;
    global $mdb;
    $lid=$user->id;
    $tbl=$this->tbl;
    $this->arr=array();
    $lsql="SELECT id FROM $tbl WHERE user=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=0;
    if($mdb->LastErr){
        while($ret=$mdb->GetRow()){
            $this->arr[]=$ret["id"];
        }
    }else $this->LastErr=1;
}
function GetItem($lid){
    global $mdb;
    $this->id=0;
    $this->user=0;
    $this->name="";
    $this->descr="";
    $this->shed="";
    $this->time=0;
    $this->valid=1;    
    $tbl=$this->tbl;
    $lsql="SELECT * FROM $tbl WHERE id=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        if($ret=$mdb->GetRow()){
            $this->id=$ret["id"];
            $this->user=$ret["user"];
            $this->name=$ret["name"];
            $this->descr=$ret["descr"];
            $this->shed=$ret["shed"];
            $this->time=$ret["time"];
            $this->valid=$ret["valid"];
            $this->impl=$ret["impl"];
            $this->LastErr=0;
        }
    };
    return($this->LastErr);
}
function Init(){
    global $GParam;
    $GParam->ptype=get_class($this);
    $GParam->parent=0;
    $this->LastRebuild=$GParam->GetByName("LASTREBUILD");
    $td = getdate();
    $this->CurRebuild= 0+sprintf("%04d%02d%02d", $td["year"], $td["mon"], $td["mday"]);
    $this->CurTime=0+sprintf("%d%02d", $td["hours"], $td["minutes"]);
    $tmp=$td["wday"];
    $tms="0000000";
    $this->CurShed=substr(substr($tms,0,$tmp)."1".$tms,0,7);
}
function NewTask(){
    global $user;
    $this->id=0;
    $this->user=$user->id;
    $this->name="New Tasck";
    $this->descr="";
    $this->shed="0111110";
    $this->time=300;
    $this->valid=1;
}
function SetTime(){
    global $mdb;
    if(!$this->id)return(-1);
    $tbl=$this->tbl;
    $time=$this->time;
    $lid=$this->id;
    $lsql="UPDATE $tbl SET time=$time WHERE id=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $this->LastErr=0;
    }
    return($this->LastErr);
}
function SetShed(){
    global $mdb;
    if(!$this->id)return(-1);
    $tbl=$this->tbl;
    $lshed=$this->shed;
    $lid=$this->id;
    $lsql="UPDATE $tbl SET shed='$lshed' WHERE id=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $this->LastErr=0;
    }
    return($this->LastErr);
}
function SetName(){
    global $mdb;
    if(!$this->id)return(-1);
    $tbl=$this->tbl;
    $lname=$this->name;
    $ldescr=$this->descr;
    $lid=$this->id;
    $lsql="UPDATE $tbl SET name='$lname',descr='$ldescr' WHERE id=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $this->LastErr=0;
    }
    return($this->LastErr);
}
function SetValid(){
    global $mdb;
    if(!$this->id)return(-1);
    $tbl=$this->tbl;
    $valid=$this->valid;
    $lid=$this->id;
    $lsql="UPDATE $tbl SET valid=$valid WHERE id=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $this->LastErr=0;
    }
    return($this->LastErr);
}
function SetImpl(){
    global $mdb;
    if(!$this->id)return(-1);
    $tbl=$this->tbl;
    $valid=$this->valid;
    $lid=$this->id;
    $impl=$this->impl;
    $lsql="UPDATE $tbl SET impl=$impl WHERE id=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $this->LastErr=0;
    }
    return($this->LastErr);
}
function SaveTask(){
    global $mdb;
    $lname=$this->name;
    $ldescr=$this->descr;
    $lusr=$this->user;
    $tbl=$this->tbl;
    $lstr="'$lname','$ldescr',$lusr";
    $lsql="INSERT INTO $tbl(name,descr,user) VALUES($lstr)";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $this->LastErr=0;
        $this->id=mysqli_insert_id($mdb->lCon);
    }
    $this->SetTime();
    $this->SetShed();
    $this->SetValid();
    return($this->id);
}
function DelItem($lid=0){
    global $mdb;
    $gid=0;
    if(!$lid){
        if(!$this->id)return(-1);
        else $gid=$this->id;
    }else $gid=$lid;
    $tbl=$this->tbl;
    $lsql="DELETE FROM $tbl WHERE id=$gid";
    $mdb->do_query($lsql);
}
function ReBuild(){
    global $mdb;
    global $GParam;
    if($this->CurRebuild>(0+$this->LastRebuild)){
        $tbl=$this->tbl;
        $lsql="SELECT id FROM $tbl WHERE valid=1";
        $mdb->do_query($lsql);
        $this->LastErr=0;
        $arr= array();
        if($mdb->LastErr){
            while($ret=$mdb->GetRow()){
                $arr[]=$ret["id"];
            }
            $kvo=count($arr);
            if($kvo){
                for($i=0;$i<$kvo;$i++){
                    $this->GetItem($arr[$i]);
                    if(($this->CurShed & $this->shed)!="0000000"){
                        $this->impl=1;
                    }else{
                        $this->impl=0;
                    }
                    $this->SetImpl();
                }
            }
        }else $this->LastErr=1;
        $GParam->ptype=get_class($this);
        $GParam->parent=0;
        $GParam->SetByName("LASTREBUILD",$this->CurRebuild);
    }
    
}
function Check(){
    global $mdb;
    $tbl=$this->tbl;
    $lsql="SELECT id FROM $tbl WHERE (impl=1) AND (valid=1)";
    $mdb->do_query($lsql);
    $this->LastErr=0;
    $arr= array();
    if($mdb->LastErr){
        while($ret=$mdb->GetRow()){
            $arr[]=$ret["id"];
        }
    }
    $kvo=count($arr);   
    for($i=0;$i<$kvo;$i++){
        $this->GetItem($arr[$i]);
        if($this->time<=$this->CurTime){
            $this->SetJob();
            $this->impl=0;
            $this->SetImpl();
        }
    }
}
function SetJob(){
    global $mdb;
    $tbl=$this->tbl2;
    $sid=$this->id;
    $lusr=$this->user;
    
    $lsql="SELECT itype, item FROM $tbl WHERE (sid=$sid)";
    $mdb->do_query($lsql);
    $this->LastErr=0;
    $arr= array();
    if($mdb->LastErr){
        while($ret=$mdb->GetRow()){
            $arr[]=[$ret["itype"],$ret["item"]];
        }
    }
    $job= new avcJobs();
    foreach($arr as $val ){
        $obj=new $val[0]();
        $obj->GetItem($val[1]);
        $arr=$obj->GetGroupsItem($obj);
        foreach($obj->arr as $vitem){
            $job->type=$val[0];
            $job->object=$vitem;
            $job->engine=1;
            $job->user=$lusr;
            $job->NewJob();
            $job->engine=2;
            $job->NewJob();
        }
    }
}
}

