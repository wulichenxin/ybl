package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class AccountsReceivableTransportationVo extends AbstractEntity{

	/**
	 * 账款运输表实体
	 */
	//账款id
	private Long accountsReceivableTransportationId;
	//运输单号
	private String transportationNumber;
	//发货日期
	private String transportationDate;
	//运输费用
	private BigDecimal transportationCost;
	//货物名称
	private String transportationName;
	//寄件人
	private String sendName;
	//收件人
	private String collectName;
	//寄件人地址
	private String sendAddress;
	//收件人地址
	private String collectAddress;
	//寄件人电话
	private String sendPhone;
	//收件人电话
	private String collectPhone;
	//运输人电话
	private String transportationPhone;
	//运输人
	private String transportationPeopleName;
	//备注
	private String transportationRemark;
	//企业id
	private Long enterpriseId;
	
	@JSONField(name="accounts_receivable_id")
	public Long getAccountsReceivableTransportationId() {
		return accountsReceivableTransportationId;
	}
	@JSONField(name="accounts_receivable_id")
	public void setAccountsReceivableTransportationId(Long accountsReceivableTransportationId) {
		this.accountsReceivableTransportationId = accountsReceivableTransportationId;
	}
	@JSONField(name="number_")
	public String getTransportationNumber() {
		return transportationNumber;
	}
	@JSONField(name="number_")
	public void setTransportationNumber(String transportationNumber) {
		this.transportationNumber = transportationNumber;
	}
	@JSONField(name="transportation_date")
	public String getTransportationDate() {
		return transportationDate;
	}
	@JSONField(name="transportation_date")
	public void setTransportationDate(String transportationDate) {
		this.transportationDate = transportationDate;
	}
	@JSONField(name="transportation_cost")
	public BigDecimal getTransportationCost() {
		return transportationCost;
	}
	@JSONField(name="transportation_cost")
	public void setTransportationCost(BigDecimal transportationCost) {
		this.transportationCost = transportationCost;
	}
	@JSONField(name="name_")
	public String getTransportationName() {
		return transportationName;
	}
	@JSONField(name="name_")
	public void setTransportationName(String transportationName) {
		this.transportationName = transportationName;
	}
	@JSONField(name="send_name")
	public String getSendName() {
		return sendName;
	}
	@JSONField(name="send_name")
	public void setSendName(String sendName) {
		this.sendName = sendName;
	}
	@JSONField(name="collect_name")
	public String getCollectName() {
		return collectName;
	}
	@JSONField(name="collect_name")
	public void setCollectName(String collectName) {
		this.collectName = collectName;
	}
	@JSONField(name="send_address")
	public String getSendAddress() {
		return sendAddress;
	}
	@JSONField(name="send_address")
	public void setSendAddress(String sendAddress) {
		this.sendAddress = sendAddress;
	}
	@JSONField(name="collect_address")
	public String getCollectAddress() {
		return collectAddress;
	}
	@JSONField(name="collect_address")
	public void setCollectAddress(String collectAddress) {
		this.collectAddress = collectAddress;
	}
	@JSONField(name="send_phone")
	public String getSendPhone() {
		return sendPhone;
	}
	@JSONField(name="send_phone")
	public void setSendPhone(String sendPhone) {
		this.sendPhone = sendPhone;
	}
	@JSONField(name="collect_phone")
	public String getCollectPhone() {
		return collectPhone;
	}
	@JSONField(name="collect_phone")
	public void setCollectPhone(String collectPhone) {
		this.collectPhone = collectPhone;
	}
	@JSONField(name="transportation_phone")
	public String getTransportationPhone() {
		return transportationPhone;
	}
	@JSONField(name="transportation_phone")
	public void setTransportationPhone(String transportationPhone) {
		this.transportationPhone = transportationPhone;
	}
	@JSONField(name="transportation_name")
	public String getTransportationPeopleName() {
		return transportationPeopleName;
	}
	@JSONField(name="transportation_name")
	public void setTransportationPeopleName(String transportationPeopleName) {
		this.transportationPeopleName = transportationPeopleName;
	}
	@JSONField(name="remark_")
	public String getTransportationRemark() {
		return transportationRemark;
	}
	@JSONField(name="remark_")
	public void setTransportationRemark(String transportationRemark) {
		this.transportationRemark = transportationRemark;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	
}
