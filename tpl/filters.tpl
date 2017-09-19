<?php
require_once($PathLoc."/cls/avc_engs.cls");
if(isset($_GET['eng'])){
    $peng=$_GET['eng'];
}
$emgr=new avcEngines();
$tabs=$emgr->GetEngsName();
if(!$peng)$peng=$tabs[0]["enkey"];
$flt=new avc_filters();
?>
<div class="page-header">
  <h1>Фильтры AV Движков</h1>
</div>
<div class="container-fluid">
<div class="panel panel-default cl1">
  <div class="panel-heading tabs">
    <?php
        
        foreach($tabs as $tbl) {
            $lname=$tbl["name"];
            $lkey=$tbl["enkey"];
            $lclass="";
            if($lkey==$peng)$lclass="active";
            
            ?>
            
            <div class="tab <?= $lclass ?>" data-id="<?= $lkey ?>"><?= $lname ?></div>
            <?php
            $lclass="";
        }
    ?>
  </div>
  <div class="panel-body">
      <div class="panel panel-default cl2">
      <div class="panel-heading">Файловые фильтры</div>
      <div class="panel-body tables">
      <table class="table">
      <thead><tr><th class="col1">#</th><th class="col2">Код</th><th class="col3">Наименование</th><th class="col4">Флаг</th></tr></thead>
      <tbody>
      <?php
          $flt->Select($peng,"avcFile");
          $arr=$flt->arr;
          $rows=count($arr);
          $hrows=floor($rows/2)+($rows%2);
          for($i=0;$i<$hrows;$i++){
              $tmp=each($arr);
              $lrow=$tmp[1];
              ?>
              <tr data-id="<?= $lrow["id"]?>"><td class="col1"><?= $i+1 ?></td><td class="col2"><?= $lrow["avkey"]?></td><td class="col3"><?= $lrow["name"]?></td><td class="col4"><span data-id = "<?= $lrow["id"]?>" class="flag flag-<?= $flt->GetUserFlag($lrow["id"])?>"></span></td></tr>
              <?php
          }
      ?>
      </tbody>
      </table>
      <table class="table">
      <thead><tr><th class="col1">#</th><th class="col2">Код</th><th class="col3">Наименование</th><th class="col4">Флаг</th></tr></thead>
      <tbody>
      <?php
          for($i=$hrows;$i<$rows;$i++){
              $tmp=each($arr);
              $lrow=$tmp[1];
              ?>
              <tr data-id="<?= $lrow["id"]?>"><td class="col1"><?= $i+1 ?></td><td class="col2"><?= $lrow["avkey"]?></td><td class="col3"><?= $lrow["name"]?></td><td class="col4"><span data-id = "<?= $lrow["id"]?>" class="flag flag-<?= $flt->GetUserFlag($lrow["id"])?>"></span></td></tr>
              <?php
          }
          if($hrows*2>$rows)echo "<tr><td></td><td></td><td></td><td></td></tr>";
      ?>
      </tbody>
      </table>
      </div>
      
      </div>
      <div class="panel panel-default">
      <div class="panel-heading">Доменные фильтры</div>
      
      </div>
  </div>
</div>

</div>
<input id='edcell'>
<?php    
  
?>
