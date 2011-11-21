	$(function() {
		 	
    $( "#dialog-modal2" ).dialog({
        autoOpen: false,
	  		modal: true,
        beforeClose: function(event, ui) { $("#cover").hide(); }
		  });
      
    $( "#dialog-modal" ).dialog({
        autoOpen: false,
	  		modal: true,
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
    
	});