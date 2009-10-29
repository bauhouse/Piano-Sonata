
-- *** STRUCTURE: `tbl_fields_author` ***
DROP TABLE IF EXISTS `tbl_fields_author`;
CREATE TABLE `tbl_fields_author` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `allow_author_change` enum('yes','no') collate utf8_unicode_ci NOT NULL,
  `allow_multiple_selection` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  `default_to_current_user` enum('yes','no') collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_fields_author` ***

-- *** STRUCTURE: `tbl_fields_checkbox` ***
DROP TABLE IF EXISTS `tbl_fields_checkbox`;
CREATE TABLE `tbl_fields_checkbox` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `default_state` enum('on','off') collate utf8_unicode_ci NOT NULL default 'on',
  `description` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_fields_checkbox` ***
INSERT INTO `tbl_fields_checkbox` (`id`, `field_id`, `default_state`, `description`) VALUES (30, 5, 'off', 'Publish this article');
INSERT INTO `tbl_fields_checkbox` (`id`, `field_id`, `default_state`, `description`) VALUES (31, 43, 'on', 'Let Symphony format my images');

-- *** STRUCTURE: `tbl_fields_date` ***
DROP TABLE IF EXISTS `tbl_fields_date`;
CREATE TABLE `tbl_fields_date` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `pre_populate` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  `calendar` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_fields_date` ***
INSERT INTO `tbl_fields_date` (`id`, `field_id`, `pre_populate`, `calendar`) VALUES (27, 29, 'yes', 'no');
INSERT INTO `tbl_fields_date` (`id`, `field_id`, `pre_populate`, `calendar`) VALUES (3, 13, 'yes', 'no');

-- *** STRUCTURE: `tbl_fields_input` ***
DROP TABLE IF EXISTS `tbl_fields_input`;
CREATE TABLE `tbl_fields_input` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `validator` varchar(100) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_fields_input` ***
INSERT INTO `tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (42, 1, NULL);
INSERT INTO `tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (2, 6, NULL);
INSERT INTO `tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (3, 10, NULL);
INSERT INTO `tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (4, 11, '/^\\w(?:\\.?[\\w%+-]+)*@\\w(?:[\\w-]*\\.)+?[a-z]{2,}$/i');
INSERT INTO `tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (5, 12, '/^[^\\s:\\/?#]+:(?:\\/{2,3})?[^\\s.\\/?#]+(?:\\.[^\\s.\\/?#]+)*(?:\\/[^\\s?#]*\\??[^\\s?#]*(#[^\\s#]*)?)?$/');
INSERT INTO `tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (6, 19, NULL);
INSERT INTO `tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (7, 20, '/^\\w(?:\\.?[\\w%+-]+)*@\\w(?:[\\w-]*\\.)+?[a-z]{2,}$/i');
INSERT INTO `tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (8, 21, NULL);
INSERT INTO `tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (30, 35, NULL);
INSERT INTO `tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (31, 36, '/^[^\\s:\\/?#]+:(?:\\/{2,3})?[^\\s.\\/?#]+(?:\\.[^\\s.\\/?#]+)*(?:\\/[^\\s?#]*\\??[^\\s?#]*(#[^\\s#]*)?)?$/');

-- *** STRUCTURE: `tbl_fields_mediathek` ***
DROP TABLE IF EXISTS `tbl_fields_mediathek`;
CREATE TABLE `tbl_fields_mediathek` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `related_section_id` varchar(255) NOT NULL,
  `filter_tags` text,
  `caption` text,
  `included_fields` text,
  `allow_multiple_selection` enum('yes','no') NOT NULL default 'yes',
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_fields_mediathek` ***
INSERT INTO `tbl_fields_mediathek` (`id`, `field_id`, `related_section_id`, `filter_tags`, `caption`, `included_fields`, `allow_multiple_selection`) VALUES (7, 42, 5, NULL, '{$description}', '32,18', 'yes');

-- *** STRUCTURE: `tbl_fields_mediathek_sorting` ***
DROP TABLE IF EXISTS `tbl_fields_mediathek_sorting`;
CREATE TABLE `tbl_fields_mediathek_sorting` (
  `entry_id` int(11) unsigned NOT NULL,
  `order` text,
  PRIMARY KEY  (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_fields_mediathek_sorting` ***
INSERT INTO `tbl_fields_mediathek_sorting` (`entry_id`, `order`) VALUES (7, 28);
INSERT INTO `tbl_fields_mediathek_sorting` (`entry_id`, `order`) VALUES (25, 27);

-- *** STRUCTURE: `tbl_fields_select` ***
DROP TABLE IF EXISTS `tbl_fields_select`;
CREATE TABLE `tbl_fields_select` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `allow_multiple_selection` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  `static_options` text collate utf8_unicode_ci,
  `dynamic_options` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_fields_select` ***

-- *** STRUCTURE: `tbl_fields_selectbox_link` ***
DROP TABLE IF EXISTS `tbl_fields_selectbox_link`;
CREATE TABLE `tbl_fields_selectbox_link` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `allow_multiple_selection` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  `related_field_id` varchar(255) collate utf8_unicode_ci NOT NULL,
  `limit` int(4) unsigned NOT NULL default '20',
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_fields_selectbox_link` ***
INSERT INTO `tbl_fields_selectbox_link` (`id`, `field_id`, `allow_multiple_selection`, `related_field_id`, `limit`) VALUES (1, 14, 'no', 1, 20);
INSERT INTO `tbl_fields_selectbox_link` (`id`, `field_id`, `allow_multiple_selection`, `related_field_id`, `limit`) VALUES (45, 4, 'yes', 6, 20);

