<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="theme.xsl"/>
 <xsl:import href="text.xsl"/>
 <xsl:output method="html"
             encoding="ascii"/>

 <xsl:param name="numbering">yes</xsl:param>
 <xsl:param name="fragment">no</xsl:param>

 <!-- catch the root element -->
 <xsl:template match="/article">
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
      <xsl:call-template name="body">
       <xsl:with-param name="id" select="@id"/>
      </xsl:call-template>
     </body>
    </html>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="body">
     <xsl:with-param name="id" select="@id"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- print the body -->
 <xsl:template name="body">
  <xsl:param name="id"/>
  <xsl:call-template name="link-pdf">
   <xsl:with-param name="id" select="@id"/>
  </xsl:call-template>
  <xsl:call-template name="header"/>
  <xsl:call-template name="abstract"/>
  <xsl:call-template name="toc"/>
  <xsl:apply-templates select="text"/>
  <xsl:call-template name="notes"/>
  <xsl:call-template name="comments">
   <xsl:with-param name="id" select="@id"/>
  </xsl:call-template>
  <xsl:call-template name="page-date"/>
 </xsl:template>

 <!-- link to PDF version -->
 <xsl:template name="link-pdf">
  <xsl:param name="id"/>
  <xsl:if test="/article[@pdf='yes' or @pdf='true' or @pdf='' or @pdf='1']">
   <table border="0" width="100%">
    <tr align="right">
     <td valign="top" width="100%">
      <a href="../pdf/{$id}.pdf">
       <xsl:choose>
        <xsl:when test="/article[@lang='fr']">
         Version PDF
        </xsl:when>
        <xsl:otherwise>
         PDF Version
        </xsl:otherwise>
       </xsl:choose>
      </a>
      &#x00A0;
     </td>
     <td valign="top">
      <a href="../pdf/{$id}.pdf">
       <img src="../img/pdf.png"/>
      </a>
     </td>
    </tr>
   </table>
  </xsl:if>
 </xsl:template>

 <!-- print header -->
 <xsl:template name="header">
  <center>
   <h1>
    <font color="{$title-color}">
     <xsl:apply-templates select="title" mode="print"/>
    </font>
   </h1>
   <font size="-1">
    <xsl:value-of select="@author"/>
    <xsl:text>&#x00A0;-&#x00A0;</xsl:text>
    <a href="mailto:{@email}"><xsl:value-of select="@email"/></a>
   </font>
  </center>
 </xsl:template>

 <!-- print abstract -->
 <xsl:template name="abstract">
  <xsl:if test="abstract">
   <br/>
   <hr noshade="true" size="1"/>
   <font size="-1">
    <i><xsl:apply-templates select="abstract"/></i>
   </font>
   <hr noshade="true" size="1"/>
  </xsl:if>
 </xsl:template>

 <!-- print toc -->
 <xsl:template name="toc">
  <xsl:if test="not(/article[@toc='false' or @toc='no'])">
   <br/>
   <table width="100%" border="1" cellpadding="10" cellspacing="0" 
          bgcolor="{$toc-color}">
    <tr>
     <td>
      <center>
       <font color="{$title-color}">
        <h2>
        <!-- TODO: true localization -->
        <xsl:choose>
         <xsl:when test="/*[@lang='fr']">
          Table des Matières
         </xsl:when>
         <xsl:otherwise>
          Table of Contents
         </xsl:otherwise>
        </xsl:choose>
        </h2>
       </font>
      </center>
      <br/><br/>
      <xsl:for-each select="text//sect">
       <xsl:variable name="number">
        <xsl:number level="multiple" count="sect" format="1.1"/>
       </xsl:variable>
       <xsl:variable name="depth">
        <xsl:choose>
         <xsl:when test="@level">
          <xsl:value-of select="number(@level)-1"/>
         </xsl:when>
         <xsl:otherwise>
          <xsl:value-of select="count(ancestor::sect)"/>
         </xsl:otherwise>
        </xsl:choose>
       </xsl:variable>
       <!-- TODO: best implementation -->
       <xsl:choose>
        <xsl:when test="$depth=1">&#160;&#160;&#160;</xsl:when>
        <xsl:when test="$depth=2">&#160;&#160;&#160;&#160;&#160;&#160;</xsl:when>
        <xsl:when test="$depth=3">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:when>
        <xsl:when test="$depth=4">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:when>
        <xsl:when test="$depth=5">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:when>
       </xsl:choose>
       <font size="+{1-$depth}">
       <a href="#{$number}">
         <xsl:if test="$numbering='true' or $numbering='yes'">
           <xsl:value-of select="$number"/>
           <xsl:text>-&#160;</xsl:text>
         </xsl:if>
         <xsl:apply-templates select="title" mode="print"/>
       </a>
       </font>
       <br/>
      </xsl:for-each>
     </td>
    </tr>
   </table>
  </xsl:if>
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

 <xsl:template name="comments">
  <xsl:param name="id"/>
  <hr noshade="true" size="0"/>
  <!-- Disqus comments -->
  <div id="disqus_thread"></div>
  <script type="text/javascript">
   var disqus_shortname = 'sweetohm';
   var disqus_identifier = 'article-<xsl:value-of select="$id"/>';
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
