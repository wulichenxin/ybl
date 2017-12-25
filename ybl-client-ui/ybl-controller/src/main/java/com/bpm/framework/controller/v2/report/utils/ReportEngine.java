package com.bpm.framework.controller.v2.report.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.v2.ReportRequiredParameterVo;
import cn.sunline.framework.controller.vo.v2.ReportVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;
import groovy.lang.GroovyObject;
import groovy.util.GroovyScriptEngine;

/**    
 * @Package com.bpm.framework.controller.v2.report.utils 
 * @Description: 报表引擎 
 * @author servin   
 * @date 2017年7月27日
 * @version V1.0   
 */
public final class ReportEngine {
	
	private final static Logger log = LoggerFactory.getLogger(ReportEngine.class);
	
	private ReportEngine() {}
	
	/**
	 * @Description:<scan>获取列表数据、分页信息</scan>
	 * @Parameter：reportParam必须包含如下信息<br/>报表配置信息（所在表名：ybl_v2_report,key:reportForm）、<br/>报表查询参数信息（所在表名：ybl_v2_report_required_parameter,key:paramMap）、<br/>分页实体类（key:page）
	 * @return <code>Map<String,Object></code> (key:records，列表数据、key:page，分页实体类)
	 */
	@SuppressWarnings("unchecked")
	public static Map<String,Object> service(Map<String,Object> reportParam) throws Exception{
		ReportVo report = (ReportVo) reportParam.get("reportForm");
		String code = report.getCode();
		if(StringUtils.isNullOrBlank(code)){
			throw new Exception("code not allown null or blank");
		}
		//获取查询参数配置
		Map<String, String[]> paramMap = (Map<String, String[]>) reportParam.get("paramMap");
		
		PageVo<?> page = (PageVo<?>) reportParam.get("page");
		List<ReportRequiredParameterVo> parameterList = new ArrayList<>();
		Map<String, Object> queryParam = new HashMap<>();
		if(paramMap != null){
			parameterList = (List<ReportRequiredParameterVo>) reportParam.get("parameterList");
			queryParam = getQueryParam(parameterList,paramMap);
		}
		Map<String,Object> executeScript = executeScript(report,page,queryParam);
		return executeScript;
	}
	
