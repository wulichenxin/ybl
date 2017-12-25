package com.bpm.framework.controller.v2.report.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.common.ConfigCache;
import com.bpm.framework.controller.v2.report.utils.ReportEngine;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.bean.ConvertUtils;
import com.bpm.framework.utils.file.ExcelUtils;
import com.bpm.framework.utils.file.ResponseDownloadUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.v2.ReportOutputParameter;
import cn.sunline.framework.controller.vo.v2.ReportRequiredParameterVo;
import cn.sunline.framework.controller.vo.v2.ReportVo;
import cn.sunline.framework.controller.vo.v2.TConfig;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 报表控制器
 * 
 * @author jzx
 *
 */
@Controller
@RequestMapping("reportFormController")
public class ReportFormController extends AbstractController {

	private static final long serialVersionUID = 1L;

	@RequestMapping("/{code}/queryReportFrom.htm")
	public String queryReportFrom(HttpServletRequest request, @PathVariable("code") String code, PageVo<?> page) {
		// 获取报表参数
		Map<String, Object> map = getReportMap(code);
		boolean isExist = false;
		if(!map.isEmpty()){//报表存在
			isExist = true;
			map.put("page", page);
			/* 调用报表引擎，返回数据 */
			queryReportData(request, map);
			/* 将code返回回去 */
			request.setAttribute("code", code);
			request.setAttribute("reportForm", map.get("reportForm"));
			request.setAttribute("parameterList", map.get("parameterList"));
			request.setAttribute("outputParamterList", map.get("outputParamterList"));
			/* 查询条件回显 */
			request.setAttribute("paramMap", map.get("paramMap"));
		}
		request.setAttribute("isExist", isExist);
		return "ybl/v2/admin/report/report";
	}

	/**
	 * 调用报表引擎，返回数据
	 * 
	 * @param request
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private void queryReportData(HttpServletRequest request, Map<String, Object> map) {
		try {
			Map<String, Object> returnMap = ReportEngine.service(map);
			String recordes = (String) returnMap.get("records");
			String page = (String) returnMap.get("page");
			List<ReportOutputParameter> outputParamterList = (List<ReportOutputParameter>) map
					.get("outputParamterList");
			List<Map<String, Object>> list = switchType(recordes, outputParamterList);
			PageVo<?> pageVo = JsonUtils.toObject(page, PageVo.class);

			request.setAttribute("list", list);
			request.setAttribute("page", pageVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取报表参数
	 * 
	 * @param code
	 *            报表的编码
	 * @return Map<String, Object>
	 */
	private Map<String, Object> getReportMap(String code) {
		Map<String, Object> map = new HashMap<>();
		List<ReportRequiredParameterVo> parameterList = null;
		List<ReportOutputParameter> outputParamterList = null;
		ReportVo reportForm = queryReportFormByCondition(code);
		if (reportForm != null && reportForm.getId() != null) {
			parameterList = queryParamterByCondition(reportForm.getId());
			outputParamterList = queryOutputParamterByCondition(reportForm.getId());
		}else{
			return map;
		}
		/* 获取页面查询参数（可能没有） */
		Map<String, String[]> paramMap = getRequest().getParameterMap();
		
		//针对时间区域查询
		if(parameterList!=null && parameterList.size()>0){
			for(ReportRequiredParameterVo o : parameterList) {
				String field = o.getField();
				String[] value = paramMap.get(field + "_1");
				if(null == value || value.length == 0) continue;
				o.setAttribute1(field + "_1");
				value = paramMap.get(field + "_2");
				if(null == value || value.length == 0) continue;
				o.setAttribute2(field + "_2");
			}
		}
		
		map.put("reportForm", reportForm);
		map.put("parameterList", parameterList);
		map.put("outputParamterList", outputParamterList);
		
		// 用户端需要默认带上企业id作为查询条件
		Map<String, String[]> paramMaps = new HashMap<String, String[]>();
		paramMaps.putAll(paramMap);
		String[] str = new String[]{ControllerUtils.getCurrentUser().getEnterpriseId().toString()};
		paramMaps.put("enterprise_id",str);
		
		map.put("paramMap", paramMaps);
		return map;
	}

