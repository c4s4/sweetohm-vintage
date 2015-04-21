<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="theme.xsl"/>
 <xsl:import href="text.xsl"/>
 <xsl:import href="applet.xsl"/>

 <xsl:output method="html" encoding="ascii"/>

 <xsl:param name="numbering">yes</xsl:param>
 <xsl:param name="fragment">no</xsl:param>

 <!-- catch the root element -->
 <xsl:template match="/page">
  <xsl:choose>
   <xsl:when test="part">
    <xsl:call-template name="part">
     <xsl:with-param name="id" select="@id"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="page">
     <xsl:with-param name="id" select="@id"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- build a part -->
 <xsl:template name="part">
  <xsl:param name="id"/>
  <xsl:for-each select="part">
   <xsl:call-template name="split"/>
   <xsl:call-template name="page">
    <xsl:with-param name="id" select="$id"/>
   </xsl:call-template>
   <xsl:call-template name="split"/>
  </xsl:for-each>
 </xsl:template>

 <!-- build a page -->
 <xsl:template name="page">
  <xsl:param name="id"/>
  <xsl:call-template name="params"/>
  <xsl:choose>
   <xsl:when test="$fragment='no'">
    <html>
     <head>
      <title><xsl:apply-templates select="title" mode="filter"/></title>
     </head>
     <body bgcolor="{$background-color}" 
           text="{$text-color}" 
           link="{$link-color}" 
           vlink="{$visited-link-color}">
      <xsl:call-template name="body-page">
       <xsl:with-param name="id" select="$id"/>
      </xsl:call-template>
     </body>
    </html>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="body-page">
     <xsl:with-param name="id" select="$id"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- print parameters -->
 <xsl:template name="params">
  <xsl:comment>
###PARAMS###
id:       <xsl:value-of select="@id"/>
date:     <xsl:value-of select="@date"/>
author:   <xsl:value-of select="@author"/>
email:    <xsl:value-of select="@email"/>
keywords: <xsl:value-of select="@keywords"/>
lang:     <xsl:value-of select="@lang"/>
title:    <xsl:value-of select="title"/>
  </xsl:comment>
 </xsl:template>

 <!-- print the body -->
 <xsl:template name="body-page">
  <xsl:param name="id"/>
  <xsl:call-template name="header-page"/>
  <xsl:apply-templates select="text"/>
  <xsl:call-template name="page-notes"/>
  <xsl:call-template name="footer-page">
   <xsl:with-param name="id" select="$id"/>
  </xsl:call-template>
 </xsl:template>

 <!-- print header -->
 <xsl:template name="header-page">
  <xsl:choose>
   <xsl:when test="/page/part">
    <xsl:call-template name="page-links"/>
    <hr noshade="true" size="1"/>
    <center>
     <h1>
      <font color="{$title-color}">
       <xsl:apply-templates select="../title" mode="print"/>
       <xsl:text>&#x00A0;-&#x00A0;</xsl:text>
       <xsl:value-of select="title"/>
      </font>
     </h1>
    </center>
   </xsl:when>
   <xsl:otherwise>
    <center>
     <h1>
      <font color="{$title-color}">
       <xsl:apply-templates select="title" mode="print"/>
      </font>
     </h1>
    </center>
   </xsl:otherwise>
  </xsl:choose>
  <center>
   <font size="-1">
    <xsl:value-of select="..//@author"/>
    <xsl:text>&#x00A0;-&#x00A0;</xsl:text>
    <a href="mailto:{..//@email}"><xsl:value-of select="..//@email"/></a>
   </font>
  </center>
  <br/>
 </xsl:template>

 <!-- generate notes -->
 <xsl:template name="page-notes">
  <xsl:if test="//note">
   <hr noshade="true" size="1"/>
   <font color="{$title-color}" size="+1"><b><xsl:text>Notes</xsl:text></b></font>
   <table width="100%" border="0" cellpadding="5" cellspacing="0">
    <xsl:for-each select=".//note">
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

 <!-- generate page footer -->
 <xsl:template name="footer-page">
  <xsl:param name="id"/>
  <xsl:if test="/page/part">
   <hr noshade="true" size="1"/>
   <xsl:call-template name="page-links"/>
  </xsl:if>
  <xsl:call-template name="comments">
   <xsl:with-param name="id" select="$id"/>
  </xsl:call-template>
  <xsl:call-template name="page-date"/>
 </xsl:template>

 <!-- print links to other parts -->
 <xsl:template name="page-links">
  <center>
   <xsl:for-each select="../part">
    <xsl:choose>
     <xsl:when test="position()=1">
      <a href="{concat(../@id,'.html')}">
       <xsl:value-of select="title"/>
      </a>
     </xsl:when>
     <xsl:otherwise>
      <a href="{concat(../@id,'.',@file,'.html')}">
       <xsl:value-of select="title"/>
      </a>
     </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="not(position()=last())">
     <xsl:text>&#160;| </xsl:text>
    </xsl:if>
   </xsl:for-each>
  </center>
 </xsl:template>

 <!-- print date -->
 <xsl:template name="page-date">
  <hr noshade="true" size="0"/>
  <font size="-1">
   <!-- TODO: true localization -->
   <xsl:choose>
    <xsl:when test="/*[@lang='fr']">
     Dernière mise à jour&#160;:&#160;
    </xsl:when>
    <xsl:otherwise>
     Last update:&#160;
    </xsl:otherwise>
   </xsl:choose>
   <xsl:value-of select="..//@date"/>
  </font>
 </xsl:template>

 <!-- generate PI to split files -->
 <xsl:template name="split">
  <xsl:choose>
   <xsl:when test="position()=1">
    <xsl:processing-instruction name="split">file=&quot;<xsl:value-of select="../@id"/>.html&quot;?</xsl:processing-instruction>
   </xsl:when>
   <xsl:otherwise>
    <xsl:processing-instruction name="split">file=&quot;<xsl:value-of select="../@id"/>.<xsl:value-of select="@file"/>.html&quot;?</xsl:processing-instruction>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="comments">
  <xsl:param name="id"/>
  <hr noshade="true" size="0"/>
  <!-- Disqus comments -->
  <div id="disqus_thread"></div>
  <script type="text/javascript">
   var disqus_shortname = 'sweetohm';
   var disqus_identifier = 'page-<xsl:value-of select="$id"/>';
   var disqus_url = 'http://sweetohm.net/html/<xsl:value-of select="$id"/>.html';
   (function() {
     var dsq = document.createElement('script');
     dsq.type = 'text/javascript';
     dsq.async = true;
     dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
     (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
   })();
  </script>
  <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
 </xsl:template>

</xsl:stylesheet>
