package cn.sunline.framework.task;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 逾期还款定时任务
 */

public class RepaymentOverdueTask extends AbstractTask {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5645887504384120476L;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RepaymentOverdueTask.class);

	/**
	 * 当服务器时间大于还款日期，修改还未还款的计划状态改为逾期。
	 */
	protected void task() {
		LOGGER.info("------逾期还款状态调整任务开始------");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sign", "repaymentOverdueTask");
		TradeInvokeUtils.invoke("FactorCollectionManagementTran", map);
	}
	
}
