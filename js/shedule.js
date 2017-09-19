function isCheck(obj){
    if(obj.children("input").prop("checked"))return("1");
    else return("0");
}
$(document).ready(function(){
    $(".mside .sitem input").change(function(){
        var isck=$(this).prop("checked");
        var val=0;
        if(isck)val=1;
        var lid=$(this).parent().attr("data-id");
        var ltp=$(this).parent().attr("data-type");
        var ltz=$(this).parent().parent().parent().attr("data-id");
        var param={
            "type":"set",
            "tz":ltz,
            "item-t":ltp,
            "item":lid,
            "val":val            
        }
        $.ajax({
            url: '?cmd=shedule',
            type: 'POST',
            data: param,
            cache: false,
            async: true,
            success: function(ret){
                if(String.substr(ret,0,2)=="ER")Console.log(ret);
            }
        });
    })
    $("span.scrl").click(function(){
        dir=$(this).attr("data-id");
        gid=$(this).attr("data-gid");
        ohor=$(".time-h[data-gid='"+gid+"']");
        omin=$(".time-m[data-gid='"+gid+"']");
        switch(dir){
            case "h1":
                lval=Number(ohor.val());
                lval++;
                if(lval>23)lval=0;
                lval=""+lval;
                ohor.val(lval);
            break;
            case "h0":
                lval=Number(ohor.val());
                lval--;
                if(lval<0)lval=23;
                lval=""+lval;
                ohor.val(lval);
            break;
            case "m1":
                lval=Number(omin.val());
                lval++;
                if(lval==60)lval=0;
                lval="0"+lval;
                omin.val(String.substr(lval,lval.length-2));
            break;
            case "m0":
                lval=Number(omin.val());
                lval--;
                if(lval<0)lval=59;
                lval="0"+lval;
                omin.val(String.substr(lval,lval.length-2));
            break;
        }
    })
    $(".btn.save-item").click(function(){
        var gid=$(this).attr("data-id");
        var str=$("tr[data-id='"+gid+"']");
        var str1=str.children("td");
        var lshed=isCheck(str1.eq(6))+isCheck(str1.eq(0))+isCheck(str1.eq(1))+isCheck(str1.eq(2))+isCheck(str1.eq(3))+isCheck(str1.eq(4))+isCheck(str1.eq(5));
        var lname=$(".pl_name[data-id='"+gid+"']").val();
        var ldescr=$(".pl_descr[data-id='"+gid+"']").val();
        var ltime=$(".time-h[data-gid='"+gid+"']").val()+$(".time-m[data-gid='"+gid+"']").val();
        param={
            "id":gid,
            "name":lname,
            "descr":ldescr,
            "shed":lshed,
            "time":ltime,
            "type":"save"
        }
        $.ajax({
            url: '?cmd=shedule',
            type: 'POST',
            data: param,
            cache: false,
            async: true,
            success: function(ret){
                if(String.substr(ret,0,2)=="OK")alert("Успешно сохранено!");
                else alert("Ошибка сохранения!");
            }
        });
    })
    $(".delsvc").click(function(){
        if(!confirm("Удалить задание?"))return;
        tmp=$(this).parent().parent().parent().attr("data-id");
        param={
            "id":tmp,
            "type":"delete"
        }
        $.ajax({
            url: '?cmd=shedule',
            type: 'POST',
            data: param,
            cache: false,
            async: true,
            success: function(ret){
                document.location.reload();
            }
        });
    })
    $(".addsvc").click(function(){
        if(!confirm("Добавить задание?"))return;
        param={
            "type":"add"
        }
        $.ajax({
            url: '?cmd=shedule',
            type: 'POST',
            data: param,
            cache: false,
            async: true,
            success: function(ret){
                document.location.reload();
            }
        });
    })
    $(".runsvc").click(function(){
        var tmp=$(this).attr("data-id");
        var obj=$(".rside>.icon[data-id='"+tmp+"']");
        var val=obj.attr("data-val");
        if(val=="0"){
            obj.attr("data-val","1");
            $(this).html("STOP");
            $(this).css("color","#f00");
            obj.children(".run").css("display","block");
            obj.children(".stop").css("display","none");
        }
        else{ 
            obj.attr("data-val","0");
            $(this).html("Start");
            $(this).css("color","rgb(17, 96, 233)");
            obj.children(".run").css("display","none");
            obj.children(".stop").css("display","block");
        }
    })
    var obj=$(".rside>.icon");
    var tmp;
    for(var i=0;i<obj.length;i++){
        tmp=obj.eq(i).attr("data-val");
        lobj=obj.eq(i);
        if(tmp=="1"){
            lobj.parent().children(".runsvc").html("STOP");
            lobj.parent().children(".runsvc").css("color","#f00");
            lobj.children(".run").css("display","block");
            lobj.children(".stop").css("display","none");
        }
        else{ 
            lobj.parent().children(".runsvc").html("Start");
            lobj.parent().children(".runsvc").css("color","rgb(17, 96, 233)");
            lobj.children(".run").css("display","none");
            lobj.children(".stop").css("display","block");
        }
    }
})