<?php

	if(!defined('__IN_SYMPHONY__')) die('<h2>Symphony Error</h2><p>You cannot directly access this file</p>');
	
	Class fieldMediathek extends Field {
	
		/**
		 * Initialize Mediathek as unrequired field
		 */

		function __construct(&$parent) {
			parent::__construct($parent);
			$this->_name = __('Mediathek');
			$this->_required = false;
		}
		
		/**
		 * Allow data source filtering
		 */
		
		function canFilter(){
			return true;
		}		
		
		/**
		 * Allow data source parameter output
		 */
		
		function allowDatasourceParamOutput(){
			return true;
		}	

		/**
		 * Displays setting panel in section editor. Possible settings:
		 *   name: the name of the created field
		 *   placement: position of the field (main content or sidebar)
		 *   related section: list of all sections besides the current one
		 *   filter: list of tags or categories to filter backend output with (supports inclusion and exclusion syntax)
		 *   caption: allows custom titles for Mediathek items
		 *   included_fields: allows field selection for data source output
		 *   multiple options: allow selection of multiple options
		 * 
		 * @param XMLElement $wrapper - parent element wrapping the field
		 * @param array $errors - array with field errors, $errors['name-of-field-element']
		 */
						
		function displaySettingsPanel(&$wrapper, $errors=NULL) {
		
			// initialize field settings based on class defaults (name, placement)
			parent::displaySettingsPanel($wrapper, $errors);
			$this->appendShowColumnCheckbox($wrapper);
			
			// get current section id
			$section_id = Administration::instance()->Page->_context[1];

			// related section
			$label = Widget::Label(__('Related section'));
			$sectionManager = new SectionManager($this->_engine);
		  	$sections = $sectionManager->fetch(NULL, 'ASC', 'name');
			$options = array(
				array('', false, __('None Selected')),
			);
			if(is_array($sections) && !empty($sections)) {
				foreach($sections as $section) {
					if($section->get('id') != $section_id) {
						$options[] = array($section->get('id'), ($section->get('id') == $this->get('related_section_id')), $section->get('name'));
					}
				}
			}
			$label->appendChild(Widget::Select('fields['.$this->get('sortorder').'][related_section_id]', $options, array('class' => 'mediathek')));
			if(isset($errors['related_section_id'])) {
				$wrapper->appendChild(Widget::wrapFormElementWithError($label, $errors['related_section_id']));
			}
			else { 
				$wrapper->appendChild($label);			
			}
			
			// multiple options
			$label = Widget::Label();
			$input = Widget::Input('fields['.$this->get('sortorder').'][allow_multiple_selection]', 'yes', 'checkbox');
			if($this->get('allow_multiple_selection') != 'no') {
				$input->setAttribute('checked', 'checked');	
			}		
			$label->setValue(__('%s Allow selection of multiple options', array($input->generate())));
			$wrapper->appendChild($label);
					
			// filter input
			$label = new XMLElement('label', __('Filter items by tags or categories') . '<i>' . __('Comma separated, click alt for negation') . '</i>', array('class' => 'filter', 'style' => 'display: none;'));
			$label->appendChild(Widget::Input('fields['.$this->get('sortorder').'][filter_tags]', $this->get('filter_tags')));
			$wrapper->appendChild($label);
			
			// filter suggestions
			if(is_array($sections) && !empty($sections)) {
				foreach($sections as $section) {
					$values = array();
					$fields = $section->fetchFields();
					foreach($fields as $field) {
						if($field->get('type') == 'taglist' || $field->get('type') == 'select' ) {					
							// fetch dynamic filter values
							$entries = $this->Database->fetch(	
								"SELECT DISTINCT `value` FROM `tbl_entries_data_" . $field->get('id') . "` LIMIT 100"		
							);
							foreach($entries as $entry) {
								$values[] = $entry['value'];
							}
							// get static values
							$static = explode(', ', $field->get('static_options'));
							// combine dynamic and static values
							$values = array_unique(array_merge($values, $static));
							natcasesort($values);
						}
					}
					if(!empty($values)) {
						$filter = new XMLElement('ul', NULL, array('class' => 'tags mediathek negation section' . $section->get('id'), 'style' => 'display: none;'));
						foreach($values as $value) {
							if(!empty($value)) {
								$filter->appendChild(new XMLElement('li', trim($value)));
							}
						}
						$wrapper->appendChild($filter);					
					}
				}
			}
			
			// caption input
			$label = new XMLElement('label', __('Custom item caption') . '<i>' . __('Use <code>{$param}</code> syntax, inline HTML elements allowed') . '</i>');
			$label->appendChild(Widget::Input('fields['.$this->get('sortorder').'][caption]', htmlspecialchars($this->get('caption'))));
			if(isset($errors['caption'])) {
				$wrapper->appendChild(Widget::wrapFormElementWithError($label, $errors['caption']));
			}
			else { 
				$wrapper->appendChild($label);			
			}
			
			// caption suggestions
			if(is_array($sections) && !empty($sections)) {
				foreach($sections as $section) {
					$values = array();
					$fields = $section->fetchFields();
					foreach($fields as $field) {
						$values[] = '{$' . $field->get('element_name') . '}';
					}
					if(!empty($values)) {
						$filter = new XMLElement('ul', NULL, array('class' => 'tags mediathek inline section' . $section->get('id'), 'style' => 'display: none;'));
						foreach($values as $value) {
							if(!empty($value)) {
								$filter->appendChild(new XMLElement('li', trim($value)));
							}
						}
						$wrapper->appendChild($filter);					
					}
				}
			}					
			
			// data source filter for related section
			$label = new XMLElement('label', __('Included elements') . '<i>' . __('Will be used for data source output') . '</i>');
			$field_groups = array();
			if(is_array($sections) && !empty($sections)) {
				foreach($sections as $section) {
					$field_groups[$section->get('id')] = array('fields' => $section->fetchFields(), 'section' => $section);
				}
			}
			$options = array();		
			foreach($field_groups as $group) {
				if(!is_array($group['fields'])) continue;
				$fields = array();
				foreach($group['fields'] as $field){
					if($field->get('id') != $this->get('id')) {
						$fields[] = array($field->get('id'), (in_array($field->get('id'), explode(',', $this->get('included_fields')))), $field->get('label'));
					}
				}
				if(is_array($fields) && !empty($fields)) {
					$options[] = array('label' => $group['section']->get('id'), 'options' => $fields);
				}
			}
			$label->appendChild(Widget::Select('fields['.$this->get('sortorder').'][included_fields][]', $options, array('multiple' => 'multiple', 'class' => 'datasource')));
			$wrapper->appendChild($label);
						
		}

		/**
		 * Checks fields for errors in section editor.
		 * 
		 * @param array $errors
		 * @param boolean $checkForDuplicates
		 */
		
		function checkFields(&$errors, $checkForDuplicates=true) {
		
			if(!is_array($errors)) $errors = array();
			
			// check if a related section has been selected
			if($this->get('related_section_id') == '') {
				$errors['related_section_id'] = __('This is a required field.');
			}
			
			// check if caption content is well formed
			if($this->get('caption')) {
				$validate = simplexml_load_string('<li>' . $this->get('caption') . '</li>');
				if(!$validate) {
					$errors['caption'] = __('Caption has to be well-formed. Please check opening and closing tags.');
				}
			}
			
			parent::checkFields($errors, $checkForDuplicates);
			
		}

		/**
		 * Save fields settings in section editor.
		 */
		
		function commit() {
			
			// prepare commit
			if(!parent::commit()) return false;
			$id = $this->get('id');			
			if($id === false) return false;
			
			// set up fields
			$fields = array();
			$fields['field_id'] = $id;		
			$fields['related_section_id'] = $this->get('related_section_id');	
			$fields['allow_multiple_selection'] = ($this->get('allow_multiple_selection') ? $this->get('allow_multiple_selection') : 'no');

			// clean up filter values
			if($this->get('filter_tags') != '') {
				$tags = explode(",", $this->get('filter_tags'));
				foreach($tags as &$tag) {
					$tag = trim($this->cleanValue($tag));
					$list[] = $tag;
				}
				$fields['filter_tags'] = implode(', ', $list);
			}

			// item caption
			$fields['caption'] = $this->get('caption');

			// data source fields
			$fields['included_fields'] = (is_null($this->get('included_fields')) ? NULL : implode(',', $this->get('included_fields')));
								
			// delete old field settings
			Administration::instance()->Database->query(
				"DELETE FROM `tbl_fields_".$this->handle()."` WHERE `field_id` = '$id' LIMIT 1"
			);
			
			// save new field setting 
			return Administration::instance()->Database->insert($fields, 'tbl_fields_' . $this->handle());
								
		}

		/**
		 * Displays publish panel in content area.
		 * 
		 * @param XMLElement $wrapper
		 * @param $data
		 * @param $flagWithError
		 * @param $fieldnamePrefix
		 * @param $fieldnamePostfix
		 */
		
		function displayPublishPanel(&$wrapper, $data=NULL, $flagWithError=NULL, $fieldnamePrefix=NULL, $fieldnamePostfix=NULL) {
		
			$this->_engine->Page->addScriptToHead(URL . '/extensions/mediathek/assets/jquery-ui.js', 100, false);
			$this->_engine->Page->addScriptToHead(URL . '/extensions/mediathek/assets/mediathek.js', 101, false);
			$this->_engine->Page->addScriptToHead(URL . '/extensions/mediathek/assets/quicksilver.js', 102, false);
			$this->_engine->Page->addStylesheetToHead(URL . '/extensions/mediathek/assets/mediathek.css', 'screen', 103, false);	

			// prepare select options
			$options = array();
			if($this->get('allow_multiple_selection') == 'no') {
				$options[] = array(-1, false, __('None Selected'));
			}
			if(!is_array($data['relation_id'])) {
				$data['relation_id'] = array($data['relation_id']);
			}		
			
			// fetch field data
			$sectionManager = new SectionManager($this->_engine);
		  	$section = $sectionManager->fetch($this->get('related_section_id'), 'ASC', 'name');
		  	$fields = $section->fetchFields();
		  	
		  	// fetch taglist, select and upload fields
		  	$tag_fields = array();
			foreach($fields as $field) {
				if(in_array($field->get('type'), array('taglist', 'select'))) {
					$tag_fields[] = $field->get('id');
				}
			}
		  	
			// fetch entry data 	
			$entryManager = new EntryManager($this->_engine);
			$entries = $entryManager->fetch(NULL, $this->get('related_section_id'));
			
			// setup filter
			$gogoes = array();
			$nonos = array();
			$filters = array();
			if($this->get('filter_tags') != '') {
				$filters = explode(', ', $this->get('filter_tags'));
			}
			foreach($filters as $filter) {
				$operator = substr($filter, 0, 1);
				if($operator == '-') {
					$nonos[] = substr($filter, 1);
				}
				else {
					$gogoes[] = $filter;
				}
			}

			// filter entries and add select options 
			foreach($entries as $entry) {			
				$entry_data = $entry->getData();
				
				// collect taglist and select field values
				$tags = array();
				foreach($tag_fields as $field_id) {
					$tag_values = $entry_data[$field_id]['value'];
					if(!is_array($tag_values)) {
						$tag_values = array($tag_values);
					}
					$tags = array_merge($tags, $tag_values);
				}
			
				// investigate entry exclusion
				$filter_nonos = array_intersect($tags, $nonos);
				
				// investigate entry inclusion
				$filter_gogoes = array_intersect($tags, $gogoes);
				
				// filter entries
				if(empty($filter_nonos) && (!empty($filter_gogoes) || empty($gogoes)) ) {
					// fetch primary field
					$field_data = $entry_data[$fields[0]->get('id')]['value'];
					// fetch field value (string)
					if(!empty($field_data)) {
						if(is_array($field_data)) {
							$field_value = implode(', ', $field_data);				
						}
						else {
							$field_value = $field_data;				
						} 
					}
					else {
						$field_value = __('Untitled');
					}
					// populate select options
					$options[] = array($entry->get('id'), in_array($entry->get('id'), $data['relation_id']), $field_value);
				}

			}
				
			// setup field name
			$fieldname = 'fields' . $fieldnamePrefix . '['. $this->get('element_name') . ']' . $fieldnamePostfix . '[]';		
			
			// setup select
			$label = Widget::Label($this->get('label'), $links);
			$select = Widget::Select($fieldname, $options, ($this->get('allow_multiple_selection') == 'yes' ? array('multiple' => 'multiple') : NULL));	
			$label->appendChild($select);
			
			// setup sorting
			$currentPageURL = Administration::instance()->getCurrentPageURL();
			preg_match_all('/\d+/', $currentPageURL, $entry_id, PREG_PATTERN_ORDER);
			$entry_id = $entry_id[0][count($entry_id[0])-1];
			$order = Administration::instance()->Database->fetchVar('order', 0,
				"SELECT `order` 
				FROM `tbl_fields_mediathek_sorting` 
				WHERE `entry_id` = " . $entry_id . "
				LIMIT 1"
			);
			$input = Widget::Input('fields[sort_order][' . $entry_id . ']', $order, 'hidden');
			$label->appendChild($input);
			
			// setup relation id
			$input = Widget::Input('fields[related_section_id][' . $this->get('id') . ']', $this->get('related_section_id'), 'hidden');
			$label->appendChild($input);
			
			// setup iframe src
			$input = Widget::Input('fields[create_new][' . $this->get('id') . ']', URL . '/symphony/publish/' . $section->_data['handle'] . '/new/', 'hidden');
			$label->appendChild($input);
			
			// error handling
			if($flagWithError != NULL) {
				$wrapper->appendChild(Widget::wrapFormElementWithError($label, $flagWithError));
			}
			else {
				$wrapper->appendChild($label);
			}		
		
		}
		
 		/**
		 * Prepares field values for database.
		 */
		
		function processRawFieldData($data, &$status, $simulate=false, $entry_id=NULL){
		
			$status = self::__OK__;
			if(!is_array($data)) return array('relation_id' => $data);
			if(empty($data)) return NULL;
		
			$result = array();

			foreach($data as $a => $value) { 
			  $result['relation_id'][] = $data[$a];
			}
	
			return $result;

		}
		
 		/**
		 * Creates database field table.
		 */
		
		function createTable(){
				
			return Administration::instance()->Database->query(
				"CREATE TABLE IF NOT EXISTS `tbl_entries_data_" . $this->get('id') . "` (
				`id` int(11) unsigned NOT NULL auto_increment,
				`entry_id` int(11) unsigned NOT NULL,
				`relation_id` int(11) unsigned NOT NULL,
				PRIMARY KEY (`id`),
				KEY `entry_id` (`entry_id`),
				KEY `relation_id` (`relation_id`)
				) TYPE=MyISAM;"
			);
			
		}	
		
 		/**
		 * Prepare value for the content overview table.
		 *
		 * @param array $data
		 * @param XMLElement $link
		 */

		function prepareTableValue($data, XMLElement $link=NULL){
		
			if(empty($data['relation_id'])) return NULL;
			$count = count($data['relation_id']);
			return parent::prepareTableValue(array('value' => ($count > 1) ? $count . ' ' . __('items') : $count . ' ' . __('item')), $link);

		}
		
 		/**
		 * Generate data source output.
		 *
		 * @param XMLElement $wrapper
		 * @param array $data
		 * @param boolean $encode
		 * @param string $mode
		 */
			
		public function appendFormattedElement(&$wrapper, $data, $encode = false) {

			// create Mediathek element
			$mediathek = new XMLElement($this->get('element_name'));
			
			// check for included fields
			if($this->get('included_fields') == '') {
				$error = new XMLElement('error', 'No fields for output defined.');
				$mediathek->appendChild($error);
				$wrapper->appendChild($mediathek);
				return;
			}

			// fetch field data
			$entryManager = new EntryManager($this->_engine);
			$entries = $entryManager->fetch($data['relation_id'], $this->get('related_section_id'));

			// sort entries
			$order = $this->_Parent->_Parent->Database->fetchVar('order', 0,
				"SELECT `order` 
				FROM `tbl_fields_mediathek_sorting` 
				WHERE `entry_id` = " . $wrapper->getAttribute('id') . "
				LIMIT 1"
			);		
			$sorted_ids = explode(',', $order);
			$sorted_entries = array();
			if(!empty($sorted_ids) && $sorted_ids[0] != 0) {
				foreach($sorted_ids as $id) {
					foreach($entries as $entry) {
						if($entry->get('id') == $id) {
							$sorted_entries[] = $entry;
						}
					}
				}
			}
			else {
				$sorted_entries = $entries;
			}
	
			// build XML			
			$count = 1;
			foreach($sorted_entries as $entry) {
				// fetch entry data
				$entry_data = $entry->getData();
			
				// create entry element
				$item = new XMLElement('item');
				// populate entry element
				$included_fields = explode(',', $this->get('included_fields'));
				foreach ($entry_data as $field_id => $values) {
					// only append if field is listed or if list empty
					if(in_array($field_id, $included_fields) || empty($included_fields[0])) {
						$field =& $entryManager->fieldManager->fetch($field_id);
						$field->appendFormattedElement($item, $values, false);
					}
				}
				// append entry element
				$mediathek->appendChild($item);
				$mediathek->setAttribute('items', $count);
				$count++;
			}
			
			// append Mediathek to data source
			$wrapper->appendChild($mediathek);
			
		}
		
 		/**
		 * Generate parameter pool values.
		 *
		 * @param array $data
		 */
		
		public function getParameterPoolValue($data) {
		
			if(is_array($data['relation_id'])) return implode(", ", $data['relation_id']);
			return $data['relation_id'];
			
		}
		
 		/**
		 * Generate data source filter panel.
		 *
		 * @param XMLElement $wrapper
		 * @param array $data
		 * @param $errors
		 * @param $fieldnamePrefix
		 * @param $fieldnamePostfix
		 */

		function displayDatasourceFilterPanel(&$wrapper, $data=NULL, $errors=NULL, $fieldnamePrefix=NULL, $fieldnamePostfix=NULL) {
			
			parent::displayDatasourceFilterPanel($wrapper, $data, $errors, $fieldnamePrefix, $fieldnamePostfix);
			$text = new XMLElement('p', __('Use comma separated entry ids for filtering.'), array('class' => 'help') );
			$wrapper->appendChild($text);
			
		}
		
 		/**
		 * Returns sample markup for the event editor.
		 */
		
		public function getExampleFormMarkup(){
			// nothing to show here yet
			return Widget::Select('fields['.$this->get('element_name').']', array(array('...')));
		}

	}
	