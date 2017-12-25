package cn.sunline.framework.controller.vo;

import java.io.Serializable;
import java.util.List;

public class PageVo<T> implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5776401484057749790L;

	public PageVo() {
	}

	public PageVo(int currentPage, int pageSize) {
		this.currentPage = currentPage;
		this.pageSize = pageSize;
	}

	// 每页显示的条数
	private int pageSize = 10;
	// 当前页
	private int currentPage = 1;
	// 总记录数
	private long recordCount;
	// 返回实体的集合
	private List<T> records;

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public long getRecordCount() {
		return recordCount;
	}

	public void setRecordCount(long recordCount) {
		this.recordCount = recordCount;
	}

	public List<T> getRecords() {
		return records;
	}

	public void setRecords(List<T> records) {
		this.records = records;
	}
}
