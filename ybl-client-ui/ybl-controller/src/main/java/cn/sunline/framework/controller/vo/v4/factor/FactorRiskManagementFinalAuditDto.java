package cn.sunline.framework.controller.vo.v4.factor;


/**
 * 资金方风控终审
 */
public class FactorRiskManagementFinalAuditDto {

	private FactorRiskManagementAuditCooperationElementsVo cooperationElements;
	
	private FactorRiskManagementAuditHistoryVo audithistory;

	public FactorRiskManagementAuditCooperationElementsVo getCooperationElements() {
		return cooperationElements;
	}

	public void setCooperationElements(
			FactorRiskManagementAuditCooperationElementsVo cooperationElements) {
		this.cooperationElements = cooperationElements;
	}

	public FactorRiskManagementAuditHistoryVo getAudithistory() {
		return audithistory;
	}

	public void setAudithistory(FactorRiskManagementAuditHistoryVo audithistory) {
		this.audithistory = audithistory;
	}
	
	
	
}
