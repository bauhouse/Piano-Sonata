/*
 * MEDIATHEK Extension
 * for Symphony CMS
 *
 * @author: Nils Hörrmann, post@nilshoerrmann.de
 * @source: http://github.com/nilshoerrmann/mediathek
 * @version: 2.0.1
 */

var Mediathek;

(function($) {

	/*
	 * Create a foldable, selectable list based on a given select field
	 */

	$.fn.mediathek = function(options, callback) {
		
		// get language
		$.getJSON(Symphony.WEBSITE + '/symphony/extension/mediathek/lang/', Mediathek.language, function(data) {
			Mediathek.language = data;
		});			

		// settings
		settings = $.extend({
			autodiscover: false,
			buttons: [
				{ text: Mediathek.language.EDIT, callback: 'open' },
				{ text: Mediathek.language.CREATE, callback: 'create' }
			]
		}, options);
		
		// apply Mediathek
		return this.each(function() {
			var select = $(this);
			var label = select.parent('label');
			var multiple = select.attr('multiple');
			// create list
			var list = $('<ul class="mediathek closed"><li class="empty"><span>' + Mediathek.language.LOADING + '</span></li></ul>');
			label.after(list);
			// get captions
			var items = [];
			select.find('option:not([value=-1])').each(function() {
				items.push($(this).val());
			});
			$.ajax({
				type: 'POST',
				dataType: 'json',
				url: Symphony.WEBSITE + '/symphony/extension/mediathek/caption/',
				data: { 
					related_section_id: select.siblings("input[name*='related_section_id']").val(),
					field_id: select.siblings("input[name*='related_section_id']").attr('name').match(/\[(\d+)\]/)[1],
					items: items.join(',')
				},
				success: function(captions){
					select.children('option:not([value=-1])').each(function() {
						var opt = $(this);
						var item = $('<li></li>');
						if(opt.attr('selected') == true) item.addClass('selected');
						item.html(captions[opt.val()]).attr('title', opt.val()).appendTo(list);
					});
					list.find('li.empty').remove();
					// livesearch
					list.prev('label.search').find('input').liveUpdate(list);			
					// close Mediathek
					Mediathek.close(list.prev('i').find('a:first-child'), list, 0);
					// autodiscovery
					if(settings.autodiscover == true) Mediathek.autodiscover();
				},
				error: function() {
					select.children('option').each(function() {
						var opt = $(this);
						var item = $('<li></li>');
						if(opt.attr('selected') == true) item.addClass('selected');
						item.html('<span>' + opt.text() + '</span>').attr('title', opt.val()).appendTo(list);
					});
					list.find('li.empty').remove();
					// livesearch
					list.prev('label.search').find('input').liveUpdate(list);			
					// close Mediathek
					Mediathek.close(list.prev('i').find('a:first-child'), list, 0);
				}
   			});
			// add events
			list.find('li').live('click', function(event) {
				if(list.hasClass('open') && list.prev('.preview').size() == 0) {
					var item = $(this);
					if(item.hasClass('selected')) {
						Mediathek.unselect(select, item, multiple);
					}
					else {
						Mediathek.select(select, item, multiple);
					}
				}
			});
			list.find('li').live('dblclick', function(event) {
				if(list.hasClass('closed') && list.prev('.preview').size() == 0) {
					Mediathek.unselect(select, $(this), multiple);
				}
			});
			list.find('a.attachment').live('click', function(event) {
				event.preventDefault();
				var attachment = $(this);
				Mediathek.openPreview(attachment.parents('ul'), attachment);
			});
			// make sortable and droppable
			Mediathek.makeSortable(list);
			Mediathek.makeDropable();
			// add buttons
			var buttons = $('<i class="buttons"></i>');
			list.before(buttons);
			$.each(settings.buttons, function(count) {
				$('<a title="' + this['callback'] + '">' + this['text'] + '</a>').click(function(event) {
					event.preventDefault();
					var switcher = $(this);
					Mediathek.toggle(switcher);
					Mediathek.closePreview(list);
					Mediathek[switcher.attr('title')](switcher, list);
				}).appendTo(buttons);
			});
			// add search
			list.before('<label class="search"><input type="search" placeholder="' + Mediathek.language.SEARCH + '" value="' + Mediathek.language.SEARCH + '" /></label>').prev('label.search').hide().find('input').focus(function() {
				Mediathek.closePreview(list);
				if($(this).val() == $(this).attr('placeholder')) {
					$(this).val(''); 
				}
			}).blur(function() {
				if($(this).val() == '') {
					$(this).val($(this).attr('placeholder')); 
				}
			});
		});	
	}; 
		
	
	/*
	 * Mediathek object
	 */

	Mediathek = {
	
		language: {
			CLOSE: 'Close',
			CREATE: 'Create New',
			EDIT: 'Edit',
			EMPTY: 'There are currently no items selected.',
			ERRORRELOAD: 'An error occured while trying to select the new item. Please reload the page.',
			ERRORMANUALLY: 'An error occured while trying to add the new item. Please reload the page and select the new item manually.',
			LOADING: 'Loading Data &#8230;',
			NEW: 'New Entry #',
			RESET: 'Reset',
			RESETENTRY: 'Reset this entry',
			SEARCH: 'type and search',
		},
		
		autodiscover: function() {
			$('textarea').each(function() {
				var text = $(this).text();
				var links = text.match(/workspace[^ .]*.[a-z0-9_]{3,4}/gi);
				$.each(links, function() {
					$('a.attachment[href=' + Symphony.WEBSITE + '/' + this + ']').each(function() {
						var item = $(this).parent('li');
						var select = item.parents('.field-mediathek').find('select');
						var multiple = select.attr('multiple');
						if(!item.hasClass('selected')) Mediathek.select(select, item, multiple);
					});
				});
			});
		},
		
		toggle: function(switcher) {
			switcher.siblings('a').removeClass('active');
			if(switcher.hasClass('active')) { 
				switcher.removeClass('active');
			}
			else {
				switcher.addClass('active');
			}
		},

		open: function(switcher, list) {
			// close create new section
			list.prevAll('div.create').slideUp(250);
			// open
			this.alphaSort(list);
			this.zebra(list);
			list.prev('label.search').slideDown(250).find('input').val(list.prev('label.search').find('input').attr('placeholder'));
			list.find('li:not(.selected)').slideDown(250, function() {
				list.removeClass('closed').addClass('open');
			});
			list.find('li.selected a.attachment').css('background', 'none');
			list.find('li.selected').removeClass('selected').animate({
				backgroundColor: '#5273C0',
				borderBottomColor: '#617DC5',
				color: '#fff'
			}, 250, function() {
				$(this).addClass('selected').removeAttr('style');
				$(this).find('a.attachment').removeAttr('style');
			});
			list.find('li.empty').remove();
			// make unsortable
			list.sortable('disable');
			// set close action
			switcher.attr('title', 'close');
		},
		
		close: function(switcher, list, time) {
			if(time != 0) time = 250;
			this.customSort(list);
			this.zebra(list.find('li.selected'));
			list.css('max-height', this.getHeight(list));
			list.prev('label.search').slideUp(time);
			list.removeClass('open').addClass('closed').scrollTop(0).find('li:not(.selected)').slideUp(time);
			list.find('li.selected:not(:visible)').slideDown(time);
			this.zebra(list.find('li.selected'));
			// handle empty Mediathek
			if(list.find('li.selected').size() == 0) $('<li class="empty"><span>' + Mediathek.language.EMPTY + '</span></li>').appendTo(list).slideDown(time);
			// make sortable
			list.sortable('enable');
			// set open action
			switcher.attr('title', 'open');	
		},
		
		create: function(switcher, list) {
			// close Mediathek
			var close = switcher.prevAll('a[title=close]');
			if(close.size() > 0) this.close(close, list);
			// create new item
			if(list.prevAll('div.create').size() == 0) {
				var name = 'frame' + $.trim(list.parent('.field-mediathek').find('label')[0].firstChild.nodeValue);
				var src = list.parent('div').find("input[name*='create_new']").val();
				$('<div class="create"><iframe name="' + name + '" src="' + src + '" /></div>').insertBefore(list.prevAll('label.search')).slideUp(0).find('iframe').css('opacity', '0.01');
			}
			var create = list.prevAll('div.create').slideToggle(250);
		},
		
		add: function(context, id) {
			if(id) {
				context.find('select').append('<option selected="selected" value="' + id + '">' + this.language.NEW + id + '</option>');
				$.ajax({
					type: 'POST',
					dataType: 'json',
					url: Symphony.WEBSITE + '/symphony/extension/mediathek/caption/',
					data: { 
						related_section_id: context.find("input[name*='related_section_id']").val(),
						field_id: context.find("input[name*='related_section_id']").attr('name').match(/\[(\d+)\]/)[1],
						items: id
					},
					success: function(captions){
						if(captions[id]) {
							var item = $('<li class="selected" title="' + id + '">' + captions[id] + '</li>');
							context.find('ul').append(item).css('max-height', Mediathek.getHeight(context.find('ul')));
							item.slideDown(250);
							Mediathek.select(context.find('select'), item, context.find('select').attr('multiple'));
							Mediathek.zebra(context.find('ul').find('.selected'));
							context.find('a[title=create]').removeClass('active');
						}
						else {
							alert(Mediathek.language.ERRORRELOAD);
						}
					},
					error: function() {
						alert(Mediathek.language.ERRORRELOAD);
					}
	   			});
   			}
   			else {
				alert(Mediathek.language.ERRORMANUALLY);
   			}
		},
		
		makeSortable: function(list) {
			list.sortable({
				placeholder: 'placeholder',
				tolerance: 'pointer',
				helper: 'clone',
				cursor: 'move',
				start: function(event, ui) {
					ui.placeholder.html(ui.helper.html());
					ui.helper.removeClass('selected').addClass('move');
				},
				out: function(event, ui) {
					var helper = $(ui.helper);
					if(helper.children('a').size() > 0) {
						helper.removeClass('odd').css('opacity', '1');
					}
				},
				over: function(event, ui) {
					ui.helper.css('opacity', '0');
				},
				change: function(event, ui) {
					// reset zebra
					$(this).find('li:visible').removeClass('odd').filter(':odd').addClass('odd');
				},
				stop: function(event, ui) {
					$(this).find('li.selected').removeClass('odd').filter(':odd').addClass('odd');
					// update sort order
					Mediathek.updateSort(list, 0, 0)
					// remove overlay
					$('.overlay').remove();
				}
			});			
		},
		
		makeDropable: function() {
			$('textarea').droppable({
				over: function(event, ui) {
					if($('.overlay').size() == 0 && ui.helper.find('a').hasClass('attachment')) {
						$(this).before('<div class="overlay"></div>');
						$('.overlay').css({
							width: $(this).width(),
							height: $(this).height(),
							position: 'absolute',
							top: $(this).position().top,
							left: 0
						});
					}
				},
				out: function(event, ui) {
					$('.overlay').remove();			
				},
				drop: function(event, ui) {
					$('.overlay').remove();
					// insert text
					type = $.trim(ui.helper.find('a.attachment').attr('class').substring(0, 5));
					formatter = $(this).attr('class').match(/(?:markdown)|(?:textile)/) || ['html'];
					matches = {
						text: $.trim(ui.helper[0].firstChild.textContent),
						path: ui.helper.find('a.attachment').attr('href')
					}
					if(ui.helper.find('a').hasClass('attachment')) {
						var formattedText = Mediathek.substitute(Mediathek.formatter[formatter.join()][type], matches);
						var start = this.selectionStart;
						var end = this.selectionEnd;
						if(start >= 0) {
							this.value = this.value.substring(0, start) + formattedText + this.value.substring(end, this.value.length);
						}
						else {
							this.value += formattedText;
						}
						this.selectionStart = start + formattedText.length;
						this.selectionEnd = start + formattedText.length;
					}
				}
			});	
		},
		
		substitute: function(template, matches) {
			var match;
			for(match in matches) {
				template = template.replace('{@' + match + '}', matches[match]); 
			}
			return template;
		},
		
		formatter: {
			markdown: {
				image: '![{@text}]({@path})',
				file: '[{@text}]({@path})'
			},
			textile: {
				image: '!{@path}({@text})!',
				file: '"{@text}":({@path})'		
			},
			html: {
				image: '<img src="{@path}" alt="{@text}" />',
				file: '<a href="{@path}">{@text}</a>'
			}
		},
		
		getHeight: function(list) {
			max = this.getMaxHeight(list);
			min = this.getMinHeight(list);
			if(max < min) return min;
			return max;		
		},
		
		getCurrentHeight: function(list) {
			max = this.getMaxHeight(list);
			min = this.getMinHeight(list);
			if(max < min) return max;
			return min;		
		},
		
		getMaxHeight: function(list) {
			var max = 0;
			list.find('li.selected').each(function() {
				max += $(this).outerHeight();
			});
			return max;
		},
		
		getMinHeight: function(list) {
			var min = list.find('li:first').outerHeight() * 10;
			return min;
		},
		
		select: function(select, item, multiple) {
			var id = item.attr('title');
			var list = item.parent('ul');
			if(multiple) {
				this.updateSort(list, id, 1);
			}
			else {
				list.find('li.selected').removeClass('selected');
				list.parent('div').find("input[name*='sort_order']").val(id);
			}
			select.find('option[value=' + item.attr('title') + ']').attr('selected', true);
			item.addClass('selected');
			if(list.hasClass('closed')) {
				item.slideDown(250);
				list.find('li.empty').slideUp(250);
				this.zebra(item.siblings('li.selected').andSelf());
			}
		},
		
		unselect: function(select, item, multiple) {
			var list = item.parent('ul');
			select.find('option[value=' + item.attr('title') + ']').removeAttr('selected');
			if(list.hasClass('closed')) {
				// handle empty Mediathek
				if(list.find('li.selected').size() == 1 && list.find('li.empty:visible').size() == 0) {
					$('<li class="empty"><span>' + Mediathek.language.EMPTY + '</span></li>').appendTo(list);
					item.removeClass('selected').slideUp(0);
				}
				else {
					item.slideUp(250, function() {
						item.removeClass('selected');
					});				
				}
				this.zebra(item.siblings('li.selected'));
			}
			else {
				item.removeClass('selected');		
			}
			this.updateSort(item.parent('ul'), item.attr('title'), 0);
		},
		
		customSort: function(list) {
			var id = list.parent('div').find("input[name*='sort_order']").val().split(',');
			$.each(id, function() {
				var item = list.find('li[title=' + this + ']');
				item.appendTo(list);
			});
			// sort order
			this.updateSort(list, 0, 0);
		},
		
		alphaSort: function(list) {
			var items = list.find('li');
			$.each(items.sort(function(a, b){ return a.innerHTML.toLowerCase() > b.innerHTML.toLowerCase() ? 1 : -1; }), function() {
				$(this).appendTo(list);
			});
		},
		
		updateSort: function(list, id, mode) {
			var cache = [];
			var sort = list.parent('div').find("input[name*='sort_order']");
			var current = sort.val().split(',');
			// convert ids to numbers
			$.each(current, function(index) {
				current[index] = parseInt(current[index]);
			});
			// add id at the end of the array
			if(mode == 1 && id > 0) {
				current.push(id);
				cache = current;
			}
			// remove id from the array
			else if(mode == 0 && id > 0) {
				cache = jQuery.grep(current, function(index) {
					return index != id;
				});			
			}
			// rebuild array
			else {
				list.find('li.selected').each(function() {
					cache.push($(this).attr('title'));
				});
			}
			sort.val(cache.toString());
		},
		
		openPreview: function(list, attachment) {
			if(list.prev('.preview').size() > 0) return;
			var text = $.trim(attachment.prev('span').text());
			var height = list.height();
			var maxheight = this.getHeight(list);
			var position = list.position();
			var href = attachment.attr('href');
			var link = href.split('/workspace/')[1];
			var ext = href.split('.');
			var img = eval("(" + attachment.attr('name') + ")");
			if(img['jit'] == 1 || img['height'] == 0 || img['width'] == 0) {
				width = Math.floor(175 / img['height'] * img['width']);
				var file = '<a class="image" href="' + href + '"><img src="' + Symphony.WEBSITE + '/image/1/' + width + '/175/' + link + '" width="' + width + '" height="175" alt="' + text + '" /></a>';
			}
			else {
				var file = '<a class="file" href="' + href + '">' + ext[ext.length - 1] + '</a>';		
			}
			var preview = $('<div class="preview"><a class="close">' + Mediathek.language.CLOSE + '</a>' + file + '<p><a href="' + href + '">' + text + '<br /><span>/workspace/' + link + '</span></a></p></div>').insertBefore(list);
			preview.css(position).css({
				width: '100%',
				height: this.getHeight(list)
			}).hide().find('.close').click(function(event) {
				Mediathek.closePreview(list);
			});
			// only animate mediathek if, it's to small
			if(maxheight > height) {
				list.animate({
					height: maxheight
				}, 'fast', 'swing', function() {
					preview.fadeIn('fast');
				});
			}
			else {
				preview.fadeIn('fast');
			}
		},
		
		closePreview: function(list) {
			list.prev('.preview').fadeOut('fast', function() {
				$(this).remove();
				list.css({
					height: 'auto',
					maxHeight: Mediathek.getHeight(list)
				});
			});
		},
		
		zebra: function(list) {
			if($(list).size() == 0) return;
			if(list[0].tagName == 'UL') list = list.find('li');
			list.each(function(count) {
				var item = $(this);
				item.removeClass('odd');
				if(count % 2) item.addClass('odd');
			});
		}
	
	}

	
	/*
	 * Initialise Mediathek
	 */
	 
	$(document).ready(function() {
		$('.field-mediathek select').mediathek();
	});
	
	
	/**
	 * live search (modified)
	 *
	 * @authors John Nunemaker, John Resig
	 * @source http://ejohn.org/blog/jquery-livesearch
	 */
	
	$.fn.liveUpdate = function(list) {
		list = $(list);
		if(list.length) {
			var rows = list.find('li'),
				cache = rows.map(function() {
					return this.innerHTML.toLowerCase();
				});
			this.keyup(filter);
			this.click(filter);
		}
			
		return this;
			
		function filter() {
			var term = $.trim($(this).val().toLowerCase()), scores = [];
			if(!term) {
				rows.show();
			} 
			else {
				rows.hide();
				cache.each(function(i) {
					var score = this.score(term);
					if(score > 0) { 
						scores.push([score, i]);
					}
				});
				$.each(scores.sort(function(a, b){ return b[0] - a[0]; }), function() {
					$(rows[this[1]]).show();
				});
				// set zebra
				var visible = list.find('li:visible');
				if(visible.size() > 0) {
					Mediathek.zebra(visible);
				}
			}
		}
	};

})(jQuery);
