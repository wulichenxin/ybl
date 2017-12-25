package cn.sunline.framework.task;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.SubjectVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 标的定时任务
 */
public class SubjectTask extends AbstractTask {
	
	private static final long serialVersionUID = -4622539187929081302L;

	/**
	 * 定时更新竞标信息已过期且无竞标方的标的状态为流标，并且修改相关的凭证，竞标信息的状态
	 */
	protected void task() {
		/*（1）查询所有竞标信息已过期且无竞标方的标的信息*/
		List<SubjectVo> subjectList= querySubjectByCondition();
		String ids="";//竞标信息已过期且无竞标方的标的id拼接的字符串
		if(CollectionUtils.isNotEmpty(subjectList)){
			for(SubjectVo subject:subjectList){
				ids += subject.getId()+",";
			}
		}
		super.log.info("竞标信息已过期且无竞标方的标的id字符串为："+ids);
		/*（2）如果存在目标数据，则讲这些数据进行流标操作*/
		if(StringUtils.isNotEmpty(ids)){
			updateSubjectStatus(ids,Constant.SUBJECT_FAIL_SUBJECT);//流标状态
			super.log.info("流标操作成功");
		}
	}
	
	 /**
	 * 批量更新标的状态信息
	 * 
	 * @param request
	 * @param ids
	 *            标的id字符串
	 * @param status
	 *            需要修改成的标的状态
	 * @return
	 */
	private void updateSubjectStatus(String ids,String status) {
		// (1)判断必要参数
		if (StringUtils.isEmpty(ids)) {
			super.log.error("ids不能为空！");
			return;
		}
		// (2)调用服务，进行数据更新
		Map<String, Object> map = new HashMap<String, Object>();
		String[] idArr = ids.split(",");
		List<SubjectVo> subjectList = new ArrayList<SubjectVo>();
		for(int i=0;i<idArr.length;i++){
			if(StringUtils.isNotEmpty(idArr[i])){
				SubjectVo subject = new SubjectVo();
				subject.setId(Long.valueOf(idArr[i]));
				subject.setStatus(status);// 状态
				subject.setLastUpdateTime(DateUtils.now());
				subjectList.add(subject);
			}
		}
		map.put("paramter", subjectList);
		map.put("sign", "updateSubjectStatusById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("SubjectManagement", map);
		// (3)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String estatus = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(estatus)) {// 交易成功
					super.log.info("标的状态信息更新,调用updateSubjectStatusById服务，信息：" + erortx);
				} else {
					super.log.error("标的状态信息更新,调用updateSubjectStatusById服务，信息：" + erortx);
				}
			}
		} else {
			super.log.error("调用服务失败！");
		}
		return;
	}

	 /**
	 * 根据条件查询所有竞标信息已过期切无竞标方的标的信息
	 * @return 标的信息列表
	 */
	private List<SubjectVo> querySubjectByCondition() {
		List<SubjectVo> subjectList = new ArrayList<SubjectVo>();
		SubjectVo parameters = new SubjectVo();
		parameters.setAttribute3("0");/*筛选竞标人数的值，这里是得到没人竞标的标的*/
		parameters.setAttribute4("1");/*筛选超过当前竞标时间的数据，将标的状态置为流标*/
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("sign", "querySubjectByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("SubjectManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				subjectList = JsonUtils.toList(resultJson, SubjectVo.class);
				super.log.info("根据条件查询标的调用querySubjectByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询标的调用querySubjectByCondition服务返回失败，信息：" + erortx);
			}
		}
		return subjectList;
	}
}