	/**
	 * 处理引擎返回数据类型的转换
	 * @param recordes 数据集合
	 * @param outputParamterList 输出参数集合
	 * @return List<Map<String, Object>>
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private List<Map<String, Object>> switchType(String recordes, List<ReportOutputParameter> outputParamterList) {
		List<Map<String, Object>> list = (List) JsonUtils.toList(recordes, Map.class);
		try {
			// 得到每个字段对应的类型
			Map<String, Class<?>> fieldTypeMap = new HashMap<>();
			for (ReportOutputParameter o : outputParamterList) {
				fieldTypeMap.put(o.getField(), Class.forName(o.getType()));
			}

			// 类型转换
			for (Map<String, Object> e : list) {
				for (Map.Entry<String, Object> ee : e.entrySet()) {
					try {
						Class<?> clazz = fieldTypeMap.get(ee.getKey());
						if (clazz.newInstance() instanceof Date) {
							Long dateMisc = Long.valueOf(ee.getValue().toString());
							Date dat = new Date(dateMisc);
							GregorianCalendar gc = new GregorianCalendar();
							gc.setTime(dat);
							java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
							String sb = format.format(gc.getTime());
							ee.setValue(sb);
						} else {
							ee.setValue(ConvertUtils.convertGt(ee.getValue().toString(), clazz));
						}
					} catch (Exception ex) {
					}
				}
			}
		} catch (Exception ex) {
		}
		return list;
	}

	/**
	 * 根据条件询报表查询的参数对象
	 * 
	 * @param code
	 *            编码
	 * @return
	 */
	private ReportVo queryReportFormByCondition(String code) {
		ReportVo param = new ReportVo();
		param.setCode(code);// 编码
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("report", param);
		map.put("page", new PageVo<>());// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V2ReportManagementQuery", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<ReportVo> returnList = new ArrayList<>();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("reportList");
				returnList = JsonUtils.toList(resultJson, ReportVo.class);
				if (CollectionUtils.isNotEmpty(returnList)) {
					for(ReportVo v:returnList){
						if(code.equals(v.getCode())){
							return v;
						}
					}
				}
			}
		}
		return new ReportVo();
	}

	/**
	 * 根据条件询报表查询的参数对象集合
	 * 
	 * @param reportId
	 *            报表id
	 * @return
	 */
	private List<ReportRequiredParameterVo> queryParamterByCondition(Long reportId) {
		ReportRequiredParameterVo param = new ReportRequiredParameterVo();
		param.setReportId(reportId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reqireParameter", param);
		map.put("page", new PageVo<>());
		ResBody result = TradeInvokeUtils.invoke("V2ReportInputParameterManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<ReportRequiredParameterVo> returnList = new ArrayList<>();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("requireParameterList");
				returnList = JsonUtils.toList(resultJson, ReportRequiredParameterVo.class);
			}
		}
		return returnList;
	}

	/**
	 * 根据条件询报表展示参数对象集合
	 * 
	 * @param reportId
	 *            报表id
	 * @return
	 */
	private List<ReportOutputParameter> queryOutputParamterByCondition(Long reportId) {
		ReportOutputParameter param = new ReportOutputParameter();
		param.setReportId(reportId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportOutput", param);
		ResBody result = TradeInvokeUtils.invoke("V2ReportOutputParamterQueryManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<ReportOutputParameter> returnList = new ArrayList<>();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				returnList = JsonUtils.toList(resultJson, ReportOutputParameter.class);
			}
		}
		return returnList;
	}

	/**
	 * 批量导出Excel-报表查询
	 * 
	 * @param request
	 * @param response
	 * @param code
	 *            报表编码
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping({ "/exportReport/{code}" })
	@Log(operation = OperationType.Exe, info = "导出报表查询")
	public void exportReport(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("code") String code) {
		// (1)获取报表参数
		Map<String, Object> map = getReportMap(code);
		map.put("page", new PageVo<>());
		// (2)构造基础参数(报表名称,报表表头参数)
		/* 报表名称 */
		ReportVo reportForm = (ReportVo) map.get("reportForm");
		reportForm.setIsPage(0);/* 导出时，不分页，查询全部 */
		map.put("reportForm", reportForm);
		String title = reportForm.getName();
		String exportType = reportForm.getExportType();/*导出类型*/
		/* 报表表头参数 */
		List<ReportOutputParameter> outputParamterList = (List<ReportOutputParameter>) map.get("outputParamterList");
		String[] columnTitles = { }; // 序号
		if (outputParamterList != null && outputParamterList.size() > 0) {
			columnTitles = new String[outputParamterList.size() + 1];
			int i = 1;
			columnTitles[0]= I18NUtils.getText("sys.v2.client.no");
			for (ReportOutputParameter output : outputParamterList) {
				if (i < outputParamterList.size() + 1) {
					columnTitles[i] = output.getName();
					i++;
				}
			}
		}
		// (3)调用引擎查询该报表所有数据
		List<String[]> dataList = new ArrayList<String[]>();
		Map<String, Object> returnMap;
		try {
			returnMap = ReportEngine.service(map);
			String recordes = (String) returnMap.get("records");
			List<Map<String, Object>> list = switchType(recordes, outputParamterList);
			// (4)构造数据
			int row = 1;
			for (Map<String, Object> map1 : list) {
				
				int col = 0;
				String[] rowData = new String[columnTitles.length];
				rowData[col++] = String.valueOf(row++);
				for(ReportOutputParameter o : outputParamterList){
					if(StringUtils.isNotEmpty(o.getConfigKey())){/*是配置参数*/
						TConfig config = ConfigCache.getByTypeCode(o.getConfigKey(), map1.get(o.getField()).toString());
						rowData[col ++] = config.getValue();
					}else{
						rowData[col++] = map1.get(o.getField()).toString();
					}
				}
				dataList.add(rowData);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		//火狐浏览器乱码问题
		String agent=request.getHeader("User-Agent").toLowerCase();
		boolean isFirefox = (agent.indexOf("firefox") > -1);
		if("Excel".equals(exportType)){/*Excel*/
			File file = ExcelUtils.simpleCreate(title, columnTitles, dataList);
			ResponseDownloadUtils.download(response, file, isFirefox);
		}else{/*其他文件*/
			/*File file = new File();
			ResponseDownloadUtils.download(response, file, title,isFirefox);*/
		}
		
	}
}
