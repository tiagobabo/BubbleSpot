/* http://keith-wood.name/countdown.html
   Brazilian initialisation for the jQuery countdown extension
   Translated by Marcelo Pellicano de Oliveira (pellicano@gmail.com) Feb 2008. */
(function($) {
	$.countdown.regional['pt-BR'] = {
		labels: ['Anos', 'Meses', 'Sem.', 'Dias', 'Horas', 'Min.', 'Seg.'],
		labels1: ['Anos', 'Meses', 'Sem.', 'Dias', 'Horas', 'Min.', 'Seg.'],
		compactLabels: ['a', 'm', 's', 'd'],
		whichLabels: null,
		timeSeparator: ':', isRTL: false};
	$.countdown.setDefaults($.countdown.regional['pt-BR']);
})(jQuery);
