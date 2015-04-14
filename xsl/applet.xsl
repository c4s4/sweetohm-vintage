<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

 <xsl:output method="html" encoding="ascii"/>
 <xsl:param name="java">../java</xsl:param>

 <!-- point d'entrée -->
 <xsl:template match="applet">
  <p>
   <center>
    <xsl:element name="applet">
     <xsl:attribute name="code">
      <xsl:value-of select="@code"/>
     </xsl:attribute>
     <xsl:attribute name="codebase"><xsl:value-of select="$java"/>/<xsl:value-of select="@codebase"/>
     </xsl:attribute>
     <xsl:attribute name="width">
      <xsl:value-of select="@width"/>
     </xsl:attribute>
     <xsl:attribute name="height">
      <xsl:value-of select="@height"/>
     </xsl:attribute>
     <font color="red">
      <xsl:text>
       Si vous voyez ce texte, c'est que votre navigateur n'est 
       pas compatible Java ou n'a pas été correctement configuré.
      </xsl:text>
     </font>
     <xsl:apply-templates select="param"/>
    </xsl:element>
   </center>
  </p>
 </xsl:template>

 <xsl:template match="param">
  <xsl:element name="param">
   <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
   <xsl:attribute name="value"><xsl:value-of select="@value"/></xsl:attribute>
  </xsl:element>
 </xsl:template>

</xsl:stylesheet>