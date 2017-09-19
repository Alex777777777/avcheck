<?php
class avcLog{
private $file;
function __construct($lfile){
    $lstr="\nSTARTING SERVER at ".date("c");
    file_put_contents($lfile,$lstr,FILE_APPEND);
    $this->file=$lfile;
}
function __destruct(){
}
function Append($lstr){
    $lstr="\n".date("c")." : ".$lstr;
    file_put_contents($this->file,$lstr,FILE_APPEND);
}
}
?>
