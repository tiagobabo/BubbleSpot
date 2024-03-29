$(function () {

  $("#bla").hide();
   if( $("#desconto2:checked").val() !== undefined)
    {
      $( "#precoi" ).hide();
      $( "#precof" ).hide();
    }
    
    $(".edit_promo").keypress(function(e) {
    if (e.which == 13) {
    return false;
    }
    });

	var austDay = new Date();
  $('#year').hide();
  $('#month').hide();
  $('#day').hide();
  $('#hour').hide();
  $('#minutes').hide();

  var i;
  for (i = 1; i < 4; i++)
  {
    $('#year'+i).hide();
    $('#month'+i).hide();
    $('#day'+i).hide();
    $('#hour'+i).hide();
    $('#minutes'+i).hide();
  }
  
	austDay = new Date($('#year').html(), $('#month').html() - 1 , $('#day').html(), $('#hour').html(), $('#minutes').html());
	$('#defaultCountdown').countdown({until: austDay});
  austDay = new Date($('#year2').html(), $('#month2').html() - 1 , $('#day2').html(), $('#hour2').html(), $('#minutes2').html());
  $('#defaultCountdown2').countdown({until: austDay});
  austDay = new Date($('#year3').html(), $('#month3').html() - 1 , $('#day3').html(), $('#hour3').html(), $('#minutes3').html());
  $('#defaultCountdown3').countdown({until: austDay});
  austDay = new Date($('#year1').html(), $('#month1').html() - 1 , $('#day1').html(), $('#hour1').html(), $('#minutes1').html());
  $('#defaultCountdown1').countdown({until: austDay});



  $( "#datepicker" ).datetimepicker({
   hour:  $('#hour').html(),
    minute: $('#minutes').html(),
    closeText: 'Ok',
    currentText: 'Hoje',
    timeText: 'Horas',
	  hourText: 'Horas',
	  minuteText: 'Minutos',
    monthNames: ['Janeiro','Fevereiro','Маrço','Abril','Maio','Junho',
	'Julho','Agosto','Setembro','Оutubro','Novembro','Dezembro'],
    dayNamesMin: ['D','S','T','Q','Q','S','S'],
    dateFormat: 'dd-mm-yy'
  });
  
   $( "#inicial_error" ).hide();
   $( "#final_error" ).hide();
   $( "#desconto_error" ).hide();
   
    

 $( "#final" ).blur(function() {
  
    
  
    if($( "#inicial" ).val().length == 0 && $( "#desconto" ).val() > 0 ){
         calculoInicial();
      }
      else if($( "#inicial" ).val() > 0 ){
         calculoDesconto();
      }
    normalizar();
  });
  

  $( "#inicial" ).blur(function() {

   
   

     if($( "#final" ).val() > 0){
       calculoDesconto();
    }
    else if($( "#desconto" ).val() > 0){
       calculoFinal();
    }
     normalizar();
  });
  

  $( "#desconto" ).blur(function() {
    
    

     if($( "#final" ).val() > 0 && $( "#inicial" ).val() > 0){
       calculoFinal();
    }
    else if($( "#final" ).val().length == 0 && $( "#inicial" ).val() > 0){
       calculoFinal();
    }
    else if($( "#inicial" ).val().length == 0 && $( "#final" ).val() > 0){
       calculoInicial();
    }
   normalizar(); 
  });
  
});


function calculoDesconto(){
  var resultado = ((1-($( "#final" ).val()/$( "#inicial" ).val()))*100);
  $( "#desconto" ).val(resultado.toFixed(1));
};

function calculoInicial(){
  var resultado = $( "#final" ).val() / ( 1- ($( "#desconto" ).val()/100));
  $( "#inicial").val(resultado.toFixed(2));  
};

function calculoFinal(){
  var resultado = ($( "#inicial" ).val()-($( "#inicial" ).val()*$( "#desconto" ).val()/100));
  $( "#final" ).val(resultado.toFixed(2));
};

function normalizar(){

    var ini = parseFloat($( "#inicial" ).val());
    var fin = parseFloat($( "#final" ).val());

    if($( "#desconto" ).val() < 0 || $( "#desconto" ).val() > 100){
        $( "#desconto_error" ).show();
        $( "#botao" ).hide();
    }
    else {
        $( "#desconto_error" ).hide();
    }

    if( $( "#final" ).val() < 0 || ini < fin){

       $( "#final_error" ).show();
      $( "#botao" ).hide();

      }
    else 
      { 
      
        $( "#final_error" ).hide();
        
    }

    if($( "#inicial" ).val() < 0 ){
      $( "#inicial_error" ).show();
      $( "#botao" ).hide();
    }
    else {
      $( "#inicial_error" ).hide();
      
    }



     if(($( "#desconto" ).val() >= 0 && $( "#desconto" ).val() < 101) ){
      
      if($( "#inicial" ).val().length > 0 && $( "#final" ).val().length > 0){
        if(ini > 0 && $( "#desconto" ).val() >= 0 && $( "#desconto" ).val() < 101 && fin >= 0){
          $( "#botao" ).show();
        }
      }
      else if($( "#inicial" ).val().length == 0 && $( "#final" ).val().length == 0){
       $( "#botao" ).show();
      }    
    }
}

