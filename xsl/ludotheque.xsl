<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

 <xsl:import href="theme.xsl"/>
 <xsl:import href="text.xsl"/>
 <xsl:output method="html" encoding="ascii"/>
 <xsl:param name="date">today</xsl:param>

 <!-- catch the root element of single document -->
 <xsl:template match="jeu">
  <html>
   <head>
    <title><xsl:apply-templates select="@titre" mode="filter"/></title>
   </head>
   <body bgcolor="{$background-color}" 
         text="{$text-color}" 
         link="{$link-color}" 
         vlink="{$visited-link-color}">
    <xsl:call-template name="entree"/>
   </body>
  </html>
 </xsl:template>
  
 <xsl:template match="jeu" mode="ludotheque">
  <xsl:call-template name="entree"/>
 </xsl:template>

 <xsl:template name="entree">
  <table width="100%" border="1" cellpadding="10" cellspacing="0" bgcolor="{$background-color}">
   <tr>
    <td bgcolor="{$title-color}"><font size="+3" color="{$background-color}"><b><xsl:value-of select="@note"/>/5</b></font></td>
    <td bgcolor="{$title-color}"><font size="+3" color="{$background-color}"><b><xsl:value-of select="@titre"/></b></font></td>
   </tr>
   <tr>
    <td valign="top" bgcolor="{$link-color}" width="1%"><img src="{$img-dir}/ludotheque.{@id}.png"/></td>
    <td valign="top">
     <xsl:apply-templates select="commentaire"/>
     <h3>Enfants</h3>
     <xsl:apply-templates select="enfants"/>
    </td>
   </tr>
  </table>
 </xsl:template>

 <xsl:template match="/ludotheque">
  <center>
   <h1>
    <font color="{$title-color}">
     <xsl:value-of select="forewords/title"/>
    </font>
   </h1>
  </center>
  <xsl:call-template name="forewords"/>
  <xsl:call-template name="ludotheque-toc"/>
  <xsl:call-template name="ludotheque"/>
  <xsl:call-template name="date"/>
 </xsl:template>

 <xsl:template name="forewords">
  <xsl:for-each select="forewords">
   <xsl:apply-templates/>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="ludotheque-toc">
  <p>
  <table width="100%" border="1" cellpadding="10" cellspacing="0" bgcolor="{$toc-color}">
   <tr>
    <td>
     <xsl:for-each select="jeu">
      <xsl:sort select="@date" order="ascending"/>
      <a href="#{@id}"><xsl:value-of select="@titre"/></a>
      <xsl:text>&#x00A0;</xsl:text>
      <font color="{$visited-link-color}">
       <xsl:text>(</xsl:text><xsl:value-of select="@date"/><xsl:text>)</xsl:text>
      </font>
      <xsl:if test="position() != last()"><xsl:text> -- </xsl:text></xsl:if>
     </xsl:for-each>
    </td>
   </tr>
  </table>
  </p>
 </xsl:template>

 <xsl:template name="ludotheque">
  <xsl:for-each select="jeu">
   <xsl:sort select="@date" order="ascending"/>
   <a name="{@id}">
    <p>
     <xsl:apply-templates mode="ludotheque" select="."/>
    </p>
   </a>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="date">
  <hr noshade="true" size="1"/>
  <font size="-1">
   Dernière compilation&#160;: <xsl:value-of select="$date"/>
  </font>
 </xsl:template>

</xsl:stylesheet>
