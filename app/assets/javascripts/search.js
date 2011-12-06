/***********************************************************/
/*                    LiveFilter Plugin                    */
/*                      Version: 1.2                       */
/*                      Mike Merritt                       */
/*             	   Updated: Apr 15th, 2010                 */
/***********************************************************/

(function($){
  
  $("#shopping option[value=-1]").attr("selected","selected") ;
  $('#loja').attr('disabled', 'disabled');
	$.fn.liveFilter = function (aType) {
		
		// Determine what we are going to be filtering.
		var filterTarget = $(this);
		var child;
		if ($(this).is('ul')) {
			child = 'li';
		} else if ($(this).is('ol')) {
			child = 'li';
		} else if ($(this).is('table')) {
			child = 'tbody tr';
		}
		
		// Declare variables
		var hide;
		var show;
		var filter;
		
		// Input element event
		$('input.filter').keyup(function() {
			
			// Grab the filter value
			filter = $(this).val();
			
			// Grab the ones we need to hide and the ones we need to show
			hide = $(filterTarget).find(child + ':not(:Contains("' + filter + '"))');
			show = $(filterTarget).find(child + ':Contains("' + filter + '")')
			
			// Animate the items we are hiding and showing
			if ( aType == 'basic' ) {
				hide.hide();
				show.show();
			} else if ( aType == 'slide' ) {
				hide.slideUp(500);
				show.slideDown(500);
			} else if ( aType == 'fade' ) {
				hide.fadeOut(400);
				show.fadeIn(400);
			}
			
		});		
		
		// Custom expression for case insensitive contains()
		jQuery.expr[':'].Contains = function(a,i,m){
		    return jQuery(a).text().toLowerCase().indexOf(m[3].toLowerCase())>=0;
		}; 

	}

})(jQuery);

function update_lojas(shopping_id) {
  
    if(shopping_id != -1)
    {
        $('#loja').empty();
        
        $.get("/search/lojas_by_shopping?shopping_id=" + shopping_id, function(data) {    
        
        var array = data.split(',');

        for (i=0;i<array.length;i+=2)
        {
          $('#loja').append(
            $('<option></option>').val(array[i]).html(array[i+1])
          );
        }
       
        });

      $('#loja').removeAttr("disabled");

    }
  else
  {
    $('#loja').attr('disabled', 'disabled');
    $('#loja').empty();
    $('#loja').append(
            $('<option></option>').html("-1").html("Todas")
          );
  }
  
}  