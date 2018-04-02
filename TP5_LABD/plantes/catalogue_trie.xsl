<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="html_wrapper.xsl"/>

  <xsl:template match="/">
    <xsl:variable name='catalog_xml' select="//param[@name='catalog_xml']"/>
    <html>
      <xsl:call-template name="header"/>
      <body>
        <xsl:call-template name="menu"/>
        <div id="content">
          <xsl:apply-templates select="document($catalog_xml)//CATALOG">
            <xsl:with-param name="cle_tri" select="//param[@name='cle_tri']"/>
          </xsl:apply-templates>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="CATALOG">
    <xsl:param name="cle_tri"/>
    <table border="1">
      <tr>
        <th><a href="?cle_tri=COMMON">COMMON</a></th>
        <th><a href="?cle_tri=BOTANICAL">BOTANICAL</a></th>
        <th><a href="?cle_tri=ZONE">ZONE</a></th>
        <th><a href="?cle_tri=LIGHT">LIGHT</a></th>
        <th><a href="?cle_tri=PRICE">PRICE</a></th>
        <th><a href="?cle_tri=AVAILABILITY">AVAILABILITY</a></th>
      </tr>
      <xsl:apply-templates select="PLANT">
        <xsl:sort select="*[name(.)=$cle_tri]"/>
      </xsl:apply-templates>
    </table>
  </xsl:template>

  <xsl:template match="PLANT">
    <xsl:param name="cle_tri"/>
    <tr>
      <td><xsl:value-of select="COMMON"/></td>
      <td><xsl:value-of select="BOTANICAL"/></td>
      <td><xsl:value-of select="ZONE"/></td>
      <td><xsl:value-of select="LIGHT"/></td>
      <td><xsl:value-of select="PRICE"/></td>
      <td><xsl:value-of select="AVAILABILITY"/></td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
