// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery-ui-timepicker-addon
//= require jquery.cookie
//= require_self
//= require_tree .


$(document).ready(function(){
  $('#user_time_zone').change(function(e){
    console.log($(this).val());
    $.cookie('time_zone', $(this).val(), { expires: 7, path: '/' });
    window.location.reload();
  });

  $('#game_scheduled_at').datetimepicker({
    dateFormat: "yy-mm-dd",
    timeFormat: "hh:mm TT"
  });
});