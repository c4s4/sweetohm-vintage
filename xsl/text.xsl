<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="blocks.xsl"/>
 <xsl:output method="html"
	     encoding="ascii"/>

 <!-- flag to number titles -->
 <xsl:variable name="numbering">yes</xsl:variable>

 <!-- catch the text element -->
 <xsl:template match="text">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- section element -->
 <xsl:template match="sect">
  <xsl:variable name="number">
   <xsl:number level="multiple" count="sect" format="1.1"/>
  </xsl:variable>
  <xsl:variable name="depth" select="count(ancestor::sect)"/>
  <xsl:if test="@level">
   <xsl:variable name="depth" select="@level"/>
  </xsl:if>
  <font color="{$title-color}">
   <xsl:element name="h{$depth+2}">
    <xsl:if test="@id">
     <a name="{@id}"/>
    </xsl:if>
    <a name="{$number}">
     <xsl:if test="$numbering='true' or $numbering='yes'">
      <xsl:value-of select="$number"/><xsl:text>-&#160;</xsl:text>
     </xsl:if>
     <xsl:apply-templates select="title" mode="print"/>
    </a>
   </xsl:element>
  </font>
  <xsl:apply-templates/>
 </xsl:template>

</xsl:stylesheet>
