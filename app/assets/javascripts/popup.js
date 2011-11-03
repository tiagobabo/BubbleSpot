	$(function() {
		 	
  $( "#dialog-modal2" ).dialog({
      autoOpen: false,
			modal: true,
      beforeClose: function(event, ui) { $("#cover").hide(); }
		});
   
  
 
    $( "#opener" ).click(function() {
      $("#cover").show();

			$( "#dialog-modal2" ).dialog( "open" );
      $( "#dialog-modal2 ul" ).css("width","119px");
			return false;
		});
    
    
	});