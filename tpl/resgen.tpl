<?php
require_once($PathLoc."/cls/avc_file.cls");
require_once($PathLoc."/cls/avc_domine.cls");
require_once($PathLoc."/cls/avc_engs.cls");
require_once($PathLoc."/cls/avc_resume.cls");
$emgr=new avcEngines();
$e1=$emgr->GetEngine(1);
$e2=$emgr->GetEngine(2);
$grp=new avcFile();
$item=new avcFile();
$rez=new avcResume();

?>
<div class="page-header">
  <h1>Крайние результаты</h1>
</div>
<div class="container-fluid">
<div class="btmenu">
<button class='button' data-id='0'>Показать все</button><button class='button' data-id='1'>Только детекты</button><button class='button' data-id='2'>Только новые</button> <div class="viewas"></div>
</div>
<?php
      $nn=1;
      $nt=0;
      $kvoGrp=$grp->GetGroups();
      for($i=0;$i<$kvoGrp;$i++){
          $grp->GetItem($grp->arr[$i]);
          $ikvo=$item->SelectByGroup($grp->id);
          if(!$ikvo) continue;
          echo "<div class='grp'> Группа файлов '$grp->name'</div>";
          $nt++;
?>
<table class="table ftbl" data-id="<?= $nt?>"><thead>
<tr><th class="col1">#пп</th><th class="col2">Имя файла</th><th class="col3">VCM</th><th class="col5">Описание</th><th class="col6">Tools</th></tr>
</thead><tbody>
<?php
          
          for($ii=0;$ii<$ikvo;$ii++){
              $item->GetItem($item->arr[$ii]);
              $lid="f=".$item->id;
              $rkvo=$rez->Select($item,1);
              if($rkvo){
              $rez->GetItem($rez->arr[0]);
              $rez->Parse();
              $rez->Compare();
              $lurl=$rez->url;
              $e1=[$rez->detecta,$rez->detect,$rez->detectn,$rez->time];
              $scl1="";$scl2="";
              if($rez->detect)$scl1="color";
              if($rez->detectn)$scl2="color";
              $e1[0]="<span class='ccolor'><span>".$e1[0]."</span><span class='slash'>&#8260;</span><span class='detects $scl1'>".$e1[1]."</span><span class='slash'>&#8260;</span><span class='detectn  $scl1'>".$e1[2]."</span></span><span><a href='$lurl' target='_blank'> от ".$e1[3]."</a></span>";
              }else $e1=["Ошибка получения данных",0,0,0];
              $fd=$e1[1];
              $fn=$e1[2];
              $datastr="data-d='$fd' data-n='$fn'";
            echo "<tr $datastr data-lid='$lid'><td class='col1'>$nn</td><td class='col2'>" . $item->name ."</td><td class='col3'>".$e1[0]."</td><td class='col5'>".$item->descr."</td><td class='col6'></td></tr>";
            $nn++;
          }
?>
</tbody></table>

<?php
}
      $grp=new avcDomine();
      $item=new avcDomine();    
      $kvoGrp=$grp->GetGroups();
      for($i=0;$i<$kvoGrp;$i++){
          $grp->GetItem($grp->arr[$i]);
          $ikvo=$item->SelectByGroup($grp->id);
          if(!$ikvo) continue;
          echo "<div class='grp'> Группа доменов/ip '$grp->name'</div>";
          $nt++;
?>
<table class="table ftbl"><thead>
<tr><th class="col1">#пп</th><th class="col2">Имя файла</th><th class="col3">VCM</th><th class="col4">S4Y</th><th class="col5">Описание</th><th class="col6">Tools</th></tr>
</thead><tbody>
<?php
          
          for($ii=0;$ii<$ikvo;$ii++){
              $item->GetItem($item->arr[$ii]);
              $lid="d=".$item->id;
              $rez=new avcResume();
              $rkvo=$rez->Select($item,1);
              if($rkvo){
              $rez->GetItem($rez->arr[0]);
              $rez->Parse();
              $rez->Compare();
              $lurl=$rez->url;
              $e1=[$rez->detecta,$rez->detect,$rez->detectn,$rez->time];
              $scl1="";$scl2="";
              if($rez->detect)$scl1="color";
              if($rez->detectn)$scl2="color";
              $e1[0]="<span class='ccolor'><span>".$e1[0]."</span><span class='slash'>&#8260;</span><span class='detects $scl1'>".$e1[1]."</span><span class='slash'>&#8260;</span><span class='detectn  $scl1'>".$e1[2]."</span></span><span><a href='$lurl' target='_blank'> от ".$e1[3]."</a></span>";
              }else $e1=["Ошибка получения данных",0,0,0];
              $fd=$e1[1];
              $fn=$e1[2];
              $datastr="data-d='$fd' data-n='$fn'";
            echo "<tr $datastr data-lid='$lid'><td class='col1'>$nn</td><td class='col2'>" . $item->name ."</td><td class='col3'>".$e1[0]."</td><td class='col5'>".$item->descr."</td><td class='col6'></td></tr>";
            $nn++;
          }
?>
</tbody></table>
<?php
      }
?>
</div>