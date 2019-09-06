// function selet_by_group(current_object){
//     var current_id = $(current_object).attr("id");
//
//     if($(current_object).is(':checked')){
//       $("#" + current_id).parents(".row.selet-multiple-checkbox").children().find('input[type="checkbox"]').attr('checked', 'checked');
//     }
//     else{
//       $("#" + current_id).parents(".row.selet-multiple-checkbox").children().find('input[type="checkbox"]').removeAttr('checked');
//     }
// }


function selet_by_group(current_object){
    var current_id = $(current_object).attr("id");

    var checkboxes = $("#" + current_id).parents(".row.selet-multiple-checkbox").children().find('input[type="checkbox"]');
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i] != current_object)
            checkboxes[i].checked = current_object.checked;
    }

}
