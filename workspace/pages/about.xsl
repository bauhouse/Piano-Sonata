<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../utilities/master.xsl"/>
	<xsl:import href="../utilities/typography.xsl"/>
	
	<xsl:template match="data">
		<div id="content" class="col span-9">
			<div class="span-9">
				<h2><xsl:value-of select="$page-title"/></h2>
				<h2 class="script">More details about <xsl:value-of select="website-owner/author/name"/><span class="amp"> &#38;</span> this site.</h2>
				<div class="copy span-9">
					<xsl:apply-templates select="about-me/entry/about-me/*" mode="html"/>
				</div>
			</div>
			<h2>Contact Me</h2>
			<div class="span-9">
				<div class="last span-7 nudge-2 make-message">
					<h4>Notes</h4>	
					<p>It's preferred to use the contact form rather than email. There is always a chance for emails to be picked up as spam.<br />I will generally reply to messages within 24 hours unless I am horribly swamped.</p>
				</div>
			</div>
			<div class="span-9">
				<form action="" method="post">
					<xsl:for-each select="events/save-message">
						<p class="{@result}">
							<xsl:choose>
								<xsl:when test="@result = 'success'">Your comment has been saved successfully.</xsl:when>
								<xsl:otherwise>The system encountered errors while sending your email. Please check if all the required fields have been filled.</xsl:otherwise>
							</xsl:choose>
						</p>
					</xsl:for-each>
					<fieldset>
						<div class="form-row">
							<div class="col span-2"><label for="fields[name]">Name </label></div>
							<div class="last span-7 nudge-2"><input type="text" class="text span-4" name="fields[name]" value="{events/save-message/post-values/name}" /></div>
						</div>
						<div class="form-row">
							<div class="col span-2"><label for="fields[email]">Email</label></div>
							<div class="last span-7 nudge-2"><input type="text" class="text span-4" name="fields[email]" value="{events/save-message/post-values/email}" /></div>
						</div>
						<div class="form-row">
							<div class="col span-2"><label for="fields[subject]">Subject</label></div>
							<div class="last span-7 nudge-2"><xsl:choose>
								<xsl:when test="events/save-message/post-values/subject">
									<input type="text" class="text span-4" name="fields[subject]" value="{events/save-message/post-values/subject}" />
								</xsl:when>
								<xsl:otherwise>
									<input type="text" class="text span-4" name="fields[subject]" value="General Enquiry" />
								</xsl:otherwise>
							</xsl:choose></div>
						</div>
						<div class="form-row">
							<div class="col span-2"><label for="fields[message]">Message</label></div>
							<div class="last span-7 nudge-2"><textarea name="fields[message]" rows="5" cols="21"><xsl:value-of select="events/save-message/post-values/message" /></textarea></div>
						</div>
						<input name="send-email[recipient]" value="{website-owner/author/username}" type="hidden" />
						<input name="send-email[sender-email]" value="fields[email]" type="hidden" />
						<input name="send-email[sender-name]" value="fields[name]" type="hidden" />
						<input name="send-email[subject]" value="fields[subject]" type="hidden" />
						<input name="send-email[body]" value="fields[message],fields[subject],fields[email],fields[name]" type="hidden" />
						<div class="form-row last">
							<div class="last span-7 nudge-2">
								<!-- <input id="submit" type="image" name="action[save-comment]" src="{$workspace}/images/button-post-comment.gif" value="Post Comment" /> -->
								<button type="submit" id="submit" name="action[save-message]" value="Send Message"> Send Message</button>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
		
		<div id="sidebar" class="col last span-3">
			<xsl:call-template name="twitter"/>
			<xsl:call-template name="external-links"/>
		</div>
	</xsl:template>

</xsl:stylesheet>