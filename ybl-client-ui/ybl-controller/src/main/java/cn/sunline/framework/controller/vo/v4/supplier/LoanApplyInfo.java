package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 放款申请表
 * @author DuanGuoJie
 *
 */
public class LoanApplyInfo extends AbstractEntity {
    
	private static final long serialVersionUID = -1088942550364577498L;

	/**
	 * 融资申请子订单id
	 */
	@JSONField(name="sub_financing_apply_id")
	private Long subFinancingApplyId;

	/**
	 * 业务id线下确权为资金方线上确权为核心企业，与子融资订单的business_id不是同一个
	 */
	@JSONField(name="right_business_id")
    private Long rightBusinessId;

    /**
     * 付款批次id
     */
	@JSONField(name="payment_batch_id")
    private Long paymentBatchId;

    /**
     * 申请单位
     */
	@JSONField(name="enterprise_name")
    private String enterpriseName;

    /**
     * 放款订单号
     */
	@JSONField(name="order_no")
    private String orderNo;

    /**
     * 主合同号
     */
	@JSONField(name="master_contract_no")
    private String masterContractNo;

    /**
     * 借款申请状态：1-待提交2-待资方办理3-待确权4-待平台审核5-待放款6-待放款确认7-放款完成99-放款失败
     */
	@JSONField(name="status")
    private String status;

    /**
     * 确权备注
     */
	@JSONField(name="right_remark")
    private String rightRemark;

    /**
     * 平台审核结果：1-通过2-不通过
     */
	@JSONField(name="platform_audit")
    private String platformAudit;

    /**
     * 平台审核
     */
	@JSONField(name="platform_remark")
    private String platformRemark;

    /**
     * 融资方
     */
	@JSONField(name="financier")
    private String financier;

    /**
     * 融资金额
     */
	@JSONField(name="financing_amount")
    private BigDecimal financingAmount;

    /**
     * 融资期限
     */
	@JSONField(name="financing_term")
    private Integer financingTerm;

    /**
     * 融资利率
     */
	@JSONField(name="financing_rate")
    private BigDecimal financingRate;

    /**
     * 增信措施
     */
	@JSONField(name="trust_measure")
    private String trustMeasure;

    /**
     * 融资需求备注
     */
	@JSONField(name="financing_demand_remark")
    private String financingDemandRemark;
	
	/**
     * 资产类型
     */
	@JSONField(name="assets_type")
    private String assetsType;
	
	/**
     * 累计还款本息
     */
	@JSONField(name="total_repay_money")
    private BigDecimal totalRepayMoney;
	/**
     * 最后一次还款时间
     */
	@JSONField(name="last_time")
    private Date lastTime;
	/**
     * 子融资申请订单
     */
	@JSONField(name="sub_order_no")
    private String subOrderNo;
	/**
     * 还款状态
     */
	@JSONField(name="repayment_status")
    private Integer repaymentStatus;
	/**
     * 实际放款金额
     */
	@JSONField(name="actual_loan_amount")
    private BigDecimal actualLoanAmount;
	/**
     * 保理商
     */
	@JSONField(name="f_enterprise_name")
    private String f_enterprise_name;

	/**
	 * 融资订单号
	 */
	@JSONField(name="financing_order_number")
	private String financingOrderNumber;
	
	
    public String getFinancingOrderNumber() {
		return financingOrderNumber;
	}

	public void setFinancingOrderNumber(String financingOrderNumber) {
		this.financingOrderNumber = financingOrderNumber;
	}

	public BigDecimal getTotalRepayMoney() {
		return totalRepayMoney;
	}

	public void setTotalRepayMoney(BigDecimal totalRepayMoney) {
		this.totalRepayMoney = totalRepayMoney;
	}

	public Date getLastTime() {
		return lastTime;
	}

	public void setLastTime(Date lastTime) {
		this.lastTime = lastTime;
	}

	public String getSubOrderNo() {
		return subOrderNo;
	}

	public void setSubOrderNo(String subOrderNo) {
		this.subOrderNo = subOrderNo;
	}

	public Integer getRepaymentStatus() {
		return repaymentStatus;
	}

	public void setRepaymentStatus(Integer repaymentStatus) {
		this.repaymentStatus = repaymentStatus;
	}

	public BigDecimal getActualLoanAmount() {
		return actualLoanAmount;
	}

	public void setActualLoanAmount(BigDecimal actualLoanAmount) {
		this.actualLoanAmount = actualLoanAmount;
	}

	public String getF_enterprise_name() {
		return f_enterprise_name;
	}

	public void setF_enterprise_name(String f_enterprise_name) {
		this.f_enterprise_name = f_enterprise_name;
	}

	public Long getSubFinancingApplyId() {
        return subFinancingApplyId;
    }

    public void setSubFinancingApplyId(Long subFinancingApplyId) {
        this.subFinancingApplyId = subFinancingApplyId;
    }

    public Long getRightBusinessId() {
        return rightBusinessId;
    }

    public void setRightBusinessId(Long rightBusinessId) {
        this.rightBusinessId = rightBusinessId;
    }

    public Long getPaymentBatchId() {
        return paymentBatchId;
    }

    public void setPaymentBatchId(Long paymentBatchId) {
        this.paymentBatchId = paymentBatchId;
    }

    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName == null ? null : enterpriseName.trim();
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo == null ? null : orderNo.trim();
    }

    public String getMasterContractNo() {
        return masterContractNo;
    }

    public void setMasterContractNo(String masterContractNo) {
        this.masterContractNo = masterContractNo == null ? null : masterContractNo.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRightRemark() {
        return rightRemark;
    }

    public void setRightRemark(String rightRemark) {
        this.rightRemark = rightRemark == null ? null : rightRemark.trim();
    }

    public String getPlatformAudit() {
        return platformAudit;
    }

    public void setPlatformAudit(String platformAudit) {
        this.platformAudit = platformAudit;
    }

    public String getPlatformRemark() {
        return platformRemark;
    }

    public void setPlatformRemark(String platformRemark) {
        this.platformRemark = platformRemark == null ? null : platformRemark.trim();
    }

    public String getFinancier() {
        return financier;
    }

    public void setFinancier(String financier) {
        this.financier = financier == null ? null : financier.trim();
    }

    public BigDecimal getFinancingAmount() {
        return financingAmount;
    }

    public void setFinancingAmount(BigDecimal financingAmount) {
        this.financingAmount = financingAmount;
    }

   

    public Integer getFinancingTerm() {
		return financingTerm;
	}

	public void setFinancingTerm(Integer financingTerm) {
		this.financingTerm = financingTerm;
	}

	public BigDecimal getFinancingRate() {
        return financingRate;
    }

    public void setFinancingRate(BigDecimal financingRate) {
        this.financingRate = financingRate;
    }

    public String getTrustMeasure() {
        return trustMeasure;
    }

    public void setTrustMeasure(String trustMeasure) {
        this.trustMeasure = trustMeasure == null ? null : trustMeasure.trim();
    }

    public String getFinancingDemandRemark() {
        return financingDemandRemark;
    }

    public void setFinancingDemandRemark(String financingDemandRemark) {
        this.financingDemandRemark = financingDemandRemark == null ? null : financingDemandRemark.trim();
    }

	public String getAssetsType() {
		return assetsType;
	}

	public void setAssetsType(String assetsType) {
		this.assetsType = assetsType;
	}
}