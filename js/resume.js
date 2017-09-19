function GetResume(){
    obj=$(".res-panel");
    objid=obj.attr("data-id");
    objclass=obj.attr("data-class");
    obj=$(".rezitem.active");
    if(obj.length==0){$(".mside").html("");return;};
    resid=obj.attr("data-id");
    eng=$(".tabs>.tab.active").attr("data-id");
    ldata={
        "type":"get",
        "objid":objid,
        "objclass":objclass,
        "resid":resid,
        "engine":eng
    }
    $.ajax({
            url: '?cmd=resume',
            type: 'POST',
            data: ldata,
            cache: false,
            async: true,
            success: function(respond){
                $(".mside").html(respond);
            }
        });
}
$(document).ready(function(){
    $(".sidebar a").click(function(e){
        e.preventDefault();
        e.stopPropagation();
        lkey=$(this).parent().attr("data-id");
        ltp=$(this).parent().attr("data-tp");
        document.location="?do=resume&"+ltp+"="+lkey;
    })
    $(".tabs>.tab").click(function(){
        if($(this).hasClass("active"))return;
        $(".tabs>.tab.active").removeClass('active');
        $(this).addClass('active');
        GetResume();
    })
    $(".rezitem").click(function(){
        if($(this).hasClass("active"))return;
        $(".rezitem.active").removeClass('active');
        $(this).addClass("active");
        GetResume();
    })
    $(".sidebar").on("click",".sb_grp.grp_close",function(){
        obj=$(".sb_grp.grp_open>span");
        obj.addClass("glyphicon-circle-arrow-down");
        obj.removeClass("glyphicon-circle-arrow-up");
        obj=$(".sb_grp.grp_open");
        obj.next("ul").slideUp();
        obj.addClass("grp_close");
        obj.removeClass("grp_open");
        $(this).next("ul").slideDown();
        obj=$(this).children("span");
        obj.addClass("glyphicon-circle-arrow-up");
        obj.removeClass("glyphicon-circle-arrow-down");
        $(this).addClass("grp_open");
        $(this).removeClass("grp_close");
    })
    $(".sb_grp.grp_open").next("ul").css("display","block");
    obj=$(".sb_grp.grp_open>span");
    obj.addClass("glyphicon-circle-arrow-up");
    obj.removeClass("glyphicon-circle-arrow-down");
    $(".rezitem").eq(0).addClass("active");
    $(".midmenu>ul>li").eq(0).addClass("active");
    GetResume();
})