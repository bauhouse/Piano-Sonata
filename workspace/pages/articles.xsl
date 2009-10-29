<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/get-article.xsl"/>
<xsl:import href="../utilities/get-comments.xsl"/>

<xsl:template match="data">
	<div id="content" class="col span-9">
		<div class="col last span-9">
			<div class="col span-7 nudge-2">
				<h4>You are reading</h4>
			</div>
		</div>
		<xsl:apply-templates select="article/entry" mode="article"/>
		<div class="comments span-9">
			<xsl:apply-templates select="comments"/>
		</div>
		<hr />
		<div class="span-9">
			<div class="last span-7 nudge-2 make-comment">
				<h4>Make a comment</h4>	
				<p>Please keep the language PG-13, my mum reads this blog. Hi mum!<br />Text is formatted with <a href="http://daringfireball.net/projects/markdown/syntax">Markdown</a>.</p>
				</div>
		</div>
		<div class="span-9">
			<form action="" method="post">
				<xsl:for-each select="events/save-comment">
					<p class="{@result}">
						<xsl:choose>
							<xsl:when test="@result = 'success'">Your comment has been saved successfully.</xsl:when>
							<xsl:otherwise>The system encountered errors when saving your comment. Please check if all the required fields have been filled.</xsl:otherwise>
						</xsl:choose>
					</p>
				</xsl:for-each>
				<fieldset>
					<div class="form-row">
						<div class="col span-2"><label for="fields-author">Name </label></div>
						<div class="last span-7 nudge-2"><input type="text" class="text span-4" id="fields-author" name="fields[author]" value="{events/save-comment/post-values/author}" /></div>
					</div>
					<div class="form-row">
						<div class="col span-2"><label for="fields-email">Email</label></div>
						<div class="last span-7 nudge-2"><input type="text" class="text span-4" id="fields-email" name="fields[email]" value="{events/save-comment/post-values/email}" /></div>
					</div>
					<div class="form-row">
						<div class="col span-2"><label for="fields-website">Website</label></div>
						<div class="last span-7 nudge-2"><input type="text" class="text span-4" id="fields-website" name="fields[website]" value="{events/save-comment/post-values/website}" /></div>
					</div>
					<div class="form-row">
						<div class="col span-2"><label for="fields-comment">Comment</label></div>
						<div class="last span-7 nudge-2"><textarea id="fields-comment" name="fields[comment]" rows="5" cols="21"><xsl:value-of select="events/save-comment/post-values/comment" /></textarea></div>
					</div>
					<input name="fields[article]" value="{article/entry/@id}" type="hidden" />
					<div class="form-row last">
						<div class="last span-7 nudge-2">
							<!-- <input id="submit" type="image" name="action[save-comment]" src="{$workspace}/images/button-post-comment.gif" value="Post Comment" /> -->
							<button type="submit" id="submit" name="action[save-comment]"> Post Comment</button>
						</div>
					</div>
				</fieldset>
			</form>
			</div>
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