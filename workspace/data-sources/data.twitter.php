<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcetwitter extends Datasource{
		
		public $dsParamROOTELEMENT = 'twitter';
		public $dsParamURL = 'http://twitter.com/statuses/user_timeline/fazalkhan.xml?count=1';
		public $dsParamXPATH = '/';
		public $dsParamCACHE = '30';
		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}
		
		public function about(){
			return array(
					 'name' => 'Twitter',
					 'author' => array(
							'name' => 'Fazal Khan',
							'website' => 'http://fazalkhan.local.co.uk',
							'email' => 'faz888@gmail.com'),
					 'version' => '1.0',
					 'release-date' => '2009-09-02T12:10:00+00:00');	
		}
		
		public function getSource(){
			return 'dynamic_xml';
		}
		
		public function allowEditorToParse(){
			return true;
		}
		
		public function grab(&$param_pool){
			$result = new XMLElement($this->dsParamROOTELEMENT);
				
			try{
				include(TOOLKIT . '/data-sources/datasource.dynamic_xml.php');
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}	

			if($this->_force_empty_result) $result = $this->emptyXMLSet();
			return $result;
		}
	}

