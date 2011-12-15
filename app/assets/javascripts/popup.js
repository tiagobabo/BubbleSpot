	$(function() {
		 	
    $( "#dialog-modal3" ).dialog({
        autoOpen: false,
	  		modal: true,
        width: 350,
        resizable: false,
        beforeClose: function(event, ui) { $("#cover").hide(); }
		  });
      
    $( "#dialog-modal2" ).dialog({
        autoOpen: false,
	  		modal: true,
        resizable: false,
        beforeClose: function(event, ui) { $("#cover").hide(); }
		  });
      
    $( "#dialog-modal" ).dialog({
        autoOpen: false,
	  		modal: true,
        resizable: false,
        beforeClose: function(event, ui) { $("#cover").hide(); }
		  });
    
    
    $( "#opener1" ).click(function() {
      $("#cover").show();

			$( "#dialog-modal" ).dialog( "open" );
      $( "#dialog-modal ul" ).css("width","196px");
			return false;
		});
    
    
    $( "#opener" ).click(function() {
      $("#cover").show();

			$( "#dialog-modal2" ).dialog( "open" );
      $( "#dialog-modal2 ul" ).css("width","196px");
			return false;
		});
        
    $( "#opener3" ).click(function() {
      $("#cover").show();

			$( "#dialog-modal3" ).dialog( "open" );
      $( "#dialog-modal3 ul" ).css("width","196px");
			return false;
		});

        
$('.flyout').hide();

$('.nav-bar li a, .nav-bar li a:after').each(function() {
    $(this).data('clicks', 0);
  });


  $('.nav-bar li a, .nav-bar li a:after').bind('touchend click', function(e){
    e.stopPropagation();
    e.preventDefault();
    var f = $(this).siblings('.flyout');
    $(this).data('clicks', ($(this).data('clicks') + 1));
    if (!f.is(':visible') && f.length > 0) {
      f.show();
    }
    else f.hide();
  });
  $('.nav-bar li a, .nav-bar li a:after').bind(' touchend click', function(e) {
    e.stopPropagation();
    e.preventDefault();
    if ($(this).data('clicks') > 1) {
      window.location = $(this).attr('href');
    }
  });
  $('.nav-bar').bind('touchend click', function(e) {
    e.stopPropagation();
    if (!$(e.target).parents('.nav-bar li .flyout') || $(e.target) != $('.nav-bar li .flyout')) {
      e.preventDefault();
    }
  });
  $('body').bind('touchend', function(e) {
    if (!$(e.target).parents('.nav-bar li .flyout') || $(e.target) != $('.nav-bar li .flyout')) {
      $('.nav-bar li .flyout').hide();
    }
  });
    
	});