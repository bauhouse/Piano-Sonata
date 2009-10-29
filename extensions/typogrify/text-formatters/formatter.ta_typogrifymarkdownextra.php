<?php

	Class formatterta_typogrifymarkdownextra extends TextFormatter {

		function about(){
			return array(
			  'name' => 'Typogrify + Markdown Extra Text Formatter',
				'description' => 'Format entries using the Typogrify + Markdown Extra formatters'
			);
		}

		function run($string){
		  if(!function_exists('Markdown')) include_once(EXTENSIONS . '/markdown/lib/markdown_extra.php');
		  if(!function_exists('typogrify')) include_once(EXTENSIONS . '/typogrify/lib/php-typogrify.php');

			return stripslashes(typogrify(Markdown($string)));
		}

	}

?>