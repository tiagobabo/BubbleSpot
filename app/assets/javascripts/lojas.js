$(function () {
  $('#filter_me').hide();
});

function update_lojas2(shopping_id, query) {
  
    
    $.get("/search/lojas_by_shopping2?shopping_id=" + shopping_id + "&query=" + query, function(data) {    
        
        var array = data.split(',');


        $('#lojas').empty();


        var conteudo = "";
         	
		conteudo += '<div id="lojas2">';

		var cont = 6;
		for (i=0;i<array.length;i+=4)
        {
          	
          	if(cont == 6)
          	{
          		conteudo += '</div><div class="row">';
          		cont = 0;
          	}
          	conteudo += '<div class="two columns"><center><a href="/shoppings/'+ array[i+3] +'/lojas/'+array[i] +'">' + '<img height="100px" src="'+ array[i+2] + '" /></a><p>'+  array[i+1] +'</p></center><p></p></div>';
          	cont++;
        }
		
		conteudo += '</div></div>';
		$('#lojas').html(conteudo);	
			
});

}

function update_lojas3(query) {
  
    
    $.get("/search/lojas_by_shopping3?query=" + query, function(data) {    
        
        var array = data.split(',');


        $('#lojas').empty();

        var shopping_atual = "";
        var conteudo = "";

        var cont = 6;

        for (i=0;i<array.length;i+=5)
        {
            
            if(array[i+4] != shopping_atual)
            {
              
              cont = 6;
              shopping_atual = array[i+4];
              conteudo += '<div class="row">'
              conteudo += '<div class="twelve columns">'
              conteudo += '<div class="underline"><h3>'+array[i+4]+'</h3></div>'
              conteudo += '</div>'
            }

            if(cont == 6)
            {
              conteudo += '</div><div class="row">';
              cont = 0;
            }

            conteudo += '<div class="two columns"><center><a href="/shoppings/'+ array[i+3] +'/lojas/'+array[i] +'">' + '<img height="100px" src="'+ array[i+2] + '" /></a><p>'+  array[i+1] +'</p></center><p></p></div>';
            cont++;
        }
    conteudo += '</div></div>';
    $('#lojas').html(conteudo); 
      
});

}