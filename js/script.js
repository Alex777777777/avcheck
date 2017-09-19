$(document).ready(function(){
$(".dropdown").mouseenter(function(){
    bl=$(this).children(".dropdown-menu");
    bl.stop();
    bl.slideDown("slow");
}).mouseleave(function(){
    bl=$(this).children(".dropdown-menu");
    bl.stop();
    bl.slideUp("slow");
})

})