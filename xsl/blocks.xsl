<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="words.xsl"/>
 <xsl:output method="html"
             encoding="ascii"/>
 <xsl:preserve-space elements="source"/>

 <!-- paragraph element -->
 <xsl:template match="p">
  <p><xsl:apply-templates/></p>
 </xsl:template>
 
 <!-- list element -->
 <xsl:template match="list">
  <ul><xsl:apply-templates/></ul>
 </xsl:template>

 <!-- enumeration element -->
 <xsl:template match="enum">
  <ol><xsl:apply-templates/></ol>
 </xsl:template>

 <!-- item element -->
 <xsl:template match="item">
  <li><xsl:apply-templates/></li>
 </xsl:template>

 <!-- table element -->
 <xsl:template match="table">
  <xsl:choose>
   <xsl:when test="@id">
    <a name="{@id}"><xsl:call-template name="print-table"/></a>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="print-table"/>
   </xsl:otherwise>
  </xsl:choose>
  <xsl:if test="title">
   <center>
    <xsl:variable name="index" select="count(preceding::table)+1"/>
    <br/>
    <xsl:text>Table&#160;</xsl:text><xsl:value-of select="$index"/><xsl:text>:&#160;</xsl:text><xsl:apply-templates select="title" mode="print"/>
   </center>  
  </xsl:if>
 </xsl:template>

 <!-- print the table -->
 <xsl:template name="print-table">
  <center>
   <table border="1" cellpadding="10" cellspacing="0">
    <xsl:apply-templates/>
   </table>
  </center>
 </xsl:template>

 <!-- table header element -->
 <xsl:template match="th">
  <tr bgcolor="{$table-header-bg-color}"><xsl:apply-templates/></tr>
 </xsl:template>

 <!-- line element -->
 <xsl:template match="li">
  <tr><xsl:apply-templates/></tr>
 </xsl:template>

 <!-- column element -->
 <xsl:template match="co">
  <xsl:choose>
   <xsl:when test="parent::th">
    <td align="left" valign="top"><font color="{$table-header-color}"><b><xsl:apply-templates/></b></font></td>
   </xsl:when>
   <xsl:otherwise>
    <xsl:choose>
     <xsl:when test="count(parent::li/preceding-sibling::li) mod 2=0">
      <td bgcolor="{$table-bg-color1}" align="left" valign="top"><font color="{$table-color}"><xsl:apply-templates/></font></td>
     </xsl:when>
     <xsl:otherwise>
      <td bgcolor="{$table-bg-color2}" align="left" valign="top"><font color="{$table-color}"><xsl:apply-templates/></font></td>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- source element -->
 <xsl:template match="source">
  <xsl:if test="@file">
   <font color="{$source-color}">
    <i><u><xsl:value-of select="@file"/></u></i>
   </font>
  </xsl:if>
  <xsl:choose>
   <xsl:when test="@id">
    <a name="{@id}"><xsl:call-template name="print-source"/></a>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="print-source"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- print the source -->
 <xsl:template name="print-source">
  <!--<blockquote>-->
   <table width="100%" border="0" cellpadding="10">
    <tr>
     <td bgcolor="{$source-background-color}">
      <font color="{$source-color}">
       <pre>
        <xsl:apply-templates/>
       </pre>
      </font>
     </td>
    </tr>
   </table>
  <!--</blockquote>-->
 </xsl:template>

 <!-- frame element -->
 <xsl:template match="frame">
  <xsl:choose>
   <xsl:when test="@id">
    <a name="{@id}"><xsl:call-template name="print-frame"/></a>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="print-frame"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- print the frame -->
 <xsl:template name="print-frame">
  <center>
   <table width="100%" border="1" cellpadding="10" cellspacing="0">
    <tr>
     <td>
      <xsl:if test="title">
       <center>
	<font size="+2"><i><b><xsl:apply-templates select="title" mode="print"/></b></i></font>
       </center>
       <br/>
      </xsl:if>
      <xsl:apply-templates/>
     </td>
    </tr>
   </table>
  </center>
 </xsl:template>

 <!-- image element -->
 <xsl:template match="figure">
  <p>
   <center>
    <xsl:choose>
     <xsl:when test="@id">
      <xsl:choose>
       <xsl:when test="@link">
        <a name="{@id}" href="{@link}"><img src="{$img-dir}/{@url}" vspace="10" hspace="10"/></a>
       </xsl:when>
       <xsl:otherwise>
        <a name="{@id}"><img src="{$img-dir}/{@url}" vspace="10" hspace="10"/></a>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:when>
     <xsl:otherwise>
      <xsl:choose>
       <xsl:when test="@link">
        <a href="{@link}"><img src="{$img-dir}/{@url}" vspace="10" hspace="10"/></a>
       </xsl:when>
       <xsl:otherwise>
        <img src="{$img-dir}/{@url}" vspace="10" hspace="10"/>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="title">
     <xsl:variable name="index" select="count(preceding::figure)+1"/>
     <br/>
     <font color="{$title-color}">
      <xsl:text>Figure&#160;</xsl:text><xsl:value-of select="$index"/><xsl:text>:&#160;</xsl:text><xsl:apply-templates select="title" mode="print"/>
     </font>
    </xsl:if>
   </center>
  </p>
 </xsl:template>

 <!-- title element for printing -->
 <xsl:template match="title" mode="print">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- title element for filtering -->
 <xsl:template match="title"/>

 <!-- any element to filter -->
 <xsl:template match="*" mode="filter">
  <xsl:apply-templates mode="filter"/>
 </xsl:template>

</xsl:stylesheet>
