<?php
 
	require_once(TOOLKIT . '/class.administrationpage.php');
 
	class contentExtensionMediathekLang extends AdministrationPage {
 
		public function __construct(&$parent){
			parent::__construct($parent);
		}
 
		public function __viewIndex() {
			$strings = $_GET;
			foreach($strings as $name => $value) {
				if($name == 'page') continue;
				$translation[$name] = __($value);
			}
			echo json_encode($translation);
			exit;
		}
	}
 
?>