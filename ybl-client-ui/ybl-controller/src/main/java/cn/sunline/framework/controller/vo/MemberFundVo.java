package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 会员资金信息实体类
 * @author MaiBenBen
 *
 */
public class MemberFundVo extends AbstractEntity {

	private static final long serialVersionUID = 1941944464893855291L;
	
	/* 企业表id */
	private Long enterpriseId=-1L;
	/* 所属会员id */
	private Long memberId=-1L;
	/*总余额 */
	private BigDecimal totalAmount;
	/*冻结金额 */
	private BigDecimal freezeAmount;
	/*可用金额 */
	private BigDecimal useableAmount;
	/*授信总额 */
	private BigDecimal creditAmount;

	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "member_id")
	public Long getMemberId() {
		return memberId;
	}

	@JSONField(name = "member_id")
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	
	@JSONField(name = "total_amount")
	public BigDecimal getTotalAmount() {
		return totalAmount;
	}

	@JSONField(name = "total_amount")
	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}

	@JSONField(name = "freeze_amount")
	public BigDecimal getFreezeAmount() {
		return freezeAmount;
	}

	@JSONField(name = "freeze_amount")
	public void setFreezeAmount(BigDecimal freezeAmount) {
		this.freezeAmount = freezeAmount;
	}

	@JSONField(name = "useable_amount")
	public BigDecimal getUseableAmount() {
		return useableAmount;
	}

	@JSONField(name = "useable_amount")
	public void setUseableAmount(BigDecimal useableAmount) {
		this.useableAmount = useableAmount;
	}

	@JSONField(name = "credit_amount")
	public BigDecimal getCreditAmount() {
		return creditAmount;
	}

	@JSONField(name = "credit_amount")
	public void setCreditAmount(BigDecimal creditAmount) {
		this.creditAmount = creditAmount;
	}
}
