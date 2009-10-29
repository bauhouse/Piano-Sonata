<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../utilities/master.xsl"/>
	<xsl:import href="../utilities/get-article.xsl"/>
	<xsl:import href="../utilities/get-notes.xsl"/>
	<xsl:import href="../utilities/get-comments.xsl"/>

	<xsl:template match="data">
		<div id="content" class="col span-9">
			<div class="col last span-9">
				<div class="col span-7 nudge-2">
					<h4>Recent entries</h4>
				</div>
			</div>
			<xsl:apply-templates select="homepage-articles/entry" mode="article"/>
		</div>
		<div id="sidebar" class="col last span-3">
			<xsl:call-template name="about"/>
			<xsl:call-template name="twitter"/>
			<xsl:call-template name="category"/>
			<xsl:call-template name="tag"/>
			<xsl:call-template name="external-links"/>
		</div>
	</xsl:template>

</xsl:stylesheet>

