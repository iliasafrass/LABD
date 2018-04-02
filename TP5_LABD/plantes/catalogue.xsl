<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" encoding="UTF-8"/>

	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<body>
				<table border="1">
					<thead>
						<tr>
							<xsl:apply-templates select="//PLANT[1]/*" mode="name"/>
						</tr>
					</thead>
					<tbody>
						<xsl:apply-templates select="//PLANT">
							<xsl:sort select="COMMON" />
						</xsl:apply-templates>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>


	<xsl:template match="PLANT">
		<tr>
			<xsl:apply-templates select="*" mode="value"/>
		</tr>
	</xsl:template>

	<xsl:template match="*" mode="name">
		<td>
			<xsl:value-of select="name(.)"/>
		</td>
	</xsl:template>

	<xsl:template match="*" mode="value">
		<td>
			<xsl:value-of select="."/>
		</td>
	</xsl:template>
</xsl:stylesheet>
