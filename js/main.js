var SFiles,dropzone;
function RefreshOpt(par1){
    par=par1.children(".col4");
    opt=par.attr("data-item").split(";");
    opts=par.children("span");
    for(var i=0;i<opt.length;i++){
        lsp=$(opts[i]);
        if(opt[i]=="1"){
            lsp.removeClass('glyphicon-ban-circle');
            lsp.addClass('glyphicon-ok-circle');
        }else{
            lsp.addClass('glyphicon-ban-circle');
            lsp.removeClass('glyphicon-ok-circle');
        }
    }
}
function SaveDescr(par){
    did=+par.attr("data-id");
    SFiles[did]["descr"]=par.val();
    par.val("");
    RefreshTb();    
}
function RefreshTb(){
    for(var i=1;i<=5;i++){
        ltr=0;
        ltr=$(".table tr[data-id='"+i+"']");
        if(ltr){
            ltr.children(".col1").html("");
            ltr.children(".col2").html("");
            ltr.children(".col3").html("");
            ltr.children(".col4").attr("data-item","1;1");
            RefreshOpt(ltr);   
        }
    }
    var ssize=0;
    var ernum=0;
    for(var i=1;i<=SFiles[0];i++){
        ssize+=SFiles[i]["name"].size;
        var lsize=SFiles[i]["name"].size;
        ltr=0;
        ltr=$(".table tr[data-id='"+i+"']");
        if(ltr){
            ltr.children(".col1").html(i);
            ltr.children(".col2").html(SFiles[i]["name"].name+"<span class='glyphicon glyphicon glyphicon-remove-circle btn-delete'></span>");
            if(lsize>5*1024*1024){
                ernum++;
                ltr.children(".col3").html("<span class='error_msg'>*Размер больше 5Мб, "+(Math.round(lsize/(1024*1024)*100)/100)+"Мб</span>");
            }else ltr.children(".col3").html(SFiles[i]["descr"]);
            ltr.children(".col4").attr("data-item",SFiles[i]["option"]);
            RefreshOpt(ltr);
        }               
    }
    $("#sizeof").html("Размер выбранных файлов = " +(Math.round(ssize/(1024*1024)*100)/100)+"Мб");
    if(ssize>(20*1024*1024)){
        ernum++;
    }
    if(ernum>0){$(".err-legend").css("display","block");$(".btn-send").attr("data-id","0");}
    else {$(".err-legend").css("display","none");$(".btn-send").attr("data-id","1");}
}
$(document).ready(function() {
    SFiles=[];
    SFiles[0]=0;
    dropzone = $('#dropzone');
    if (typeof(window.FileReader) == 'undefined') {
        dropzone.text('Не поддерживается браузером!');
        dropzone.addClass('error');
    }
    dropzone[0].ondragover = function() {
        dropzone.addClass('hover');
        return false;
    };
    
    dropzone[0].ondragleave = function() {
        dropzone.removeClass('hover');
        return false;
    };
    dropzone[0].ondrop = function(event) {
        event.preventDefault();
        if(SFiles[0]>=5){
            alert("Добавлено максимальное количество файлов!");
            return;
        }
        dropzone.removeClass('hover');
        dropzone.addClass('drop');
        var file = event.dataTransfer.files[0];        
        if (file.size > 100*1024*1024) {
            dropzone.text('Файл слишком большой!');
            dropzone.addClass('error');
            return false;
        }
        SFiles[0]++;
        SFiles[SFiles[0]]=[];
        SFiles[SFiles[0]]["name"]=file;
        SFiles[SFiles[0]]["descr"]="";
        SFiles[SFiles[0]]["option"]="1;1";
        RefreshTb();    
    };
    $("#dropzone .col4>span").click(function(){
        pr=$(this).parent();
        lkey=pr.attr("data-item").split(";");
        lpar=$(this).attr("data-id");
        lpar=0+lpar-1;
        if(lkey[lpar]=="1")lkey[lpar]=0;
        else lkey[lpar]=1;
        lstr="";
        for(i=0;i<lkey.length;i++){
            lstr+=lkey[i]+";";
        }
        lstr=lstr.substring(0,lstr.length-1);
        pr.attr("data-item",lstr);
        idx=+pr.parent().attr("data-id");
        if(SFiles[0]>=idx)SFiles[idx]['option']=lstr;
        RefreshOpt(pr.parent())
    })
    $("#dropzone .col3").click(function(){
        var limp=$("#inpstr");
        var par=$(this).parent().parent().parent();
        var did=$(this).parent().attr("data-id");
        if(limp.css("display")!="none"){
            SaveDescr(limp);
        }
        if(SFiles[did]==undefined){
            limp.css("display","none");
            return;
        }
        limp.attr("data-id",did);
        limp.val(SFiles[did]["descr"]);
        var lt=$(this)[0].offsetTop+par[0].offsetTop;
        var ll=$(this)[0].offsetLeft+par[0].offsetLeft;
        var lw=$(this)[0].offsetWidth;
        var lh=$(this)[0].offsetHeight;
        limp.css({
            "top":lt,
            "left":ll,
            "width":lw,
            "heigth":lh,
            "display":"block"
        })
    })
    $("#inpstr").keydown(function(e) {
        switch(e.keyCode){ 
            case 13:
               SaveDescr($(this))
               $(this).css("display","none");
            break;
        }
    })
    $('.btn-send').click(function( event ){
        if($(this).attr("data-id")=="0"){
            alert("Устраните ошибки!");
            return;
        }
        $("#ext-wrp").css("display","block");
        event.stopPropagation();
        event.preventDefault();
        var ldata = new FormData();
       for(var i=1;i<=SFiles[0];i++){
            ldata.append( "lfile[]",SFiles[i]["name"],SFiles[i]["name"].name);
            ldata.append( "ldescr[]",SFiles[i]["descr"]);
            ldata.append( "lopt[]",SFiles[i]["option"]);
        }
        $.ajax({
            url: '?cmd=upload',
            type: 'post',
            data: ldata,
            cache: false,
            dataType: "html",
            processData: false, // Не обрабатываем файлы (Don't process the files)
            contentType: false, // Так jQuery скажет серверу что это строковой запрос
            success: function( respond, textStatus, jqXHR ){
                if( typeof respond.error === 'undefined' )window.location="?do=resume";
                else console.log('ОШИБКИ ОТВЕТА сервера: ' + respond.error );
            },
            error: function( jqXHR, textStatus, errorThrown ){
                console.log('ОШИБКИ AJAX запроса: ' + textStatus );
            }
        });    
    });
    $(document).on("click",".btn-delete",function(){
        idx=+$(this).parent().parent().attr("data-id");
        if(SFiles[0]<idx)return;
        SFiles.splice(idx,1);
        SFiles[0]=SFiles.length-1;
        RefreshTb();
    })
})
