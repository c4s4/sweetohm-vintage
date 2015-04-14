<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

 <xsl:import href="theme.xsl"/>
 <xsl:import href="text.xsl"/>
 <xsl:output method="html" encoding="ascii"/>
 <xsl:param name="fragment">false</xsl:param>
 <xsl:param name="entries-per-page">10</xsl:param>
 <xsl:param name="img-dir">img</xsl:param>

 <!-- catch the root element -->
 <xsl:template match="/blog">
   <xsl:apply-templates/>
 </xsl:template>

 <xsl:template match="/blogs">
  <xsl:param name="max" select="count(blog)"/>
  <xsl:param name="last-page" select="ceiling($max div $entries-per-page)"/>
  <xsl:processing-instruction name="split">file=&quot;index-1.html&quot;?</xsl:processing-instruction>
  <xsl:call-template name="site-title"/>
  <xsl:for-each select="blog">
   <xsl:sort select="@date" order="descending"/>
   <xsl:variable name="current-page" select="($max - @id + 1) div $entries-per-page"/>
   <xsl:variable name="previous-page" select="$current-page - 1"/>
   <xsl:variable name="next-page" select="$current-page + 1"/>
   <br/>
   <a name="{@id}">
    <table width="100%" border="1" cellpadding="10" cellspacing="0"
           bordercolor="#E0E0E0">
     <tr bgcolor="#FAFAFA">
      <td>
       <font size="+2">
        <font color="{$link-color}">
         <xsl:value-of select="@date"/>
        </font>
        <xsl:text> : </xsl:text>
        <font color="{$visited-link-color}">
         <xsl:value-of select="title"/>
        </font>
       </font>
       <a href="blog/{@id}.html">
        <img src="{$img-dir}/blog.png" align="right" width="24px" height="24px"/>
       </a>
      </td>
     </tr>
     <tr>
      <td>
       <xsl:apply-templates select="p[1]"/>
       <p align="right"><b><a href="blog/{@id}.html"><xsl:value-of select="title"/></a><font color="{$link-color}"> - la suite...</font></b></p>
      </td>
     </tr>
    </table>
   </a>
   <xsl:if test="($max - @id) mod $entries-per-page=($entries-per-page - 1)">
    <br/>
    <xsl:call-template name="prevnext">
     <xsl:with-param name="current-page" select="$current-page"/>
     <xsl:with-param name="previous-page" select="$previous-page"/>
     <xsl:with-param name="next-page" select="$next-page"/>
     <xsl:with-param name="last-page" select="$last-page"/>
    </xsl:call-template>
    <xsl:processing-instruction name="split">file=&quot;index-<xsl:value-of select="$current-page"/>.html&quot;?</xsl:processing-instruction>
    <xsl:processing-instruction name="split">file=&quot;index-<xsl:value-of select="$next-page"/>.html&quot;?</xsl:processing-instruction>
    <xsl:call-template name="blog-title"/>
   </xsl:if>
  </xsl:for-each>
  <xsl:processing-instruction name="split">file=&quot;index-<xsl:value-of select="$last-page"/>.html&quot;?</xsl:processing-instruction>
 </xsl:template>

 <xsl:template name="site-title">
  <center>
    <font color="{$title-color}" size="+4">
      <h1>Sweetohm</h1>
    </font>
    <img src="{$img-dir}/index.titre.png"/>
  </center>
  <br/>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
   <tr>
    <td align="left">
     <b><font color="{$title-color}" size="+4">Blog</font></b>
    </td>
    <td align="right" valign="center" colspan="2">
     <a href="rss.xml">
      <img src="{$img-dir}/rss.png" alt="Flux RSS" title="Flux RSS"/>
     </a>
    </td>
   </tr>
  </table>
 </xsl:template>

 <xsl:template name="blog-title">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
   <tr>
    <td align="left" valign="center">
     <b><font color="{$title-color}" size="+4">Blog Sweetohm</font></b>
    </td>
    <td align="right" valign="center">
     <a href="rss.xml">
      <img src="{$img-dir}/rss.png" alt="Flux RSS" title="Flux RSS"/>
     </a>
    </td>
   </tr>
  </table>
 </xsl:template>

 <xsl:template name="prevnext">
  <xsl:param name="current-page"/>
  <xsl:param name="previous-page"/>
  <xsl:param name="next-page"/>
  <xsl:param name="last-page"/>
  <table width="100%" cellpadding="0" cellspacing="0">
   <tr>
    <td align="left" width="30%">
     <xsl:if test="$current-page != 1">
      <a href="index-{$previous-page}.html"><img src="{$img-dir}/previous.png"/></a>
     </xsl:if>
    </td>
    <td align="center" valign="middle" width="40%">
     <font size="+2" color="{$title-color}">
      <b><xsl:value-of select="$current-page"/>
      /<xsl:value-of select="$last-page"/></b>
     </font>
    </td>
    <td align="right" width="30%">
     <xsl:if test="$current-page != $last-page">
      <a href="index-{$next-page}.html"><img src="{$img-dir}/next.png"/></a>
     </xsl:if>
    </td>
   </tr>
  </table>
 </xsl:template>

</xsl:stylesheet>
