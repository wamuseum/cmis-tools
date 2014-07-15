<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--identity template copies everything forward by default-->
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>

	<!--replace the minerals list with a blank list -->
	<xsl:template match="list[@code = 'minerals']">
		<list code="minerals" hierarchical="0" system="0" vocabulary="1">
		<labels>
			<label locale="en_AU">
				<name>Minerals</name>
			</label>
		</labels>
		</list>
	</xsl:template>
</xsl:stylesheet>
