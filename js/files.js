function GetResume(){
    objid=$("ul.gpss>.active").attr("data-id");
    ldata={
        "objid":objid,
        "type":"get"
    }
    $.ajax({
            url: '?cmd=files',
            type: 'POST',
            data: ldata,
            cache: false,
            async: true,
            success: function(respond){
                if(respond.substr(0,2)=="ER")console.log('ОШИБКИ ОТВЕТА сервера: ' + respond);
                else $(".panel-files").html(respond);
                
            }
        });
}
function GetProp(){
    objid=$(".item.active").attr("data-id");
    ldata={
        "objid":objid,
        "type":"prop"
    }
    $.ajax({
            url: '?cmd=files',
            type: 'POST',
            data: ldata,
            cache: false,
            async: true,
            success: function(respond){
                if(respond.substr(0,2)=="ER"){
                    console.log('ОШИБКИ ОТВЕТА сервера: ' + respond);
                    alert("ОШИБКИ ОТВЕТА сервера");
                }
                else {
                    $(".panel_prop1").html(respond);
                    $(".panel_prop1").slideDown("slow");
                    $(".panel_prop2").slideDown("slow");
                }
                
            }
        });
}
$(document).ready(function(){
    $(".avfl").click(function(){
        if($(".item.active").length =0){
            alert("Не выбран файл");
            return(0);
        }
        ngrp=$(".item.active>.it_r").html();
        if(!confirm("Действительно отправить на проверку '"+ngrp+"'"))return;
        ngrp=$(".item.active").attr("data-id");
        ldata={
            "val":ngrp,
            "type":"avitm"
        }
        $.ajax({
            url: '?cmd=files',
            type: 'POST',
            data: ldata,
            cache: false,
            async: true,
            success: function(respond){
                if(substr(respond,0,3)=="ERR") alert(respond);
                else alert("Файл поставлен в очередь.");
            }
        });
        
    });
    $(".avgrp").click(function(){
        ngrp=$(".sidebar li.active").html();
        if(!confirm("Действительно отправить на проверку группу '"+ngrp+"'"))return;
        ngrp=$(".sidebar li.active").attr("data-id");
        ldata={
            "val":ngrp,
            "type":"avgrp"
        }
        $.ajax({
            url: '?cmd=files',
            type: 'POST',
            data: ldata,
            cache: false,
            async: true,
            success: function(respond){
                if(substr(respond,0,3)=="ERR") alert(respond);
                else alert("Группа поставлена в очередь");
            }
        });
        
    });
    $(".delgrp").click(function(){
        ngrp=$(".sidebar li.active").html();
        if(!confirm("Действительно удалить группу '"+ngrp+"'"))return;
        ngrp=$(".sidebar li.active").attr("data-id");
        ldata={
            "val":ngrp,
            "type":"dgrp"
        }
        $.ajax({
            url: '?cmd=files',
            type: 'POST',
            data: ldata,
            cache: false,
            async: true,
            success: function(respond){
                document.location.reload();
            }
        });
        
    });
    $(".addgrp").click(function(){
        $("#ext-wrp").html("");
        $("#ext-wrp").css("display","block");
        $("#addfrm").css("display","block");
    });
    $(".frmbtn.btn").click(function(){
        fl=$(this).attr("data-id");
        if(fl=="OK"){
            lname=$("#addfrm input").val();
            ldata={
                "val":lname,
                "type":"ngrp"
            }
            $.ajax({
                url: '?cmd=files',
                type: 'POST',
                data: ldata,
                cache: false,
                async: true,
                success: function(respond){
                    document.location.reload();
                }
            });
        }
        $("#ext-wrp").css("display","none");
        $("#addfrm").css("display","none");
        $("#addfrm input").val("");
    });
    $(".delfl").click(function(){
        if(!confirm("Действительно удалить файл?"))return;
                ngrp=$(".sidebar li.active").html();
        ngrp=$(".item.active").attr("data-id");
        ldata={
            "val":ngrp,
            "type":"delfl"
        }
        $.ajax({
            url: '?cmd=files',
            type: 'POST',
            data: ldata,
            cache: false,
            async: true,
            success: function(respond){
                document.location.reload();
            }
        });
    });
    $(".dwnfl").click(function(){
        host=location.origin;
        fl=$('.item.active').attr('data-id');
        host="/?file="+fl;
        window.open(host);
    });
    $(".copfl").click(function(){
         fl=$('.item.active').attr('data-id');
         us=$(".seluser").val();
         ldata={
            "file":fl,
            "user":us,
            "type":"copfl"
        }
        $.ajax({
            url: '?cmd=files',
            type: 'POST',
            data: ldata,
            cache: false,
            async: true,
            success: function(respond){
                alert(respond);
            }
        });
    });
    $(".panel-files").on("change","input",function(e){
        e.preventDefault();
        e.stopPropagation();
        val=$(this).prop("checked");
        lid=$(this).parent().parent().attr("data-id");
        gid=$(".sidebar li.active").attr("data-id");
        ldata={
        "val":val,
        "objid":lid,
        "grpid":gid,
        "type":"set"
        }
        $.ajax({
                url: '?cmd=files',
                type: 'POST',
                data: ldata,
                cache: false,
                async: true,
                success: function(respond){
                    console.log('ОШИБКИ ОТВЕТА сервера: ' + respond);
                }
            });
        
    });
    $(".sidebar li").click(function(){
        $(".sidebar li").removeClass("active");
        $(this).addClass("active");
        $(".midbar h3").html("Группа : "+$(this).html());
        GetResume();
    });
    $(".panel-files").on("click",".item",function(){
        $(".item.active").removeClass("active");
        $(this).addClass("active");
        $(".panel_prop1").css("display","none");
        $(".panel_prop2").css("display","none");
        GetProp();
    });
    GetResume();
    $(".midbar h3").html("Группа : "+$(".sidebar li.active").html());
})