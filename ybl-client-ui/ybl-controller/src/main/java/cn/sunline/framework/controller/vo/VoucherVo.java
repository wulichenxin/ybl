package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.bpm.framework.utils.StringUtils;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class VoucherVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5236855632175766791L;

	
	//所属供应商
	private Long memberId;
	//凭证编号
	private String voucherNo;
	//所属核心企业名称
	private String enterpriseName; 
	//所属核心企业id
	private Long enterId;
	//凭证类型
	private String type;
	//凭证到期日期
	private String expireDate;
	//凭证金额
	private BigDecimal amount;
	//凭证登记日期
	private String registerDate;
	//凭证生效日期
	private String effectiveDate;
	//凭证说明/备注
	private String remark;
	//状态
	private String status;
	//所属企业id
	private Long enterpriseId;
	//融资申请id
	private Long financeApplyId;
	//所属核心企业id
	private Long enterpriseMemeberId;
	//凭证的url
	private String picUrls;
	//融资申请编号
	private String number;
	
	/*凭证的url*/
	@JSONField(name="url_")
	private String url;
	
	
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	@JSONField(name="number_")
	public String getNumber() {
		return number;
	}
	@JSONField(name="number_")
	public void setNumber(String number) {
		this.number = number;
	}
	@JSONField(name="enterprise_memeber_id")
	public Long getEnterpriseMemeberId() {
		return enterpriseMemeberId;
	}
	@JSONField(name="enterprise_memeber_id")
	public void setEnterpriseMemeberId(Long enterpriseMemeberId) {
		this.enterpriseMemeberId = enterpriseMemeberId;
	}
	@JSONField(name="finance_apply_id")
	public Long getFinanceApplyId() {
		return financeApplyId;
	}
	@JSONField(name="finance_apply_id")
	public void setFinanceApplyId(Long financeApplyId) {
		this.financeApplyId = financeApplyId;
	}
	@JSONField(name="member_id")
	public Long getMemberId() {
		return memberId;
	}
	@JSONField(name="member_id")
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	@JSONField(name="voucher_no")
	public String getVoucherNo() {
		return voucherNo;
	}
	@JSONField(name="voucher_no")
	public void setVoucherNo(String voucherNo) {
		this.voucherNo = voucherNo;
	}
	@JSONField(name="enterprise_name")
	public String getEnterpriseName() {
		return enterpriseName;
	}
	@JSONField(name="enterprise_name")
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	@JSONField(name="type_")
	public String getType() {
		return type;
	}
	@JSONField(name="type_")
	public void setType(String type) {
		this.type = type;
	}
	@JSONField(name="expire_date")
	public String getExpireDate() {
		return expireDate;
	}
	@JSONField(name="expire_date")
	public void setExpireDate(String expireDate) {
		this.expireDate = expireDate;
	}
	@JSONField(name="amount_")
	public BigDecimal getAmount() {
		return amount;
	}
	@JSONField(name="amount_")
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	@JSONField(name="register_date")
	public String getRegisterDate() {
		return registerDate;
	}
	
	@JSONField(name="register_date")
	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}
	
	@JSONField(name="effective_date")
	public String getEffectiveDate() {
		return effectiveDate;
	}
	@JSONField(name="effective_date")
	public void setEffectiveDate(String effectiveDate) {
		this.effectiveDate = effectiveDate;
	}
	@JSONField(name="remark_")
	public String getRemark() {
		return remark;
	}
	@JSONField(name="remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="picUrls_")
	public String getPicUrls() {
		return picUrls;
	}
	@JSONField(name="picUrls_")
	public void setPicUrls(String picUrls) {
		this.picUrls = picUrls;
	}
	@JSONField(name="enter_id")
	public Long getEnterId() {
		return enterId;
	}
	@JSONField(name="enter_id")
	public void setEnterId(Long enterId) {
		this.enterId = enterId;
	}
	
	
}
