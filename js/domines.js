function GetResume(){
    objid=$("ul.gpss>.active").attr("data-id");
    ldata={
        "objid":objid,
        "type":"get"
    }
    $.ajax({
            url: '?cmd=domines',
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
$(document).ready(function(){
    $(".avfl").click(function(){
        ngrp=$(".item.active>.it_r").html();
        if(!confirm("Действительно отправить на проверку '"+ngrp+"'"))return;
        ngrp=$(".item.active").attr("data-id");
        ldata={
            "val":ngrp,
            "type":"avitm"
        }
        $.ajax({
            url: '?cmd=domines',
            type: 'POST',
            data: ldata,
            cache: false,
            async: true,
            success: function(respond){
                if(substr(respond,0,3)=="ERR") alert(respond);
                else alert("Домен/ip поставлен в очередь.");
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
            url: '?cmd=domines',
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
            url: '?cmd=domines',
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
                url: '?cmd=domines',
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
    $(".panel-files").on("change","input",function(){
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
                url: '?cmd=domines',
                type: 'POST',
                data: ldata,
                cache: false,
                async: true,
                success: function(respond){
                    console.log('ОТВЕТ сервера: ' + respond);
                }
            });
    });
    $(".panel-files").on("click",".item",function(){
        $(".item.active").removeClass("active");
        $(this).addClass("active");
        $(".panel_prop2").css("display","block");
    });
    $(".sidebar li").click(function(){
        $(".sidebar li").removeClass("active");
        $(this).addClass("active");
        $(".midbar h3").html("Группа : "+$(this).html());
        $(".panel_prop2").css("display","none");
        GetResume();
    });
    $(".delfl").click(function(){
        if(!confirm("Действительно удалить файл?"))return;
                ngrp=$(".sidebar li.active").html();
        ngrp=$(".item.active").attr("data-id");
        ldata={
            "val":ngrp,
            "type":"dfle"
        }
        $.ajax({
            url: '?cmd=domines',
            type: 'POST',
            data: ldata,
            cache: false,
            async: true,
            success: function(respond){
                document.location.reload();
            }
        });
    });
    GetResume();
    $(".midbar h3").html("Группа : "+$(".sidebar li.active").html());
})