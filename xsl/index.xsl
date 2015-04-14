<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

 <xsl:import href="theme.xsl"/>
 <xsl:import href="text.xsl"/>
 <xsl:output method="html" encoding="ascii"/>

 <xsl:param name="date">today</xsl:param>
 <xsl:param name="lang"/>
 <xsl:param name="limit">0000-01-01</xsl:param>

 <xsl:template match="/index">
  <xsl:apply-templates select="forewords"/>
  <table border="0" cellpadding="10" cellspacing="0">
   <tr>
    <td valign="top" width="50%">
     <xsl:call-template name="news"/>
    </td>
    <td valign="top" width="50%">
     <xsl:call-template name="links"/>
    </td>
   </tr>
  </table>
  <xsl:call-template name="date"/>
 </xsl:template>

 <xsl:template match="forewords">
  <center><h1>
    <font color="{$title-color}">
     <xsl:value-of select="title"/>
    </font>
   </h1></center>
  <xsl:apply-templates/>
 </xsl:template>

 <xsl:template name="news">
  <p>
   <font size="+1" color="{$title-color}">
    <xsl:choose>
     <xsl:when test="$lang='fr'">
      Nouveautés :
     </xsl:when>
     <xsl:otherwise>
      News:
     </xsl:otherwise>
    </xsl:choose>
   </font>
  </p>
  <xsl:for-each select="news">
   <xsl:sort select="@date" order="descending"/>
   <xsl:call-template name="index-item"/>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="links">
  <p>
   <font size="+1" color="{$title-color}">
    <xsl:choose>
     <xsl:when test="$lang='fr'">
      Liens :
     </xsl:when>
     <xsl:otherwise>
      Links:
     </xsl:otherwise>
    </xsl:choose>
   </font>
  </p>
  <xsl:for-each select="links">
   <xsl:sort select="@date" order="descending"/>
   <xsl:call-template name="index-item"/>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="index-item">
  <xsl:if test="number(substring(@date,1,4))>=number(substring($limit,1,4))">
   <xsl:if test="number(substring(@date,6,2))>=number(substring($limit,6,2))">
    <xsl:if test="number(substring(@date,9,2))>=number(substring($limit,9,2))">
     <font color="{$link-color}"><xsl:value-of select="@date"/></font>
     <xsl:text> : </xsl:text>
     <a href="{@url}"><xsl:value-of select="title"/></a>
     <br/>
     <xsl:apply-templates/>
    </xsl:if>
   </xsl:if>
  </xsl:if>
 </xsl:template>

 <xsl:template name="date">
  <hr noshade="true" size="1"/>
  <font size="-1">
   Dernière compilation&#160;: <xsl:value-of select="$date"/>
  </font>
 </xsl:template>

</xsl:stylesheet>
