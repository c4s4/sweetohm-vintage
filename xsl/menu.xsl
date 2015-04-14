<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="theme.xsl"/>
 <xsl:output method="html"/>
 
 <xsl:param name="root"/>
 <xsl:param name="html"/>
 <xsl:param name="img"/>
 <xsl:param name="lang"/>

 <!-- build the header and footer of the menu -->
 <xsl:template match="menu">
  <font size="-1">
   <!-- flags -->
   <table border="0" width="100%" cellpadding="0">
    <tr>
     <td align="left">
      <a href="{$root}/index.html">
       <img src="{$img}/{$image-flag-fr}" border="0"/>
      </a>
     </td>
     <td align="right">
      <a href="{$root}/index.en.html">
       <img src="{$img}/{$image-flag-en}" border="0"/>
      </a>
     </td>
    </tr>
   </table>
   <hr/>
   <table border="0" width="100%" cellpadding="0">
    <tr>
     <td align="left">
      <font color="{$link-color}">
       <xsl:choose>
        <xsl:when test="$lang='fr'">
	     Home page de<br/>
	     <a href="mailto:casa@sweetohm.net">
	     Michel Casabianca
         </a>
        </xsl:when>
        <xsl:otherwise>
         <a href="mailto:casa@sweetohm.net">Michel Casabianca</a>
         Home Page<br/>
        </xsl:otherwise>
       </xsl:choose>
      </font>
     </td>
    </tr>
   </table>
   <hr/>
   <!-- build submenus -->
   <xsl:apply-templates/>
   <hr/>
   <xsl:call-template name="logos" />
  </font>
 </xsl:template>

 <xsl:template match="submenu">
  <table border="0" width="100%" cellpadding="5" cellspacing="0">
   <tr>
    <td align="center" bgcolor="{$menu-sub-color}">
     <font color="{$background-color}">
      <strong><xsl:value-of select="@title"/></strong>
     </font>
    </td>
   </tr>
   <tr>
    <td bgcolor="{$background-color}">
     <table border="0" width="100%" cellpadding="3" cellspacing="0">
      <xsl:for-each select="menuitem">
       <tr>
	<td align="left" valign="top" width="0%">
	 <img src="{$img}/{$image-puce}" border="0" alt="o"/>
	</td>
	<td align="left" valign="top">
      <xsl:choose>
        <xsl:when test="starts-with(@url, 'http:')">
          <a href="{@url}"><xsl:value-of select="@title"/></a><br/>
        </xsl:when>
        <xsl:otherwise>
          <a href="{$html}/{@url}"><xsl:value-of select="@title"/></a><br/>
        </xsl:otherwise>
      </xsl:choose>
	</td>
       </tr>
      </xsl:for-each>
     </table>
    </td>
   </tr>
  </table>
  <br/>
 </xsl:template>

 <xsl:template match="menuimage">
  <center>
   <img src="{$img}/{@url}" border="0"/>
  </center>
 </xsl:template>

 <xsl:template match="menuseparator">
  <hr/>
 </xsl:template>

 <xsl:template name="logos">
  <center>
   <h2>Powered by</h2>
   <a href="http://www.debian.org">
    <img src="{$img}/menu.debian.png" 
         alt="Powered by Debian"
         border="0"/>
   </a>
  </center>
 </xsl:template>
  
</xsl:stylesheet>