-- *** STRUCTURE: `tbl_fields_static_section` ***
DROP TABLE IF EXISTS `tbl_fields_static_section`;
CREATE TABLE `tbl_fields_static_section` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `section_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `field_id` (`field_id`),
  UNIQUE KEY `section_id` (`section_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_fields_static_section` ***
INSERT INTO `tbl_fields_static_section` (`id`, `field_id`, `section_id`) VALUES (1, 41, 8);

-- *** STRUCTURE: `tbl_fields_subsection` ***
DROP TABLE IF EXISTS `tbl_fields_subsection`;
CREATE TABLE `tbl_fields_subsection` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `child_section_id` int(11) unsigned default NULL,
  `child_field_id` int(11) unsigned default NULL,
  `allow_multiple` enum('yes','no') default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`),
  KEY `child_section_id` (`child_section_id`),
  KEY `child_field_id` (`child_field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_fields_subsection` ***
INSERT INTO `tbl_fields_subsection` (`id`, `field_id`, `child_section_id`, `child_field_id`, `allow_multiple`) VALUES (9, 38, 9, 37, 'yes');

-- *** STRUCTURE: `tbl_fields_subsectionchild` ***
DROP TABLE IF EXISTS `tbl_fields_subsectionchild`;
CREATE TABLE `tbl_fields_subsectionchild` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `parent_section_id` int(11) unsigned default NULL,
  `parent_field_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`),
  KEY `parent_section_id` (`parent_section_id`),
  KEY `parent_field_id` (`parent_field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_fields_subsectionchild` ***
INSERT INTO `tbl_fields_subsectionchild` (`id`, `field_id`, `parent_section_id`, `parent_field_id`) VALUES (15, 30, 1, 31);
INSERT INTO `tbl_fields_subsectionchild` (`id`, `field_id`, `parent_section_id`, `parent_field_id`) VALUES (14, 37, 8, 38);

-- *** STRUCTURE: `tbl_fields_taglist` ***
DROP TABLE IF EXISTS `tbl_fields_taglist`;
CREATE TABLE `tbl_fields_taglist` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `validator` varchar(100) collate utf8_unicode_ci default NULL,
  `pre_populate_source` varchar(15) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`),
  KEY `pre_populate_source` (`pre_populate_source`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_fields_taglist` ***
INSERT INTO `tbl_fields_taglist` (`id`, `field_id`, `validator`, `pre_populate_source`) VALUES (11, 40, NULL, 'existing');

-- *** STRUCTURE: `tbl_fields_textarea` ***
DROP TABLE IF EXISTS `tbl_fields_textarea`;
CREATE TABLE `tbl_fields_textarea` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `formatter` varchar(100) collate utf8_unicode_ci default NULL,
  `size` int(3) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_fields_textarea` ***
INSERT INTO `tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (49, 2, 'ta_typogrifymarkdown', 20);
INSERT INTO `tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (2, 7, 'pb_markdownextrasmartypants', 5);
INSERT INTO `tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (41, 33, 'ta_typogrifymarkdown', 3);
INSERT INTO `tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (4, 15, 'pb_markdownextrasmartypants', 8);
INSERT INTO `tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (28, 18, NULL, 9);
INSERT INTO `tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (6, 22, NULL, 9);
INSERT INTO `tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (42, 34, 'ta_typogrifymarkdown', 15);

-- *** STRUCTURE: `tbl_fields_uniqueupload` ***
DROP TABLE IF EXISTS `tbl_fields_uniqueupload`;
CREATE TABLE `tbl_fields_uniqueupload` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `destination` varchar(255) NOT NULL,
  `validator` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_fields_uniqueupload` ***
INSERT INTO `tbl_fields_uniqueupload` (`id`, `field_id`, `destination`, `validator`) VALUES (1, 32, '/workspace/uploads', '/\\.(?:bmp|gif|jpe?g|png)$/i');
INSERT INTO `tbl_fields_uniqueupload` (`id`, `field_id`, `destination`, `validator`) VALUES (4, 39, '/workspace/uploads', '/\\.(?:bmp|gif|jpe?g|png)$/i');

-- *** STRUCTURE: `tbl_fields_upload` ***
DROP TABLE IF EXISTS `tbl_fields_upload`;
CREATE TABLE `tbl_fields_upload` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `destination` varchar(255) collate utf8_unicode_ci NOT NULL,
  `validator` varchar(50) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_fields_upload` ***

-- *** STRUCTURE: `tbl_entries_data_1` ***
DROP TABLE IF EXISTS `tbl_entries_data_1`;
CREATE TABLE `tbl_entries_data_1` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) collate utf8_unicode_ci default NULL,
  `value` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_1` ***
INSERT INTO `tbl_entries_data_1` (`id`, `entry_id`, `handle`, `value`) VALUES (36, 7, 'experimental', 'Experimental');
INSERT INTO `tbl_entries_data_1` (`id`, `entry_id`, `handle`, `value`) VALUES (44, 25, 'paris-the-city-of-lights', 'Paris: the city of lights');

-- *** STRUCTURE: `tbl_entries_data_10` ***
DROP TABLE IF EXISTS `tbl_entries_data_10`;
CREATE TABLE `tbl_entries_data_10` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) collate utf8_unicode_ci default NULL,
  `value` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_10` ***
INSERT INTO `tbl_entries_data_10` (`id`, `entry_id`, `handle`, `value`) VALUES (4, 31, 'test', 'test');

-- *** STRUCTURE: `tbl_entries_data_11` ***
DROP TABLE IF EXISTS `tbl_entries_data_11`;
CREATE TABLE `tbl_entries_data_11` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) collate utf8_unicode_ci default NULL,
  `value` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_11` ***
INSERT INTO `tbl_entries_data_11` (`id`, `entry_id`, `handle`, `value`) VALUES (4, 31, 'test-testcom', 'test@test.com');

-- *** STRUCTURE: `tbl_entries_data_12` ***
DROP TABLE IF EXISTS `tbl_entries_data_12`;
CREATE TABLE `tbl_entries_data_12` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) collate utf8_unicode_ci default NULL,
  `value` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_12` ***
INSERT INTO `tbl_entries_data_12` (`id`, `entry_id`, `handle`, `value`) VALUES (4, 31, 'http-wwwairlockcom', 'http://www.airlock.com');

-- *** STRUCTURE: `tbl_entries_data_13` ***
DROP TABLE IF EXISTS `tbl_entries_data_13`;
CREATE TABLE `tbl_entries_data_13` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` varchar(80) collate utf8_unicode_ci default NULL,
  `local` int(11) default NULL,
  `gmt` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_13` ***
INSERT INTO `tbl_entries_data_13` (`id`, `entry_id`, `value`, `local`, `gmt`) VALUES (4, 31, '2009-09-03T14:24:00+01:00', 1251984240, 1251984240);

