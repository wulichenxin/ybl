package cn.sunline.framework.controller.vo.v4.drools;

import java.math.BigDecimal;
import java.util.Date;

import javax.validation.constraints.Digits;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 资金方股东表VO
 * 
 * @author pc
 *
 */
public class StockHolderVO extends AbstractEntity {

    /**
     * 
     */
    private static final long serialVersionUID = 4248075153929500889L;
    @JSONField(name = "business_id")
    private Long businessId;// 业务ID

    @JSONField(name = "financing_apply_id")
    private Long financingApplyId;// 融资申请ID

    @JSONField(name = "name")
    private String name;// 股东名称
    
    @Digits(fraction = 4, integer = 28,message="注册资本格式错误")
    @JSONField(name = "investment_amount")
    private BigDecimal investmentAmount;// 出资金额
    
    @Digits(fraction = 4, integer = 28,message="股权比例格式错误")
    @JSONField(name = "investment_ratio")
    private BigDecimal investmentRatio;// 出资比例

    @JSONField(name = "investment_mode")
    private String investmentMode;// 出资方式

    @JSONField(name = "legal_name")
    private String legalName;// 法人姓名
    
    @Digits(fraction = 4, integer = 28,message="实收资本格式错误")
    @JSONField(name = "received_amount")
    private BigDecimal receivedAmount;// 实收资本

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @JSONField(name = "register_date", format = "yyyy-MM-dd")
    private Date registerDate;// 注册日期
    
    private String registerDateTemp;// 注册日期页面接受参数

    public String getRegisterDateTemp() {
        return registerDateTemp;
    }

    public void setRegisterDateTemp(String registerDateTemp) {
        this.registerDateTemp = registerDateTemp;
    }

    public Long getBusinessId() {
        return businessId;
    }

    public void setBusinessId(Long businessId) {
        this.businessId = businessId;
    }

    public Long getFinancingApplyId() {
        return financingApplyId;
    }

    public void setFinancingApplyId(Long financingApplyId) {
        this.financingApplyId = financingApplyId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getInvestmentAmount() {
        return investmentAmount;
    }

    public void setInvestmentAmount(BigDecimal investmentAmount) {
        this.investmentAmount = investmentAmount;
    }

    public BigDecimal getInvestmentRatio() {
        return investmentRatio;
    }

    public void setInvestmentRatio(BigDecimal investmentRatio) {
        this.investmentRatio = investmentRatio;
    }

    public String getInvestmentMode() {
        return investmentMode;
    }

    public void setInvestmentMode(String investmentMode) {
        this.investmentMode = investmentMode;
    }

    public String getLegalName() {
        return legalName;
    }

    public void setLegalName(String legalName) {
        this.legalName = legalName;
    }

    public BigDecimal getReceivedAmount() {
        return receivedAmount;
    }

    public void setReceivedAmount(BigDecimal receivedAmount) {
        this.receivedAmount = receivedAmount;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    public boolean emptyStockHolderVO(StockHolderVO stockHolderVO) {
        boolean falg = false;
        if ((stockHolderVO.getName() != null && !"".equals(stockHolderVO.getName()))
                || (stockHolderVO.getInvestmentAmount() != null && !"".equals(stockHolderVO.getInvestmentAmount()))
                || (stockHolderVO.getInvestmentRatio() != null && !"".equals(stockHolderVO.getInvestmentRatio()))
                || (stockHolderVO.getInvestmentMode() != null && !"".equals(stockHolderVO.getInvestmentMode()))
                || (stockHolderVO.getLegalName() != null && !"".equals(stockHolderVO.getLegalName()))
                || (stockHolderVO.getRegisterDateTemp() != null && !"".equals(stockHolderVO.getRegisterDateTemp()))
                || (stockHolderVO.getReceivedAmount() != null && !"".equals(stockHolderVO.getReceivedAmount()))) {
            falg = true;
        }
        return falg;
    }

}
