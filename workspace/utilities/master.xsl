<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../utilities/page-title.xsl"/>
	<xsl:import href="../utilities/navigation.xsl"/>
	<xsl:import href="../utilities/date-time.xsl"/>
	<xsl:import href="../utilities/get-article.xsl"/>
	<xsl:import href="../utilities/sidebar.xsl"/>

	<xsl:output method="xml"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		omit-xml-declaration="yes"
		encoding="UTF-8"
		indent="yes" />

	<xsl:variable name="is-logged-in" select="/data/events/login-info/@logged-in"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:call-template name="page-title"/>
				</title>
				<link rel="icon" type="images/png" href="{$workspace}/images/icons/bookmark.png" />
				<link rel="stylesheet" type="text/css" media="screen" href="{$workspace}/css/grid-1080.css" />
				<link rel="stylesheet" type="text/css" media="screen" href="{$workspace}/css/master.css" />
				<xsl:comment><![CDATA[[if lte IE 6]><link rel="stylesheet" type="text/css" href="/workspace/css/ie6.css" media="screen, projection" /><![endif]]]></xsl:comment>
				<link rel="alternate" type="application/rss+xml" href="{$root}/rss/" />
			</head>
			<body>
				<div id="wrapper" class="span-12">			
					<div id="pages">
							<xsl:apply-templates select="data/navigation"/>
					</div>						
					<div id="header" class="col last span-12">
						<h1><a href="{$root}"><xsl:value-of select="$website-name"/></a></h1>
						<h2><span class="by">by </span><xsl:value-of select="data/website-owner/author/name"/></h2>
					</div>			
					<xsl:apply-templates select="data"/>											
					<div id="footer">
						<p id="foo"><em>in</em> symphony</p>
						<p>Original Template by <a href="http://www.rodrigogalindez.com/" title="Rodrigo Galindez">Rodrigo Galindez</a>, re-orchestrated with permission for <a href="http://www.symphony-cms.com/" title="Symphony CMS">Symphony</a> by <a href="http://www.fazalkhan.co.uk/" title="Fazal Khan">Fazal Khan.</a></p>
						<p><xsl:value-of select="$website-name"/> &#169; <xsl:value-of select="$this-year"/><xsl:text> </xsl:text><xsl:value-of select="data/website-owner/author/name"/>. All rights reserved.</p>		
					</div>			
				</div>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>