	/**
	 * @throws Exception 
	 * 
	 * @Title: getGroovyScript 
	 * @Description:获取存在数据库中的groovy脚本
	 * @param code 脚本code
	 * @return groovy脚本的绝对路径
	 */
	private static File getGroovyScript(String code) throws Exception{
		Map<String,Object> map = new HashMap<>();
		ReportVo reportVo = new ReportVo();
		reportVo.setCode(code);
		map.put("report", reportVo);
		ResBody resBody = TradeInvokeUtils.invoke("V2ReportManagementQuery", map);
		//获取报表配置
		List<ReportVo> list= new ArrayList<>();
 		if(resBody.getSys()!=null){
			String status = resBody.getSys().getStatus();
			String erortx = resBody.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) resBody.getOutput();
				String records = output.getString("reportList");
				list = JsonUtils.toList(records, ReportVo.class);
				log.warn("根据条件查询报表配置queryReportByCondition服务返回成功，信息："+list);
			}else{
				log.warn("根据条件查询报表配置queryReportByCondition服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		
 		if(list != null && list.size() == 1){
 			reportVo = list.get(0);
 		}else{
 			log.warn("传入的报表code有误");
			return null;
 		}
 		
 		//当前groovy脚本
 		String groovyScript = reportVo.getGroovyScript();
 		
 		//获取当前路径
 		String curPath = System.getProperty("user.dir");
 		
 		//获取当前系统的文件分隔符
// 		String separator = File.separator;
 		//生成的脚本名为脚本的code值
 		File file = new File(curPath, code + ".groovy");
 		
 		if(file.exists()){
 			//删除之前生成的脚本
 			file.delete();
 		}else{
 			file.getParentFile().mkdirs();
 			try {
				file.createNewFile();
			} catch (Exception e) {
				e.printStackTrace();
			}
 		} 		OutputStreamWriter outputStreamWriter = null;
 		try {
	 		//创建输入流
			outputStreamWriter = new OutputStreamWriter(new FileOutputStream(file), "utf-8");
			outputStreamWriter.write(groovyScript);
			outputStreamWriter.flush(); 		} catch(Exception e) {
 			log.error("生成groovy脚本异常：", e);
 		} finally {
 			if(null != outputStreamWriter) {
 				outputStreamWriter.close();
 				outputStreamWriter = null;
 			}
 		}
		
		return file;
	}
	
	/**
	 * @throws Exception 
	 * 
	 * @Title: getData 
	 * @Description: 执行脚本
	 * @param reportvo 表格配置实体类
	 * @param pagevo 分页数据
	 * @param parameterMap    查询参数配置 
	 * @return List<Map<String,Object>>    返回表格数据
	 */
	@SuppressWarnings("unchecked")
	private static Map<String,Object> executeScript(ReportVo reportvo,PageVo<?> pagevo,Map<String,Object> parameterMap) throws Exception{
		String code = reportvo.getCode();
		File groovyScript = getGroovyScript(code);
		GroovyScriptEngine scriptEngine = new GroovyScriptEngine(groovyScript.getAbsolutePath());
		GroovyObject groovyObject = (GroovyObject)scriptEngine.loadScriptByName(code + ".groovy").newInstance();

		//删除生成的脚本文件
		if (groovyScript.exists()) {
			groovyScript.delete();
		}
		if(reportvo.getIsPage() == 1){
			parameterMap.put("_pageNum", pagevo.getCurrentPage());
			parameterMap.put("_pageSize", pagevo.getPageSize());
		}
		
		Map<String,Object> resultMap =  (Map<String, Object>)groovyObject.invokeMethod("execution", parameterMap);
		return resultMap;
	}

	/**
	 * 
	 * @Title: getQueryParam 
	 * @Description: 获取表格的查询条件配置 
	 * @param @param 表格code
	 * @param @return    查询条件配置 
	 * @return Map<String,Object>    返回类型 
	 */
	private static Map<String,Object> getQueryParam(List<ReportRequiredParameterVo> paramterConfig,Map<String,String[]> paramterMap){
		Map<String,Object> map = new HashMap<String,Object>();
		
		//遍历查询参数的map
		for(Map.Entry<String, String[]> e : paramterMap.entrySet()) {
			String key = e.getKey();
			String value =  e.getValue()[0];
			//组装查询参数的名字、值、比较方式为一个map
			if(StringUtils.isEmpty(value)){
				continue;
			}
			
			// 企业id特殊处理
			if("enterprise_id".equals(key)) {
				Map<String, Object> valueMap = new HashMap<String,Object>();
				valueMap.put("value", Long.valueOf(value));
				valueMap.put("type", "fixCondition_" + key);// 日期框
				map.put(key, valueMap);
				continue;
			}
			
			for(int i = 0; i < paramterConfig.size(); i++){
				ReportRequiredParameterVo requiredParameterVo = paramterConfig.get(i);
				String type = requiredParameterVo.getType();
				String field = requiredParameterVo.getField();
				//日期框需要特殊处理
				if("DATE_BOX".equals(type) && (key.equals(field + "_1") || key.equals(field + "_2"))){
					Map<String, Object> valueMap = new HashMap<String,Object>();
					valueMap.put("value", value);
					valueMap.put("type", type);// 日期框
					map.put(key, valueMap);
					break;
				}else if(key.equals(requiredParameterVo.getField())){
					Map<String, Object> valueMap = new HashMap<String,Object>();
					valueMap.put("value", value);
					valueMap.put("type", type);// 下拉框/文本框
					map.put(key, valueMap);
					break;
				}
			}
		}
		return map;
	}
}
