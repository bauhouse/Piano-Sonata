<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:key name="tags" match="tags/entry/tags/item" use="@handle"/>

	<xsl:template name="about">
		<div id="about" class="section">
			<h3>About</h3>
			<img src="{$root}/image/2/60/68/2/{about-me/entry/my-photo/@path}/{about-me/entry/my-photo/filename}" alt="Avatar" class="avatar" />
			<xsl:copy-of select="about-me/entry/about-me-snippet/*" />
			<p> <a href="{$root}/about/">Read more</a>.</p>
		</div>
	</xsl:template>

	<xsl:template name="twitter">
		<div id="twitter" class="section">
			<h3>Recently on Twitter</h3>
			<blockquote><p><xsl:value-of select="twitter/statuses/status/text"/></p></blockquote>
			<p><a href="http://twitter.com/{twitter//screen_name}">Follow me</a>.</p>
		</div>
	</xsl:template>

	<xsl:template name="category">
		<div class="section">
			<h3>Posts by categories</h3>
			<p>Dig in the archives.</p>
			<ul>
				<xsl:for-each select="categories/entry[@articles &gt; '0']">
					<li><a href="{$root}/archive/category/{title/@handle}"><xsl:value-of select="title"/></a></li>
				</xsl:for-each>
			</ul>
		</div>
	</xsl:template>

	<xsl:template name="category-all">
		<div class="section">
			<h3>Posts by categories</h3>
			<ul>
				<xsl:for-each select="all-categories/entry[@articles &gt; '0']">
					<li><a href="{$root}/archive/category/{title/@handle}"><xsl:value-of select="title"/></a></li>
				</xsl:for-each>
			</ul>
		</div>
	</xsl:template>	

	<xsl:template name="tag">
		<div class="section">
			<h3>Posts by tags</h3>
			<p>Recently tagged as.</p>
			<div id="tags">
				<xsl:for-each select="tags/entry/tags/item[generate-id() = generate-id(key('tags',@handle)[1])]">
					<a href="{$root}/archive/tag/{@handle}"><xsl:value-of select="@handle"/></a>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="external-links">
			<div class="section">
				<h3>External links</h3>
				<p>I'm on the web, visit me at</p>
				<div id="links">
					<ul>
						<xsl:for-each select="//external-links/item">
							<li><a href="{link}"><xsl:value-of select="title"/></a></li>
						</xsl:for-each>
					</ul>
				</div>
			</div>
	</xsl:template>

</xsl:stylesheet>