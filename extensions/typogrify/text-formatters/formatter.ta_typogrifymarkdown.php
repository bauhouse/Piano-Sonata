<?php

	Class formatterta_typogrifymarkdown extends TextFormatter {

		function about(){
			return array(
			  'name' => 'Typogrify + Markdown Text Formatter',
				'description' => 'Format entries using the Typogrify + Markdown formatters'
			);
		}

		function run($string){
		  if(!function_exists('Markdown')) include_once(EXTENSIONS . '/markdown/lib/markdown.php');
		  if(!function_exists('typogrify')) include_once(EXTENSIONS . '/typogrify/lib/php-typogrify.php');

			return stripslashes(typogrify(Markdown($string)));
		}

	}

?>