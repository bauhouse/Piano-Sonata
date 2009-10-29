<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourceall_categories extends Datasource{
		
		public $dsParamROOTELEMENT = 'all-categories';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '99';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamSTARTPAGE = '1';
		public $dsParamINCLUDEDELEMENTS = array(
				'title'
		);

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}
		
		public function about(){
			return array(
					 'name' => 'All Categories',
					 'author' => array(
							'name' => 'Fazal Khan',
							'website' => 'http://fazalkhan.co.uk',
							'email' => 'faz888@gmail.com'),
					 'version' => '1.0',
					 'release-date' => '2009-10-22T10:06:07+00:00');	
		}
		
		public function getSource(){
			return '2';
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

