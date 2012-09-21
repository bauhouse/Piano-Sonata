<?php
	$settings = array(


		###### ADMIN ######
		'admin' => array(
			'max_upload_size' => '5242880',
		),
		########


		###### SYMPHONY ######
		'symphony' => array(
			'pagination_maximum_rows' => '20',
			'lang' => 'en',
			'version' => '2.3',
			'pages_table_nest_children' => 'yes',
			'cookie_prefix' => 'sym-',
			'session_gc_divisor' => '10',
		),
		########


		###### LOG ######
		'log' => array(
			'archive' => '1',
			'maxsize' => '102400',
		),
		########


		###### GENERAL ######
		'general' => array(
			'sitename' => 'Piano Sonata',
			'useragent' => 'Symphony/2.3',
		),
		########


		###### IMAGE ######
		'image' => array(
			'cache' => '1',
			'quality' => '90',
		),
		########


		###### DATABASE ######
		'database' => array(
			'query_caching' => 'default',
			'host' => 'localhost',
			'port' => '3306',
			'user' => null,
			'password' => null,
			'db' => null,
			'tbl_prefix' => 'sym_',
		),
		########


		###### PUBLIC ######
		'public' => array(
			'display_event_xml_in_source' => 'yes',
		),
		########


		###### REGION ######
		'region' => array(
			'time_format' => 'g:i a',
			'date_format' => 'd F Y',
			'timezone' => 'America/Vancouver',
			'datetime_separator' => ' ',
		),
		########


		###### MAINTENANCE_MODE ######
		'maintenance_mode' => array(
			'enabled' => 'no',
		),
		########


		###### FILE ######
		'file' => array(
			'write_mode' => '0775',
		),
		########


		###### DIRECTORY ######
		'directory' => array(
			'write_mode' => '0775',
		),
		########


		###### SORTING ######
		'sorting' => array(
			'section_articles_sortby' => '26',
			'section_articles_order' => 'asc',
			'section_categories_sortby' => null,
			'section_categories_order' => 'asc',
			'section_about_sortby' => null,
			'section_about_order' => 'asc',
			'section_comments_sortby' => null,
			'section_comments_order' => 'asc',
			'section_images_sortby' => null,
			'section_images_order' => 'asc',
			'section_messages_sortby' => null,
			'section_messages_order' => 'asc',
			'section_elsewhere_sortby' => null,
			'section_elsewhere_order' => 'asc',
		),
		########
	);
