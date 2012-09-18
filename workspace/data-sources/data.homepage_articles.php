<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcehomepage_articles extends SectionDatasource{

		public $dsParamROOTELEMENT = 'homepage-articles';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '3';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamPARAMOUTPUT = array(
				'system:id'
		);
		public $dsParamSORT = 'date';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'yes';
		

		public $dsParamFILTERS = array(
				'5' => 'yes',
		);
		

		public $dsParamINCLUDEDELEMENTS = array(
				'title',
				'body: formatted',
				'date',
				'manage-images',
				'article-images: image',
				'article-images: description',
				'categories',
				'tags'
		);
		

		public function __construct($env=NULL, $process_params=true){
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Homepage Articles',
				'author' => array(
					'name' => 'Stephen Bau',
					'website' => 'http://home/sym/ensembles/piano-sonata-2.3',
					'email' => 'bauhouse@gmail.com'),
				'version' => 'Symphony 2.3',
				'release-date' => '2012-09-18T13:49:29+00:00'
			);
		}

		public function getSource(){
			return '1';
		}

		public function allowEditorToParse(){
			return true;
		}

	}
