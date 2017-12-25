package cn.sunline.framework.task;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 合同定时任务
 * @author guang
 *
 */
public class ContractTask extends AbstractTask {
	
	private static final long serialVersionUID = -4622539187929081302L;
	private static final Logger LOGGER = LoggerFactory.getLogger(ContractTask.class);

	/**
	 * 1、当合同开始日期开始，修改对应的合同状态为生效中。
	 * 2、合同结束日期到期，合同状态改为已过去
	 */
	protected void task() {
		LOGGER.info("------合同状态调整任务开始------");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sign", "contractTask");
		TradeInvokeUtils.invoke("V2ContractManagement", map);
	}
	
}
