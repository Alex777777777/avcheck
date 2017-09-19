<?php
class js_file{
    var $infile;
    var $LastErr;
    var $raw;
    var $oraw;
    function __construct() {
         $this->LastErr=0;
    }
    function __destruct() {
    }
    function Init(){
    }
    function Open($lf){
        $this->LastErr=0;
        $this->infile=$lf;
        if(file_exists($lf['tmp_name']))$this->raw=file($lf['tmp_name']);
        else $this->LastErr=1;
        for($i=0;$i<count($this->raw);$i++){
            $this->raw[$i]=trim($this->raw[$i]);
        }
    }            
    function Encode(){
        $this->oraw="";
        for($i=0;$i<count($this->raw);$i++){
            $lstr=$this->raw[$i];
            $ret="";
            $pstr="";
            $ln=strlen($lstr);
            if($ln==0) continue;
            for($ii=0;$ii<$ln;$ii++){
                $lch=substr($lstr,$ii,1);
                $lch=dechex(ord($lch));
                if(strlen($lch)==1)$lch="0".$lch;
                $ret.=$lch;
            }
            while(strlen($ret)>128){
                $this->oraw.="//".substr($ret,0,128)."\n";
                $ret=substr($ret,128);
            }
            $this->oraw.="//".$ret."\n";
        }
    }
    function SaveFile($lname){
        file_put_contents ( $lname, $this->oraw);       
    }
}
return(new js_file())
?>   
