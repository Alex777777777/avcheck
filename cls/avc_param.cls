<?php
class avc_param{
  var $id;
  var $name;
  var $val;
  var $parent;
  var $ptype;
  
  var $arr;
  var $tbl;
function __construct(){
    $this->_clean;
    $this->arr="";
    $this->tbl="avc_param";
}
function __destruct() {
}

function GetByName($lname){
    global $mdb;
    $par1=$this->parent;
    $par2=$this->ptype;
    $this->id=0;
    $this->name="";
    $this->val="";
    $lsql="SELECT * FROM ".$this->tbl." WHERE parent=$par1 AND ptype='$par2' AND name='$lname'";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        if($row=$mdb->GetRow()){
            $this->id=$row["id"];
            $this->name=$row["name"];
            $this->val=$row["val"];
            $this->LastErr=0;
        }
    }
    return($this->val);
}
function SetByName($lname,$val){
    global $mdb;
    $par1=$this->parent;
    $par2=$this->ptype;
    $tbl=$this->tbl;
    $lsql="UPDATE $tbl SET val='$val' WHERE (name='$lname')AND (parent=$par1) AND(ptype='$par2')";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $lkvo=mysqli_affected_rows($mdb->lCon);
        if(! $lkvo){
            $lsql="INSERT INTO ".$this->tbl."(name,val,parent,ptype) VALUES('$lname','$val',$par1,'$par2')";
            $mdb->do_query($lsql);
        };
        $this->LastErr=0;
    }
}
private function _clean(){
    $this->id="";
    $this->name="";
    $this->val="";
    $this->parent="";
    $this->ttype="";
}
}
?>