-- *** STRUCTURE: `tbl_entries_data_14` ***
DROP TABLE IF EXISTS `tbl_entries_data_14`;
CREATE TABLE `tbl_entries_data_14` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `relation_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `relation_id` (`relation_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_14` ***
INSERT INTO `tbl_entries_data_14` (`id`, `entry_id`, `relation_id`) VALUES (4, 31, 25);

-- *** STRUCTURE: `tbl_entries_data_15` ***
DROP TABLE IF EXISTS `tbl_entries_data_15`;
CREATE TABLE `tbl_entries_data_15` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` text collate utf8_unicode_ci,
  `value_formatted` text collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_15` ***
INSERT INTO `tbl_entries_data_15` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (4, 31, 'Morbi interdum mollis sapien. Sed ac risus. Phasellus lacinia, magna a ullamcorper laoreet, lectus arcu pulvinar risus, vitae facilisis libero dolor a purus. Sed vel lacus. Mauris nibh felis, adipiscing varius, adipiscing in, lacinia vel, tellus. Suspendisse ac urna. Etiam pellentesque mauris ut lectus. Nunc tellus ante, mattis eget, gravida vitae, ultricies ac, leo. Integer leo pede, ornare a, lacinia eu, vulputate vel, nisl.\r\n\r\nSuspendisse mauris. Fusce accumsan mollis eros. Pellentesque a diam sit amet mi ullamcorper vehicula. Integer adipiscing risus a sem. Nullam quis massa sit amet nibh viverra malesuada. Nunc sem lacus, accumsan quis, faucibus non, congue vel, arcu. Ut scelerisque hendrerit tellus. Integer sagittis. Vivamus a mauris eget arcu gravida tristique. Nunc iaculis mi in ante. Vivamus imperdiet nibh feugiat est.\r\n\r\nUt convallis, sem sit amet interdum consectetuer, odio augue aliquam leo, nec dapibus tortor nibh sed augue. Integer eu magna sit amet metus fermentum posuere. Morbi sit amet nulla sed dolor elementum imperdiet. Quisque fermentum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque adipiscing eros ut libero. Ut condimentum mi vel tellus. Suspendisse laoreet. Fusce ut est sed dolor gravida convallis. Morbi vitae ante. Vivamus ultrices luctus nunc. Suspendisse et dolor. Etiam dignissim. Proin malesuada adipiscing lacus. Donec metus. Curabitur gravida.', '<p>Morbi interdum mollis sapien. Sed ac risus. Phasellus lacinia, magna a ullamcorper laoreet, lectus arcu pulvinar risus, vitae facilisis libero dolor a purus. Sed vel lacus. Mauris nibh felis, adipiscing varius, adipiscing in, lacinia vel, tellus. Suspendisse ac urna. Etiam pellentesque mauris ut lectus. Nunc tellus ante, mattis eget, gravida vitae, ultricies ac, leo. Integer leo pede, ornare a, lacinia eu, vulputate vel, nisl.</p>\n\n<p>Suspendisse mauris. Fusce accumsan mollis eros. Pellentesque a diam sit amet mi ullamcorper vehicula. Integer adipiscing risus a sem. Nullam quis massa sit amet nibh viverra malesuada. Nunc sem lacus, accumsan quis, faucibus non, congue vel, arcu. Ut scelerisque hendrerit tellus. Integer sagittis. Vivamus a mauris eget arcu gravida tristique. Nunc iaculis mi in ante. Vivamus imperdiet nibh feugiat est.</p>\n\n<p>Ut convallis, sem sit amet interdum consectetuer, odio augue aliquam leo, nec dapibus tortor nibh sed augue. Integer eu magna sit amet metus fermentum posuere. Morbi sit amet nulla sed dolor elementum imperdiet. Quisque fermentum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque adipiscing eros ut libero. Ut condimentum mi vel tellus. Suspendisse laoreet. Fusce ut est sed dolor gravida convallis. Morbi vitae ante. Vivamus ultrices luctus nunc. Suspendisse et dolor. Etiam dignissim. Proin malesuada adipiscing lacus. Donec metus. Curabitur gravida.</p>\n');

-- *** STRUCTURE: `tbl_entries_data_18` ***
DROP TABLE IF EXISTS `tbl_entries_data_18`;
CREATE TABLE `tbl_entries_data_18` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` text collate utf8_unicode_ci,
  `value_formatted` text collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_18` ***
INSERT INTO `tbl_entries_data_18` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (11, 27, 'Eiffel Tower, Paris', 'Eiffel Tower, Paris');
INSERT INTO `tbl_entries_data_18` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (12, 28, 'Sennheiser HD-202', 'Sennheiser HD-202');

-- *** STRUCTURE: `tbl_entries_data_19` ***
DROP TABLE IF EXISTS `tbl_entries_data_19`;
CREATE TABLE `tbl_entries_data_19` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) collate utf8_unicode_ci default NULL,
  `value` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_19` ***

-- *** STRUCTURE: `tbl_entries_data_2` ***
DROP TABLE IF EXISTS `tbl_entries_data_2`;
CREATE TABLE `tbl_entries_data_2` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` text collate utf8_unicode_ci,
  `value_formatted` text collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_2` ***
