<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourceabout_me extends Datasource{
		
		public $dsParamROOTELEMENT = 'about-me';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamSTARTPAGE = '1';
		public $dsParamINCLUDEDELEMENTS = array(
				'my-photo',
				'about-me-snippet: formatted',
				'about-me: formatted',
				'external-links: entries'
		);

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}
		
		public function about(){
			return array(
					 'name' => 'About me',
					 'author' => array(
							'name' => 'Fazal Khan',
							'website' => 'http://fazalkhan.local.co.uk',
							'email' => 'faz888@gmail.com'),
					 'version' => '1.0',
					 'release-date' => '2009-09-03T16:30:59+00:00');	
		}
		
		public function getSource(){
			return '8';
		}
		
		public function allowEditorToParse(){
			return true;
		}
		
		public function grab(&$param_pool){
			$result = new XMLElement($this->dsParamROOTELEMENT);
				
			try{
				include(TOOLKIT . '/data-sources/datasource.section.php');
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}	

			if($this->_force_empty_result) $result = $this->emptyXMLSet();
			return $result;
		}
	}

