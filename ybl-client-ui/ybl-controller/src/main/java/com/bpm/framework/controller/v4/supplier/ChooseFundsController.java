package com.bpm.framework.controller.v4.supplier;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.net.ftp.FTPClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.console.Application;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.FtpUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.file.ResponseDownloadUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({ "/chooseFundsController" })
public class ChooseFundsController extends AbstractController {

	private static final long serialVersionUID = 3738403280720538549L;

	/**
	 * 选择资金方列表
	 * 
	 * @param parm
	 *            筛选条件
	 * @param page
	 *            分页参数
	 * @return
	 */
	@RequestMapping(value = "chooseFundsList")
	public String chooseFundsList(ChooseFundsVo parm, PageVo page) {
		UserVo user = ControllerUtils.getCurrentUser();
		if (page == null) {
			page = new PageVo<>(1, 10);
		}

		if (parm == null) {
			parm = new ChooseFundsVo();
		}

		parm.setBusiness_id(user.getBusinessId());
		parm.setFinancing_status(4);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("financing", parm);
		maps.put("page", page);
		maps.put("sign", "selectToAuditFinancing");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FanacingCheckPendingManagement", maps);

		isSuccess(result);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringPage = output.getString("page");
				page = JSONObject.parseObject(stringPage, PageVo.class);
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息：" + page);
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);
				return null;
			}
		}
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("parm", parm);
		return "ybl4.0/admin/supplier/riskControlManagement/chooseFuns";
	}

	/**
	 * 确定资金方列表
	 * 
	 * @param parm
	 *            筛选条件
	 * @param page
	 *            分页参数
	 * @return
	 */
	@RequestMapping(value = "confirmFundsList")
	public String confirmFundsList(ChooseFundsVo parm, PageVo page) {
		UserVo user = ControllerUtils.getCurrentUser();
		if (page == null) {
			page = new PageVo<>(1, 10);
		}

		if (parm == null) {
			parm = new ChooseFundsVo();
		}

		parm.setBusiness_id(user.getBusinessId());
		parm.setFinancing_status(6);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("financing", parm);
		maps.put("page", page);
		maps.put("sign", "selectToAuditFinancing");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FanacingCheckPendingManagement", maps);

		isSuccess(result);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringPage = output.getString("page");
				page = JSONObject.parseObject(stringPage, PageVo.class);
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息：" + page);
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);
				return null;
			}
		}
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("parm", parm);
		return "ybl4.0/admin/supplier/riskControlManagement/confirmFuns";
	}

	/**
	 * 查询融资订单的下子订单所有的列表
	 * 
	 * @param id
	 *            融资主订单的id
	 * @param financing_status
	 *            融资子订单状态
	 * @return
	 */
	/*@ResponseBody*/
	@RequestMapping(value = "chooseSubFundsList")
	public String /*ControllerResponse*/ chooseSubFundsList(Integer id, Integer financing_status, Integer audit_type) {
		/*ControllerResponse response = new ControllerResponse(ResponseType.ERROR);*/
		PageVo page = new PageVo<>(1, 10);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("financing_apply_id", id);
		maps.put("financing_status", financing_status);
		maps.put("audit_type", audit_type);
		maps.put("sign", "selectFubFinancing");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FanacingCheckPendingManagement", maps);

		isSuccess(result);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringPage = output.getString("page");
				page = JSONObject.parseObject(stringPage, PageVo.class);
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息：" + page);
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);
				return null;
			}
		}
		getRequest().setAttribute("financing_id", id);
		getRequest().setAttribute("page", page);
		/*response.setInfo("操作成功");
		response.setResponseType(ResponseType.SUCCESS);
		response.setObject(page);*/
		/*return response;*/
		return "ybl4.0/admin/supplier/riskControlManagement/choosesubList";

	}
	
	@RequestMapping(value = "confirmSubFundsList")
	public String confirmSubFundsList(Integer id, Integer financing_status, Integer audit_type) {
		/*ControllerResponse response = new ControllerResponse(ResponseType.ERROR);*/
		PageVo page = new PageVo<>(1, 10);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("financing_apply_id", id);
		maps.put("financing_status", financing_status);
		maps.put("audit_type", audit_type);
		maps.put("sign", "selectFubFinancing");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FanacingCheckPendingManagement", maps);

		isSuccess(result);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringPage = output.getString("page");
				page = JSONObject.parseObject(stringPage, PageVo.class);
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息：" + page);
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);
				return null;
			}
		}
		getRequest().setAttribute("financing_id", id);
		getRequest().setAttribute("page", page);
		/*response.setInfo("操作成功");
		response.setResponseType(ResponseType.SUCCESS);
		response.setObject(page);*/
		/*return response;*/
		return "ybl4.0/admin/supplier/riskControlManagement/confirmsubList";

	}

	/**
	 * 更新融资主订单和融资子订单的状态
	 * 
	 * @param ids
	 *            被选中的融资子订单id( 1,2,3)
	 * @param financing_apply_id
	 *            融资子订单
	 * @param financing_status
	 *            状态
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "updateSubFundsList")
	public ControllerResponse updateSubFundsList(String ids, Integer financing_apply_id, Integer financing_status,
			Integer selection_status) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("ids", ids);
		maps.put("financing_apply_id", financing_apply_id);
		maps.put("financing_status", financing_status);
		maps.put("selection_status", selection_status);
		maps.put("sign", "updateFubFinancing");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FanacingCheckPendingManagement", maps);
		isSuccess(result);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				response.setResponseType(ResponseType.SUCCESS);
				response.setInfo("选择成功");
				return response;
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);
				response.setInfo("操作失败");
				return response;
			}
		}
		response.setObject("操作失败");
		return response;
	}

	/**
	 * 更新融资状态(用来撤销融资的)
	 * 
	 * @param financing_apply_id
	 *            融资订单id
	 * @param financing_status
	 *            99
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "updateSubFundAndPattnList")
	public ControllerResponse updateSubFundAndPattnList(Integer financing_apply_id, Integer financing_status) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("financing_apply_id", financing_apply_id);
		maps.put("financing_status", financing_status);
		maps.put("sign", "updateApplyFinancing");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FanacingCheckPendingManagement", maps);
		isSuccess(result);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				response.setResponseType(ResponseType.SUCCESS);
				response.setInfo("撤销成功");
				return response;
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);
				response.setInfo("操作失败");
				return response;
			}
		}
		response.setObject("操作失败");
		return response;
	}

	/**
	 * 初审附件下载
	 * 
	 * @param sub_id
	 *            融资申请订单
	 * @return
	 */
	@RequestMapping(value = "/downloadPreaAttachment")
	@ResponseBody
	public void downPraeiudiciumAttachment(Integer sub_id, HttpServletResponse response) {
		this.downAttchment("35", 3L, sub_id, response);

	}

	/**
	 * 终审附件下载
	 * 
	 * @param sub_id
	 *            融资申请订单
	 * @return
	 */
	@RequestMapping(value = "/downLastAttachment")
	public void downLastAttachment(Integer sub_id, HttpServletResponse response) {
		this.downAttchment("36", 4L, sub_id, response);

	}

	private void downAttchment(String type, Long category, Integer business_id, HttpServletResponse response) {
		/**
		 * 放款附件信息
		 */
		AttachmentVo attachment = new AttachmentVo();
		attachment.setType(type);
		attachment.setCategory(category);
		attachment.setResourceId(business_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", attachment);
		map.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
		ResBody resultAttachment = TradeInvokeUtils.invoke("AttachmentManagement", map);
		if (isSuccess(resultAttachment)) {
			JSONObject output = (JSONObject) resultAttachment.getOutput();
			String resultJson = output.getString("result");
			List<AttachmentVo> attachmentList = null;
			attachmentList = JsonUtils.toList(resultJson, AttachmentVo.class);
			if (attachmentList != null && attachmentList.size() > 0) {
				for (AttachmentVo attachmentVo : attachmentList) {
					try {
						String fileDownloadName = attachmentVo.getNewName();
						String oldName = attachmentVo.getOldName();
						// 判断是否配置了ftp，如果配置了ftp，则使用ftp上传
						String ip = Application.getInstance().getByKey("ftp.ip");
						String user = Application.getInstance().getByKey("ftp.user");
						String pwd = Application.getInstance().getByKey("ftp.password");
						// 先下载到本地的目录
						String tempDir = Application.getInstance().getByKey("app.attach.file_upload_temp.dir");
						// randomName="aa.jpg"
						File file = new File((tempDir + "/" + fileDownloadName).replaceAll("\\\\", "/"));
						// 如果文件不存在则先从FTP服务器上下载到本地
						if (!file.exists() && StringUtils.isNotEmpty(ip)) {
							StringBuffer sb = new StringBuffer();
							sb.append("开始ftp下载，ip = ").append(ip).append(";user = ").append(user).append(";pwd = ")
									.append(pwd).append(";本地地址 = ").append(file.getParent()).append(";文件名称= ")
									.append(file.getName());
							log.info(sb.toString());
							FTPClient client = FtpUtils.loginFtp(ip, user, pwd);
							client.changeWorkingDirectory("customer");
							boolean ftpFlag = FtpUtils.downOneFile(client, file.getParent(), file.getName());
							log.info("开始ftp下载结果： " + ftpFlag);
						}
						String agent = getRequest().getHeader("User-Agent").toLowerCase();
						boolean isFirefox = (agent.indexOf("firefox") > -1);
						// 下载
						ResponseDownloadUtils.download(response, file, oldName, isFirefox);
					} catch (Exception ex) {
						log.error("下载文件异常：", ex);
						throw new RuntimeException("下载文件异常：", ex);
					}
				}
			}
		}
	}

}
