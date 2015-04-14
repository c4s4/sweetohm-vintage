<?xml version="1.0" encoding="utf-8"?>

<!--

Exemple de flux RSS :

<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
    <channel>
        <title>Mon site</title>
        <description>Ceci est un exemple de flux RSS 2.0</description>
        <lastBuildDate>Sat, 07 Sep 2002 00:00:01 GMT</lastBuildDate>
        <link>http://www.example.org</link>
        <item>
            <title>Actualité N°1</title>
            <description>Ceci est ma première actualité</description>
            <pubDate>Sat, 07 Sep 2002 00:00:01 GMT</pubDate>
            <link>http://www.example.org/actu1</link>
        </item>
        <item>
            <title>Actualité N°2</title>
            <description>Ceci est ma seconde actualité</description>
            <pubDate>Sat, 07 Sep 2002 00:00:01 GMT</pubDate>
            <link>http://www.example.org/actu2</link>
        </item>
    </channel>
</rss>

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

 <xsl:output method="xml" encoding="utf-8"/>
 <xsl:param name="date"/>

 <!-- catch the root element -->
 <xsl:template match="/blog">
   <xsl:apply-templates/>
</xsl:template>

 <xsl:template match="/blogs">
  <xsl:call-template name="blogs"/>
 </xsl:template>

 <xsl:template name="blogs">
  <rss version="2.0">
   <channel>
    <title>Sweetohm</title>
    <description>Blog de Michel Casabianca</description>
    <lastBuildDate><xsl:value-of select="$date"/></lastBuildDate>
    <link>http://www.sweetohm.net/blog/index.html</link>
    <xsl:for-each select="blog">
    <xsl:sort select="@date" order="descending"/>
    <item>
     <title><xsl:value-of select="title"/></title>
     <description><xsl:value-of select="p[1]"/></description>
     <pubDate><xsl:value-of select="@date"/></pubDate>
     <link>http://www.sweetohm.net/blog/<xsl:value-of select="@id"/>.html</link>
    </item>
   </xsl:for-each>
   </channel>
  </rss>
 </xsl:template>

</xsl:stylesheet>
