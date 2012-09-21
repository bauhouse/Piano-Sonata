<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourceabout_me extends SectionDatasource{

		public $dsParamROOTELEMENT = 'about-me';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '1';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'yes';
		

		

		public $dsParamINCLUDEDELEMENTS = array(
				'my-photo',
				'about-me-snippet: formatted',
				'about-me: formatted',
				'external-links: title',
				'external-links: link'
		);
		

		public function __construct($env=NULL, $process_params=true){
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'About me',
				'author' => array(
					'name' => 'Stephen Bau',
					'website' => 'http://home/sym/ensembles/piano-sonata-2.3',
					'email' => 'bauhouse@gmail.com'),
				'version' => 'Symphony 2.3',
				'release-date' => '2012-09-18T13:58:19+00:00'
			);
		}

		public function getSource(){
			return '8';
		}

		public function allowEditorToParse(){
			return true;
		}

	}
