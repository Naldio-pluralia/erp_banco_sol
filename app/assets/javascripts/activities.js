jQuery(document).ready(function ($) {

    $('.button-collapse-notification').sideNav({
          menuWidth: 300,
          edge: 'right',
          // closeOnClick: true,

          // draggable: true,
          // onOpen: function(el) {  },
          // onClose: function(el) {  },

      });

    // $.getJSON( "/activities.json", function( data ) {
    //     data = [];
    //     $.each( data, function( key, object ){
    //
    //         if (key % 2 == 0) {
    //             $(".collection#list-result-activite").append(
    //               // '<a href="' + object + '">' +
    //               '<a href="#">' +
    //
    //                 '<li class="collection-item" style="padding: 10px; background-color: rgba(250, 176, 51, 0.1);">' +
    //                   '<p class="no-margin" style="font-weight: bold;">' + object.created_by + '</p>' +
    //                   '<p class="no-margin" style="font-size: 12px;">' + object.description +  '</p>' +
    //                   '<p class="no-margin" style="font-size: 12px;">' + object.created_at + '</p>' +
    //                 '</li>' +
    //               '</a>'
    //
    //             );
    //
    //         }else {
    //
    //           $(".collection#list-result-activite").append(
    //               '<li class="collection-item" style="padding: 10px; background-color: #fff;">' +
    //                 '<p class="no-margin" style="font-weight: bold;">' + object.created_by + '</p>' +
    //                 '<p class="no-margin" style="font-size: 12px;">' + object.description +  '</p>' +
    //                 '<p class="no-margin" style="font-size: 12px;">' + object.created_at + '</p>' +
    //               '</li>'
    //           );
    //         }
    //
    //
    //     });
    // });

});