INSERT INTO `tbl_entries_data_2` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (36, 7, 'This Post has been written using [Markdown](http://daringfireball.net/projects/markdown/) & has nice Typographic elements added using Tony Arnold\'s [Typogrify Extension](http://github.com/tonyarnold/typogrify/tree/master)\r\n\r\nSed egestas, ante et vulputate volutpat, eros pede semper est, vitae luctus metus libero eu augue. Morbi purus libero, faucibus adipiscing, commodo quis, gravida id, est. Sed lectus. Praesent elementum hendrerit tortor. Sed semper lorem at felis. Vestibulum volutpat, lacus a ultrices sagittis, mi neque euismod dui, eu pulvinar nunc sapien ornare nisl. Phasellus pede arcu, dapibus eu, fermentum et, dapibus sed, urna.\r\n\r\n#####If I had a photograph of you\r\n\r\nMorbi interdum mollis sapien. Sed ac risus. Phasellus lacinia, magna a ullamcorper laoreet, lectus arcu pulvinar risus, vitae facilisis libero dolor a purus. Sed vel lacus. Mauris nibh felis, adipiscing varius, adipiscing in, lacinia vel, tellus. Suspendisse ac urna. Etiam pellentesque mauris ut lectus. Nunc tellus ante, mattis eget, gravida vitae, ultricies ac, leo. Integer leo pede, ornare a, lacinia eu, vulputate vel, nisl.\r\n\r\nSuspendisse mauris. Fusce accumsan mollis eros. Pellentesque a diam sit amet mi ullamcorper vehicula. Integer adipiscing risus a sem. Nullam quis massa sit amet nibh viverra malesuada. Nunc sem lacus, accumsan quis, faucibus non, congue vel, arcu. Ut scelerisque hendrerit tellus. Integer sagittis. Vivamus a mauris eget arcu gravida tristique. Nunc iaculis mi in ante. Vivamus imperdiet nibh feugiat est.\r\n\r\nUt convallis, sem sit amet interdum consectetuer, odio augue aliquam leo, nec dapibus tortor nibh sed augue. Integer eu magna sit amet metus fermentum posuere. Morbi sit amet nulla sed dolor elementum imperdiet. Quisque fermentum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque adipiscing eros ut libero. Ut condimentum mi vel tellus. Suspendisse laoreet. Fusce ut est sed dolor gravida convallis. Morbi vitae ante. Vivamus ultrices luctus nunc. Suspendisse et dolor. Etiam dignissim. Proin malesuada adipiscing lacus. Donec metus. Curabitur gravida.\r\n\r\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Phasellus hendrerit. Pellentesque aliquet nibh nec urna. In nisi neque, aliquet vel, dapibus id, mattis vel, nisi. Sed pretium, ligula sollicitudin laoreet viverra, tortor libero sodales leo, eget blandit nunc tortor eu nibh. Nullam mollis. Ut justo. Suspendisse potenti.', '<p>This Post has been written using <a href=\"http://daringfireball.net/projects/markdown/\">Markdown</a> <span class=\"amp\">&amp;</span> has nice Typographic elements added using Tony Arnold&#8217;s <a href=\"http://github.com/tonyarnold/typogrify/tree/master\">Typogrify&#160;Extension</a></p>\n\n<p>Sed egestas, ante et vulputate volutpat, eros pede semper est, vitae luctus metus libero eu augue. Morbi purus libero, faucibus adipiscing, commodo quis, gravida id, est. Sed lectus. Praesent elementum hendrerit tortor. Sed semper lorem at felis. Vestibulum volutpat, lacus a ultrices sagittis, mi neque euismod dui, eu pulvinar nunc sapien ornare nisl. Phasellus pede arcu, dapibus eu, fermentum et, dapibus sed,&#160;urna.</p>\n\n<h5>If I had a photograph of&#160;you</h5>\n\n<p>Morbi interdum mollis sapien. Sed ac risus. Phasellus lacinia, magna a ullamcorper laoreet, lectus arcu pulvinar risus, vitae facilisis libero dolor a purus. Sed vel lacus. Mauris nibh felis, adipiscing varius, adipiscing in, lacinia vel, tellus. Suspendisse ac urna. Etiam pellentesque mauris ut lectus. Nunc tellus ante, mattis eget, gravida vitae, ultricies ac, leo. Integer leo pede, ornare a, lacinia eu, vulputate vel,&#160;nisl.</p>\n\n<p>Suspendisse mauris. Fusce accumsan mollis eros. Pellentesque a diam sit amet mi ullamcorper vehicula. Integer adipiscing risus a sem. Nullam quis massa sit amet nibh viverra malesuada. Nunc sem lacus, accumsan quis, faucibus non, congue vel, arcu. Ut scelerisque hendrerit tellus. Integer sagittis. Vivamus a mauris eget arcu gravida tristique. Nunc iaculis mi in ante. Vivamus imperdiet nibh feugiat&#160;est.</p>\n\n<p>Ut convallis, sem sit amet interdum consectetuer, odio augue aliquam leo, nec dapibus tortor nibh sed augue. Integer eu magna sit amet metus fermentum posuere. Morbi sit amet nulla sed dolor elementum imperdiet. Quisque fermentum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque adipiscing eros ut libero. Ut condimentum mi vel tellus. Suspendisse laoreet. Fusce ut est sed dolor gravida convallis. Morbi vitae ante. Vivamus ultrices luctus nunc. Suspendisse et dolor. Etiam dignissim. Proin malesuada adipiscing lacus. Donec metus. Curabitur&#160;gravida.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Phasellus hendrerit. Pellentesque aliquet nibh nec urna. In nisi neque, aliquet vel, dapibus id, mattis vel, nisi. Sed pretium, ligula sollicitudin laoreet viverra, tortor libero sodales leo, eget blandit nunc tortor eu nibh. Nullam mollis. Ut justo. Suspendisse&#160;potenti.</p>\n');
INSERT INTO `tbl_entries_data_2` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (44, 25, 'Sed egestas, ante et vulputate volutpat, eros pede semper est, vitae luctus metus libero eu augue. Morbi purus libero, faucibus adipiscing, commodo quis, gravida id, est. Sed lectus. Praesent elementum hendrerit tortor. Sed semper lorem at felis. Vestibulum volutpat, lacus a ultrices sagittis, mi neque euismod dui, eu pulvinar nunc sapien ornare nisl. Phasellus pede arcu, dapibus eu, fermentum et, dapibus sed, urna.\r\n\r\nMorbi interdum mollis sapien. Sed ac risus. Phasellus lacinia, magna a ullamcorper laoreet, lectus arcu pulvinar risus, vitae facilisis libero dolor a purus. Sed vel lacus. Mauris nibh felis, adipiscing varius, adipiscing in, lacinia vel, tellus. Suspendisse ac urna. Etiam pellentesque mauris ut lectus. Nunc tellus ante, mattis eget, gravida vitae, ultricies ac, leo. Integer leo pede, ornare a, lacinia eu, vulputate vel, nisl.\r\n\r\n* A simple list of items\r\n* And another one\r\n* Symphony is the leading open source PHP based XML CMS on the market.\r\n\r\nUt convallis, sem sit amet interdum consectetuer, odio augue aliquam leo, nec dapibus tortor nibh sed augue. Integer eu magna sit amet metus fermentum posuere. Morbi sit amet nulla sed dolor elementum imperdiet. Quisque fermentum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque adipiscing eros ut libero. Ut condimentum mi vel tellus. Suspendisse laoreet. Fusce ut est sed dolor gravida convallis. Morbi vitae ante. Vivamus ultrices luctus nunc. Suspendisse et dolor. Etiam dignissim. Proin malesuada adipiscing lacus. Donec metus. Curabitur gravida.\r\n\r\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Phasellus hendrerit. Pellentesque aliquet nibh nec urna. In nisi neque, aliquet vel, dapibus id, mattis vel, nisi. Sed pretium, ligula sollicitudin laoreet viverra, tortor libero sodales leo, eget blandit nunc tortor eu nibh. Nullam mollis. Ut justo. Suspendisse potenti.', '<p>Sed egestas, ante et vulputate volutpat, eros pede semper est, vitae luctus metus libero eu augue. Morbi purus libero, faucibus adipiscing, commodo quis, gravida id, est. Sed lectus. Praesent elementum hendrerit tortor. Sed semper lorem at felis. Vestibulum volutpat, lacus a ultrices sagittis, mi neque euismod dui, eu pulvinar nunc sapien ornare nisl. Phasellus pede arcu, dapibus eu, fermentum et, dapibus sed,&#160;urna.</p>\n\n<p>Morbi interdum mollis sapien. Sed ac risus. Phasellus lacinia, magna a ullamcorper laoreet, lectus arcu pulvinar risus, vitae facilisis libero dolor a purus. Sed vel lacus. Mauris nibh felis, adipiscing varius, adipiscing in, lacinia vel, tellus. Suspendisse ac urna. Etiam pellentesque mauris ut lectus. Nunc tellus ante, mattis eget, gravida vitae, ultricies ac, leo. Integer leo pede, ornare a, lacinia eu, vulputate vel,&#160;nisl.</p>\n\n<ul>\n<li>A simple list of&#160;items</li>\n<li>And another&#160;one</li>\n<li>Symphony is the leading open source <span class=\"caps\">PHP</span> based <span class=\"caps\">XML</span> <span class=\"caps\">CMS</span> on the&#160;market.</li>\n</ul>\n\n<p>Ut convallis, sem sit amet interdum consectetuer, odio augue aliquam leo, nec dapibus tortor nibh sed augue. Integer eu magna sit amet metus fermentum posuere. Morbi sit amet nulla sed dolor elementum imperdiet. Quisque fermentum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque adipiscing eros ut libero. Ut condimentum mi vel tellus. Suspendisse laoreet. Fusce ut est sed dolor gravida convallis. Morbi vitae ante. Vivamus ultrices luctus nunc. Suspendisse et dolor. Etiam dignissim. Proin malesuada adipiscing lacus. Donec metus. Curabitur&#160;gravida.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Phasellus hendrerit. Pellentesque aliquet nibh nec urna. In nisi neque, aliquet vel, dapibus id, mattis vel, nisi. Sed pretium, ligula sollicitudin laoreet viverra, tortor libero sodales leo, eget blandit nunc tortor eu nibh. Nullam mollis. Ut justo. Suspendisse&#160;potenti.</p>\n');

