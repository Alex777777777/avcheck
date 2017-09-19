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
function GetUserFlag(){
    global $user;
    global $mdb;
    $uid=$user->id;
    $fig=$this->id;
    $lsql="SELECT flag FROM avc_userfilters WHERE user=$uid AND aveng=$fid";
    $mdb->do_query($lsql);
    $ret=1;
    if($mdb->LastErr){if($row=$mdb->GetRow())$ret=$row['flag'];}
    return($ret);
}    
}
?>
