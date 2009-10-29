<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../utilities/master.xsl"/>
	<xsl:import href="../utilities/get-article.xsl"/>

	<xsl:template match="data">
		<div class="col span-9">
			<div class="span-9">
			<h2>Archive</h2>
			<h3 class="script">filtered by <xsl:value-of select="tags//item[@handle = $tag]"/> tag</h3>
			</div>
			<xsl:apply-templates select="archive-listing/entry" mode="short"/>
		</div>
		<div id="sidebar" class="col last span-3">
			<xsl:call-template name="tag"/>
			<xsl:call-template name="category"/>
		</div>
	</xsl:template>

</xsl:stylesheet>