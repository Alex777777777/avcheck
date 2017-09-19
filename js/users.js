$(document).ready(function(){
    $(".tbtools").click(function(){
        lid=$(this).parent().attr("data-id");
        ldo=$(this).attr("data-id");
        lc=document.location;
        switch(ldo){
            case "open":
                document.location=lc.origin+lc.pathname+"?do=newuser&item="+lid;
            break;
            case "frozen":
            param={
                "do":"frozuser",
                "tpl":"frozuser",
                "id":lid
            }
            $.ajax({
                type: "POST",
                url: "?cmd=frozuser",
                data: param,
                cache: false,
                async: true,
                success: function(qstr){
                    if(qstr="0"){
                        document.location.reload();
                    }else alert("Ошибка!");           
                }
            });
            break;
            case "dell":
            if(confirm("Вы желаете удалить?"))return;
            param={
                "do":"deluser",
                "tpl":"deluser",
                "id":lid
            }
            $.ajax({
                type: "POST",
                url: "?cmd=deluser",
                data: param,
                cache: false,
                async: true,
                success: function(qstr){
                    if(qstr="0"){
                        document.location.reload();
                    }else alert("Ошибка!");           
                }
            })
            break;
        }
    })
    $("#btn_newuser>span").click(function(){
        lc=document.location;
        document.location=lc.origin+lc.pathname+"?do=newuser";
    })
    $(".nav-sidebar>li").click(function(event){
            event.preventDefault();    
            lst=$(this).attr("class");
            nid=$(this).attr("data-id");
            if(lst!="active"){
                $(".nav-sidebar>li").removeClass('active2');
                $(this).addClass('active2');
                $(".table>tbody>tr").show();
                if(nid!="-1"){
                $(".table>tbody>tr").each(function(idx){
                    iid=$(this).attr("data-id");
                    if(nid!=iid)$(this).hide();
                })}
            }
    })
    $("tr").click(function(event){
        lst=$(this).attr("data-id");
        if(lst!=undefined){
            $("tr").removeClass('active2');
            $(this).addClass('active2');
        }
    })
})