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
    dateFormat: 'yy-mm-dd'
  });
  
  $( "#normalizar" ).submit(function() {
    $( "#inicial").val(Math.round($( "#inicial").val()).toFixed(2));
    $( "#final").val(Math.round($( "#final").val()).toFixed(2));
    $( "#desconto").val(Math.round($( "#desconto").val()).toFixed(1));
  
  });
  
  $( "#inicial" ).change(calculoInicial);
  $( "#desconto" ).change(calculoInicial);
  $( "#final" ).change(calculoInicial2);
  
  function calculoInicial2(){
   if($( "#inicial").val().length == 0 && $( "#desconto").val().length > 0 && $( "#final").val().length > 0 ){
        var resultado = $( "#final" ).val() / ( 1- ($( "#desconto" ).val()/100));
        $( "#inicial").val(Math.round(resultado).toFixed(2));  
      }
      else if( $( "#inicial").val().length > 0 && $( "#final").val().length > 0){

         var resultado = ((1-($( "#final" ).val()/$( "#inicial" ).val()))*100);
     
        if(resultado < 0){
            alert("Valores Inválidos");
            $( "#final" ).val("");
            $( "#desconto" ).val("");
        }
        else{
           $( "#desconto" ).val(Math.round(resultado).toFixed(1));
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
        var resultado = $( "#final" ).val() / ( 1- ($( "#desconto" ).val()/100));
        $( "#inicial").val(Math.round(resultado).toFixed(2));  
      }
      else if( $( "#inicial").val().length > 0 && $( "#desconto").val().length > 0){
        var resultado = ($( "#inicial" ).val()-($( "#inicial" ).val()*$( "#desconto" ).val()/100));
       
        if(resultado < 0){
            alert("Valores Inválidos");
            $( "#final" ).val("");
            $( "#desconto" ).val("");
        }
        else{
            $( "#final" ).val(Math.round(resultado).toFixed(2));
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
            $( "#desconto" ).val(Math.round(resultado).toFixed(1));
        }

      }

  }
  }
  
  $('#lojas').hide();
  
  $("#shoppings").change(function() {
    alert('teste');
    });

  
  
});