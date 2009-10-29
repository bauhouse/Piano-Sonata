<?php

	Class formatterta_typogrify extends TextFormatter {
		
		function about(){
			return array(
			  'name' => 'Typogrify Text Formatter',
				'description' => 'Format entries using the Typogrify formatter'
			);
		}	
		
		function run($string){
			if(!function_exists('typogrify'))  include_once(EXTENSIONS . '/typogrify/lib/php-typogrify.php');
			return stripslashes(typogrify($string)); 
		}
		
	}

?>