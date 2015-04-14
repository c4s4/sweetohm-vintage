<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="theme.xsl"/>
 <xsl:output method="html"
             encoding="ascii"/>

 <xsl:param name="img-dir" select="'.'"/>

 <xsl:template match="/">
  <html>
   <head>
    <title>Sweetohm</title>
    <link rel="alternate" type="application/rss+xml"
          title="Sweetohm" href="http://sweetohm.net/rss.xml" />
   </head>
   <body bgcolor="{$background-color}" text="{$text-color}" 
         link="{$link-color}" vlink="{$visited-link-color}"
         marginwidth="0" marginheight="0">
    <table border="0" cellpadding="10" cellspacing="0" width="100%">
     <tr>
      <td width="{$menu-width}" bgcolor="{$menu-background-color}" 
          align="left" valign="top">
       <xsl:processing-instruction name="menu"/>
      </td>
      <td valign="top">
        <xsl:processing-instruction name="page"/>
      </td>
     </tr>
    </table>
   </body>
  </html>
 </xsl:template>

</xsl:stylesheet>
