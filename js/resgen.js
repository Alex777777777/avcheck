$(document).ready(function(){
    $("tbody tr").click(function(){
        lid=$(this).attr("data-lid");
        document.location="?do=resume&"+lid;
    });
    $("button.button").click(function(){
        vid=$(this).attr("data-id");
        switch(vid){
            case "0":
                $(".grp").css("display","");
                $("table thead tr").css("display","");
                $("table tbody tr").css("display","");
                $(".viewas").html("Отображение всех результатов");
            break;
            case "1":
                $(".grp").css("display","none");
                $("table thead tr").css("display","none");
                $("table thead tr").eq(0).css("display","");
                $("table tbody tr").css("display","none");
                obj=$("table tbody tr");
                len=obj.length;
                for(i=0;i<len;i++){
                    fl=obj.eq(i).attr("data-d");
                    if(fl!="0")obj.eq(i).css("display","");
                }
                $(".viewas").html("Отображение всех детектов");
            break;
            case "2":
                $(".grp").css("display","none");
                $("table thead tr").css("display","none");
                $("table thead tr").eq(0).css("display","");
                $("table tbody tr").css("display","none");
                obj=$("table tbody tr");
                len=obj.length;
                for(i=0;i<len;i++){
                    fl=obj.eq(i).attr("data-n");
                    if(fl!="0")obj.eq(i).css("display","");
                }
                $(".viewas").html("Отображение только новых детектов");
            break;
        }

    })
    $("button.button[data-id='2']").click();
})