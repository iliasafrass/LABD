<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="html_wrapper.xsl"/>

  <xsl:template match="/">
    <xsl:variable name='catalog_xml' select="//param[@name='catalog_xml']"/>
    <xsl:variable name='families_xml' select="//param[@name='families_xml']"/>
    <xsl:variable name='family' select="//param[@name='family']"/>
    <xsl:variable name="sort_key" select="//param[@name='sort_key']"/>
    <!-- attention, il ne sait pas gerer la transmission des arbres XML -->

    <html>
      <xsl:call-template name="header"/>
      <body>
        <xsl:call-template name="menu"/>
        <div id="content">
          <xsl:apply-templates select="document($families_xml)/CLASSIFICATION"
            mode="generate-select">
            <xsl:with-param name='default' select="$family"/>
          </xsl:apply-templates>

          <xsl:apply-templates select="document($catalog_xml)//CATALOG">
            <xsl:with-param name="sort_key" select="$sort_key"/>
            <xsl:with-param name="family" select="$family"/>
            <xsl:with-param name="families_xml" select="$families_xml"/>
          </xsl:apply-templates>
        </div>
      </body>
    </html>

  </xsl:template>

  <xsl:template match="CLASSIFICATION" mode="generate-select">
    <xsl:param name="default"/>
    <form>
      <b>Filtrer par Famille</b> : <select name="family" onChange="javascript:submit()">
      <option value="">Aucune</option>
      <xsl:apply-templates select="FAMILY" mode="generate-select">
        <xsl:with-param name="default" select="$default"/>
      </xsl:apply-templates>
    </select>
  </form>
</xsl:template>

<xsl:template match="FAMILY" mode="generate-select">
  <xsl:param name="default"/>
  <option value="{NAME}">
    <xsl:value-of select="NAME"/>
  </option>
</xsl:template>

<xsl:template match="CATALOG">
  <xsl:param name="sort_key"/>
  <xsl:param name="family"/>
  <xsl:param name="families_xml"/>
  <table>
    <tr>
      <th><a href="">COMMON</a></th>
      <th><a href="">BOTANICAL</a></th>
      <th><a href="">ZONE</a></th>
      <th><a href="">LIGHT</a></th>
      <th><a href="">PRICE</a></th>
      <th><a href="">AVAILABILITY</a></th>
    </tr>
    <xsl:choose>
      <xsl:when test="$family=''">
        <xsl:apply-templates select="PLANT">
          <xsl:sort select="*[name()=$sort_key]"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="PLANT[BOTANICAL=document($families_xml)//NAME[.=$family]/following-sibling::SPECIES]">
          <xsl:sort select="*[name()=$sort_key]"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </table>
</xsl:template>

<xsl:template match="PLANT">
  <tr>
    <td><xsl:value-of select="COMMON"/></td>
    <td><xsl:value-of select="BOTANICAL"/></td>
    <td><xsl:value-of select="ZONE"/></td>
    <td><xsl:value-of select="LIGHT"/></td>
    <td><xsl:value-of select="PRICE"/></td>
    <td><xsl:value-of select="AVAILABILITY"/></td>
    <td><a href="panier_ajouter.php?plant={COMMON}">Add</a></td>
  </tr>
</xsl:template>

</xsl:stylesheet>
