<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!-- Color definitions -->
 <xsl:param name="white">#FFFFFF</xsl:param>
 <xsl:param name="black">#000000</xsl:param>
 <xsl:param name="green">#00D0A0</xsl:param>
 <xsl:param name="blue">#0090D0</xsl:param>
 <xsl:param name="red">#FF0000</xsl:param>
 <xsl:param name="light-green">#E0FFE0</xsl:param>
 <xsl:param name="light-blue">#E0E0FF</xsl:param>
 <xsl:param name="dark-green">#00A070</xsl:param>
 <xsl:param name="lighter-green">#F0FFF0</xsl:param>
 <xsl:param name="gray">#707070</xsl:param>
 <xsl:param name="light-gray">#F0F0F0</xsl:param>
 <xsl:param name="light-blue">#EDF3FE</xsl:param>
 <xsl:param name="light-yellow">#FFFFFA</xsl:param>

 <!-- Parameter definition for themes -->
 <xsl:param name="menu-width">200</xsl:param>
 <xsl:param name="image-cafebabe">menu.cafebabe.png</xsl:param>
 <xsl:param name="image-sweetohm">menu.sweetohm.png</xsl:param>
 <xsl:param name="image-flag-fr">menu.fr.png</xsl:param>
 <xsl:param name="image-flag-en">menu.en.png</xsl:param>
 <xsl:param name="image-puce">menu.puce.png</xsl:param>
 <xsl:param name="background-color"><xsl:value-of select="$white"/></xsl:param>
 <xsl:param name="text-color"><xsl:value-of select="$black"/></xsl:param>
 <xsl:param name="title-color"><xsl:value-of select="$blue"/></xsl:param>
 <xsl:param name="link-color"><xsl:value-of select="$green"/></xsl:param>
 <xsl:param name="visited-link-color"><xsl:value-of select="$blue"/></xsl:param>
 <xsl:param name="comment-color"><xsl:value-of select="$red"/></xsl:param>
 <xsl:param name="toc-color"><xsl:value-of select="$lighter-green"/></xsl:param>
 <xsl:param name="table-color"><xsl:value-of select="$black"/></xsl:param>
 <xsl:param name="table-bg-color1"><xsl:value-of select="$light-green"/></xsl:param>
 <xsl:param name="table-bg-color2"><xsl:value-of select="$light-blue"/></xsl:param>
 <xsl:param name="table-header-color"><xsl:value-of select="$white"/></xsl:param>
 <xsl:param name="table-header-bg-color"><xsl:value-of select="$blue"/></xsl:param>
 <xsl:param name="source-color"><xsl:value-of select="$dark-green"/></xsl:param>
 <xsl:param name="source-background-color"><xsl:value-of select="$light-blue"/></xsl:param>
 <xsl:param name="menu-background-color"><xsl:value-of select="$blue"/></xsl:param>
 <xsl:param name="menu-sub-color"><xsl:value-of select="$green"/></xsl:param>

</xsl:stylesheet>
