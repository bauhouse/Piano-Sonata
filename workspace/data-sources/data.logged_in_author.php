<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcelogged_in_author extends AuthorDatasource{

		public $dsParamROOTELEMENT = 'logged-in-author';
		public $dsParamORDER = 'desc';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'id';
		

		public $dsParamFILTERS = array(
				'username' => '{$cookie-username:0}',
		);
		

		public $dsParamINCLUDEDELEMENTS = array(
				'username'
		);
		

		public function __construct($env=NULL, $process_params=true){
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Logged in Author',
				'author' => array(
					'name' => 'Stephen Bau',
					'website' => 'http://home/sym/ensembles/piano-sonata-2.3',
					'email' => 'bauhouse@gmail.com'),
				'version' => 'Symphony 2.3',
				'release-date' => '2012-09-16T07:17:05+00:00'
			);
		}

		public function getSource(){
			return 'authors';
		}

		public function allowEditorToParse(){
			return true;
		}

	}
