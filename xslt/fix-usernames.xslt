<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--identity template copies everything forward by default-->
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>

	<!--Remove user specific access and replace them with administrator-->
	<xsl:template match="userAccess/permission/@user[. != 'administrator']">
		<xsl:attribute name="user">administrator</xsl:attribute>
	</xsl:template>

</xsl:stylesheet>
