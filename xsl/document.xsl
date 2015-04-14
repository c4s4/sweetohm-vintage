<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="article.xsl"/>
 <xsl:import href="page.xsl"/>
 <xsl:import href="blog-index.xsl"/>
 <xsl:output method="html"
             encoding="ascii"/>

 <!-- catch the root element -->
 <xsl:template match="/">
  <xsl:apply-templates/>
 </xsl:template>

</xsl:stylesheet>
