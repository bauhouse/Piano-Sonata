/*
 * MEDIATHEK Extension
 * for Symphony CMS
 *
 * @author: Nils Hörrmann, post@nilshoerrmann.de
 * @source: http://github.com/nilshoerrmann/mediathek
 * @version: 2.0.1
 */

(function($) {

	/*
	 * restyle admin interface for iframe use
	 */

	$(document).ready(function() {
		
		// page is inside iframe
		if(self != top) {
			var iframe = $(window.frameElement);
			// restyle
			$('body').addClass('mediasection');
			$('h1').remove();
			$('h2').remove();
			$('#nav').remove();
			$('#usr').remove();
			$('div.actions').append('<button name="reset" class="delete" title="' + self.top.Mediathek.language.RESETENTRY + '">' + self.top.Mediathek.language.RESET + '</button>')
			$('div.actions button').click(function(event) {
				event.preventDefault();
				iframe.animate({
					'opacity': 0.01,
				}, 250, function() {
					window.location.reload();				
				});
			});
			// hide iframe while page is loading
			$('form').submit(function() {
				iframe.animate({
					'opacity': 0.01,
				}, 250);
			});
			// show iframe when new page is loaded
			// hide iframe when new entry was created successfully
			if($('p.success').size() > 0) {
				// add newly created item
				var id = window.location.href.match(/\d+/g);
				self.top.Mediathek.add(iframe.parents('.field-mediathek'), id[id.length - 1]);
				iframe.parent('div').slideUp(250, function() {
					$(this).remove();
				});
			}
			else {
				iframe.animate({
					'opacity': 1,
					'height': $('form').height()
				}, 250);
			}
		}
		
	});
	
})(jQuery.noConflict());
