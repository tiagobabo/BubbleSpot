$(function () {
	var austDay = new Date();
  $('#year').hide();
  $('#month').hide();
  $('#day').hide();
  $('#hour').hide();
  $('#minutes').hide();
  
	austDay = new Date($('#year').html(), $('#month').html() - 1 , $('#day').html(), $('#hour').html(), $('#minutes').html());
	$('#defaultCountdown').countdown({until: austDay});



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
  
    normalizar();
  
    if($( "#inicial" ).val().length == 0 && $( "#desconto" ).val() > 0 ){
         calculoInicial();
      }
      else if($( "#inicial" ).val() > 0 ){
         calculoDesconto();
      }
    
  });
  

  $( "#inicial" ).blur(function() {

    normalizar();
   

     if($( "#final" ).val() > 0){
       calculoDesconto();
    }
    else if($( "#desconto" ).val() > 0){
       calculoFinal();
    }
    
  });
  

  $( "#desconto" ).blur(function() {
    
    normalizar(); 

     if($( "#final" ).val() > 0 && $( "#inicial" ).val() > 0){
       calculoFinal();
    }
    else if($( "#final" ).val().length == 0 && $( "#inicial" ).val() > 0){
       calculoFinal();
    }
    else if($( "#inicial" ).val().length == 0 && $( "#final" ).val() > 0){
       calculoInicial();
    }
   
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

    var ini = parseInt($( "#inicial" ).val());
    var fin = parseInt($( "#final" ).val());

    if( $( "#final" ).val() < 0 || ini < fin){

       $( "#final_error" ).show();
          
      }
    else 
      { $( "#final_error" ).hide();
    }

    if($( "#inicial" ).val() < 0 ){
      $( "#inicial_error" ).show();
    }
    else{
      $( "#inicial_error" ).hide();
    }

    if($( "#desconto" ).val() < 0 || $( "#desconto" ).val() > 100){
        $( "#desconto_error" ).show();
    }
    else {
        $( "#desconto_error" ).hide();
    }
    
}


