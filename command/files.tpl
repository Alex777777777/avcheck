<?php
require_once($PathLoc."/cls/avc_file.cls");
if(!isset($_POST["type"])){echo "ERR: Wrong Parametr list"; exit;}
switch($_POST["type"]){
    case "avgrp":
        require_once($PathLoc."/cls/avc_jobs.cls");
        require_once($PathLoc."/cls/avc_engs.cls");
        $engs=new avcEngines();
        $engs->SelectEngines();
        $gid=$_POST["val"];
        $job=new avcJobs();
        $dom=new avcFile();
        $dom->SelectByGroup($gid);
        $ltype="avcFile";
        $luser=$user->id;
        $job->user=$luser;
        foreach($dom->arr as $lid){
            foreach($engs->arr as $neng=>$ceng){
                $job->id=0;
                $job->type=$ltype;
                $job->object=$lid;
                $job->engine=$neng;
                $job->NewJob();
            }
        }        
        echo "OK: Set group files to job";
    break;
    case "avitm":
        require_once($PathLoc."/cls/avc_jobs.cls");
        require_once($PathLoc."/cls/avc_engs.cls");
        $engs=new avcEngines();
        $engs->SelectEngines();
        $gid=$_POST["val"];
        $job=new avcJobs();
        $ltype="avcFile";
        $luser=$user->id;
        $job->user=$luser;
        foreach($engs->arr as $neng=>$ceng){
            $job->id=0;
            $job->type=$ltype;
            $job->object=$gid;
            $job->engine=$neng;
            $job->NewJob();
        }
        echo "OK: Set file to job";
    break;
    case "set":
        $grpid=$_POST["grpid"];
        $objid=$_POST["objid"];
        $val=$_POST["val"];
        $fl=new avcFile();
        $fl->GetItem($objid);
        if(!$fl->id){echo "ERR: Wrong item id"; exit;}
        if($val=="true")$fl->SetParent($grpid);
        else $fl->SetParent("0");
        echo "OK: Change group passed";
        
    break;
    case "ngrp":
        $val=$_POST["val"];
        $fl=new avcFile();
        $fl->NewGrp($val);
        echo "OK: New group passed";
    break;
    case "dgrp":
        $val=$_POST["val"];
        $fl=new avcFile();
        $fl->DeleteGrp($val);
        echo "OK: Delete group passed";
    break;
    case "delfl":
        $val=$_POST["val"];
        $fl=new avcFile();
        $fl->GetItem($val);
        $fl->Delete();
        echo "OK: Delete group passed";
    break;
    case "copfl":
        $ff=$_POST["file"];
        $us=$_POST["user"];
        $fl=new avcFile();
        $usr=new ShellUser();
        $usr->GetItem($us);
        $fl->GetItem($ff);
        $f1=0;$f2=0;
        $msg="Файл ".$fl->name." добавлен юзеру ". $usr->login ."\n";
        if($f1=$fl->HesUserFile($fl,$us)){
            $f2=$fl->HesUserOFile($fl,$us);
            $msg="У пользователя есть этот файл.";
        };
        if(($f1>0)&&($f2==0)){
            $msg="У пользователя другая версия файла.";
        }
        if($f1==0){
            $nf=new avcFile();
            /*$nf->NewItem($fl->name,$us);
            $nf->oname=$fl->oname;
            $nf->type=$fl->type;
            $nf->Update();   */
            $fl->SetOwner($us);
        }
        echo $msg;
        exit;
    break;
    case "prop":
        $val=$_POST["objid"];
        $fl=new avcFile();
        $fl->GetItem($val);
        if($fl->LastErr){echo "ERR: Wrong param";exit;}
        echo "<div class='prop_str'><div class='caps'>Имя файла :</div><div class='vals'>".$fl->name."</div></div>";
        echo "<div class='prop_str'><div class='caps'>md5 файла :</div><div class='vals'>".$fl->oname."</div></div>";
        echo "<div class='prop_str'><div class='caps'>Тип файла :</div><div class='vals'>".$fl->type."</div></div>";
        echo "<div class='prop_str'><div class='caps'>Группа :</div><div class='vals'>".$fl->GetNameById($fl->parent)."</div></div>";
        echo "<div class='prop_str'><div class='caps'>Дата :</div><div class='vals'>".$fl->time."</div></div>";
    break;
    case "get":
        $fl=new avcFile();
        $cnt=$fl->SelectByGroup($_POST["objid"]);
        for($i=0;$i<$cnt;$i++){
            $fl->GetItem($fl->arr[$i]);
?>
<div class="item" data-id="<?= $fl->id?>">
<div class="it_l"><input type="checkbox" checked></div>
<div class="it_r"><?= $fl->name ?></div>
</div>
<?php
        }
        $cnt=$fl->SelectByGroup("0");
        for($i=0;$i<$cnt;$i++){
            $fl->GetItem($fl->arr[$i]);
?>
<div class="item" data-id="<?= $fl->id?>">
<div class="it_l"><input type="checkbox"></div>
<div class="it_r"><?= $fl->name ?></div>
</div>
<?php
        }
    break;
    default:
    echo "ERR: Wrong type";
}
?>