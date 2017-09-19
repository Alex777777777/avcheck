<?php
require_once($PathLoc."/cls/avc_file.cls");
require_once($PathLoc."/cls/avc_domine.cls");
require_once($PathLoc."/cls/avc_jobs.cls");
function do_imp($larr){
    global $user;
    $mDom=new avcDomine();
    $fl = file($larr["tmp_name"]);
    $lstr=trim($fl[0]);
    if($lstr!="AVC IMP v1.1")return(1);
    for($i=1;$i<count($fl);$i++){
        $lstr=$fl[$i];
        if(substr($lstr,0,1)=="#"){
            $lstr=substr($lstr,1);
            $pos=strpos($lstr,"#");
            if($pos){
                $lname=trim(substr($lstr,0,$pos));
                $ldesgr=trim(substr($lstr,$pos+1));
            }else{
                $lname=trim($lstr);
                $ldesgr="";
            }
            if($lname){
                if($lid=$mDom->isName($lname)){
                    $mDom->GetItem($lid);
                    if($mDom->owner!=$user->id){
                        $mDom->SetOwner(0);
                    }
                }else $mDom->NewItem($lname);
                if($ldesgr){
                    $mDom->descr=$ldesgr;
                    $mDom->Update();
                }
                $engs=split(";",$larr["option"]);
                for($ii=0;$ii<count($engs);$ii++){
                    if($engs[$ii]!=0){
                        $njob=new avcJobs();
                        $njob->object=$mDom->id;
                        $njob->type="avcDomine";
                        $njob->user=$user->id;
                        $njob->engine=$ii+1;
                        $njob->NewJob();
                    }
                }
            }
        }
    }
    return(0);
}
if(isset($_FILES["lfile"])){
    $arr=$_FILES["lfile"];
    $cnt=count($arr["name"]);
    $dar=$_POST["ldescr"];
    $oar=$_POST["lopt"];
    $narr=array();
    for($i=0;$i<$cnt;$i++){
        $parr["name"]=$arr["name"][$i];
        $parr["type"]=$arr["type"][$i];
        $parr["tmp_name"]=$arr["tmp_name"][$i];
        $parr["error"]=$arr["error"][$i];
        $parr["size"]=$arr["size"][$i];
        $parr["descr"]=$dar[$i];
        $parr["option"]=$oar[$i];
        $narr[]=$parr;
    }
    $err_cnt=0;
    foreach($narr as $larr){
        if($larr["error"]==0){
            if(file_exists($larr["tmp_name"])){
                if($larr["name"]=="domins.imp")do_imp($larr);
                else{
                $mfile=new avcFile();
                $hesh=md5_file ($larr["tmp_name"]);
                $name=$larr["name"];
                $i=0;
                $lpath=$PathLoc."/files/";
                if(!file_exists($lpath.$name)){
                    if(!$ret=mkdir($lpath.$name, 0777)){$err_cnt++;continue;};
                }
                $lpath=$lpath.$name."/";
                $hesh=$hesh.$lext;
                if(!file_exists($lpath.$hesh)){
                    copy($larr["tmp_name"],$lpath.$hesh);
                }                
                $mfile->NewItem($name);
                if(!$mfile->LastErr){
                        $mfile->oname =$hesh;
                        $mfile->descr=$larr["descr"];
                        $mfile->type=$larr["type"];
                        $mfile->Update();
                        $mfile->SetOwner($user->id);
                    
                    for($i=0;$i<count($engs);$i++){
                        $njob=new avcJobs();
                        $njob->object=$mfile->id;
                        $njob->type="avcFile";
                        $njob->user=$user->id;
                        $njob->engine=1;
                        $njob->NewJob();
                    }
                }else $err_cnt++;
                }
            }else $err_cnt++;
        }else $err_cnt++;
    }
}else echo "100";

