# Documentation: Mediathek

Mediathek is the German word for media center. It is an enhancement of a normal select box field -- which links entries between sections -- that focuses on connecting media to article-like entries.

* [Mediathek Extension](http://github.com/nilshoerrmann/mediathek/)

### Known Issues

1. If you have been using one of the early beta versions of this extension you cannot upgrade to this release. You will have to uninstall the extension, upload all new files and then start again from scratch. Sorry about that!
2. There have been a lot of changes to the field's database structure. If you are coming from version 1.x please do -- as always -- make a backup of your database _before_ uploading any of the new files and starting the update process.
3. If you update from an earlier version, please be aware that the XML output of the extension changed and that you will have to edit your XSL templates.
4. If there are any Java Script errorss in the backend (thrown by this or any other extension), Mediathek will not show previews and custom captions. All Java Script–related Mediathek features will stop working.


### Dependencies

This extension has been developed for Symphony CMS version 2.0.6. It won't work in older versions due to the lack of jQuery support. If you want to use Mediathek in an older Symphony version, please download version 1.3 of the extension (available on GitHub).

If you would like to use the image preview feature of this extension you need to install the [JIT image manipulation extension](http://github.com/pointybeard/jit_image_manipulation/). Install the [extension](http://github.com/pointybeard/jit_image_manipulation/) in the `extensions` directory. This is an optional feature.

    extensions/jit_image_manipulation

#### Installation using Git

JIT image manipulation can be installed with Git by cloning the GitHub repositories:

	cd extensions
	git clone git://github.com/pointybeard/jit_image_manipulation.git

Or install it as submodule:

	git submodule add git://github.com/pointybeard/jit_image_manipulation.git extensions/jit_image_manipulation

      
### Configuration

After installing and enabling the extension you will find a new field type `Field: Mediathek` in your section preferences.

#### Label

Title of the field.

#### Placement

Location of the field (main content or sidebar).

#### Related section

Section to be linked to the current one.

#### Allow selection of multiple options

Switch between single or multiple select mode.

#### Filter items by tags or category:

A comma-separated list of tags or categories that is used to filter the output. A minus sign excludes a tag or category.

#### Custom item caption

Template used to build the text that represents the linked entries in the Mediathek panel.

#### Included elements

List of all fields to be included in the data source output. Due to the current admin interface it is not possible to specify this directly in the data source manager.


### Usage

Mediathek has two interface states: open panel and closed panel. By default the panel is closed.

#### Open panel

An open Mediathek will show all items from the related section depending on the given filter values. Items will be sorted alphabetically, and selected items will be highlighted. Click edit to open and close the Mediathek.

- *select:* Click an item to select it.
- *unselect:* Click a selected item to unselect it.
- *preview:* Same behaviour as in open mode.
- *search:* Type a term into the search field. Searching will start automatically.

#### Closed panel

A closed Mediathek will only show selected items.

- *dragging:* Dragging items up and down will reorder the Mediathek. This order will be respected in the data source output. Note: You have to save changes to apply your ordering.
- *drag and drop:* Dragging items outside the Mediathek allows you to drop the item into any given textarea. Images will be inserted as image tags, files will be inserted as links (The markup will respect your selected text-formatter. Currently supported are Markdown, Textile and plain HTML). Note: Drag and drop is only available for items with files attached.
- *preview:* Images and files can be previewed. A small plus icon indicates a connected file and toggles the preview. 
- *unselect:* Double-click an item to unselect it.

#### Create new Items

Click the Create New tab to add a new item. Newly created items will be marked as selected automatically.

#### Drag and Drop Items

If a Mediathek item has a file or image attached, it is possible to drag this to any given textarea to automatically create a reference. The extension will respect your text formatter settings, it currently supports:

- HTML (default)
- [Markdown](http://github.com/pointybeard/markdown/)
- [Textile](http://github.com/rowan-lewis/textileplusformatter/)
- [WYMEditor](http://github.com/nilshoerrmann/wymeditor/)

#### Preview

If you like to preview an image or file, just click the plus button on the right side of the Mediathek item.


### Sample Data Source Output

	<data>
	    <article>
	        <section id="1" handle="articles">Articles</section>
	        <entry id="4" comments="0" images="0">
	            <title handle="an-example-draft-article">An example draft article</title>
	            <mediathek items="1">
	                <item>
	                    <name handle="atasdf">Mediathek test image</name>
	                    <image size="22 kb" path="" type="image/png">
	                        <filename>sym_mediathek_test.png</filename>
	                        <meta creation="2009-09-27T10:09:59+02:00" width="361" height="516" />
	                    </image>
	                </item>
	            </mediathek>
	        </entry>
	    </article>
	</data>

#### Using XSLT to change markup

If you like to change the output of your page based on information provided by Mediathek, please have a look at [Manipulating HTML in XML](http://chaoticpattern.com/article/manipulating-html-in-xml/) written by Allen Chang.


### Contributing

If you have ideas for improvement or if you like to contribute bug fixes, please fork this repository and send a pull request.

#### Discussion

You can discuss this extension in the Symphony forum: <http://symphony-cms.com/community/discussions/26361/>


### Bug reports

If you think you've found a bug, please consult the Symphony forum first and see if the problem has been discussed or solved. If you can't find anything, please post a bug report at <http://github.com/nilshoerrmann/mediathek/issues/> providing the following information:

- A description of your problem. Please be precise: What's the problem? When does is occur? How can it be reproduced?
- Your Symphony version number.
- Your Mediathek version number.
- Any errors and warnings in your activity log.
- Any errors in your Java Script console.