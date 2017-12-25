package cn.sunline.framework.task;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 合同额度设置定时任务
 */
public class QuotaRecordTask extends AbstractTask {
	
	private static final long serialVersionUID = -5337152812244338950L;
	private static final Logger LOGGER = LoggerFactory.getLogger(ContractTask.class);

	/**
	 * 1、当生效日期开始，调整对应的合同中相关的额度值,并修改额度记录里面相关状态。
	 */
	protected void task() {
		LOGGER.info("------合同额度设置定时任务开始------");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sign", "quotaRecordTask");
		TradeInvokeUtils.invoke("V2ContractManagement", map);
	}
}
