<?php

	Class formatterta_typogrifytextile extends TextFormatter {

		function about(){
			return array(
			  'name' => 'Typogrify + Textile Text Formatter',
				'description' => 'Format entries using the Typogrify + Textile formatters'
			);
		}

		function run($string){
		  if(!function_exists('typogrify')) include_once(EXTENSIONS . '/typogrify/lib/php-typogrify.php');
		  if(!class_exists('Textile')) include_once(EXTENSIONS . '/typogrify/lib/textile.php');
			$textile = new Textile;
			return stripslashes(typogrify($textile->TextileThis($string)));
		}

	}

?>