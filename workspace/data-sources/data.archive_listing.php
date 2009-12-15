<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcearchive_listing extends Datasource{
		
		public $dsParamROOTELEMENT = 'archive-listing';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '999';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamPARAMOUTPUT = 'categories';
		public $dsParamSORT = 'system:id';
		public $dsParamSTARTPAGE = '1';
		
		public $dsParamFILTERS = array(
				'4' => '{$ds-categories}',
				'40' => '{$tag}',
				'5' => 'yes',
		);
		
		public $dsParamINCLUDEDELEMENTS = array(
				'title',
				'body: formatted',
				'publish',
				'date',
				'tags'
		);

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-categories');
		}
		
		public function about(){
			return array(
					 'name' => 'Archive: Listing',
					 'author' => array(
							'name' => 'Stephen Bau',
							'website' => 'http://home/sym/piano-sonata',
							'email' => 'stephen@domain7.com'),
					 'version' => '1.0',
					 'release-date' => '2009-12-15T19:37:24+00:00');	
		}
		
		public function getSource(){
			return '1';
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

