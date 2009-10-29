<?php
 
	require_once(TOOLKIT . '/class.administrationpage.php');
	require_once(TOOLKIT . '/class.sectionmanager.php');
	require_once(TOOLKIT . '/class.entrymanager.php');
 
	class contentExtensionMediathekCaption extends AdministrationPage {
 
		public function __construct(&$parent){
			parent::__construct($parent);
		}

 		/**
		 * Builds captions based on $_POST values.
		 *
		 * @return json object - { id: caption }
		 */
		
		public function __viewIndex() {
			$related_section_id = intval($_POST['related_section_id']);
			$field_id = intval($_POST['field_id']);
			$items = explode(',', $_POST['items']);
			$id = array();
			foreach($items as $item) {
				array_push($id, intval($item));
			}
			
			// fetch field data
			$sectionManager = new SectionManager($this->_Parent);
		  	$section = $sectionManager->fetch($related_section_id, 'ASC', 'name');
		  	$fields = $section->fetchFields();

			// fetch entry data 	
			$entryManager = new EntryManager($this->_Parent);
			$entries = $entryManager->fetch($id, $related_section_id);
		  	
			// create formated captions
			$result = array();
			$template = Administration::instance()->Database->fetch(
				"SELECT `caption` 
				FROM `tbl_fields_mediathek` 
				WHERE `related_section_id` = " . $related_section_id . " 
				AND `field_id`= " . $field_id . " 
				LIMIT 0 , 1"
			);
			$template = $template[0]['caption'];
			if(empty($template)) $template = '{$' . $fields[0]->get('element_name') . '}';
			
			foreach($entries as $entry) {
				$caption = $template;
				$file = '';
				$entry_data = $entry->getData();
				foreach($fields as $field) {
					$field_name = $field->get('element_name');
					$field_id = $field->get('id');
					$field_data = $entry_data[$field_id]['value'];
					if(is_array($field_data)) {
						$field_value = implode(', ', $field_data);				
					}
					elseif(empty($field_data) && $entry_data[$field_id]['file']) {
						$field_value = $entry_data[$field_id]['file'];
					}
					else {
						$field_value = $field_data;				
					}
					$caption = str_replace('{$' . $field_name . '}', $field_value, $caption);
					// get file
					if(strpos($field->get('type'), 'upload') !== false && !empty($entry_data[$field->get('id')]['file'])) {
						$file = $this->buildAttachment($entry_data[$field->get('id')]['file']);
					}
				}
				$result[$entry->_fields['id']] = '<span>' . $caption . '</span>' . $file;
			}
 
 			if(empty($result)) exit;
			echo json_encode($result);
			exit;
			
		}

 		/**
		 * Builds attachement element.
		 *
		 * @param string $file - path relative to the workspace folder
		 */
		
		function buildAttachment($file) {
			$href = URL . '/workspace' . $file;
			$class = 'file';
			$ext = substr($file, -4);
			$jit = $width = $height = '0';
			if(in_array($ext, array('.png', '.jpg', 'jpeg', '.gif'))) {
				$size = getimagesize($href);
				$width = $size[0];
				if(empty($width)) $width = '0';
				$height = $size[1];
				if(empty($height)) $height = '0';
				$class = 'image';
				$status = $this->_Parent->Database->fetchVar('status', 0, "SELECT `status` FROM `tbl_extensions` WHERE `name` = 'jit_image_manipulation' LIMIT 1");
				if($status == 'enabled') {
				    $jit = '1';
				}
			}
			return '<a href="' . $href . '" class="' . $class . ' attachment" name="{ width: ' . $width . ', height: ' . $height . ', jit: ' . $jit . '}">' .  __('Attachment') . '</a>';
		}

	}
 
?>