function update_promos(query) {
  
    
    $.get("/search/promos2?query=" + query, function(data) {    
        
        var array = data.split(',');


        $('#promos').empty();

        if(array.length > 1)
        {

        var shopping_atual = "";
        var conteudo = "";

        var cont = 3;

        for (i=0;i<array.length;i+=7)
        {
            
            if(array[i+4] != shopping_atual)
            {
              
              cont = 3;
              shopping_atual = array[i+4];
              conteudo += '<div class="row">'
              conteudo += '<div class="twelve columns">'
              conteudo += '<div class="underline"><h3>'+array[i+4]+'</h3></div>'
              conteudo += '</div>'
            }

            if(cont == 3)
            {
              conteudo += '</div><div class="row">';
              cont = 0;
            }

            conteudo += '<div class="four columns"><center><a href="/shoppings/'+ array[i+3] +'/lojas/'+ array[i+6] +'/promos/'+array[i] +'">' + '<img height="200px" src="'+ array[i+2] + '" /></a><p>'+  array[i+1] +'</br>'+array[i+5] + '&#37;  de desconto</center><p></p></div>';
            cont++;
        }

      conteudo += '</div></div>';

      $('#promos').html(conteudo); 
      }
});

}

function update_promos3(query, shopping_id, loja_id) {
  
  
    $.get("/search/getLojasPromos?query=" + query + "&shopping=" + shopping_id + "&loja=" + loja_id, function(data) {    
        

        var array = data.split(',');


        $('#promos').empty();
        if(array.length > 1)
        {

            var conteudo = "";
              
        conteudo += '<div id="promos2">';

        var cont = 3;
        for (i=0;i<array.length;i+=7)
            {
                
                if(cont == 3)
                {
                  conteudo += '</div><div class="row">';
                  cont = 0;
                }
                conteudo += '<div class="four columns"><center><a href="/shoppings/'+ array[i+3] +'/lojas/'+ array[i+6] +'/promos/'+array[i] +'">' + '<img height="200px" src="'+ array[i+2] + '" /></a><p>'+  array[i+1] +'</br>'+array[i+5] + '&#37;  de desconto</center><p></p></div>';
                cont++;
            }
        
        conteudo += '</div></div>';
        $('#promos').html(conteudo); 
      }
});

}


function update_promos2(query, shopping) {
  
    
    $.get("/search/allshoppingpromos?query=" + query+"&shopping_id="+shopping, function(data) {    
        
        var array = data.split(',');


        $('#promos').empty();

        if(array.length > 1)
        {

        var loja_atual = "";
        var conteudo = "";

        var cont = 3;

        for (i=0;i<array.length;i+=7)
        {
            
            if(array[i+4] != loja_atual)
            {
              
              cont = 3;
              loja_atual = array[i+4];
              conteudo += '<div class="row">'
              conteudo += '<div class="twelve columns">'
              conteudo += '<div class="underline"><h3>'+array[i+4]+'</h3></div>'
              conteudo += '</div>'
            }

            if(cont == 3)
            {
              conteudo += '</div><div class="row">';
              cont = 0;
            }

            conteudo += '<div class="four columns"><center><a href="/shoppings/'+ array[i+3] +'/lojas/'+ array[i+6] +'/promos/'+array[i] +'">' + '<img height="200px" src="'+ array[i+2] + '" /></a><p>'+  array[i+1] +'</br>'+array[i+5] + '&#37;  de desconto</center><p></p></div>';
            cont++;
        }

      conteudo += '</div></div>';

      $('#promos').html(conteudo); 
      }
});

}


function updatetablepromos(value, promos) {

    if(value)
    {
      var i = 0;
      var j = 0;
      for(i = 0; i < promos; i++)
      {
        if( $(".check"+i+":checked").val() !== undefined)
        {
          $( "#teste"+i ).hide();
          j++;
        }
        else
        {
          $( "#teste"+i ).show();
        }
      }

      if(j == i)
      {
        $( "#promos" ).hide();
        $("#bla").show();
      }
    }
    else
    {
      $("#bla").hide();
      var i = 0;
      $( "#promos" ).show();
      for(i = 0; i < promos; i++)
      {
          $( "#teste"+i ).show();
      }
      
    }
  
  
    

}

function sodesconto(test) {
  if(test)
  {
    $( "#precoi" ).hide();
    $( "#precof" ).hide();
  }
  else
  {
    $( "#precoi" ).show();
    $( "#precof" ).show();
  }
}



