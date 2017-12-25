package cn.sunline.framework.task;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.v4.supplier.FinancingApplyVO;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 竞标逾期(融资失败)定时任务
 */

public class FinancingApplyBidTask extends AbstractTask {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5645887504384120476L;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(FinancingApplyBidTask.class);

	/**
	 * 当服务器时间大于竞标截止日期且没有子订单数据，修改还竞标类型的融资申请为融资失败。
	 */
	protected void task() {
		LOGGER.info("------竞标逾期(融资失败)定时任务------");
		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("sign", "repaymentOverdueTask");
//		TradeInvokeUtils.invoke("FactorCollectionManagementTran", map);
		/*1、查询出已超时的融资申请*/
		FinancingApplyVO financingApplyVO = new FinancingApplyVO();
		financingApplyVO.setFinancingMode(3);//设置融资申请类型为竞标
		financingApplyVO.setFinancingStatus(3);//设置融资申请状态为待资方初审
		financingApplyVO.setBidExpireDate(new Date());
		map.put("financingApply",financingApplyVO);
		ResBody result = TradeInvokeUtils.invoke("FactorQueryBidOverDueManage", map);
		List<FinancingApplyVO> list=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("逾期竞标数据查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("financingApplyList");
				list=JsonUtils.toList(records,FinancingApplyVO.class);
			}
		}
		/*2、子订单数为0*/
		Map<String,Object> maps = new HashMap<String,Object>();
		if(null != list&&list.size() > 0){
			for(FinancingApplyVO financingApply : list){
				if(financingApply.getCount() == 0){
					/*3、遍历更新融资申请订单状态为99-融资失败*/
					financingApply.setFinancingStatus(99);
					maps.put("ids", "");
					maps.put("financing_apply_id", financingApply.getId());
					maps.put("financing_status", financingApply.getFinancingStatus());
					maps.put("sign", "updateFubFinancing");//所调用的服务中的方法
					//更新状态
					TradeInvokeUtils.invoke("FanacingCheckPendingManagement", maps);
				}
			}
		}
	}
	
}
