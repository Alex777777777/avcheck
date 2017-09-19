<?php
$resume="";
if(isset($_POST["login"])){
    $login=$_POST["login"];
    $pass="";
    $pass=@$_POST["pass"];
    $user=new ShellUser();
    $user->authing=1;
    $user->Open($login,$pass);
    if($user->valid){
        if($user->role){
        $_SESSION["user"]=$login;
        $_SESSION["pass"]="".crc32(md5($pass));
        if(@$_POST['remem']){
            SetCookie("v1",$_SESSION["user"],time()+3600*24*365);
            SetCookie("p1",$_SESSION["pass"],time()+3600*24*365);
        }
        header("Location: http://".$_SERVER['HTTP_HOST'].$_SERVER['SCRIPT_NAME']);
        exit;
        };
        $resume="Пользователь заблокирован, обратитесь к администратору!";
    }else $resume="Неверный логин или пароль!";
    
}
?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link href="css/signin.css" rel="stylesheet">
<title>Вход</title>
</head>
<body>  
    <div class="container">
      <form class="form-signin" action="index.php?do=auth" method="POST">
        <h2 class="form-signin-heading">Пожалуйста зарегистрируйтесь</h2>
        <input type="text" name="login" class="form-control" placeholder="Логин" required autofocus>
        <input type="password" name="pass" class="form-control" placeholder="Пароль" required>
        <label class="checkbox">
          <input type="checkbox" name="remem" value="remember-me"> Запомнить меня
        </label>
        <button class="btn btn-lg btn-primary btn-block" type="submit">ОК</button>
      </form>
    </div>
</body>
</html>