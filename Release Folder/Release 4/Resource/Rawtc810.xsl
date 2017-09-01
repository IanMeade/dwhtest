<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:db="http://deutsche-boerse.com/dbag/app/open/xetra">
	<xsl:output method="xml"/>
	<xsl:template match="/">
		<trades>
			<xsl:for-each select="//db:tc810Rec">
				<trade>
					<xsl:attribute name="REPORT_ID"><xsl:value-of select="../../../db:rptHdr/db:rptCod"/></xsl:attribute>
					<xsl:attribute name="REPORT_EFF_DATE"><xsl:value-of select="../../../db:rptHdr/db:rptPrntEffDat"/></xsl:attribute>
					<xsl:attribute name="REPORT_PROCESS_DATE"><xsl:value-of select="../../../db:rptHdr/db:rptPrntRunDat"/></xsl:attribute>
					<xsl:attribute name="ENV_ONE">5</xsl:attribute>
					<xsl:attribute name="ENV_TWO">1</xsl:attribute>
					<xsl:attribute name="CLRMEM_ID"><xsl:value-of select="../../db:tc810KeyGrp/db:membClgIdCod"/></xsl:attribute>
					<xsl:attribute name="CLRMEM_SETTLE_LOC"><xsl:value-of select="../../db:tc810KeyGrp/db:stlIdLoc"/></xsl:attribute>
					<xsl:attribute name="CLRMEM_SETTLE_ACC"><xsl:value-of select="../../db:tc810KeyGrp/db:stlIdAct"/></xsl:attribute>				
					<xsl:attribute name="EXCHMEMB_ID"><xsl:value-of select="../../db:tc810KeyGrp/db:membCcpClgIdCod"/></xsl:attribute>
					<xsl:attribute name="OWNER_EXMEMB_INST_ID"><xsl:value-of select="substring(../../db:tc810KeyGrp/db:membClgIdCod,1,3)"/></xsl:attribute>
					<xsl:attribute name="OWNER_EXMEMB_BR_ID"><xsl:value-of select="substring(../../db:tc810KeyGrp/db:membClgIdCod,4,2)"/></xsl:attribute>
					<xsl:attribute name="INSTRU_ISIN"><xsl:value-of select="db:isinCod"/></xsl:attribute>
					<xsl:attribute name="UNITS"><xsl:value-of select="../../db:tc810KeyGrp/db:cntcUnt"/></xsl:attribute>
					<xsl:attribute name="TRANS_TIME"><xsl:value-of select="translate(translate(db:tranTim,'.',''),':','')"/></xsl:attribute>
					<xsl:attribute name="PARTA_SUBGRP_ID"><xsl:value-of select="substring(../db:tc810KeyGrp1/db:partIdCod,1,3)"/></xsl:attribute>
					<xsl:attribute name="PARTA_USR_NO"><xsl:value-of select="substring(../db:tc810KeyGrp1/db:partIdCod,4,3)"/></xsl:attribute>
					<xsl:attribute name="UNIQ_TRADE_NO"><xsl:value-of select="db:tranIdNo"/></xsl:attribute>
					<xsl:attribute name="TRADE_NO_SUFX"><xsl:value-of select="db:tranIdSfxNo"/></xsl:attribute>
					<xsl:attribute name="TRANS_TYPE"><xsl:value-of select="db:tranTypCod"/></xsl:attribute>
					<xsl:attribute name="ORIGIN_TYPE"><xsl:value-of select="db:typOrig"/></xsl:attribute>
					<xsl:attribute name="CROSS_IND"><xsl:value-of select="db:typOrig"/></xsl:attribute>
					<xsl:attribute name="SETTLE_IND"><xsl:value-of select="db:setlmCod"/></xsl:attribute>
					<xsl:attribute name="OTC_TRADE_TIME"><xsl:value-of select="translate(translate(db:otcEntTim,'.',''),':','')"/></xsl:attribute>
					<xsl:attribute name="ORDER_INSTR_ISIN"><xsl:value-of select="db:isinCod"/></xsl:attribute>
					<xsl:attribute name="ORD_NO"><xsl:value-of select="db:ordrNo"/></xsl:attribute>
					<xsl:attribute name="EXECUTOR_ID"><xsl:value-of select="db:bestExrMembIdCod"/></xsl:attribute>
					<xsl:attribute name="INTERMEM_ORD_NO"><xsl:value-of select="db:usrOrdrNum"/></xsl:attribute>
					<xsl:attribute name="FREE"><xsl:value-of select="db:text"/></xsl:attribute>
					<xsl:attribute name="ACC_TYPE_CODE"><xsl:value-of select="substring(db:acctTypCodGrp,1,1)"/></xsl:attribute>
					<xsl:attribute name="ACC_TYPE_NO"><xsl:value-of select="substring(db:acctTypCodGrp,2,1)"/></xsl:attribute>
					<xsl:attribute name="BUY_SELL_IND"><xsl:value-of select="db:ordrBuyCod"/></xsl:attribute>
					<xsl:attribute name="NETTING_TYPE"><xsl:value-of select="db:netTypCod"/></xsl:attribute>
					<xsl:attribute name="MATCHED_QTY"><xsl:value-of select="translate(db:tradMtchQty,'+','')"/></xsl:attribute>
					<xsl:attribute name="MATCHED_PRICE"><xsl:value-of select="db:tradMtchPrc"/></xsl:attribute>
					<xsl:attribute name="SETTLE_AMOUNT"><xsl:value-of select="translate(db:stlAmnt,'+','')"/></xsl:attribute>
					<xsl:attribute name="SETTLE_DATE"><xsl:value-of select="db:stlDate"/></xsl:attribute>
					<xsl:attribute name="SETTLE_CODE"><xsl:value-of select="db:setlTypCod"/></xsl:attribute>
					<xsl:attribute name="ACCRUED_INTEREST"><xsl:value-of select="db:bonAcrInt"/></xsl:attribute>
					<xsl:attribute name="ACCRUED_INTEREST_DAY"><xsl:value-of select="db:bonAcrIntDay"/></xsl:attribute>
					<xsl:attribute name="EXCHMEM_INST_ID"><xsl:value-of select="substring(db:membExcIdCodOboMs,1,3)"/></xsl:attribute>
					<xsl:attribute name="EXCHMEM_BR_ID"><xsl:value-of select="substring(db:membExcIdCodOboMs,4,2)"/></xsl:attribute>
					<xsl:attribute name="PART_USR_GRP_ID"><xsl:value-of select="substring(db:partIdCodOboMs,1,3)"/></xsl:attribute>
					<xsl:attribute name="PART_USR_NO"><xsl:value-of select="substring(db:partIdCodOboMs,4,3)"/></xsl:attribute>
					<xsl:attribute name="COUNTER_EXCHMEM_ID"><xsl:value-of select="substring(db:membCtpyIdCod,1,3)"/></xsl:attribute>
					<xsl:attribute name="COUNTER_EXCHMEM_BR_ID"><xsl:value-of select="substring(db:membCtpyIdCod,4,2)"/></xsl:attribute>
					<xsl:attribute name="COUNTER_CRL_SET_MEM_ID"></xsl:attribute>
					<xsl:attribute name="COUNTER_SETL_LOC"><xsl:value-of select="db:ctpyStlIdLoc"/></xsl:attribute>
					<xsl:attribute name="COUNTER_SETL_ACC"><xsl:value-of select="db:ctpyStlIdAct"/></xsl:attribute>
					<xsl:attribute name="COUNTER_KASSEN_NO"><xsl:value-of select="db:dwzNo"/></xsl:attribute>
					<xsl:attribute name="DEPOSITORY_TYPE"><xsl:value-of select="db:kindOfDepo"/></xsl:attribute>
					<xsl:attribute name="TRANS_FEE"><xsl:value-of select="translate(db:feeAmt,'+','')"/></xsl:attribute>
					<xsl:attribute name="TRANS_FEE_CURRENCY"><xsl:value-of select="db:feesCurrTypCod"/></xsl:attribute>
				</trade>
			</xsl:for-each>
		</trades>
	</xsl:template>
</xsl:stylesheet>
