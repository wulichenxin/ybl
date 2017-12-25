package cn.sunline.framework.controller.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class RecruitVo extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2229370885764523600L;
	//岗位名称
	private String roleName;
	//薪水
	private String salary;
	//省份id
	private Long provinceId;
	//城市id
	private Long cityId;
	//县区id
	private Long areaId;
	//工作经验年限
	private String jobYears;
	//工作性质
	private String jobCategory;
	//学历
	private String degree;
	//招聘人数
	private Long number;
	//职位描述
	private String desc;
    //发布时间
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date releaseDate;
	//发布状态
	private String status;
	//发布开始时间,条件查询用
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date releaseBeginDate;

	//发布结束时间
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date releaseEendDate;
	@JSONField(name="role_name")
	public String getRoleName() {
		return roleName;
	}
	@JSONField(name="role_name")
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	@JSONField(name="salary_")
	public String getSalary() {
		return salary;
	}
	@JSONField(name="salary_")
	public void setSalary(String salary) {
		this.salary = salary;
	}
	@JSONField(name="province_id")
	public Long getProvinceId() {
		return provinceId;
	}
	@JSONField(name="province_id")
	public void setProvinceId(Long provinceId) {
		this.provinceId = provinceId;
	}
	@JSONField(name="city_id")
	public Long getCityId() {
		return cityId;
	}
	@JSONField(name="city_id")
	public void setCityId(Long cityId) {
		this.cityId = cityId;
	}
	@JSONField(name="area_id")
	public Long getAreaId() {
		return areaId;
	}
	@JSONField(name="area_id")
	public void setAreaId(Long areaId) {
		this.areaId = areaId;
	}
	@JSONField(name="job_years")
	public String getJobYears() {
		return jobYears;
	}
	@JSONField(name="job_years")
	public void setJobYears(String jobYears) {
		this.jobYears = jobYears;
	}
	@JSONField(name="job_category")
	public String getJobCategory() {
		return jobCategory;
	}
	@JSONField(name="job_category")
	public void setJobCategory(String jobCategory) {
		this.jobCategory = jobCategory;
	}
	@JSONField(name="degree_")
	public String getDegree() {
		return degree;
	}
	@JSONField(name="degree_")
	public void setDegree(String degree) {
		this.degree = degree;
	}
	@JSONField(name="number_")
	public Long getNumber() {
		return number;
	}
	@JSONField(name="number_")
	public void setNumber(Long number) {
		this.number = number;
	}
	@JSONField(name="desc_")
	public String getDesc() {
		return desc;
	}
	@JSONField(name="desc_")
	public void setDesc(String desc) {
		this.desc = desc;
	}
	@JSONField(name="release_date")
	public Date getReleaseDate() {
		return releaseDate;
	}
	@JSONField(name="release_date")
	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}
	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name="release_begin_date")
	public Date getReleaseBeginDate() {
		return releaseBeginDate;
	}
	@JSONField(name="release_begin_date")
	public void setReleaseBeginDate(Date releaseBeginDate) {
		this.releaseBeginDate = releaseBeginDate;
	}
	@JSONField(name="release_end_date")
	public Date getReleaseEendDate() {
		return releaseEendDate;
	}
	@JSONField(name="release_end_date")
	public void setReleaseEendDate(Date releaseEendDate) {
		this.releaseEendDate = releaseEendDate;
	}
}
