jQuery(document).ready(function ($) {

    function checkTime(i) {
      if (i < 10) {
        i = "0" + i;
      }
      return i;
    }

    function startTime() {
      var today = new Date();
      var h = today.getHours();
      var m = today.getMinutes();
      var s = today.getSeconds();

      var ampm = h >= 12 ? 'PM' : 'AM';
      h = h % 12;
      h = h ? h : 12; // the hour '0' should be '12'

      m = checkTime(m);
      s = checkTime(s);

      $( "#get-time-now" ).html(  h + ":" + m + " " + '<span style="font-size: 15px">'+ ampm +'</span>');

      t = setTimeout(function() {
        startTime()
      }, 500);
    }
    startTime();
});
