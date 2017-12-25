package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 融资申请综合查询VO
 * @author ZSW
 *
 */
public class IntegerQueryVO extends AbstractEntity{
	private static final long serialVersionUID = 1L;
	

	private  Long id_; //主键id
	
	private String is_enterprise;
	
	/*企业id*/
	private Long enterprise_id;
	
	/*
	 * 企业类型
	 */
	private int auth_type;
	
	
	private Long financing_apply_id;
	
	private String master_contract_no;
	//业务ID
	private Integer business_id;
	
	/*保理类型0-明保理1-暗保理*/
	private Integer factoring_mode;
	
	/*申请单位*/
	private String enterprise_name;
	
	/*融资订单号*/
	private String financing_order_number;
	
	/*融资方式0-签约资方1-平台推荐2-竞标*/
	private Integer   financing_mode;
	/*资金方多个id逗号隔开*/
	private String investor_name;
	
	
	
	/*资产类型0-应收账款1-应付账款2-票据*/
	private Integer assets_type;
	
	/*融资状态0-待提交1-待平台初审2-待资方初审3-待选择资方4-待资方终审5-待确定资方6-待平台复核7-待签署合同8-融资完成9-融资失败*/
	private Integer financing_status;
	
	private Integer status;
	
	/*融资金额*/
	private BigDecimal financing_amount;
	
	/*融资期限*/
	private Integer financing_term;
	
	/*融资利率*/
	private BigDecimal financing_rate;
	
	
	
	/*融资需求备注*/
	private String financing_demand_remark;
	
	/*备注*/
	private String remark;
	
	/*申请开始时间*/
	private String begin_date;
	
	/*申请结束时间*/
	private String end_date;
	
	/*融资方*/
	private String financier;
	
	/*
	 * 子定单下得放款订单数
	 */
	private Integer count;

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

	public String getEnterprise_name() {
		return enterprise_name;
	}

	public void setEnterprise_name(String enterprise_name) {
		this.enterprise_name = enterprise_name;
	}

	public String getFinancing_order_number() {
		return financing_order_number;
	}

	public void setFinancing_order_number(String financing_order_number) {
		this.financing_order_number = financing_order_number;
	}

	
	public String getInvestor_name() {
		return investor_name;
	}

	public void setInvestor_name(String investor_name) {
		this.investor_name = investor_name;
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

	

	public String getFinancing_demand_remark() {
		return financing_demand_remark;
	}

	public void setFinancing_demand_remark(String financing_demand_remark) {
		this.financing_demand_remark = financing_demand_remark;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	

	public String getMaster_contract_no() {
		return master_contract_no;
	}

	public void setMaster_contract_no(String master_contract_no) {
		this.master_contract_no = master_contract_no;
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

	public Long getId_() {
		return id_;
	}

	public void setId_(Long id_) {
		this.id_ = id_;
	}

	public Long getFinancing_apply_id() {
		return financing_apply_id;
	}

	public void setFinancing_apply_id(Long financing_apply_id) {
		this.financing_apply_id = financing_apply_id;
	}

	public String getFinancier() {
		return financier;
	}

	public void setFinancier(String financier) {
		this.financier = financier;
	}

	public Integer getFinancing_term() {
		return financing_term;
	}

	public void setFinancing_term(Integer financing_term) {
		this.financing_term = financing_term;
	}


	public Long getEnterprise_id() {
		return enterprise_id;
	}

	public void setEnterprise_id(Long enterprise_id) {
		this.enterprise_id = enterprise_id;
	}

	public int getAuth_type() {
		return auth_type;
	}

	public void setAuth_type(int auth_type) {
		this.auth_type = auth_type;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public BigDecimal getFinancing_amount() {
		return financing_amount;
	}

	public void setFinancing_amount(BigDecimal financing_amount) {
		this.financing_amount = financing_amount;
	}

	public BigDecimal getFinancing_rate() {
		return financing_rate;
	}

	public void setFinancing_rate(BigDecimal financing_rate) {
		this.financing_rate = financing_rate;
	}

	public String getIs_enterprise() {
		return is_enterprise;
	}

	public void setIs_enterprise(String is_enterprise) {
		this.is_enterprise = is_enterprise;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}
	
	/*
	 * 临时字段--标识查询竞标数据的排序方式  attribute1_
	 * 0-默认排序(能否参加<占用attribute2_来传参，但不影响数据库数据>,平台审核时间)
	 * 1-融资利率
	 * 2-融资期限(融资期限天数 = 融资期限日期 - 系统时间，精确到天<占用attribute3_来传参，但不影响数据库数据>)
	 * 3-融资金额
	 */



}
