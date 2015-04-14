<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:output method="html"
	     encoding="ascii"/>

 <xsl:param name="draft">yes</xsl:param>
 <xsl:param name="img-dir" select="'.'"/>
 <xsl:param name="version"/>

 <!-- italic template -->
 <xsl:template name="italic">
  <i><xsl:apply-templates/></i>
 </xsl:template>

 <!-- bold template -->
 <xsl:template name="bold">
  <b><xsl:apply-templates/></b>
 </xsl:template>

 <!-- fixed template -->
 <xsl:template name="fixed">
  <tt><xsl:apply-templates/></tt>
 </xsl:template>

 <!-- underline template -->
 <xsl:template name="underline">
  <u><xsl:apply-templates/></u>
 </xsl:template>

 <!-- sub template -->
 <xsl:template name="sub">
  <sub><xsl:apply-templates/></sub>
 </xsl:template>

 <!-- sup template -->
 <xsl:template name="sup">
  <sup><xsl:apply-templates/></sup>
 </xsl:template>

 <!-- big template -->
 <xsl:template name="big">
  <big><xsl:apply-templates/></big>
 </xsl:template>

 <!-- highlight template -->
 <xsl:template name="highlight">
  <font color="{$comment-color}">
   <xsl:if test="@author">
    <b><xsl:value-of select="@author"/>:</b>&#160;
   </xsl:if>
   <xsl:apply-templates/>
  </font>
 </xsl:template>

 <!-- value element -->
 <xsl:template match="value">
  <xsl:call-template name="italic"/>
 </xsl:template>

 <!-- file element -->
 <xsl:template match="file">
  <xsl:call-template name="italic"/>
 </xsl:template>

 <!-- code element -->
 <xsl:template match="code">
  <xsl:call-template name="fixed"/>
 </xsl:template>

 <!-- keyboard element -->
 <xsl:template match="keyb">
  <xsl:call-template name="fixed"/>
 </xsl:template>

 <!-- important element -->
 <xsl:template match="imp">
  <xsl:call-template name="bold"/>
 </xsl:template>

 <!-- term element -->
 <xsl:template match="term">
  <xsl:call-template name="italic"/>
 </xsl:template>

 <!-- glyph element -->
 <xsl:template match="glyph">
  <img src="{$img-dir}/{@url}"/>
 </xsl:template>

 <!-- link element -->
 <xsl:template match="link">
  <xsl:choose>
   <xsl:when test=".=''">
    <a href="{@url}"><xsl:value-of select="@url"/></a>
   </xsl:when>
   <xsl:otherwise>
    <a href="{@url}"><xsl:apply-templates/></a>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ref element -->
 <xsl:template match="ref">
  <a href="#{@id}">
   <xsl:choose>
    <xsl:when test=".=''">
     <xsl:choose>
      <xsl:when test="name(id(@id))='table'">
       <xsl:variable name="index" select="count(preceding::table[@id=id(@id)/@id])+1"/>
       <xsl:text>Table&#160;</xsl:text><xsl:value-of select="$index"/>
      </xsl:when>
      <xsl:when test="name(id(@id))='figure'">
       <xsl:variable name="index" select="count(preceding::figure[@id=id(@id)/@id])+1"/>
       <xsl:text>Figure&#160;</xsl:text><xsl:value-of select="$index"/>
      </xsl:when>
      <xsl:when test="name(id(@id))='source'">
       <xsl:text>source</xsl:text>
       <xsl:if test="id(@id)[@file]">
	<xsl:text> </xsl:text><i><xsl:value-of select="id(@id)/@file"/></i>
       </xsl:if>
      </xsl:when>
      <xsl:when test="name(id(@id))='frame'">
       <xsl:choose>
	<xsl:when test="/*[@lang='fr']">encadré</xsl:when>
	<xsl:otherwise>frame</xsl:otherwise>
       </xsl:choose>
      </xsl:when>
      <xsl:when test="name(id(@id))='sect'">
       <xsl:variable name="index">
	<xsl:for-each select="id(@id)">
	 <xsl:number level="multiple" count="sect" format="1.1"/>
	</xsl:for-each>
       </xsl:variable>
       <xsl:choose>
	<xsl:when test="/*[@lang='fr']"><xsl:text>section&#160;</xsl:text><xsl:value-of select="$index"/></xsl:when>
	<xsl:otherwise><xsl:text>section&#160;</xsl:text><xsl:value-of select="$index"/></xsl:otherwise>
       </xsl:choose>
      </xsl:when>
     </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates/>
    </xsl:otherwise>
   </xsl:choose>
  </a>
 </xsl:template>

 <!-- note element -->
 <xsl:template match="note">
  <xsl:variable name="number">
   <xsl:number level="any" count="note" format="1"/>
  </xsl:variable>
  <a name="note-orig-{$number}"/>
  <a href="#note-dest-{$number}">[<xsl:value-of select="$number"/>]</a>
 </xsl:template>

 <!-- print notes -->
 <xsl:template name="notes">
  <xsl:if test="//note">
   <hr noshade="true" size="1"/>
   <font color="{$title-color}" size="+1"><b><xsl:text>Notes</xsl:text></b></font>
   <table width="100%" border="0" cellpadding="5" cellspacing="0">
    <xsl:for-each select="//note">
     <xsl:variable name="number">
      <xsl:number level="any" count="note" format="1"/>
     </xsl:variable>
     <tr>
      <td align="left" valign="top">
       <a name="note-dest-{$number}">
	<a href="#note-orig-{$number}">
	 <xsl:text>[</xsl:text>
	 <xsl:value-of select="$number"/>
	 <xsl:text>]</xsl:text>
	</a>
       </a>
      </td>
      <td align="left" valign="top" width="100%">
       <xsl:apply-templates/>
      </td>
     </tr>
    </xsl:for-each>
   </table>
  </xsl:if>
 </xsl:template>

 <!-- comment element -->
 <xsl:template match="comment">
  <xsl:if test="$draft='true' or $draft='yes'">
   <font color="{$comment-color}">
    <xsl:if test="@author">
     <b><xsl:value-of select="@author"/>:</b>&#160;
    </xsl:if>
    <xsl:apply-templates/>
   </font>
  </xsl:if>
 </xsl:template>

 <!-- version element -->
 <xsl:template match="version">
  <xsl:value-of select="$version"/>
 </xsl:template>

</xsl:stylesheet>
