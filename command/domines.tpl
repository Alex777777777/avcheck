<?php
require_once($PathLoc."/cls/avc_domine.cls");

if(!isset($_POST["type"])){echo "ERR: Wrong Parametr list"; exit;}
switch($_POST["type"]){
    case "avgrp":
        require_once($PathLoc."/cls/avc_jobs.cls");
        require_once($PathLoc."/cls/avc_engs.cls");
        $engs=new avcEngines();
        $engs->SelectEngines();
        $gid=$_POST["val"];
        $job=new avcJobs();
        $dom=new avcDomine();
        $dom->SelectByGroup($gid);
        $ltype="avcDomine";
        $luser=$user->id;
        $job->user=$luser;
        foreach($dom->arr as $lid){
            $dom->GetItem($lid);
            $ldom=$dom->id;
            foreach($engs->arr as $neng=>$ceng){
                $leng=$neng;
                $job->id=0;
                $job->type=$ltype;
                $job->object=$ldom;
                $job->engine=$leng;
                $job->NewJob();
            }
        }        
        echo "OK: Change group passed";
    break;
    case "avitm":
        require_once($PathLoc."/cls/avc_jobs.cls");
        require_once($PathLoc."/cls/avc_engs.cls");
        $engs=new avcEngines();
        $engs->SelectEngines();
        $gid=$_POST["val"];
        $job=new avcJobs();
        $dom=new avcDomine();
        $dom->GetItem($gid);
        $ltype="avcDomine";
        $luser=$user->id;
        $job->user=$luser;
        foreach($engs->arr as $neng=>$ceng){
            $job->id=0;
            $job->type=$ltype;
            $job->object=$gid;
            $job->engine=$neng;
            $job->NewJob();
        }
        echo "OK: Change group passed";
    break;
    case "set":
        $grpid=$_POST["grpid"];
        $objid=$_POST["objid"];
        $val=$_POST["val"];
        $fl=new avcDomine();
        $fl->GetItem($objid);
        if(!$fl->id){echo "ERR: Wrong item id"; exit;}
        if($val=="true")$fl->SetParent($grpid);
        else $fl->SetParent("0");
        echo "OK: Change group passed";
        
    break;
    case "ngrp":
        $val=$_POST["val"];
        $fl=new avcDomine();
        $fl->NewGrp($val);
        echo "OK: New group passed";
    break;
    case "dgrp":
        $val=$_POST["val"];
        $fl=new avcDomine();
        $fl->DeleteGrp($val);
        echo "OK: Delete group passed";
    break;
    case "dfle":
        $val=$_POST["val"];
        $fl=new avcDomine();
        $fl->GetItem($val);
        $fl->Delete();
        echo "OK: Delete group passed";
    break;
    
    case "get":
        $fl=new avcDomine();
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