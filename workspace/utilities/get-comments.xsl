<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="comments">
	<div class="span-7 nudge-2">
	<h4>
		<xsl:text>Comments for this article</xsl:text>
		<xsl:if test="$is-logged-in = 'true'">
			<xsl:text> &#8212; </xsl:text>
			<a href="{$root}/symphony/publish/comments/?filter=article:{/data/article/entry/@id}">Manage</a>
		</xsl:if>
	</h4>
	</div>
	<div id="comments">
		<xsl:apply-templates select="entry"/>
		<xsl:apply-templates select="error"/>
	</div>
</xsl:template>

<xsl:template match="comments/entry">
	<dl class="comment span-9 x">
		<dt class="col span-2">
			<xsl:choose>
				<xsl:when test="website">
					<a href="{website}">
						<xsl:value-of select="author"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="author"/>
				</xsl:otherwise>
			</xsl:choose>
			<em>
				<xsl:call-template name="format-date">
					<xsl:with-param name="date" select="date"/>
					<xsl:with-param name="format" select=" 'd m y, t' "/>
				</xsl:call-template>
			</em>
		</dt>
		<dd class="span-7 nudge-2">
			<xsl:copy-of select="comment/*"/>
		</dd>
	</dl>
</xsl:template>

<xsl:template match="comments/error">
	<div class="span-7 nudge-2">
		<p>No comments have been made so far.</p>
	</div>
</xsl:template>

</xsl:stylesheet>