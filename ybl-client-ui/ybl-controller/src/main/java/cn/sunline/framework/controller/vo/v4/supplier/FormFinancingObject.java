package cn.sunline.framework.controller.vo.v4.supplier;

import java.util.ArrayList;
import java.util.List;

import cn.sunline.framework.controller.vo.AttachmentVo;

/**
 * 融资申请表单list合集
 * @author liuls
 *
 */
public class FormFinancingObject{

	/*企业借款*/
	List<LoanDebtSituationVO> enterpriseLoanList = new ArrayList<LoanDebtSituationVO>();
	/*个人负债*/
	List<LoanDebtSituationVO> personDebtList = new ArrayList<LoanDebtSituationVO>();
	/*对外担保*/
	List<ExternalGuaranteeSituationVO> guaranteeList = new ArrayList<ExternalGuaranteeSituationVO>();
	/*应收账款*/
	List<AccountsReceivableV4VO> receivableList = new ArrayList<AccountsReceivableV4VO>();
	/*应付账款*/
	List<AccountsPayableVO> repayableList = new ArrayList<AccountsPayableVO>();
	/*资料清单列表*/
	List<AttachmentVo> dataAttachmentList = new ArrayList<AttachmentVo>();
	/*补充资料列表*/
	List<AttachmentVo> rejectList = new ArrayList<AttachmentVo>();
	/*底层资产附件列表*/
	List<AttachmentVo> assetList = new ArrayList<AttachmentVo>();
	/*票据*/
	List<BillVO> billList = new ArrayList<BillVO>();
	public List<LoanDebtSituationVO> getEnterpriseLoanList() {
		return enterpriseLoanList;
	}
	public void setEnterpriseLoanList(List<LoanDebtSituationVO> enterpriseLoanList) {
		this.enterpriseLoanList = enterpriseLoanList;
	}
	public List<LoanDebtSituationVO> getPersonDebtList() {
		return personDebtList;
	}
	public void setPersonDebtList(List<LoanDebtSituationVO> personDebtList) {
		this.personDebtList = personDebtList;
	}
	public List<ExternalGuaranteeSituationVO> getGuaranteeList() {
		return guaranteeList;
	}
	public void setGuaranteeList(List<ExternalGuaranteeSituationVO> guaranteeList) {
		this.guaranteeList = guaranteeList;
	}
	public List<AccountsPayableVO> getRepayableList() {
		return repayableList;
	}
	public void setRepayableList(List<AccountsPayableVO> repayableList) {
		this.repayableList = repayableList;
	}
	public List<AccountsReceivableV4VO> getReceivableList() {
		return receivableList;
	}
	public void setReceivableList(List<AccountsReceivableV4VO> receivableList) {
		this.receivableList = receivableList;
	}
	public List<AttachmentVo> getDataAttachmentList() {
		return dataAttachmentList;
	}
	public List<AttachmentVo> getRejectList() {
		return rejectList;
	}
	public void setRejectList(List<AttachmentVo> rejectList) {
		this.rejectList = rejectList;
	}
	public void setDataAttachmentList(List<AttachmentVo> dataAttachmentList) {
		this.dataAttachmentList = dataAttachmentList;
	}
	public List<BillVO> getBillList() {
		return billList;
	}
	public void setBillList(List<BillVO> billList) {
		this.billList = billList;
	}
	public List<AttachmentVo> getAssetList() {
		return assetList;
	}
	public void setAssetList(List<AttachmentVo> assetList) {
		this.assetList = assetList;
	}
	
}
