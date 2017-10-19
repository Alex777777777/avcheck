<?php
session_start();
$prn="No data avaible";
$flag=0;
if(isset($_SESSION["file"])){
    $file=$_SESSION["file"];
    $_SESSION["file"]="";
    $flag=$_SESSION["flag"];
    $_SESSION["flag"]="";
};
$tmpf="";
$flmail=0;
if(isset($_SESSION["mail"])){
    $flmail=$_SESSION["mail"];
}
if(isset($_FILES['mfile'])){
    if($_FILES['mfile']['error'])$prn='Transfer Error #'.$_FILES['mfile']['error'];
    else{
        $obj=require("js_file.cls");
        $obj->Open($_FILES['mfile']);
        $obj->Encode();
        $ret=$obj->oraw."\r\n";
        $tpl=file_get_contents("js.tmpl");
        $ret.=$tpl;
        if (ob_get_level()) {
          ob_end_clean();
        }
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename=' . $_FILES['mfile']["name"]);
        header('Content-Transfer-Encoding: binary');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . strlen($ret));
        echo($ret);
        //header("Location: index.php");
        exit or die();
        }
    }
?>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

  <title>Обфускатор JS</title>
<style>
#b1{
width:1000px;
margin:10px auto;
}
.b1_hd{
font-size:18pt;
text-align:center;
}
form{
	width:100%;
	border:1px solid;
	background:#aaa;
}
.b1_txt{
height:350px;
min-height: 350px;
overflow-y: scroll;
}
.b1_mn{
background: #aaa;
border: 1px solid;
font-size: 16pt;
margin:10px 0 10px 10px;
}
#ret{
 display:block;
}
.pp_hlp{
    display:block;
    font-size: 14pt;
}
</style>

</head>

<body>
<div id="b1">
<div class='b1_hd'>Обфускация JS файла</div>
<span class="pp_hlp">Для отправки файла выберите файл скрипта(*.js)!</span>
<form method='post' enctype='multipart/form-data'>
<input style='width:400px;' name='mfile' type='file'>
<input type='submit' value='Отправить'>
</form>
</div>
</body>

</html>