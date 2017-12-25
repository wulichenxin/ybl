package com.bpm.framework.controller.v4.enterprise;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.DocumentEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.ContractTemplateVO;
import cn.sunline.framework.controller.vo.v4.factor.AccountsPayableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.AccountsReceivableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.BillElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanAuditVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_STATUS;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.framework.controller.vo.v4.supplier.LoanApply;
import cn.sunline.framework.controller.vo.v4.supplier.LoanApplyInfo;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_LOAN_STATE;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 核心企业确权功能
 * 
 * @author pc
 *
 */
@Controller
@RequestMapping("/enterpriseAssetOwnership")
public class EnterpriseAssetOwnership extends AbstractController {

	private static final long serialVersionUID = 3879870855960437274L;

	/**
	 * 确权管理首页
	 * 
	 * @author pc
	 * @param factorLoanAuditVo
	 *            资金方放款审核实体
	 * @param pageVo
	 *            分页实体
	 * @return 确权管理列表页面
	 */
	@RequestMapping("/assetOwnershipList.htm")
	public String assetOwnershipList(FactorLoanAuditVo factorLoanAuditVo, PageVo<?> pageVo) {
		// (1) 用户登录判断
		UserVo user = ControllerUtils.getCurrentUser();
		if (user == null) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		// 只查询待确权的放款申请记录
		factorLoanAuditVo.setRightBusinessId(user.getBusinessId());
		factorLoanAuditVo.setStatus(E_V4_STATUS.WAIT_AUTHORIZE.getStatus());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("factorLoanAudit", factorLoanAuditVo);
		map.put("sign", "queryListByCondition");// 所调用的服务中的方法
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("EnterpriseAssetOwnership", map);

		List<FactorLoanAuditVo> list = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("factorLoanAudit");
				pageVo = JSONObject.parseObject(jsonPage, PageVo.class);
				if (records != null) {
					list = JsonUtils.toList(records, FactorLoanAuditVo.class);
				}
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询放款审核记录服务返回成功，信息：" + list);
			} else {
				super.log.error("根据条件查询查询放款审核记录服务返回失败，信息：" + erortx);
			}
		}
		getRequest().setAttribute("page", pageVo);
		getRequest().setAttribute("factorLoanAuditVo", factorLoanAuditVo);
		return "ybl4.0/admin/enterprise/rightManagement/assetOwnershipList";
	}

	/**
	 * 确权页面跳转
	 * 
	 * @param loanApplyId
	 *            放款申请ID
	 * @param assetsType
	 *            放款申请底层资产类型
	 * @param returnPage
	 *            返回按钮标识字段
	 * @return
	 */
	@RequestMapping("/assetTransfer.htm")
	public String assetTransfer(String loanApplyId, String assetsType, String returnPage) {
		// (1) 用户登录判断
		UserVo user = ControllerUtils.getCurrentUser();
		if (user == null) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		if (returnPage != null) {
			getRequest().setAttribute("returnPage", returnPage);
		}
		getRequest().setAttribute("id", loanApplyId);
		getRequest().setAttribute("assetsType", assetsType);
		// 查询附件
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sign", "queryprotocoltemplate");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("EnterpriseAssetOwnership", map);
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String contractTemplate = output.getString("result");
					if (contractTemplate != null) {
						List<ContractTemplateVO> list = JsonUtils.toList(contractTemplate, ContractTemplateVO.class);
						getRequest().setAttribute("list", list);
						super.log.error("根据条件查询模板服务返回成功，信息：" + list);
					}
				} else {
					super.log.error("根据条件查询查询模板服务返回失败，信息：" + erortx);
				}
			}
		}
		return "ybl4.0/admin/enterprise/rightManagement/assetTransfer";
	}

	/**
	 * 资产确权
	 * 
	 * @author pc
	 * @param attachment
	 *            确权需要的附件
	 * @param loanApplyId
	 *            待确权放款申请记录ID
	 * @return 确权结果
	 */
	@RequestMapping(value = "/assetOwnership")
	@ResponseBody
	@Log(operation = OperationType.Exe, info = "资产确权")
	public ControllerResponse assetOwnership(AttachmentVo attachment, String loanApplyId, String returnPage) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)参数设置
		Map<String, Object> maps = new HashMap<String, Object>();
		Object result = null;
		//1.1附件参数设置
		attachment.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		ControllerUtils.setWho(attachment);
		attachment.setEnable(1);
		maps.put("attachment", attachment);
		//1.2设置放款申请参数
		LoanApply loanApply = new LoanApply();
		loanApply.setId(Long.valueOf(loanApplyId));
		loanApply.setRightBusinessId(ControllerUtils.getCurrentUser().getBusinessId().intValue());
		loanApply.setStatus(E_V4_LOAN_STATE.TO_PLATFORM_AUDI.getStatus());
		loanApply.setLastUpdateBy(ControllerUtils.getCurrentUser().getId());
		loanApply.setLastUpdateTime(new Date());
		maps.put("loanApply", loanApply);
		// (2)调用服务，进行数据保存
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("param", maps);
		map.put("sign", "assetOwnership");// 所调用的服务中的方法
		result = TradeInvokeUtils.invoke("EnterpriseAssetOwnership", map);
		response.setResponseType(ResponseType.SUCCESS_SAVE);
		// (3)对调用服务后的返回数据进行解析
		if (result != null) {
			Map<String, Object> jsonMap = JsonUtils.toMap(result);
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			if (sys != null) {
				String status = sys.getString("status");// 状态：'S'成功，'F'失败
				String erortx = sys.getString("erortx");// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setObject(returnPage);// 设置返回结果
					response.setInfo("确权成功");// 添加成功
					super.log.info("assetOwnership服务调用信息：" + erortx);
				} else {
					response.setResponseType(ResponseType.ERROR);
					response.setInfo("确权失败");// 添加失败
					super.log.error("assetOwnership服务调用信息：" + erortx);
				}
			}
		} else {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo("调用服务失败");// 调用服务失败
			super.log.error("调用服务失败！");
		}
		return response;
	}

	/**
	 * 资产确权附件下载
	 * 
	 * @param response
	 * @param request
	 * @param templateId
	 *            附件ID
	 * @param loanApplyId
	 *            放款申请ID
	 */
	@RequestMapping(value = "/templateDownload", method = { RequestMethod.GET, RequestMethod.POST })
	public void attachmentDownload(HttpServletResponse response, HttpServletRequest request, Long templateId,
			Long loanApplyId) {
		UserVo user = ControllerUtils.getCurrentUser();
		Map<String, Object> map = new HashMap<String, Object>();
		FactorLoanAuditVo factorLoanAuditVo = new FactorLoanAuditVo();
		factorLoanAuditVo.setId(loanApplyId);
		factorLoanAuditVo.setRightBusinessId(user.getBusinessId());
		map.put("param", templateId);
		map.put("factorLoanAudit", factorLoanAuditVo);
		map.put("sign", "templateDownload");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("EnterpriseAssetOwnership", map);
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String contractTemplate = output.getString("result");
					if (contractTemplate != null) {
						ContractTemplateVO contractTemplateVO = JsonUtils.toObject(contractTemplate,
								ContractTemplateVO.class);
						super.log.error("根据条件查询模板服务返回成功，信息：" + contractTemplateVO);
						// html拼接出word内容
						String content = "<html>";
						String temp = contractTemplateVO.getTemplateContent();
						// html拼接出word内容
						content += "<div style=\"text-align: left\"><span >" + temp
								+ "<br /> <br /> </span></span></div>";
						// 插入分页符
						content += "<span lang=EN-US style='font-size:12.0pt;line-height:150%;mso-fareast-font-family:宋体;mso-font-kerning:1.0pt;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'></span>";
						content += "<p class=MsoNormal style='line-height:150%'><span lang=EN-US style='font-size:12.0pt;line-height:150%'><o:p> </o:p></span></p>";
						content += "</html>";
						try {
							ByteArrayInputStream bais = new ByteArrayInputStream(content.getBytes("GBK"));
							POIFSFileSystem poifs = new POIFSFileSystem();
							DirectoryEntry directory = poifs.getRoot();
							DocumentEntry documentEntry = directory.createDocument("WordDocument", bais);
							// 输出文件
							String name = "应收账款转让协议";
							response.reset();
							response.setHeader("Content-Disposition",
									"attachment;filename=" + new String((name + ".doc").getBytes(), "iso-8859-1"));
							response.setContentType("application/msword");
							OutputStream ostream = response.getOutputStream();
							poifs.writeFilesystem(ostream);
							ostream.flush();
							ostream.close();
							bais.close();

						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				} else {
					super.log.error("根据条件查询查询模板服务返回失败，信息：" + erortx);
				}
			}
		}
	}

	/**
	 * 资方办理页面跳转
	 * 
	 * @param loanApplyId
	 *            放款申请ID
	 * @param assetsType
	 *            底层资产类型
	 * @param returnPage
	 *            返回按钮标识
	 * @return 资方办理页面
	 */
	@RequestMapping("/capitalHandle.htm")
	public String capitalHandle(String loanApplyId, String assetsType, String returnPage) {
		// (1) 用户登录判断loanApplyId
		UserVo user = ControllerUtils.getCurrentUser();
		if (user == null) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		if (returnPage != null) {
			getRequest().setAttribute("returnPage", returnPage);
		}
		getRequest().setAttribute("id", loanApplyId);
		getRequest().setAttribute("type", assetsType);
		Map<String, Object> mapInfo = new HashMap<String, Object>();
		mapInfo.put("loanApplyId", loanApplyId);
		mapInfo.put("assetsType", assetsType);
		// 查询保理要素
		Map<String, Object> map = new HashMap<String, Object>();
		// (2)调用服务，进行数据保存
		map.put("param", mapInfo);
		map.put("sign", "queryFactoringElements");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("EnterpriseAssetOwnership", map);
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String elements = output.getString("elements");// 保理要素主表
					String underlyAssets = output.getString("result");// 底层资产表
					String fwAttachment = output.getString("fwAttachment");// 附件表
					if ("1".equals(assetsType)) {
						// 应收账款保理要素
						AccountsReceivableElementsVo receivableElementsResult = JsonUtils.toObject(elements,
								AccountsReceivableElementsVo.class);
						getRequest().setAttribute("ReceivableElementsResult", receivableElementsResult);
						// 应收账款底层资产
						List<AccountsReceivableV4VO> assetslist = JsonUtils.toList(underlyAssets,
								AccountsReceivableV4VO.class);
						getRequest().setAttribute("assetslist", assetslist);
					} else if ("2".equals(assetsType)) {
						// 应付账款保理要素vo
						AccountsPayableElementsVo payableElementsResult = JsonUtils.toObject(elements,
								AccountsPayableElementsVo.class);
						getRequest().setAttribute("payableElementsResult", payableElementsResult);
						// 应付账款底层资产
						List<AccountsPayableVO> assetslist = JsonUtils.toList(underlyAssets, AccountsPayableVO.class);
						getRequest().setAttribute("assetslist", assetslist);
					} else if ("3".equals(assetsType)) {
						// 票据保理要素
						BillElementsVo billElementsResult = JsonUtils.toObject(elements, BillElementsVo.class);
						getRequest().setAttribute("billElementsResult", billElementsResult);
						// 票据底层资产
						List<BillVO> assetslist = JsonUtils.toList(underlyAssets, BillVO.class);
						getRequest().setAttribute("assetslist", assetslist);
					}
					if (fwAttachment != null){
					    List<AttachmentVo> attachmentList = JsonUtils.toList(fwAttachment, AttachmentVo.class);
					    getRequest().setAttribute("list", attachmentList);
					}
					
				} else {
					super.log.error("根据条件查询资方办理信息返回失败，信息：" + erortx);
				}
			}
		}
		return "/ybl4.0/admin/enterprise/rightManagement/capitalHandle";
	}

	/**
	 * 放款申请详情页面跳转
	 * 
	 * @param loanApplyId
	 *            放款申请ID
	 * @param assetsType
	 *            底层资产类型
	 * @param returnPage
	 *            返回按钮标识
	 * @return 放款申请详情页面
	 */
	@RequestMapping("/loanApplicationDetails.htm")
	public String loanApplicationDetails(Long loanApplyId, String assetsType, String returnPage) {
		// (1) 用户登录判断
		UserVo user = ControllerUtils.getCurrentUser();
		if (user == null) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		if (returnPage != null) {
			getRequest().setAttribute("returnPage", returnPage);
		}
		getRequest().setAttribute("id", loanApplyId);
		getRequest().setAttribute("assetsType", assetsType);
		// 查询附件
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("param", loanApplyId);
		map.put("sign", "queryloanApplyInfo");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("EnterpriseAssetOwnership", map);
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String strLoan = output.getString("result");// 放款申请主信息
					String fwAttachment = output.getString("fwAttachment");// 附件表信息
					String underlyAssets = output.getString("elements");// 底层资产信息
					LoanApplyInfo loanApplyInfo = JsonUtils.toObject(strLoan, LoanApplyInfo.class);
					if(fwAttachment != null){
						List<AttachmentVo> attachmentList = JsonUtils.toList(fwAttachment, AttachmentVo.class);
						getRequest().setAttribute("attachmentList", attachmentList);
					}
					if (loanApplyInfo != null) {
						getRequest().setAttribute("loanApplyInfo", loanApplyInfo);
						if ("1".equals(loanApplyInfo.getAssetsType())) {// 应收账款底层资产信息
							List<AccountsReceivableV4VO> accountsReceivableList = JsonUtils.toList(underlyAssets,
									AccountsReceivableV4VO.class);
							getRequest().setAttribute("accountsReceivableList", accountsReceivableList);
						}
						if ("2".equals(loanApplyInfo.getAssetsType())) {// 应付账款底层资产信息
							List<AccountsPayableVO> accountsPayableList = JsonUtils.toList(underlyAssets,
									AccountsPayableVO.class);
							getRequest().setAttribute("accountsPayableList", accountsPayableList);
						}
						if ("3".equals(loanApplyInfo.getAssetsType())) {// 票据底层资产信息
							List<BillVO> billList = JsonUtils.toList(underlyAssets, BillVO.class);
							getRequest().setAttribute("billList", billList);
						}
						super.log.error("根据条件查询模板服务返回成功，信息：" + loanApplyInfo);
					}
				} else {
					super.log.error("根据条件查询查询模板服务返回失败，信息：" + erortx);
				}
			}
		}
		return "/ybl4.0/admin/enterprise/rightManagement/loanApplicationDetails";
	}

}