-- *** STRUCTURE: `tbl_entries_data_20` ***
DROP TABLE IF EXISTS `tbl_entries_data_20`;
CREATE TABLE `tbl_entries_data_20` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) collate utf8_unicode_ci default NULL,
  `value` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_20` ***

-- *** STRUCTURE: `tbl_entries_data_21` ***
DROP TABLE IF EXISTS `tbl_entries_data_21`;
CREATE TABLE `tbl_entries_data_21` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) collate utf8_unicode_ci default NULL,
  `value` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_21` ***

-- *** STRUCTURE: `tbl_entries_data_22` ***
DROP TABLE IF EXISTS `tbl_entries_data_22`;
CREATE TABLE `tbl_entries_data_22` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` text collate utf8_unicode_ci,
  `value_formatted` text collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_22` ***

-- *** STRUCTURE: `tbl_entries_data_29` ***
DROP TABLE IF EXISTS `tbl_entries_data_29`;
CREATE TABLE `tbl_entries_data_29` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` varchar(80) default NULL,
  `local` int(11) default NULL,
  `gmt` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_29` ***
INSERT INTO `tbl_entries_data_29` (`id`, `entry_id`, `value`, `local`, `gmt`) VALUES (26, 25, '2009-09-03T10:42:00+01:00', 1251970920, 1251970920);
INSERT INTO `tbl_entries_data_29` (`id`, `entry_id`, `value`, `local`, `gmt`) VALUES (18, 7, '2009-09-03T10:50:00+01:00', 1251971400, 1251971400);

-- *** STRUCTURE: `tbl_entries_data_30` ***
DROP TABLE IF EXISTS `tbl_entries_data_30`;
CREATE TABLE `tbl_entries_data_30` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `parent_entry_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `parent_entry_id` (`parent_entry_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_30` ***
INSERT INTO `tbl_entries_data_30` (`id`, `entry_id`, `parent_entry_id`) VALUES (10, 27, 25);
INSERT INTO `tbl_entries_data_30` (`id`, `entry_id`, `parent_entry_id`) VALUES (11, 28, 7);

-- *** STRUCTURE: `tbl_entries_data_32` ***
DROP TABLE IF EXISTS `tbl_entries_data_32`;
CREATE TABLE `tbl_entries_data_32` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `file` varchar(255) default NULL,
  `size` int(11) unsigned NOT NULL,
  `mimetype` varchar(50) default NULL,
  `meta` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `file` (`file`),
  KEY `mimetype` (`mimetype`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_32` ***
INSERT INTO `tbl_entries_data_32` (`id`, `entry_id`, `file`, `size`, `mimetype`, `meta`) VALUES (9, 27, '/uploads/eiffel-tower-1251971410.jpg', 122842, 'image/jpg', 'a:3:{s:8:\"creation\";s:25:\"2009-09-03T10:50:10+01:00\";s:5:\"width\";i:804;s:6:\"height\";i:444;}');
INSERT INTO `tbl_entries_data_32` (`id`, `entry_id`, `file`, `size`, `mimetype`, `meta`) VALUES (10, 28, '/uploads/headphones-1256135406.jpg', 29900, 'image/jpeg', 'a:3:{s:8:\"creation\";s:25:\"2009-10-21T15:30:05+01:00\";s:5:\"width\";i:403;s:6:\"height\";i:523;}');

-- *** STRUCTURE: `tbl_entries_data_33` ***
DROP TABLE IF EXISTS `tbl_entries_data_33`;
CREATE TABLE `tbl_entries_data_33` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` text,
  `value_formatted` text,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_33` ***
INSERT INTO `tbl_entries_data_33` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (7, 32, 'I am a professional space monkey extraordinaire!', '<p>I am a professional space monkey&#160;extraordinaire!</p>\n');

-- *** STRUCTURE: `tbl_entries_data_34` ***
DROP TABLE IF EXISTS `tbl_entries_data_34`;
CREATE TABLE `tbl_entries_data_34` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` text,
  `value_formatted` text,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_34` ***
INSERT INTO `tbl_entries_data_34` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (7, 32, 'Suspendisse mauris. Fusce accumsan mollis eros. Pellentesque a diam sit amet mi ullamcorper vehicula. Integer adipiscing risus a sem. Nullam quis massa sit amet nibh viverra malesuada. Nunc sem lacus, accumsan quis, faucibus non, congue vel, arcu. Ut scelerisque hendrerit tellus. Integer sagittis. Vivamus a mauris eget arcu gravida tristique. Nunc iaculis mi in ante. Vivamus imperdiet nibh feugiat est.\r\n\r\nUt convallis, sem sit amet interdum consectetuer, odio augue aliquam leo, nec dapibus tortor nibh sed augue. Integer eu magna sit amet metus fermentum posuere. Morbi sit amet nulla sed dolor elementum imperdiet. Quisque fermentum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque adipiscing eros ut libero. Ut condimentum mi vel tellus. Suspendisse laoreet. Fusce ut est sed dolor gravida convallis. Morbi vitae ante. Vivamus ultrices luctus nunc. Suspendisse et dolor. Etiam dignissim. Proin malesuada adipiscing lacus. Donec metus. Curabitur gravida.', '<p>Suspendisse mauris. Fusce accumsan mollis eros. Pellentesque a diam sit amet mi ullamcorper vehicula. Integer adipiscing risus a sem. Nullam quis massa sit amet nibh viverra malesuada. Nunc sem lacus, accumsan quis, faucibus non, congue vel, arcu. Ut scelerisque hendrerit tellus. Integer sagittis. Vivamus a mauris eget arcu gravida tristique. Nunc iaculis mi in ante. Vivamus imperdiet nibh feugiat&#160;est.</p>\n\n<p>Ut convallis, sem sit amet interdum consectetuer, odio augue aliquam leo, nec dapibus tortor nibh sed augue. Integer eu magna sit amet metus fermentum posuere. Morbi sit amet nulla sed dolor elementum imperdiet. Quisque fermentum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque adipiscing eros ut libero. Ut condimentum mi vel tellus. Suspendisse laoreet. Fusce ut est sed dolor gravida convallis. Morbi vitae ante. Vivamus ultrices luctus nunc. Suspendisse et dolor. Etiam dignissim. Proin malesuada adipiscing lacus. Donec metus. Curabitur&#160;gravida.</p>\n');

-- *** STRUCTURE: `tbl_entries_data_35` ***
DROP TABLE IF EXISTS `tbl_entries_data_35`;
CREATE TABLE `tbl_entries_data_35` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) default NULL,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_35` ***
INSERT INTO `tbl_entries_data_35` (`id`, `entry_id`, `handle`, `value`) VALUES (16, 33, 'linkedin', 'LinkedIn');
INSERT INTO `tbl_entries_data_35` (`id`, `entry_id`, `handle`, `value`) VALUES (17, 34, 'lastfm', 'Last.fm');
INSERT INTO `tbl_entries_data_35` (`id`, `entry_id`, `handle`, `value`) VALUES (18, 35, 'flickr', 'Flickr');

-- *** STRUCTURE: `tbl_entries_data_36` ***
DROP TABLE IF EXISTS `tbl_entries_data_36`;
CREATE TABLE `tbl_entries_data_36` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) default NULL,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_36` ***
INSERT INTO `tbl_entries_data_36` (`id`, `entry_id`, `handle`, `value`) VALUES (16, 33, 'http-wwwlinkedincom-in-fazalkhan', 'http://www.linkedin.com/in/fazalkhan');
INSERT INTO `tbl_entries_data_36` (`id`, `entry_id`, `handle`, `value`) VALUES (17, 34, 'http-wwwlastfm-user-demwunz', 'http://www.last.fm/user/demwunz');
INSERT INTO `tbl_entries_data_36` (`id`, `entry_id`, `handle`, `value`) VALUES (18, 35, 'http-wwwflickrcom-photos-demwunz', 'http://www.flickr.com/photos/demwunz');

