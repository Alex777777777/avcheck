<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Lang" content="ru">
<title>AV Checker</title>
<link rel="shortcut icon" href="img/favicon.png" type="image/png">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" type="text/css" href="css/style.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="js/script.js"></script>
<?php
    echo "<link rel='stylesheet' type='text/css' href='css/".$do.".css'>\n";
    echo "<script src='js/".$do.".js' type='text/javascript'></script>\n";
    switch ($do){
        case "afgani":
        break;
        //default:
    }
?>
</head>
<body>
<div id="ext-wrp">
<img src="img/Loading-28.gif">
</div>
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">AVChecker</a>
        </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="?do=main">Главная</a></li>
        <li><a href="?do=resgen">Результаты</a></li>
        <li><div class="dropdown" >            
                Настройки<span class="caret"></span>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                <li><a tabindex="-1" href="?do=files">Управление файлами</a></li>
                <li><a tabindex="-1" href="?do=domines">Управление domen/ip</a></li>
                <li><a tabindex="-1" href="?do=params">Настройка Движка</a></li>
                <li class="divider"></li>
                <li><a tabindex="-1" href="?do=filters">Фильтры в Жабу</a></li>
                <li><a tabindex="-1" href="?do=shedule">Расписание</a></li>
            </ul>
            </div>
        </li>
        <li><a href="?do=users">Пользователи</a></li>
        <li><a href="?logout=true">Выход</a></li>
      </ul>
    </div>
    </div>
</div>