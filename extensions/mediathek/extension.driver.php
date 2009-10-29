<?php

	Class extension_mediathek extends Extension {
	
		/**
		 * Extension information
		 */
		 
		public function about() {
			return array(
				'name' => 'Field: Mediathek',
				'version' => '2.0.1',
				'release-date' => '2009-08-11',
				'author' => array(
					'name' => 'Nils Hörrmann',
					'website' => 'http://www.nilshoerrmann.de',
					'email' => 'post@nilshoerrmann.de'
				)
			);
		}
	
		/**
		 * Add callback functions to backend delegates
		 */

		public function getSubscribedDelegates(){
			return array(
				array(
					'page' => '/administration/',
					'delegate' => 'AdminPagePreGenerate',
					'callback' => '__appendAssets'
				),
				array(
					'page' => '/publish/new/',
					'delegate' => 'EntryPostNew',
					'callback' => '__saveSortOrder'
				),
				array(
					'page' => '/publish/edit/',
					'delegate' => 'EntryPostEdit',
					'callback' => '__saveSortOrder'
				),
				array(
					'page' => '/publish/',
					'delegate' => 'Delete',
					'callback' => '__deleteSortOrder'
				)
			);
		}
	
		/**
		 * Append assets to the page head
		 *
		 * @param object $context 
		 */

		public function __appendAssets($context) {
			$callback = Administration::instance()->getPageCallback();

			// Append javascript for field settings pane
			if ($callback['driver'] == 'blueprintssections' && is_array($callback['context'])){
				Administration::instance()->Page->addScriptToHead(URL . '/extensions/mediathek/assets/section.js', 100, false);
			}

			// Append styles and javascript for mediasection display
			if ($callback['driver'] == 'publish' && ($callback['context']['page'] == 'edit' || $callback['context']['page'] == 'new')){
					Administration::instance()->Page->addScriptToHead(URL . '/extensions/mediathek/assets/mediasection.js', 100, false);
					Administration::instance()->Page->addStylesheetToHead(URL . '/extensions/mediathek/assets/mediasection.css', 'screen', 101, false);
			}
		}

		/**
		 * Saves sort order of the field
		 *
		 * @param object $context 
		 */

		public function __saveSortOrder($context) {
			foreach($context['fields']['sort_order'] as $id => $value) {
				$entries = explode(',', $value);
				$order = array();
				foreach($entries as $entry) {
					$order[] = intval($entry);
				}
				// delete current sort order
				Administration::instance()->Database->query(
					"DELETE FROM `tbl_fields_mediathek_sorting` WHERE `entry_id` = '$id' LIMIT 1"
				);
				// add new sort order
				Administration::instance()->Database->query(
					"INSERT INTO `tbl_fields_mediathek_sorting` (`entry_id`, `order`) 
					VALUES ('$id', '" . implode(',', $order) . "')"
				);
			}
		}
			
		/**
		 * Delete sort order of the field
		 *
		 * @param object $context 
		 */

		public function __deleteSortOrder($context) {
			// DELEGATE NOT WORKING:
			// http://github.com/symphony/symphony-2/issues#issue/108
		}
	
		/**
		 * Function to be executed on uninstallation
		 */
	
		public function uninstall() {
			// drop database table
			Administration::instance()->Database->query("DROP TABLE `tbl_fields_mediathek`");
			Administration::instance()->Database->query("DROP TABLE `tbl_fields_mediathek_sorting`");
		}
	
		/**
		 * Function to be executed if the extension has been updated
		 *
		 * @param string $previousVersion - version number of the currently installed extension build
		 * @return boolean - true on success, false otherwise
		 */
		
		public function update($previousVersion) {
			if(version_compare($previousVersion, '1.1', '<')){
				$updated = Administration::instance()->Database->query(
					"ALTER TABLE `tbl_fields_mediathek` 
					ADD `allow_multiple_selection` enum('yes','no') NOT NULL default 'yes', 
					ADD `filter_tags` text"
				);
				if(!$updated) return false;
			}
			if(version_compare($previousVersion, '2.0', '<')) {
				$updated = Administration::instance()->Database->query(
					"ALTER TABLE `tbl_fields_mediathek` 
					ADD `caption` text, 
					ADD `included_fields` text, 
					DROP `related_field_id`, 
					DROP `related_title_id`, 
					DROP `show_count`"
				);
				if(!$updated) return false;
				$updated = Administration::instance()->Database->query(
					"CREATE TABLE `tbl_fields_mediathek_sorting` (
						`entry_id` int(11) unsigned NOT NULL,
						`order` text,
						PRIMARY KEY (`entry_id`)
					);"
				);
				if(!$updated) return false;
			}
			return true;
		}
	
		/**
		 * Function to be executed on installation.
		 *
		 * @return boolean - true on success, false otherwise
		 */
	
		public function install() {
			// Create database table and fields.
			$fields = Administration::instance()->Database->query(
				"CREATE TABLE `tbl_fields_mediathek` (
					`id` int(11) unsigned NOT NULL auto_increment,
					`field_id` int(11) unsigned NOT NULL,
					`related_section_id` VARCHAR(255) NOT NULL,
					`filter_tags` text,
					`caption` text, 
					`included_fields` text, 
					`allow_multiple_selection` enum('yes','no') NOT NULL default 'yes',
        	  		PRIMARY KEY  (`id`),
			  		KEY `field_id` (`field_id`)
				)"
			);
			$sorting = Administration::instance()->Database->query(
				"CREATE TABLE `tbl_fields_mediathek_sorting` (
					`entry_id` int(11) unsigned NOT NULL,
					`order` text,
					PRIMARY KEY (`entry_id`)
				)"
			);
			if($fields && $sorting) return true;
			else return false;
		}
		
	}
