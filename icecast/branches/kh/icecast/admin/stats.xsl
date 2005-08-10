<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" version = "1.0" >
<xsl:output omit-xml-declaration="no" method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8" />
<xsl:template match = "/icestats" >
<html>
<head>
<title>Icecast Streaming Media Server</title>
<link rel="stylesheet" type="text/css" href="/style.css" />
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
<img align="left" src="/images/icecast.png" /><h2><center>Icecast2 Admin</center></h2>
<br />
<!--header menu -->
<div class="roundcont">
<div class="roundtop">
<img src="/images/corner_topleft.jpg" class="corner" style="display: none" />
</div>
	<table border="0" cellpadding="1" cellspacing="3">
	<tr>        
	    <td align="center">
	        <a class="nav" href="stats.xsl">Admin Home</a> | 
		    <a class="nav" href="listmounts.xsl">List Mountpoints</a> | 
        	<a class="nav" href="moveclients.xsl">Move Listeners</a> | 
            <a class="nav" href="managerelays.xsl">Manage Relays</a> |
        	<a class="nav" href="/status.xsl">Index</a>
	    </td></tr>
	</table>
<div class="roundbottom">
<img src="/images/corner_bottomleft.jpg" class="corner" style="display: none" />
</div>
</div>
<br />
<br />
<!--end header menu -->

<!--global server stats-->
<div class="roundcont">
<div class="roundtop">
<img src="/images/corner_topleft.jpg" class="corner" style="display: none" />
</div>
<div class="newscontent">
<h3>Global Server Stats</h3>
<table border="0" cellpadding="4">
<xsl:for-each select="/icestats">
<xsl:for-each select="*">
<xsl:if test = "name()!='source'"> 
<tr>
	<td width="130"><xsl:value-of select="name()" /></td>
	<td class="streamdata"><xsl:value-of select="." /></td>
</tr>
</xsl:if>
</xsl:for-each>
</xsl:for-each>
</table>
</div>
<div class="roundbottom">
<img src="/images/corner_bottomleft.jpg" class="corner" style="display: none" />
</div>
</div>
<br />
<br />
<!--end global server stats-->

<!--mount point stats-->
<xsl:for-each select="source">
<xsl:if test = "listeners!=''"> 
<div class="roundcont">
<div class="roundtop">
<img src="/images/corner_topleft.jpg" class="corner" style="display: none" />
</div>
<div class="newscontent">
<h3>
<xsl:choose>
<xsl:when test="authenticator">
<a href="auth.xsl"><img border="0" src="/images/key.png"/></a> Authentication Required
</xsl:when>
<xsl:otherwise>
<a href="{@mount}.m3u"><img border="0" src="/images/tunein.png"/></a> Mount Point
</xsl:otherwise>
</xsl:choose>

(<xsl:value-of select="@mount" />)
<xsl:if test="authenticator"><a href="manageauth.xsl?mount={@mount}"><img border="0" src="/images/key.gif"/></a> </xsl:if>

</h3>
	<table border="0" cellpadding="1" cellspacing="5" bgcolor="444444">
	<tr>        
	    <td align="center">
		    <a class="nav2" href="listclients.xsl?mount={@mount}">List Clients</a> | 
        	<a class="nav2" href="moveclients.xsl?mount={@mount}">Move MountPoints</a> | 
        	<a class="nav2" href="updatemetadata.xsl?mount={@mount}">Update Metadata</a> |
        	<a class="nav2" href="killsource.xsl?mount={@mount}">Kill Source</a>
                <xsl:if test="authenticator"> | <a class="nav2" href="manageauth.xsl?mount={@mount}">Manage Authentication</a></xsl:if>
	    </td></tr>
	</table>
<br />
<table cellpadding="5" cellspacing="0" border="0">
	<xsl:for-each select="*">
	<tr>
		<td width="130"><xsl:value-of select="name()" /></td>
		<td class="streamdata"><xsl:value-of select="." /></td>
	</tr>
	</xsl:for-each>
</table>
</div>
<div class="roundbottom">
<img src="/images/corner_bottomleft.jpg" class="corner" style="display: none" />
</div>
</div>
<br />
<br />
</xsl:if>
</xsl:for-each>
<xsl:text disable-output-escaping="yes">&amp;</xsl:text>nbsp;


<!--end mount point stats-->
<div class="poster">Support icecast development at <a class="nav" href="http://www.icecast.org">www.icecast.org</a></div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
