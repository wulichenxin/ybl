package cn.sunline.framework.controller.vo.v4.drools;

import java.util.List;

/**
 * 资金放股东集合VO
 * @author pc
 *
 */
public class StockHolderListVO {
	//股东集合
	private List<StockHolderVO>  StockHolderList;

	public List<StockHolderVO> getStockHolderList() {
		return StockHolderList;
	}

	public void setStockHolderList(List<StockHolderVO> stockHolderList) {
		StockHolderList = stockHolderList;
	}
}
