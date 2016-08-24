$(document).ready(function(){
  var start = new Date();
  start.setMinutes(0);
  $('.datepickermin').datepicker({
    timepicker: true,
    language: 'en',
    minutesStep: 30,
    startDate: start,
    autoClose: true
    })
});
