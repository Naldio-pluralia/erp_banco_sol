
  function validat_status_rsult(id){

      var current_id = $(id).attr("id");
      var data_id = $(id).attr("data-id");

      if($(id).is(':checked')){
        $("label#"+current_id).addClass("result-text-decoration");
      }else {
        $("label#"+current_id).removeClass("result-text-decoration");
      }


      $.ajax({
          type: "GET",
          url: "/change_status?result_id=" + data_id,
          success: function(){
            console.log("com sucesso");
            // debugger;
          },
          error: function(){
            console.log("tem erro");
            // debugger;
          }
      });
  }


  function get_id_remove_result(current_id){
    $("li#destroy_"+current_id).addClass("hide");
  }
