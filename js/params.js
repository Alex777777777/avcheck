timer=0;
function getStatusServer(){
    param={
        "type":"getStSrv"
    }
    $.ajax({
        url: '?cmd=params',
        type: 'POST',
        data: param,
        cache: false,
        async: true,
        success: function(ret){
            obj=JSON.parse(ret);
            if(obj){
                ff=obj.ff;
                txt=obj.txt;
                btObj=$(".btn.srvbt");
                btObj.prop("disabled",false)
                bc="Запустить сервер";
                if(ff){
                    bc="Остановить сервер";
                    btObj.addClass("active");                
                    if(ff==2)btObj.prop("disabled",true);
                }else{
                    btObj.removeClass("active");
                }
                btObj.html(bc);
                $(".srvcaps").html(txt);
            }
            timer=setTimeout("getStatusServer();",10000);        
        }
    });
    
}
$(document).ready(function(){
    $(".saveprm").click(function(){
        lid=$(this).attr("data-id");
        obj=$(".item[data-id="+lid+"]");
        sobj=obj.children(".lside").children(".i_str").children(".vals").children("textarea");
        ldescr=sobj.val();
        sobj=obj.children(".mside").children(".i_str").children(".vals").children("input");
        lapik=sobj.eq(0).val();
        lapiu=sobj.eq(1).val();
        param={
            "item":lid,
            "descr":ldescr,
            "lapik":lapik,
            "lapiu":lapiu,
            "type":"set"
        }
        $.ajax({
            url: '?cmd=params',
            type: 'POST',
            data: param,
            cache: false,
            async: true,
            success: function(respond){
                if(respond.substr(0,2)=="ER")alert('ОШИБКИ ОТВЕТА сервера: ' + respond);
                else alert("Изменения успешно записаны.");
                
            }
        });
    });
    $(".btn.srvbt").click(function(){
        fl=$(this).hasClass("active");
        if(fl){
            lstr="StopServer";
            if(!confirm("Остановить сервер?"))return;
        }else {
            lstr="StartServer";
            if(!confirm("Запустить сервер?"))return;
        }
        param={
        "type":lstr
        }
        $.ajax({
            url: '?cmd=params',
            type: 'POST',
            data: param,
            cache: false,
            async: true,
            success: function(ret){
                if(String.substr(ret,0,3)=="ERR"){alert(String.substr(ret,3));exit;}
                if(ret=="STOP")alert("Запущена процедура остановки сервера!");
                else alert("Запущена процедура старта сервера!");
                clearTimeout(timer);
                getStatusServer();
            }
        });
    })
    getStatusServer()
})