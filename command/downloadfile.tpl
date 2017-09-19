<?php
/*if($user->role!=1){
    echo "<h1 style='color:red;'>Неудача</h1><br><span>Нет прав на скачивание файла.</span>";
    exit;
}  */
require($PathLoc."/cls/avc_file.cls");
$obj=new avcFile();
$obj->GetItem($_GET["file"]);
if(!$obj->LastErr){
$file=$obj->path.$obj->name."/".$obj->oname;
    if (file_exists($file)) {
    if (ob_get_level()) {
      ob_end_clean();
    }
    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename=' . basename($obj->name));
    header('Content-Transfer-Encoding: binary');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($file));
    readfile($file);
  }
}