-- *** STRUCTURE: `tbl_entries_data_37` ***
DROP TABLE IF EXISTS `tbl_entries_data_37`;
CREATE TABLE `tbl_entries_data_37` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `parent_entry_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `parent_entry_id` (`parent_entry_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_37` ***
INSERT INTO `tbl_entries_data_37` (`id`, `entry_id`, `parent_entry_id`) VALUES (16, 33, 32);
INSERT INTO `tbl_entries_data_37` (`id`, `entry_id`, `parent_entry_id`) VALUES (17, 34, 32);
INSERT INTO `tbl_entries_data_37` (`id`, `entry_id`, `parent_entry_id`) VALUES (18, 35, 32);

-- *** STRUCTURE: `tbl_entries_data_38` ***
DROP TABLE IF EXISTS `tbl_entries_data_38`;
CREATE TABLE `tbl_entries_data_38` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `child_entry_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `child_entry_id_id` (`child_entry_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_38` ***
INSERT INTO `tbl_entries_data_38` (`id`, `entry_id`, `child_entry_id`) VALUES (18, 32, 35);
INSERT INTO `tbl_entries_data_38` (`id`, `entry_id`, `child_entry_id`) VALUES (17, 32, 34);
INSERT INTO `tbl_entries_data_38` (`id`, `entry_id`, `child_entry_id`) VALUES (16, 32, 33);

-- *** STRUCTURE: `tbl_entries_data_39` ***
DROP TABLE IF EXISTS `tbl_entries_data_39`;
CREATE TABLE `tbl_entries_data_39` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `file` varchar(255) default NULL,
  `size` int(11) unsigned NOT NULL,
  `mimetype` varchar(50) default NULL,
  `meta` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `file` (`file`),
  KEY `mimetype` (`mimetype`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_39` ***
INSERT INTO `tbl_entries_data_39` (`id`, `entry_id`, `file`, `size`, `mimetype`, `meta`) VALUES (2, 32, '/uploads/me-1251996330.jpg', 35599, 'image/jpg', 'a:3:{s:8:\"creation\";s:25:\"2009-09-03T17:45:30+01:00\";s:5:\"width\";i:453;s:6:\"height\";i:604;}');

-- *** STRUCTURE: `tbl_entries_data_4` ***
DROP TABLE IF EXISTS `tbl_entries_data_4`;
CREATE TABLE `tbl_entries_data_4` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `relation_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `relation_id` (`relation_id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_4` ***
INSERT INTO `tbl_entries_data_4` (`id`, `entry_id`, `relation_id`) VALUES (36, 7, 12);
INSERT INTO `tbl_entries_data_4` (`id`, `entry_id`, `relation_id`) VALUES (44, 25, 9);

-- *** STRUCTURE: `tbl_entries_data_40` ***
DROP TABLE IF EXISTS `tbl_entries_data_40`;
CREATE TABLE `tbl_entries_data_40` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) default NULL,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=84 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_40` ***
INSERT INTO `tbl_entries_data_40` (`id`, `entry_id`, `handle`, `value`) VALUES (83, 25, 'stuff', 'stuff');
INSERT INTO `tbl_entries_data_40` (`id`, `entry_id`, `handle`, `value`) VALUES (82, 25, 'paris', 'paris');
INSERT INTO `tbl_entries_data_40` (`id`, `entry_id`, `handle`, `value`) VALUES (41, 7, 'headphones', 'headphones');
INSERT INTO `tbl_entries_data_40` (`id`, `entry_id`, `handle`, `value`) VALUES (81, 25, 'music', 'music');
INSERT INTO `tbl_entries_data_40` (`id`, `entry_id`, `handle`, `value`) VALUES (80, 25, 'holidays', 'holidays');
INSERT INTO `tbl_entries_data_40` (`id`, `entry_id`, `handle`, `value`) VALUES (43, 7, 'stuff', 'stuff');
INSERT INTO `tbl_entries_data_40` (`id`, `entry_id`, `handle`, `value`) VALUES (42, 7, 'music', 'music');
INSERT INTO `tbl_entries_data_40` (`id`, `entry_id`, `handle`, `value`) VALUES (79, 25, 'headphones', 'headphones');

-- *** STRUCTURE: `tbl_entries_data_42` ***
DROP TABLE IF EXISTS `tbl_entries_data_42`;
CREATE TABLE `tbl_entries_data_42` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `relation_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `relation_id` (`relation_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_42` ***
INSERT INTO `tbl_entries_data_42` (`id`, `entry_id`, `relation_id`) VALUES (15, 25, 27);
INSERT INTO `tbl_entries_data_42` (`id`, `entry_id`, `relation_id`) VALUES (7, 7, 28);

-- *** STRUCTURE: `tbl_entries_data_43` ***
DROP TABLE IF EXISTS `tbl_entries_data_43`;
CREATE TABLE `tbl_entries_data_43` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` enum('yes','no') NOT NULL default 'yes',
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- *** DATA: `tbl_entries_data_43` ***
INSERT INTO `tbl_entries_data_43` (`id`, `entry_id`, `value`) VALUES (10, 25, 'yes');
INSERT INTO `tbl_entries_data_43` (`id`, `entry_id`, `value`) VALUES (2, 7, 'yes');

-- *** STRUCTURE: `tbl_entries_data_5` ***
DROP TABLE IF EXISTS `tbl_entries_data_5`;
CREATE TABLE `tbl_entries_data_5` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` enum('yes','no') collate utf8_unicode_ci NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_5` ***
INSERT INTO `tbl_entries_data_5` (`id`, `entry_id`, `value`) VALUES (36, 7, 'yes');
INSERT INTO `tbl_entries_data_5` (`id`, `entry_id`, `value`) VALUES (44, 25, 'yes');

-- *** STRUCTURE: `tbl_entries_data_6` ***
DROP TABLE IF EXISTS `tbl_entries_data_6`;
CREATE TABLE `tbl_entries_data_6` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) collate utf8_unicode_ci default NULL,
  `value` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_6` ***
INSERT INTO `tbl_entries_data_6` (`id`, `entry_id`, `handle`, `value`) VALUES (3, 8, 'artwork', 'Artwork');
INSERT INTO `tbl_entries_data_6` (`id`, `entry_id`, `handle`, `value`) VALUES (4, 9, 'exhibiting', 'Exhibiting');
INSERT INTO `tbl_entries_data_6` (`id`, `entry_id`, `handle`, `value`) VALUES (5, 10, 'intervention', 'Intervention');
INSERT INTO `tbl_entries_data_6` (`id`, `entry_id`, `handle`, `value`) VALUES (6, 11, 'periods', 'Periods');
INSERT INTO `tbl_entries_data_6` (`id`, `entry_id`, `handle`, `value`) VALUES (7, 12, 'questions', 'Questions');
INSERT INTO `tbl_entries_data_6` (`id`, `entry_id`, `handle`, `value`) VALUES (8, 13, 'theory', 'Theory');

-- *** STRUCTURE: `tbl_entries_data_7` ***
DROP TABLE IF EXISTS `tbl_entries_data_7`;
CREATE TABLE `tbl_entries_data_7` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `entry_id` int(11) unsigned NOT NULL,
  `value` text collate utf8_unicode_ci,
  `value_formatted` text collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA: `tbl_entries_data_7` ***
INSERT INTO `tbl_entries_data_7` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (3, 8, NULL, NULL);
INSERT INTO `tbl_entries_data_7` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (4, 9, NULL, NULL);
INSERT INTO `tbl_entries_data_7` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (5, 10, NULL, NULL);
INSERT INTO `tbl_entries_data_7` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (6, 11, NULL, NULL);
INSERT INTO `tbl_entries_data_7` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (7, 12, NULL, NULL);
INSERT INTO `tbl_entries_data_7` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (8, 13, NULL, NULL);

-- *** DATA: `tbl_entries` ***
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (9, 2, 1, '2009-09-01 16:52:06', '2009-09-01 15:52:06');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (8, 2, 1, '2009-09-01 16:51:56', '2009-09-01 15:51:56');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (10, 2, 1, '2009-09-01 16:52:14', '2009-09-01 15:52:14');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (7, 1, 1, '2009-09-01 16:35:39', '2009-09-01 15:35:39');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (31, 4, 0, '2009-09-03 14:24:42', '2009-09-03 13:24:42');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (25, 1, 1, '2009-09-03 09:57:31', '2009-09-03 08:57:31');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (11, 2, 1, '2009-09-01 16:52:20', '2009-09-01 15:52:20');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (12, 2, 1, '2009-09-01 16:52:26', '2009-09-01 15:52:26');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (13, 2, 1, '2009-09-01 16:52:33', '2009-09-01 15:52:33');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (27, 5, 1, '2009-09-03 10:50:10', '2009-09-03 09:50:10');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (28, 5, 1, '2009-09-03 10:50:25', '2009-09-03 09:50:25');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (32, 8, 1, '2009-09-03 17:25:23', '2009-09-03 16:25:23');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (33, 9, 1, '2009-09-03 17:26:34', '2009-09-03 16:26:34');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (34, 9, 1, '2009-09-03 17:26:34', '2009-09-03 16:26:34');
INSERT INTO `tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`) VALUES (35, 9, 1, '2009-09-03 17:26:34', '2009-09-03 16:26:34');

-- *** DATA: `tbl_extensions` ***
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (75, 'export_ensemble', 'enabled', 1.9);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (74, 'debugdevkit', 'enabled', 1);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (76, 'selectbox_link_field', 'enabled', 1.1);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (77, 'jit_image_manipulation', 'enabled', 1.05);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (78, 'maintenance_mode', 'enabled', 1.1);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (79, 'markdown', 'enabled', 1.8);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (80, 'profiledevkit', 'enabled', 1);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (81, 'typogrify', 'enabled', 1);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (90, 'calendaroverlay', 'enabled', 1);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (83, 'subsectionfield', 'enabled', 1.009);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (84, 'uniqueuploadfield', 'enabled', 1);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (85, 'multiselect_to_checkboxes', 'enabled', 1);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (93, 'mediathek', 'enabled', 2);
INSERT INTO `tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (87, 'static_section', 'enabled', 1.2);

-- *** DATA: `tbl_extensions_delegates` ***
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (65, 75, '/system/preferences/', 'AddCustomPreferenceFieldsets', 'appendPreferences');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (64, 74, '/frontend/', 'ManipulateDevKitNavigation', 'manipulateDevKitNavigation');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (63, 74, '/frontend/', 'FrontendDevKitResolve', 'frontendDevKitResolve');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (67, 77, '/system/preferences/', 'Save', '__SavePreferences');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (72, 78, '/frontend/', 'FrontendParamsResolve', '__addParam');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (71, 78, '/frontend/', 'FrontendPrePageResolve', '__checkForMaintenanceMode');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (70, 78, '/system/preferences/', 'CustomActions', '__toggleMaintenanceMode');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (69, 78, '/system/preferences/', 'Save', '__SavePreferences');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (68, 78, '/system/preferences/', 'AddCustomPreferenceFieldsets', 'appendPreferences');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (75, 80, '/frontend/', 'ManipulateDevKitNavigation', 'manipulateDevKitNavigation');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (74, 80, '/frontend/', 'FrontendDevKitResolve', 'frontendDevKitResolve');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (66, 77, '/system/preferences/', 'AddCustomPreferenceFieldsets', 'appendPreferences');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (73, 78, '/backend/', 'AppendPageAlert', '__appendAlert');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (76, 85, '/administration/', 'AdminPagePreGenerate', '__appendAssets');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (86, 93, '/publish/new/', 'EntryPostNew', '__saveSortOrder');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (85, 93, '/administration/', 'AdminPagePreGenerate', '__appendAssets');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (79, 87, '/backend/', 'InitaliseAdminPageHead', 'appendScriptToHead');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (80, 87, '/administration/', 'NavigationPreRender', 'applyStaticSections');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (81, 87, '/administration/', 'AdminPagePostGenerate', 'modifyPageElements');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (82, 90, '/backend/', 'InitaliseAdminPageHead', 'initaliseAdminPageHead');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (87, 93, '/publish/edit/', 'EntryPostEdit', '__saveSortOrder');
INSERT INTO `tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (88, 93, '/publish/', 'Delete', '__deleteSortOrder');

-- *** DATA: `tbl_fields` ***
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (1, 'Title', 'title', 'input', 1, 'yes', 0, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (2, 'Body', 'body', 'textarea', 1, 'yes', 1, 'main', 'no');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (30, 'Article Images', 'article-images', 'subsectionchild', 5, 'no', 2, 'sidebar', 'no');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (4, 'Categories', 'categories', 'selectbox_link', 1, 'yes', 6, 'sidebar', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (5, 'Publish', 'publish', 'checkbox', 1, 'no', 2, 'sidebar', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (6, 'Title', 'title', 'input', 2, 'yes', 0, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (7, 'Description', 'description', 'textarea', 2, 'no', 1, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (29, 'Date', 'date', 'date', 1, 'no', 3, 'sidebar', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (10, 'Author', 'author', 'input', 4, 'yes', 0, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (11, 'Email', 'email', 'input', 4, 'yes', 1, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (12, 'Website', 'website', 'input', 4, 'yes', 2, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (13, 'Date', 'date', 'date', 4, 'no', 3, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (14, 'Article', 'article', 'selectbox_link', 4, 'yes', 4, 'sidebar', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (15, 'Comment', 'comment', 'textarea', 4, 'yes', 5, 'sidebar', 'no');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (32, 'Image', 'image', 'uniqueupload', 5, 'yes', 0, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (43, 'Manage Images', 'manage-images', 'checkbox', 1, 'no', 4, 'sidebar', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (18, 'Description', 'description', 'textarea', 5, 'yes', 1, 'sidebar', 'no');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (19, 'Name', 'name', 'input', 6, 'yes', 0, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (20, 'Email', 'email', 'input', 6, 'yes', 1, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (21, 'Subject', 'subject', 'input', 6, 'no', 2, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (22, 'Message', 'message', 'textarea', 6, 'no', 3, 'sidebar', 'no');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (41, 'Static Section', 'static-section', 'static_section', 8, 'no', 4, 'main', 'no');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (33, 'About me snippet', 'about-me-snippet', 'textarea', 8, 'yes', 1, 'sidebar', 'no');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (34, 'About me', 'about-me', 'textarea', 8, 'yes', 2, 'main', 'no');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (35, 'Title', 'title', 'input', 9, 'no', 0, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (36, 'Link', 'link', 'input', 9, 'no', 1, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (37, 'External Links', 'external-links', 'subsectionchild', 9, 'no', 2, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (38, 'External Links', 'external-links', 'subsection', 8, 'no', 3, 'sidebar', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (39, 'My Photo', 'my-photo', 'uniqueupload', 8, 'no', 0, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (40, 'Tags', 'tags', 'taglist', 1, 'no', 7, 'main', 'yes');
INSERT INTO `tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (42, 'Article Images', 'article-images', 'mediathek', 1, 'no', 5, 'sidebar', 'yes');

-- *** DATA: `tbl_pages` ***
INSERT INTO `tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (64, NULL, 'Home', 'home', NULL, 'category', 'about_me,categories,homepage_articles,navigation,tags,twitter,website_owner', 'login', 1);
INSERT INTO `tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (66, NULL, 'About', 'about', NULL, NULL, 'about_me,navigation,twitter,website_owner', 'login,save_message', 7);
INSERT INTO `tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (67, NULL, 'RSS', 'rss', NULL, NULL, 'rss_articles', NULL, 8);
INSERT INTO `tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (68, NULL, 'Archive', 'archive', NULL, 'year', 'archive,categories,navigation,tags,twitter,website_owner', 'login', 4);
INSERT INTO `tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (69, NULL, 'Articles', 'articles', NULL, 'entry/cat', 'about_me,article,categories,comments,navigation,twitter,website_owner', 'login,save_comment', 2);
INSERT INTO `tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (75, NULL, 'Maintenance', 'maintenance', NULL, NULL, NULL, NULL, 9);
INSERT INTO `tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (76, NULL, 'Page Not Found', 'page-not-found', NULL, NULL, NULL, NULL, 10);
INSERT INTO `tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (77, 68, 'Categories', 'category', 'archive', 'category', 'about_me,all_categories,archive_listing,categories,navigation,tags,twitter,website_owner', 'login', 5);
INSERT INTO `tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (78, 68, 'Tag', 'tag', 'archive', 'tag', 'about_me,archive_listing,categories,navigation,tags,twitter,website_owner', 'login', 6);

-- *** DATA: `tbl_pages_types` ***
INSERT INTO `tbl_pages_types` (`id`, `page_id`, `type`) VALUES (609, 76, 404);
INSERT INTO `tbl_pages_types` (`id`, `page_id`, `type`) VALUES (611, 75, 'maintenance');
INSERT INTO `tbl_pages_types` (`id`, `page_id`, `type`) VALUES (641, 64, 'index');
INSERT INTO `tbl_pages_types` (`id`, `page_id`, `type`) VALUES (653, 69, 'hidden');
INSERT INTO `tbl_pages_types` (`id`, `page_id`, `type`) VALUES (463, 67, 'XML');
INSERT INTO `tbl_pages_types` (`id`, `page_id`, `type`) VALUES (462, 67, 'hidden');
INSERT INTO `tbl_pages_types` (`id`, `page_id`, `type`) VALUES (640, 64, 'hidden');
INSERT INTO `tbl_pages_types` (`id`, `page_id`, `type`) VALUES (610, 75, 'hidden');
INSERT INTO `tbl_pages_types` (`id`, `page_id`, `type`) VALUES (608, 76, 'hidden');
INSERT INTO `tbl_pages_types` (`id`, `page_id`, `type`) VALUES (652, 77, 'hidden');

-- *** DATA: `tbl_sections` ***
INSERT INTO `tbl_sections` (`id`, `name`, `handle`, `sortorder`, `entry_order`, `entry_order_direction`, `hidden`, `navigation_group`) VALUES (1, 'Articles', 'articles', 0, 26, 'asc', 'no', 'Content');
INSERT INTO `tbl_sections` (`id`, `name`, `handle`, `sortorder`, `entry_order`, `entry_order_direction`, `hidden`, `navigation_group`) VALUES (2, 'Categories', 'categories', 1, NULL, 'asc', 'no', 'Content');
INSERT INTO `tbl_sections` (`id`, `name`, `handle`, `sortorder`, `entry_order`, `entry_order_direction`, `hidden`, `navigation_group`) VALUES (8, 'About', 'about', 5, NULL, 'asc', 'no', 'About');
INSERT INTO `tbl_sections` (`id`, `name`, `handle`, `sortorder`, `entry_order`, `entry_order_direction`, `hidden`, `navigation_group`) VALUES (4, 'Comments', 'comments', 2, NULL, 'asc', 'no', 'Content');
INSERT INTO `tbl_sections` (`id`, `name`, `handle`, `sortorder`, `entry_order`, `entry_order_direction`, `hidden`, `navigation_group`) VALUES (5, 'Images', 'images', 3, NULL, 'asc', 'yes', 'Content');
INSERT INTO `tbl_sections` (`id`, `name`, `handle`, `sortorder`, `entry_order`, `entry_order_direction`, `hidden`, `navigation_group`) VALUES (6, 'Messages', 'messages', 4, NULL, 'asc', 'no', 'Content');
INSERT INTO `tbl_sections` (`id`, `name`, `handle`, `sortorder`, `entry_order`, `entry_order_direction`, `hidden`, `navigation_group`) VALUES (9, 'Elsewhere', 'elsewhere', 6, NULL, 'asc', 'yes', 'About');

-- *** DATA: `tbl_sections_association` ***
INSERT INTO `tbl_sections_association` (`id`, `parent_section_id`, `parent_section_field_id`, `child_section_id`, `child_section_field_id`, `cascading_deletion`) VALUES (1, 1, 1, 4, 14, 'no');
INSERT INTO `tbl_sections_association` (`id`, `parent_section_id`, `parent_section_field_id`, `child_section_id`, `child_section_field_id`, `cascading_deletion`) VALUES (45, 2, 6, 1, 4, 'no');
