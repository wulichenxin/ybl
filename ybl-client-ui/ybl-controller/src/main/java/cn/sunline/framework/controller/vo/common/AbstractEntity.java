package cn.sunline.framework.controller.vo.common;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public abstract class AbstractEntity implements Entity {

	private static final long serialVersionUID = -677556382824712936L;

	protected Long id; //主键id

	protected Date createdTime; // 对象的创建时间

	protected Long createdBy; // 持久化对象的创建人

	protected Date lastUpdateTime; // 该对象最后更新时间

	protected Long lastUpdateBy; // 该对象最后更新人

	protected int enable = 1; // 该对象的有效标识

	protected String sign;//标识字段
	
	protected String attribute1; // 备用字段
	protected String attribute2;
	protected String attribute3;
	protected String attribute4;
	protected String attribute5;
	protected String attribute6;
	protected String attribute7;
	protected String attribute8;
	protected String attribute9;
	protected String attribute10;
	
	@JSONField(serialize=false)
	protected long rowNo;// 用于显示在界面上“序号”

	public AbstractEntity() {
		super();
	}

	public AbstractEntity(Long id) {
		super();
		this.setId(id);
	}
	@JSONField(name="attribute1_")
	public String getAttribute1() {
		return attribute1;
	}

	@JSONField(name="attribute10_")
	public String getAttribute10() {
		return attribute10;
	}
	@JSONField(name="attribute2_")
	public String getAttribute2() {
		return attribute2;
	}
	@JSONField(name="attribute3_")
	public String getAttribute3() {
		return attribute3;
	}
	@JSONField(name="attribute4_")
	public String getAttribute4() {
		return attribute4;
	}
	@JSONField(name="attribute5_")
	public String getAttribute5() {
		return attribute5;
	}
	@JSONField(name="attribute6_")
	public String getAttribute6() {
		return attribute6;
	}
	@JSONField(name="attribute7_")
	public String getAttribute7() {
		return attribute7;
	}
	@JSONField(name="attribute8_")
	public String getAttribute8() {
		return attribute8;
	}
	@JSONField(name="attribute9_")
	public String getAttribute9() {
		return attribute9;
	}
	@JSONField(name="created_by")
	public Long getCreatedBy() {
		return createdBy;
	}

	@JSONField(format = "yyyy-MM-dd HH:mm:ss",name="created_time")
	public Date getCreatedTime() {
		return createdTime;
	}
	@JSONField(name="enable_")
	public int getEnable() {
		return enable;
	}
	@JSONField(name="id_")
	public Long getId() {
		return id;
	}
	@JSONField(name="last_update_by")
	public Long getLastUpdateBy() {
		return lastUpdateBy;
	}

	@JSONField(format = "yyyy-MM-dd HH:mm:ss",name="last_update_time")
	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}
	@JSONField(name="attribute1_")
	public void setAttribute1(String attribute1) {
		this.attribute1 = attribute1;
	}
	@JSONField(name="attribute10_")
	public void setAttribute10(String attribute10) {
		this.attribute10 = attribute10;
	}
	@JSONField(name="attribute2_")
	public void setAttribute2(String attribute2) {
		this.attribute2 = attribute2;
	}
	@JSONField(name="attribute3_")
	public void setAttribute3(String attribute3) {
		this.attribute3 = attribute3;
	}
	@JSONField(name="attribute4_")
	public void setAttribute4(String attribute4) {
		this.attribute4 = attribute4;
	}
	@JSONField(name="attribute5_")
	public void setAttribute5(String attribute5) {
		this.attribute5 = attribute5;
	}
	@JSONField(name="attribute6_")
	public void setAttribute6(String attribute6) {
		this.attribute6 = attribute6;
	}
	@JSONField(name="attribute7_")
	public void setAttribute7(String attribute7) {
		this.attribute7 = attribute7;
	}
	@JSONField(name="attribute8_")
	public void setAttribute8(String attribute8) {
		this.attribute8 = attribute8;
	}
	@JSONField(name="attribute9_")
	public void setAttribute9(String attribute9) {
		this.attribute9 = attribute9;
	}
	@JSONField(name="created_by")
	public void setCreatedBy(Long createdBy) {
		this.createdBy = createdBy;
	}
	@JSONField(name="created_time")
	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
	@JSONField(name="enable_")
	public void setEnable(int enable) {
		this.enable = enable;
	}
	@JSONField(name="id_")
	public void setId(Long id) {
		this.id = id;
	}
	@JSONField(name="last_update_by")
	public void setLastUpdateBy(Long lastUpdateBy) {
		this.lastUpdateBy = lastUpdateBy;
	}
	@JSONField(name="last_update_time")
	public void setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

	public long getRowNo() {
		return rowNo;
	}

	public void setRowNo(long rowNo) {
		this.rowNo = rowNo;
	}
	@JSONField(name="sign_")
	public String getSign() {
		return sign;
	}
	@JSONField(name="sign_")
	public void setSign(String sign) {
		this.sign = sign;
	}

	@Override
	public String toString() {
		return "AbstractEntity [id=" + id + ", createdTime=" + createdTime + ", createdBy=" + createdBy
				+ ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateBy=" + lastUpdateBy + ", enable=" + enable
				+ ", sign=" + sign + ", attribute1=" + attribute1 + ", attribute2=" + attribute2 + ", attribute3="
				+ attribute3 + ", attribute4=" + attribute4 + ", attribute5=" + attribute5 + ", attribute6="
				+ attribute6 + ", attribute7=" + attribute7 + ", attribute8=" + attribute8 + ", attribute9="
				+ attribute9 + ", attribute10=" + attribute10 + ", rowNo=" + rowNo + "]";
	}

}
