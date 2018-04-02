<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="html_wrapper.xsl"/>

  <xsl:template match="/">
    <xsl:variable name='catalog_xml' select="//param[@name='catalog_xml']"/>
    <xsl:variable name='families_xml' select="//param[@name='families_xml']"/>
    <html>
      <xsl:call-template name="header"/>
      <body>
        <xsl:call-template name="menu"/>
        <div id="content">
          <xsl:apply-templates select="document($catalog_xml)//CATALOG">
            <xsl:with-param name="sort_key" select="//param[@name='sort_key']"/>
            <xsl:with-param name='families_xml' select="//param[@name='families_xml']"/>
          </xsl:apply-templates>
        </div>
      </body>
    </html>

  </xsl:template>

  <xsl:template match="CATALOG">
    <!--xsl:variable name="sort_key" select="//param[@name='sort_key']"/-->
    <xsl:param name="sort_key"/>
    <xsl:param name="families_xml"/>
    <table>
      <tr>
        <th>COMMON</th>
        <th>BOTANICAL</th>
        <th>ZONE</th>
        <th>LIGHT</th>
        <th>PRICE</th>
        <th>AVAILABILITY</th>
        <th>FAMILY</th>
      </tr>

      <xsl:apply-templates select="PLANT">
        <xsl:sort select="*[name()=$sort_key]"/>
        <xsl:with-param name="families_xml" select="$families_xml"/>
      </xsl:apply-templates>
    </table>
  </xsl:template>

  <xsl:template match="PLANT">
    <xsl:param name='families_xml'/>
    <xsl:for-each select=".">
      <tr>
        <td><xsl:value-of select="COMMON"/></td>
        <td><xsl:value-of select="BOTANICAL"/></td>
        <td><xsl:value-of select="ZONE"/></td>
        <td><xsl:value-of select="LIGHT"/></td>
        <td><xsl:value-of select="PRICE"/></td>
        <td><xsl:value-of select="AVAILABILITY"/></td>
        <xsl:variable name="botan" select="BOTANICAL"/>
        <td>
          <a>
            <xsl:attribute name="href">catalogue_par_famille.php?family=<xsl:value-of select="document($families_xml)//NAME[following-sibling::SPECIES=$botan]"/></xsl:attribute>
            <xsl:value-of select="document($families_xml)//NAME[following-sibling::SPECIES=$botan]"/>
          </a>
        </td>
        <td><a href="panier_ajouter.php?plant={COMMON}">Add</a></td>
      </tr>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
