<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="get-images">
		<xsl:param name="image-entry"/>
		<xsl:choose>
			<xsl:when test="($image-entry/image/meta/@width) &gt; ($image-entry/image/meta/@height)">
				<xsl:apply-templates select="$image-entry/image">
					<xsl:with-param name="image-class" select="'full-width'"/>
					<xsl:with-param name="caption-class" select="'full-width-caption'"/>
					<xsl:with-param name="width" select="'796'"/>
					<xsl:with-param name="height" select="'440'"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<div class="half-size">
					<xsl:apply-templates select="$image-entry/image">
						<xsl:with-param name="image-class" select="'centered'"/>
						<xsl:with-param name="caption-class" select="'caption'"/>
						<xsl:with-param name="width" select="'403'"/>
						<xsl:with-param name="height" select="'523'"/>
					</xsl:apply-templates>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="image">
		<xsl:param name="image-class" />
		<xsl:param name="caption-class" />	
		<xsl:param name="width" />
		<xsl:param name="height" />
		<img src="{$root}/image/2/{$width}/{$height}/2{@path}/{filename}" alt="{description}" class="{$image-class}"/>
		<p class="{$caption-class}">
			<xsl:value-of select="../description"/>
		</p>
	</xsl:template>

</xsl:stylesheet>