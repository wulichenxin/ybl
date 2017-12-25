package com.bpm.framework.controller.v2.report.utils;

import java.util.HashMap;import com.alibaba.fastjson.JSONObject;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;import java.util.Map;

/**    
 * @Package com.bpm.framework.controller.v2.report.utils 
 * @Description: 封装了基础的groovy脚本、拼接sql
 * @author servin   
 * @date 2017.07.27
 * @version V1.0   
 */
public abstract class BaseScript {
	
	private def pageNum;
	private def pageSize;
	
	/**
	 * 
	 * 所有业务脚本实现
	 * 
	 * @return
	 */
	public abstract Object buildSql();
	
	public BaseScript() {
	}
	
	/**
	 * 
	 * 主体执行方法，外面不需要调，由ReportEngine调用
	 * 
	 */
	protected def execution(Map<String,Object> parameterMap) {
		pageNum = parameterMap.get("_pageNum");
		if(null != pageNum) {
			
			parameterMap.remove("_pageNum");
		}
		pageSize = parameterMap.get("_pageSize");
		if(null != pageSize) {
			parameterMap.remove("_pageSize");
		}
		Object sql = buildSql();
		def subSql = getWhere(parameterMap);
		
		return rows(sql + " " + subSql);
	}
	
	//查询报表数据
	private def rows(sql){
		//分页对象
		def page;
		
		//调用后台服务交易
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sql",sql);
		map.put("pageNum", pageNum);
		map.put("pageSize", pageSize);
		
		ResBody result =  TradeInvokeUtils.invoke("V2ExecuteReportScript", map);
		def records;
   		if(result.getSys()!=null){
  			String status = result.getSys().getStatus();
  			if("S".equals(status)){//交易成功
  				JSONObject output = (JSONObject) result.getOutput();
  				records = output.getString("result");
  				page = output.getString("page");
  			}			
  		}
   		
   		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("records",records);
	    resultMap.put("page",page);
   		return resultMap;
	}
	
	//拼接sql的where条件
	private def getWhere(Map<String, Map<String, Object>> param) {
		def str = "";
		for(Map.Entry<String, Object> e : param.entrySet()) {
			def key = e.key;
			Map<String, Object> valueMap = e.value;
			Object type = valueMap.get("type");
			Object value = valueMap.get("value");
			// select_box   text_box   date_box
			if(type == "DROP_DOWN_BOX") {
				str += " and " + key + " = '" + value + "'";
			} else if(type == "TEXT_BOX") {
				str += " and " + key + " like '%" + value + "%'";
			} else if(type == "DATE_BOX") {
				if(key.endsWith("_1")){
					key = key.replaceFirst("_1", "");
					str += " and " + key + " >= '" + value + "'";
				}else if(key.endsWith("_2")){
					key = key.replaceFirst("_2", "");
					str += " and " + key + " <= '" + value + "'";
				}
//				str += " and " + key + " = '" + value + "'";
			} else if(((String)type).startsWith("fixCondition_")) {// 固定条件
				if(!(value instanceof String)) {
					str += " and " + key + " = " + value + "";
				} else {
					str += " and " + key + " = '" + value + "'";
				}
			}
			
//			if(compareWay == "like" && value != ""){
//				str += " and " + key + " " + compareWay + " '%" + value + "%'";
//			}else if(compareWay == "in" && value != ""){
//				str += " and " + key + " " + compareWay + " (" + value + ")";
//			}else if(value != ""){
//				str += " and " + key + " " + compareWay + " " + value + "";
//			}
		}
		return str;
	}
}
