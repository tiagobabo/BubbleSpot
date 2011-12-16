function update_filmes(query) {
  
    
    $.get("/search/filmes?query=" + query, function(data) {    
        
        var array = data.split(',');


        $('#filmes').empty();

        var shopping_atual = "";
        var conteudo = "";

        var cont = 4;

        for (i=0;i<array.length;i+=5)
        {
            
            if(array[i+4] != shopping_atual)
            {
              
              cont = 4;
              shopping_atual = array[i+4];
              conteudo += '<div class="row">'
              conteudo += '<div class="twelve columns">'
              conteudo += '<div class="underline"><h3>'+array[i+4]+'</h3></div>'
              conteudo += '</div>'
            }

            if(cont == 4)
            {
              conteudo += '</div><div class="row">';
              cont = 0;
            }

            conteudo += '<div class="three columns"><center><a href="/shoppings/'+ array[i+3] +'/filmes/'+array[i] +'">' + '<img height="200px" src="'+ array[i+2] + '" /></a><p>'+  array[i+1] +'</p></center><p></p></div>';
            cont++;
        }
    conteudo += '</div></div>';

    $('#filmes').html(conteudo); 
      
});

}