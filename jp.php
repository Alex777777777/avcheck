<?php
set_time_limit(0);
error_reporting(E_ALL);
include("Jabber/SendMessage.php");
function JabberNotify($user, $message){OverviewMessage($message, "", "", $user);}
$PathLoc=__DIR__;


$mdb=require_once("cls/db_class.cls");
$mdb->OpenDB();
require_once("cls/shell_user.cls");
require_once("cls/avc_resume.cls");
$user=new ShellUser();
$user->GetItem(1);
$resume=new avcResume();
$resume->GetItem(17);
$resume->user=$luser->id;
$resume->Parse();
if($resume->DoMesage()){
    JabberNotify($user->jabber, $resume->GetMessage());
}


?>
