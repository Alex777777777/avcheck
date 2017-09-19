
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
})