<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcedrafts extends Datasource{
		
		public $dsParamROOTELEMENT = 'drafts';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '999';
		public $dsParamREDIRECTONEMPTY = 'yes';
		public $dsParamSORT = 'system:id';
		public $dsParamSTARTPAGE = '1';
		
		public $dsParamFILTERS = array(
				'1' => '{$entry}',
				'5' => 'no',
		);
		
		public $dsParamINCLUDEDELEMENTS = array(
				'title',
				'body: formatted',
				'date',
				'manage-images',
				'article-images',
				'categories',
				'tags'
		);

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}
		
		public function about(){
			return array(
					 'name' => 'Drafts',
					 'author' => array(
							'name' => 'Stephen Bau',
							'website' => 'http://home/sym/piano-sonata',
							'email' => 'stephen@domain7.com'),
					 'version' => '1.0',
					 'release-date' => '2009-12-15T18:55:12+00:00');	
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

