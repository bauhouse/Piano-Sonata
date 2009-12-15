<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../utilities/master.xsl"/>
	<xsl:import href="../utilities/get-article.xsl"/>
	<xsl:import href="../utilities/get-notes.xsl"/>
	<xsl:import href="../utilities/get-comments.xsl"/>

	<xsl:template match="data">
		<div id="content" class="col span-9">
			<h2>Drafts</h2>
			<h3 class="script">These articles are yet to be published</h3>
			<p>Head back to <a href="{$root}/">home</a> or <a href="{$root}/about/">contact</a> me.</p>
			<xsl:apply-templates select="drafts/entry" mode="article"/>
		</div>
		<div id="sidebar" class="col last span-3">
			<xsl:call-template name="category"/>
			<xsl:call-template name="tag"/>
			<xsl:call-template name="external-links"/>
		</div>
	</xsl:template>

</xsl:stylesheet>
