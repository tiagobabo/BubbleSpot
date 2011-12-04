$(function () {
	var austDay = new Date();
  $('#year').hide();
  $('#month').hide();
  $('#day').hide();
  $('#hour').hide();
  $('#minutes').hide();
  
	austDay = new Date($('#year').html(), $('#month').html() - 1 , $('#day').html(), $('#hour').html(), $('#minutes').html());
	$('#defaultCountdown').countdown({until: austDay});
  
  $( "#datepicker" ).datepicker();
  
  $( "#inicial" ).change(calculoInicial);
  $( "#desconto" ).change(calculoInicial);
  $( "#final" ).change(calculoInicial2);
  
  function calculoInicial2(){
   if($( "#inicial").val().length == 0 && $( "#desconto").val().length > 0 && $( "#final").val().length > 0 ){
            $( "#inicial").val($( "#final" ).val() / ( 1- ($( "#desconto" ).val()/100)));  
      }
      else if( $( "#inicial").val().length > 0 && $( "#final").val().length > 0){
         var resultado = ((1-($( "#final" ).val()/$( "#inicial" ).val()))*100);
     
        if(resultado < 0){
            alert("Valores Inválidos");
            $( "#final" ).val("");
            $( "#desconto" ).val("");
        }
        else{
            $( "#desconto" ).val(resultado);
        }
    }
  }
  
  function calculoInicial(){
   
    if($( "#final").val() < 0 || $( "#desconto").val() < 0 || $( "#desconto").val() > 100 || $( "#inicial").val() < 0 ){
          alert("Valores Inválidos");
          $( "#inicial" ).val("");
          $( "#final" ).val("");
          $( "#desconto" ).val("");
    }
    else{
      if($( "#inicial").val().length == 0 && $( "#desconto").val().length > 0 && $( "#final").val().length > 0 ){
            $( "#inicial").val($( "#final" ).val() / ( 1- ($( "#desconto" ).val()/100)));  
      }
      else if( $( "#inicial").val().length > 0 && $( "#desconto").val().length > 0){
        var resultado = ($( "#inicial" ).val()-($( "#inicial" ).val()*$( "#desconto" ).val()/100));
       
        if(resultado < 0){
            alert("Valores Inválidos");
            $( "#final" ).val("");
            $( "#desconto" ).val("");
        }
        else{
            $( "#final" ).val(resultado);
        }

      }

      else if( $( "#inicial").val().length > 0 && $( "#final").val().length > 0){
        var resultado = ((1-($( "#final" ).val()/$( "#inicial" ).val()))*100);
     
        if(resultado < 0){
            alert("Valores Inválidos");
            $( "#final" ).val("");
            $( "#desconto" ).val("");
        }
        else{
            $( "#desconto" ).val(resultado);
        }

      }
  }
  }
});