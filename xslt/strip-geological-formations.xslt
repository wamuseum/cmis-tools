<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--identity template copies everything forward by default-->
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>

	<!--replace the taxonomy list with a blank taxonomy containing just animalia-->
	<xsl:template match="list[@code = 'geological_formation']">
		<list code="geological_formation" hierarchical="0" system="0" vocabulary="1">
		<labels>
			<label locale="en_AU">
				<name>Geological Formation</name>
			</label>
		</labels>
		</list>
	</xsl:template>
</xsl:stylesheet>
