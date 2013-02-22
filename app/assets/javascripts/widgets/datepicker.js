$(function() {
  $('input.datepicker').each(function(i) {
    var options = {
      altField: $(this).next(),
      altFormat: 'yy-mm-dd',
      dateFormat: 'yy-mm-dd',
      showOtherMonths: true
    };
    $(this).datepicker(options);
  });
});
