package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;
import java.util.Date;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 融资申请子订单VO
 * @author liuls
 *
 */
public class SubFinancingApplyVO extends AbstractEntity{
	private static final long serialVersionUID = 1L;
	
	// 融资主订单id
	private Integer financing_apply_id;
	
	//业务ID
	private Integer business_id;
	
	/*保理类型0-明保理1-暗保理*/
	private Integer factoring_mode;
	
	/*融资订单号*/
	private String order_no;
	
	/*融资方式0-签约资方1-平台推荐2-竞标*/
	private Integer financing_mode;
	
	private Date create_time;
	
	/*资产类型0-应收账款1-应付账款2-票据*/
	private Integer assets_type;
	
	/*融资状态0-待提交1-待平台初审2-待资方初审3-待选择资方4-待资方终审5-待确定资方6-待平台复核7-待签署合同8-融资完成9-融资失败*/
	private Integer financing_status;
	
	/*融资金额*/
	private BigDecimal financing_amount;
	
	/*融资期限*/
	private Integer financing_term;
	
	/*融资利率*/
	private BigDecimal financing_rate;
	
	/*融资方*/
	private String financier;
	
	/*备注*/
	private String ruject_remark;
	
	/*申请开始时间*/
	private String begin_date;
	
	/*申请结束时间*/
	private String end_date;
	
	/*是否有放款申请记录*/
	private Boolean had_loan;
	
	/*资金方名称*/
	private String funder_name;
	
	
	public Integer getFinancing_apply_id() {
		return financing_apply_id;
	}

	public void setFinancing_apply_id(Integer financing_apply_id) {
		this.financing_apply_id = financing_apply_id;
	}

	public Integer getBusiness_id() {
		return business_id;
	}

	public void setBusiness_id(Integer business_id) {
		this.business_id = business_id;
	}

	public Integer getFactoring_mode() {
		return factoring_mode;
	}

	public void setFactoring_mode(Integer factoring_mode) {
		this.factoring_mode = factoring_mode;
	}

	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}

	public Integer getAssets_type() {
		return assets_type;
	}

	public void setAssets_type(Integer assets_type) {
		this.assets_type = assets_type;
	}

	public Integer getFinancing_status() {
		return financing_status;
	}

	public void setFinancing_status(Integer financing_status) {
		this.financing_status = financing_status;
	}

	public BigDecimal getFinancing_amount() {
		return financing_amount;
	}

	public void setFinancing_amount(BigDecimal financing_amount) {
		this.financing_amount = financing_amount;
	}

	public Integer getFinancing_term() {
		return financing_term;
	}

	public void setFinancing_term(Integer financing_term) {
		this.financing_term = financing_term;
	}

	public BigDecimal getFinancing_rate() {
		return financing_rate;
	}

	public void setFinancing_rate(BigDecimal financing_rate) {
		this.financing_rate = financing_rate;
	}


	public String getRuject_remark() {
		return ruject_remark;
	}

	public void setRuject_remark(String ruject_remark) {
		this.ruject_remark = ruject_remark;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getFinancing_mode() {
		return financing_mode;
	}

	public void setFinancing_mode(Integer financing_mode) {
		this.financing_mode = financing_mode;
	}

	public String getBegin_date() {
		return begin_date;
	}

	public void setBegin_date(String begin_date) {
		this.begin_date = begin_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getFinancier() {
		return financier;
	}

	public void setFinancier(String financier) {
		this.financier = financier;
	}

	public Boolean getHad_loan() {
		return had_loan;
	}

	public void setHad_loan(Boolean had_loan) {
		this.had_loan = had_loan;
	}

    public String getFunder_name() {
        return funder_name;
    }

    public void setFunder_name(String funder_name) {
        this.funder_name = funder_name;
    }
	
	
	
	
	/*
	 * 临时字段--标识查询竞标数据的排序方式  attribute1_
	 * 0-默认排序(能否参加<占用attribute2_来传参，但不影响数据库数据>,平台审核时间)
	 * 1-融资利率
	 * 2-融资期限(融资期限天数 = 融资期限日期 - 系统时间，精确到天<占用attribute3_来传参，但不影响数据库数据>)
	 * 3-融资金额
	 */



}
