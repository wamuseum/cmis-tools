<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--identity template copies everything forward by default-->
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>

	<!--replace the taxonomy list with a blank taxonomy containing just animalia-->
	<xsl:template match="list[@code = 'eps_taxonomy']">
		<list code="eps_taxonomy" hierarchical="1" system="0" vocabulary="1">
			<labels>
				<label locale="en_AU">
					<name>EPS Taxonomy</name>
				</label>
			</labels>
			<items>
				<item idno="eps_animalia" enabled="1" default="0" type="scientific_name">
					<labels>
						<label locale="en_AU" preferred="1">
							<name_singular>Animal</name_singular>
							<name_plural>Animals</name_plural>
						</label>
					</labels>
				</item>
			</items>
		</list>
	</xsl:template>
</xsl:stylesheet>
