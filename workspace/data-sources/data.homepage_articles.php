<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcehomepage_articles extends Datasource{
		
		public $dsParamROOTELEMENT = 'homepage-articles';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '3';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamPARAMOUTPUT = 'system:id';
		public $dsParamSORT = 'date';
		public $dsParamSTARTPAGE = '1';
		
		public $dsParamFILTERS = array(
				'5' => 'yes',
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
					 'name' => 'Homepage Articles',
					 'author' => array(
							'name' => 'Fazal Khan',
							'website' => 'http://fazalkhan.co.uk',
							'email' => 'faz888@gmail.com'),
					 'version' => '1.0',
					 'release-date' => '2009-10-21T15:38:48+00:00');	
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

