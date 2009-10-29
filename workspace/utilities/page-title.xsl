<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="page-title">
		<xsl:value-of select="concat($website-name, '&#8212;', $page-title)"/>
	</xsl:template>

</xsl:stylesheet>