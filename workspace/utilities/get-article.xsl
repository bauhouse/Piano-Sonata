<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="typography.xsl"/>
	<xsl:import href="get-images.xsl"/>

	<xsl:template match="entry" mode="article">
		<div class="post span-9">
			<div class="post-meta col span-2">
				<span><xsl:call-template name="format-date">
					<xsl:with-param name="date" select="date"/>
					<xsl:with-param name="format" select="'d m'"/>
				</xsl:call-template></span>
				<ul>
					<li>
						<xsl:text>Tagged as: </xsl:text>
						<xsl:for-each select="tags/item">
							<a href="{$root}/archive/tag/{@handle}"><xsl:value-of select="."/></a>
							<xsl:if test="position() != last()">, </xsl:if>
						</xsl:for-each>
					</li>
					<li><a href="{$root}/articles/{title/@handle}#comments"><xsl:value-of select="@comments"/> comment<xsl:if test="@comments != 1">s</xsl:if></a></li>
				</ul>
			</div>

			<div class="post-content last span-7 nudge-2">
				<h3><a href="{$root}/articles/{title/@handle}"><xsl:value-of select="title"/></a></h3>
				<xsl:apply-templates select="body/*[position() &lt; 3]" mode="html"/>
					<xsl:if test="(article-images) and (manage-images = 'Yes')">
						<xsl:call-template name="get-images">
							<xsl:with-param name="image-entry" select="article-images/item"/>					
						</xsl:call-template>
					</xsl:if>
				<xsl:apply-templates select="body/*[position() &gt; 2]" mode="html"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="entry" mode="short">
		<div class="post span-9">
			<div class="post-meta col span-2">
				<span><xsl:call-template name="format-date">
					<xsl:with-param name="date" select="date"/>
					<xsl:with-param name="format" select="'d m'"/>
				</xsl:call-template></span>
				<ul>
					<li>
						<xsl:text>Tagged as: </xsl:text>
						<xsl:for-each select="tags/item">
							<a href="{$root}/archive/tag/{@handle}"><xsl:value-of select="."/></a>
							<xsl:if test="position() != last()">, </xsl:if>
						</xsl:for-each>
					</li>
					<li><a href="{$root}/articles/{title/@handle}#comments"><xsl:value-of select="@comments"/> comment<xsl:if test="@comments != 1">s</xsl:if></a></li>
				</ul>
			</div>

			<div class="post-content last span-7 nudge-2">
				<h3><a href="{$root}/articles/{title/@handle}"><xsl:value-of select="title"/></a></h3>
				<xsl:apply-templates select="body/*[position() &lt; 3]" mode="html"/>
				<p><a href="{$root}/articles/{title/@handle}" title="Read {title}">Read the full article</a></p>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="categories/item">
		<xsl:value-of select="."/>
		<xsl:if test="position() != last()">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>