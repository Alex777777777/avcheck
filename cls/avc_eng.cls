<?php
class avc_eng{
    protected $type; //`avcFile', `avcUrl', or `avcDomain', 
    protected $obj;
    public $name_key;
    public $idkey;
    public $resp;
    protected $base_url;
    protected $apikey;
    protected $apiuser;
    protected $param;
function __construct(){
    $this->type="";
    $this->obj="";
    $this->name_key="";
    $this->idkey="";
    $this->resp="";
    $this->param= new avc_param();
}
function __destruct() {
}
function ReadParam(){
    $this->apikey=$this->GetParam("APIKEY");
    $this->apiuser=$this->GetParam("APIUSER");
}
function GetParam($lname){
    return($this->param->GetByName($lname));
}
function SetParam($lname,$lval){
    return($this->param->SetByName($lname,$lval));
}
function CreateResume(){
    $ret=new avcResume();
    $ret->engine=$this->name_key;
    $ret->type=$this->type;
    $ret->SetObject($this->obj->id);
    $ret->resume=$this->resp;
    return($ret);
}
function SetTypeObject($ltype){
    $this->type=$ltype;
}
function SetObject($lobj){
    $this->obj=false;
    if($this->type=="avcFile"){
        require_once("avc_file.cls");
        $this->obj=new avcFile();
        $this->obj->GetItem($lobj);
    }else{
        require_once("avc_domine.cls");
        $this->obj=new avcDomine();
        $this->obj->GetItem($lobj);
    };
}
}
class avc_filters{
    public $id;
    public $engine;
    public $class;
    public $avkey;
    public $name;
    
    public $LastErr;
    public $arr;
    private $tbl;
function __construct(){
    $this->id=0;
    $this->engine=0;
    $this->class="";
    $this->avkey="";
    $this->name="";
    
    $this->tbl="avc_filters";
}
function __destruct() {
}
function ReadAV($larr){
    foreach($larr as $key =>$val){
        if(substr($key,0,2)=="~~")continue;
        if(!isset($this->arr[$key]))$this->AddAV($key);
    }
}
function AddAV($lkey){
    global $mdb;
    $ltb=$this->tbl;
    $leng=$this->engine;
    $lcls=$this->class;
    $lsql="INSERT INTO $ltb(avkey,engine,class,name) VALUES('$lkey','$leng','$lcls','$lkey')";
    $mdb->do_query($lsql);
    if($mdb-LastErr){
        $lid=mysqli_insert_id($mdb->lCon);
        $this->arr[$lkey]=[$lid,$lkey,$lkey];
    }
}
function Select($eng,$cls){
    global $mdb;
    $this->arr=array();
    $this->engine=$eng;
    $this->class=$cls;
    if($eng==1)$eng="vcm";
    if($eng==2)$eng="s4y";
    $lsql="SELECT id,avkey,name FROM ".$this->tbl." WHERE engine='$eng' AND class='$cls' ORDER BY avkey";
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        while($row=$mdb->GetRow()){
            $this->arr[$row['avkey']]=$row;
        }
    }
}
function Open($avkey){
    global $mdb;
    if(isset($this->arr[$avkey])){
        $this->id=$this->arr[$avkey]["id"];
        $this->avkey=$this->arr[$avkey]["avkey"];
        $this->name=$this->arr[$avkey]["name"];
        return;
    }
    $this->id=0;
    if((!$this->engine)or(!$this->class))return;
    
    $lsql="INSERT INTO ".$this->tbl."(engine,class,avkey,name) VALUE(".$this->engine.",'".$this->class."','".$avkey."','".$avkey."')";
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        $this->id=mysqli_insert_id($mdb->lCon);
        $this->avkey=$avkey;
        $this->name=$avkey;
        $this->arr[$avkey]=array();
        $this->arr[$avkey]["id"]=$this->id;
        $this->arr[$avkey]["avkey"]=$avkey;
        $this->arr[$avkey]["name"]=$avkey;
    }
}
function UpdateName($name){
    global $mdb;
    $this->LastErr=0;
    if(!$this->id){
        $this->LastErr=1;
        return;
    }
    $lsql="UPDATE ".$this->tbl." SET name='$name' WHERE id=".$this->id;
    $mdb->do_query($lsql);
    if(!$mdb->LastErr){
        $this->LastErr=2;
    }
}
function GetUserFlag($avid=0){
    global $user;
    global $mdb;
    $uid=$user->id;
    $fig=$avid;
    if(!$fig)$fig=$this->id;
    $lsql="SELECT flag FROM avc_userfilters WHERE user=$uid AND avkey=$fig";
    $mdb->do_query($lsql);
    $ret="ok";
    if($mdb->LastErr)if($row=$mdb->GetRow())if($row['flag']==0)$ret="no";
    return($ret);    
}
function SetUserFlag($leng,$lflag){
    global $user;
    global $mdb;
    $uid=$user->id;
    $lsql="SELECT id FROM avc_userfilters WHERE user=$uid AND avkey=$leng";
    $mdb->do_query($lsql);
    $fn=1;
    $lid=0;
    if($mdb->LastErr){
        if($row=$mdb->GetRow()){
            $fn=0;
            $lid=$row["id"];
        }
    }
    if($fn){
        $lsql="INSERT INTO avc_userfilters(user,avkey,flag) VALUES($uid,$leng,$lflag)";
    }else{
        $lsql="UPDATE avc_userfilters SET flag=$lflag WHERE id=$lid";
    }
    $mdb->do_query($lsql);
}
}
?>
