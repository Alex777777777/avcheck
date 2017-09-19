function click1() {
  
  if (window.FileList && this.files && this.files.length > 1) {

    for (var i = 0; i < this.files.length; i++) {
      var name = this.files[i].name;
      if (select_handler.has(name))
        return ssmsg.alert(UPLOAD_ERROR_MSG_DUPLICATE.replace('%filename%', name));
    }

    for (var i = 0; i < this.files.length; i++) {
      var name = this.files[i].name;
      var filename = shorten_name(name, 35);

      var size = this.files[i].size ? this.files[i].size : 0;

      if (size > max_upload_size) {
        ssmsg.alert(UPLOAD_ERROR_MSG_TOO_BIG.replace("%filename%", name));
        continue;
      }

      if (!select_handler.add(name)) {
        ssmsg.alert('An error occurred adding: ' + name + ' please try again.');
      } else if (i) {
        var $clone = $("<tr/>")
          .addClass("hoverable")
          .data('full', $(this).val())
          .html(slot.replace("%filename%", filename)).attr("title", name);

        $clone.find('a.remove').remove();

        $clone
          .insertAfter($start.find("tr.hoverable, tr.droid").last());
      } else {
        $start.find("tr.hoverable").data('full', name);
        $start.find("tr.hoverable .filename").text(filename).attr("title", name);
        $start.find("tr.hoverable").append($(".browse .file").hide());
        $start.find('a.remove').remove();
      }
    }
  } else {
    var filename = shorten_name($(this).val(), 35);
    $start.find("tr.hoverable").data('full', $(this).val());
    $start.find("tr.hoverable .filename").text(filename).attr("title", shorten_name($(this).val(), false));
    $start.find("tr.hoverable").append($(".browse .file").hide());
    select_handler.add($(this).val());
  }

  // show files list only if we got at least 1 file
  if (select_handler.count() > 0) {
    $start.find(".browse").hide();
    $start.find(".select").show()
      .find('input[name=password]').val(''); /*prevent autocomplete*/
  }
}
$(document).ready(function(){
    $(".btn1").click(function(){
        click1();
    })
    
})