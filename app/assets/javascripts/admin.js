function update_lojas_admin(shopping_id, tipo_id) {
  
  if(tipo_id == 2){
    if(shopping_id != -1)
    {
        $('#loj').empty();
        
        $.get("/search/lojas_by_shopping4?shopping_id=" + shopping_id, function(data) {    
        
        var array = data.split(',');

        for (i=0;i<array.length;i+=2)
        {
          $('#loj').append(
            $('<option></option>').val(array[i]).html(array[i+1])
          );
        }
       
        });

      $('#loj').removeAttr("disabled");

    }}

  
}  

function update_shoppings(tipo_id) {

  
    if(tipo_id == 1 )
    {
      $('#shopping').show();
      $('#loja').hide();
    }
    else if ( tipo_id == 2){
      $('#shopping').show();
      $('#loja').show();
    }
    else{
    	$('#shopping').hide();
      $('#loja').hide();

    }

  
}  


 $(function() {
  var pathname = window.location.pathname;
  
  if(pathname == "/admins/new"){

      $('#shopping').hide();
      $('#loja').hide();
  }

  });