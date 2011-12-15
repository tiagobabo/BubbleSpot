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


  $('.nav-bar li a, .nav-bar li a:after').bind('click', function(e){
    var f = $(this).siblings('.flyout');
    if (!f.is(':visible') && f.length > 0) {
      f.show();
    }
    else f.hide();
  });
	});