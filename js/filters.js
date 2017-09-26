var CurCell;
function ResizeEdCell(lCell){
    edit=$("#edcell");
    if(edit.css("display")=="block"){
    it=lCell[0];
    it0=lCell.parent().parent().parent()[0];
    ltop=it0.offsetTop+it.offsetTop;
    lleft=it0.offsetLeft+it.offsetLeft;
    lw=it.offsetWidth;
    lh=it.offsetHeight;
    edit.css({
        "top":ltop,
        "left":lleft,
        "width": lw,
        "height": lh
    })
    }
}
$( window ).resize(function(){
    ResizeEdCell(CurCell);
})
$(document).ready(function(){
    $(".tab").click(function(){
        if($(this).hasClass("active")){
            return(0);
        }
        $(".tab.active").removeClass("active");
        $(this).addClass("active");
        leng=$(this).attr("data-id");
        document.location ="?do=filters&eng="+leng;
    })
    $("td.col3").click(function(){
        CurCell=$(this);
        ltxt=CurCell.html();
        $("#edcell").val(ltxt);
        $("#edcell").css({
        "display":"block"
        });
        ResizeEdCell(CurCell);
    })
    $("td.col4").click(function(){
        it=$(this).children("span");
        if(it.hasClass("flag-ok")){it.removeClass("flag-ok").addClass("flag-no");lfl=0;}
        else {it.removeClass("flag-no").addClass("flag-ok");lfl=1;}
        leng=it.attr("data-id");
        param={
            "do":"flag",
            "flag":lfl,
            "eng":leng
        }
        $.ajax({
            url: '?cmd=fltcmd',
            type: 'POST',
            data: param,
            cache: false,
            async: true,
            success: function(respond){
                if(respond=="0"){
                    console.log("OK");
                }else console.log('ОШИБКА ОТВЕТА сервера: ' + parseInt(respond,10));
            }
        });
    })
    $("#edcell").keydown(function(event){
      if (event.keyCode == 13) {
          lid=CurCell.parent().attr("data-id");
          lname=$(this).val();
          CurCell.html(lname);
          param={
                "do":"name",
                "name":lname,
                "id":lid
            }
          $.ajax({
                url: '?cmd=fltcmd',
                type: 'POST',
                data: param,
                cache: false,
                async: true,
                success: function(respond){
                    if(respond=="0"){
                        console.log("OK");
                    }else console.log('ОШИБКА ОТВЕТА сервера: ' + parseInt(respond,10));
                }
          })
          $(this).css("display","none");
      }
    });   
})