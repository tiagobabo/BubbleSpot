$(function () {
	var austDay = new Date();
  $('#year').hide();
  $('#month').hide();
  $('#day').hide();
  $('#hour').hide();
  $('#minutes').hide();
  
	austDay = new Date($('#year').html(), $('#month').html() - 1 , $('#day').html(), $('#hour').html(), $('#minutes').html());
	$('#defaultCountdown').countdown({until: austDay});
});