<?php
require_once($PathLoc."/cls/avc_engs.cls");
if(!isset($_POST["type"])){echo "ERR: Wrong Parametr list"; exit;}
switch($_POST["type"]){
    case "set":
    $lid=$_POST["item"];
    $ldescr=$_POST["descr"];
    $lapik=$_POST["lapik"];
    $lapiu=$_POST["lapiu"];
    $engs=new avcEngines();
    $engs->SelectEngines();
    $leng=$engs->arr[$lid];
    $leng->SetParam("APIKEY",$lapik);
    $leng->SetParam("APIUSER",$lapiu);
    echo "OK";
    break;
    case "getStSrv":
        $lf=$PathLoc."/log/ex.log";
        $ff=0;
        $txt="Сервер остановлен.";
        if(file_exists($lf)){
            $ff=1;
            $txt ="Сервер запущен. Последний обзор в ".trim(file_get_contents($lf));
            $lf=$PathLoc."/log/signal";
            if(file_exists($lf)){
                $ff=2;
                $txt ="Сервер в процессе остановки. Подождите.";
            }
        }
        $param=array();
        $param["ff"]=$ff;
        $param["txt"]=$txt;
        echo json_encode($param);
    break;
    case "StopServer":
        if($user->role!=1){echo("ERR:Нехватает прав!");exit;};
        $lf=$PathLoc."/log/ex.log";
        if(file_exists($lf)){
            $lf=$PathLoc."/log/signal";
            if(!file_exists($lf)){
                file_put_contents($lf,"");
                echo("STOP");
            }else{
                echo("ERR:Процедура уже запущена!");
            }
        }
    break;
    case "StartServer":
        if($user->role!=1){echo("ERR:Нехватает прав!");exit;};
        $lf=$PathLoc."/log/ex.log";
        if(file_exists($lf)){echo("ERR:Сервер уже запущен!");exit;}
        exec ("sh sserver.sh >> log/out.txt");
        echo("START");
    break;
}
?>