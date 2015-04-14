<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

 <xsl:import href="theme.xsl"/>
 <xsl:import href="text.xsl"/>
 <xsl:output method="html" encoding="ascii"/>
 <xsl:param name="entries-per-page">10</xsl:param>

 <!-- catch the root element -->
 <xsl:template match="/blog">
   <xsl:apply-templates/>
 </xsl:template>

 <xsl:template match="/blogs">
  <xsl:call-template name="blogs"/>
 </xsl:template>

 <xsl:template name="blogs">
  <xsl:param name="last" select="count(blog)"/>
  <xsl:for-each select="blog">
   <xsl:sort select="@date" order="descending"/>
   <xsl:variable name="current" select="@id"/>
   <xsl:variable name="previous" select="$current + 1"/>
   <xsl:variable name="next" select="$current - 1"/>
   <xsl:processing-instruction name="split">file=&quot;<xsl:value-of select="$current"/>.html&quot;?</xsl:processing-instruction>
   <xsl:call-template name="blog-title">
    <xsl:with-param name="current" select="$current"/>
    <xsl:with-param name="last" select="$last"/>
   </xsl:call-template>
   <br/>
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
     </td>
    </tr>
    <tr>
     <td>
      <xsl:apply-templates/>
     </td>
    </tr>
    <tr>
     <td>
      <xsl:call-template name="comments">
       <xsl:with-param name="id" select="@id"/>
      </xsl:call-template>
     </td>
    </tr>
   </table>
   <br/>
   <xsl:call-template name="prevnext">
    <xsl:with-param name="current-page" select="$current"/>
    <xsl:with-param name="previous-page" select="$previous"/>
    <xsl:with-param name="next-page" select="$next"/>
    <xsl:with-param name="last-page" select="$last"/>
   </xsl:call-template>
   <xsl:processing-instruction name="split">file=&quot;<xsl:value-of select="$current"/>.html&quot;?</xsl:processing-instruction>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="blog-title">                                               
  <xsl:param name="current"/>
  <xsl:param name="last"/>
  <xsl:param name="index" select="floor((($last - $current) div $entries-per-page)) + 1"/>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
   <tr>
    <td align="left" valign="center">
     <b><font color="{$title-color}" size="+4">Blog Sweetohm</font></b>
    </td>
    <td align="right" valign="center">
     <a href="../index-{$index}.html">
      <img src="../img/up.png" alt="Index" title="Index"/>
     </a>
     <xsl:text> </xsl:text>
     <a href="../rss.xml">
      <img src="../img/rss.png" alt="Flux RSS" title="Flux RSS"/>
     </a>
    </td>
   </tr>
  </table>
 </xsl:template>

 <xsl:template name="comments">
  <xsl:param name="id"/>
  <!-- Disqus comments -->
  <div id="disqus_thread"></div>
  <script type="text/javascript">
   var disqus_shortname = 'sweetohm';
   var disqus_identifier = 'blog-<xsl:value-of select="$id"/>';
   var disqus_url = 'http://sweetohm.net/blog/<xsl:value-of select="$id"/>.html';
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

 <xsl:template name="prevnext">
  <xsl:param name="current-page"/>
  <xsl:param name="previous-page"/>
  <xsl:param name="next-page"/>
  <xsl:param name="last-page"/>
  <table width="100%" cellpadding="0" cellspacing="0">
   <tr>
    <td align="left" width="30%">
     <xsl:if test="$current-page != $last-page">
      <a href="{$previous-page}.html"><img src="../img/previous.png"/></a>
     </xsl:if>
    </td>
    <td align="center" valign="middle" width="40%">
     <font size="+2" color="{$title-color}">
      <b><xsl:value-of select="$current-page"/>
      /<xsl:value-of select="$last-page"/></b>
     </font>
    </td>
    <td align="right" width="30%">
     <xsl:if test="$current-page != 1">
      <a href="{$next-page}.html"><img src="../img/next.png"/></a>
     </xsl:if>
    </td>
   </tr>
  </table>
 </xsl:template>

</xsl:stylesheet>
