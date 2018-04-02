<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


  <xsl:param name="plant"/>

  <xsl:template match="/">
    <!-- Feuille de style � impl�menter -->
    <xsl:copy>
      <xsl:apply-templates select="BASKET"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="BASKET">
    <xsl:copy>
      <xsl:copy-of select="*"/>
      <PLANT>
        <xsl:value-of select="$plant"/>
      </PLANT>
    </xsl:copy>
    
  </xsl:template>

</xsl:stylesheet>
