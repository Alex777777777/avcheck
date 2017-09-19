<div class="page-header">
  <h1>Загрузка файлов</h1>
</div>
<div class="container chp1">
      <div id="dropzone"><h3>Перетащите сюда файлы</h3>
      <table class="table">
      <thead><tr><th class="col1">#</th><th class="col2">File</th><th class="col3">Описание</th><th class="col4">Опции</th></tr></thead>
      <tbody>
      <?php
        for($i=1;$i<=5;$i++){
            ?>
            <tr data-id='<?= $i;?>'><td class="col1"></td><td class="col2"></td><td class="col3"></td><td class="col4" data-item="1;1"><span data-id="1" class="glyphicon glyphicon-ok-circle"></span><span data-id="2" class="glyphicon glyphicon-ok-circle"></span></td></tr>
            <?php
        }
      ?>
      </tbody>
      </table>
      <div class="well well-lg err-legend"><span>* размер файла должен быть меньше 5мб</span>
      <span>** размер всех файлов должен быть меньше 20мб</span><span id="sizeof"></span></div>
      <button class="btn btn-primary btn-send">Отправить</button>
      </div>
      <input id="inpstr" class="form-control" style="display:none;position:absolute;">
</div>
<?php    
  
?>
