package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 选择意向资方，和合作资方详情
 * @author ZSW
 *
 */
public class IntegerFundsMangementVO extends AbstractEntity{
	private static final long serialVersionUID = 1L;
	
	private String  order_no;
	
	/*
	 * 资金方名称
	 */
	private String  funder_name;

	private  Long id_; //主键id
	
	private BigDecimal financing_amount;
	
	private BigDecimal financing_term;
	
	private BigDecimal financing_rate;
	
	private Date audit_date;

	private String audit_opinion;
	
	private String remark;
	
	private Integer audit_result ;
	
	private Integer selection_status;
	
	/*附件名称*/
	@JSONField(name = "old_name")
	private String oldName;
	/*附件id*/
	@JSONField(name = "attachment_id")
	private String attachmentId;

	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}

	public String getFunder_name() {
		return funder_name;
	}

	public void setFunder_name(String funder_name) {
		this.funder_name = funder_name;
	}

	public Long getId_() {
		return id_;
	}

	public void setId_(Long id_) {
		this.id_ = id_;
	}

	public BigDecimal getFinancing_amount() {
		return financing_amount;
	}

	public void setFinancing_amount(BigDecimal financing_amount) {
		this.financing_amount = financing_amount;
	}

	public BigDecimal getFinancing_term() {
		return financing_term;
	}

	public void setFinancing_term(BigDecimal financing_term) {
		this.financing_term = financing_term;
	}

	public BigDecimal getFinancing_rate() {
		return financing_rate;
	}

	public void setFinancing_rate(BigDecimal financing_rate) {
		this.financing_rate = financing_rate;
	}

	public Date getAudit_date() {
		return audit_date;
	}

	public void setAudit_date(Date audit_date) {
		this.audit_date = audit_date;
	}

	public String getAudit_opinion() {
		return audit_opinion;
	}

	public void setAudit_opinion(String audit_opinion) {
		this.audit_opinion = audit_opinion;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getAudit_result() {
		return audit_result;
	}

	public void setAudit_result(Integer audit_result) {
		this.audit_result = audit_result;
	}

	public Integer getSelection_status() {
		return selection_status;
	}

	public void setSelection_status(Integer selection_status) {
		this.selection_status = selection_status;
	}

	public String getOldName() {
		return oldName;
	}

	public void setOldName(String oldName) {
		this.oldName = oldName;
	}

	public String getAttachmentId() {
		return attachmentId;
	}

	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
	}
	
	


}
