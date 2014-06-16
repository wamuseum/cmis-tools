<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--identity template copies everything forward by default-->
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>
 
	<!--replace replace en_US labels-->
	<xsl:template match="setting[@name = 'label']/@locale[. = 'en_US']">
		<xsl:attribute name="locale">en_AU</xsl:attribute>
	</xsl:template>
	<xsl:template match="setting[@name = 'add_label']/@locale[. = 'en_US']">
		<xsl:attribute name="locale">en_AU</xsl:attribute>
	</xsl:template>
	<xsl:template match="label/@locale[. = 'en_US']">
		<xsl:attribute name="locale">en_AU</xsl:attribute>
	</xsl:template>

</xsl:stylesheet>
