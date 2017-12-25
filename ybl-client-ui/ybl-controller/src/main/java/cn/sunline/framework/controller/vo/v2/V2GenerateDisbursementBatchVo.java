package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

//待生成放款的批次
public class V2GenerateDisbursementBatchVo extends AbstractEntity{

	//应收账款id集合，格式为  1,2,4
	@JSONField(name="ids")
	private String ids;
	
	//供应商名称
	@JSONField(name="enterprise_name")
	private String enterpriseName;
	
	//企业id
	@JSONField(name="enterprise_id")
	private Long enterpriseId;
	
	//应收金额
	@JSONField(name="amount_")
	private BigDecimal amount;
	
	//审核日期
	@JSONField(name="date_")
	private Date date;
	
	//企业id
	@JSONField(name="supplier_id")
	private Long supplierId;
	

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public Long getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Long getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Long supplierId) {
		this.supplierId = supplierId;
	}
	
	
	
	
}
