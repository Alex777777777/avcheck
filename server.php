<?php
set_time_limit(0);
error_reporting(E_ALL);
//include("Jabber/SendMessage.php");
function JabberNotify($user, $message){OverviewMessage($message, "", "", $user);}
$PathLoc=__DIR__;
$logDir=$PathLoc."/log";
$logFile=$logDir."/server.log";
$exFile=$logDir."/ex.log";
$sigFile=$logDir."/signal";

$mdb=require_once("cls/db_class.cls");
$mdb->OpenDB();
require_once("cls/avc_jobs.cls");
require_once("cls/avc_log.cls");
require_once("cls/avc_engs.cls");
require_once("cls/shell_user.cls");
require_once("cls/avc_file.cls");
require_once("cls/avc_domine.cls");
require_once("cls/avc_shedule.cls");
require_once("cls/avc_param.cls");

$GParam=new avc_param();
$log=new avcLog($logFile);
$jobs=new avcJobs();
$enmgr=new avcEngines();
$resume=new avcResume();
$luser=new ShellUser();
$sh= new avcShedule();
if (file_exists($exFile)) exit;
$enmgr->SelectEngines();
$flag_exit=0;
while(!file_exists($sigFile)){
    $curtime=date("c");
    file_put_contents($exFile,$curtime);
    $sh->Init();
    $sh->ReBuild();
    $sh->Check();
    while($jobs->Select()){
        $jobs->GetItem();
        if(!$jobs->LastErr){
            $lstr="New JOB # ".$jobs->id;
            $log->Append($lstr);
            $luser->GetItem($jobs->user);
            $resume=$enmgr->ExecuteJob($jobs);
            $resume->user=$luser->id;
            $resume->Parse();
            $resume->Save();
            if($resume->DoMesage()){
                JabberNotify($user, $resume->GetMessage());
            }
        }
        $jobs->DeleteJob();
    }

    sleep(30);
}
$lstr="SHUTDOWN at SIGNAL";
$log->Append($lstr);
unlink($sigFile);
unlink($exFile);
exit(0);

?>
