package com.bpm.framework.controller.subject;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.fileupload.AttachmentVo;
import com.bpm.framework.sequence.Sequence;
import com.bpm.framework.sequence.generator.DateTimeSequence;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.ConfigLoanMaterialVo;
import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.LoanSignBidVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.ProductConfigLoanMaterialVo;
import cn.sunline.framework.controller.vo.SubjectBatchVo;
import cn.sunline.framework.controller.vo.SubjectBidVo;
import cn.sunline.framework.controller.vo.SubjectVo;
import cn.sunline.framework.controller.vo.SubjectVoucherVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.VoucherVo;
import cn.sunline.framework.controller.vo.common.FormListObject;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 标的管理controller
 * 
 * @author MaiBenBen
 *
 */
@Controller
@RequestMapping({ "/subjectController" })
public class SubjectController extends AbstractController {

	private static final long serialVersionUID = 6345154754700285729L;

	/**
	 * 标的列表页面跳转，并加载数据
	 * @param subject 标的查询对象
	 * @param step 跳转到不同页面的标志
	 * @param page 分页对象
	 * @return
	 */
	@RequestMapping({ "/subjectList" })
	public String querySubjectList(PageVo<?> page, SubjectVo subject, String step) {
		// (1)获取当前登录人的信息
		UserVo userVo = ControllerUtils.getCurrentUser();
		if (userVo != null && userVo.getId() != null) {
			subject.setMemberId(userVo.getId());
			subject.setEnterpriseId(userVo.getEnterpriseId());
			subject.setId(-1L);
		}
		if ("bid_subject".equals(step) && StringUtils.isEmpty(subject.getStatus()) ) {
			subject.setStatus("'biding','paymenting','end','fail_subject','reject'");
		}
		subject.setEnable(1);// 有效
		JSONObject output = querySubjectByCondition(subject, page);
		if (output != null) {
			String pageJson = output.getString("page");
			String resultJson = output.getString("result");
			page = (PageVo<?>) JSONObject.parseObject(pageJson, PageVo.class);
			List<SubjectVo> subjectList = JsonUtils.toList(resultJson, SubjectVo.class);
			getRequest().setAttribute("subjectList", subjectList);
			getRequest().setAttribute("page", page);
		}
		getRequest().setAttribute("subject", subject);
		if ("fail_subject".equals(step)) {// 流标管理页面
			return "ybl/admin/supplier/subject/failSubject";
		} else if ("bid_subject".equals(step)) {
			return "ybl/admin/supplier/subject/bidManage";
		} else {
			return "ybl/admin/supplier/subject/commonSubjectManage";
		}
	}

	/**
	 * 标的编辑页面跳转，并加载数据
	 * @param id 标的id
	 * @return
	 */
	@RequestMapping({ "/editSubject" })
	public String toReleaseSubjectPage(Long id) {
			Map<String, Object> map = findEditSubjectMessage(id);
			Sequence seq = new DateTimeSequence();
			String subjectNum = seq.next("S");
			getRequest().setAttribute("subjectNum", subjectNum);
			if (CollectionUtils.isNotEmpty(map)) {
				getRequest().setAttribute("subject", map.get("subject"));
				getRequest().setAttribute("enterprise", map.get("enterprise"));
				getRequest().setAttribute("subjectVoucherList", map.get("subjectVoucherList"));
				getRequest().setAttribute("page", map.get("page"));
				getRequest().setAttribute("loanmaterialList", map.get("loanmaterialList"));
			}
		return "ybl/admin/supplier/subject/releaseSubject";
	}

	/**
	 * 标的详情页面跳转，并加载数据
	 * @param id 标的id
	 * @return
	 */
	@RequestMapping({ "/lookSubject-{id}"})
	public String toSubjectPage(@PathVariable Long id) {
			Map<String, Object> map = findEditSubjectMessage(id);
			if (CollectionUtils.isNotEmpty(map)) {
				getRequest().setAttribute("subject", map.get("subject"));
				getRequest().setAttribute("enterprise", map.get("enterprise"));
				getRequest().setAttribute("subjectVoucherList", map.get("subjectVoucherList"));
				getRequest().setAttribute("page", map.get("page"));
				getRequest().setAttribute("loanmaterialList", map.get("loanmaterialList"));
				//查询竞标信息
				SubjectBidVo parameters = new SubjectBidVo();
				parameters.setLoanSignId(id);
				JSONObject output = queryLoanBidBySubjectId(parameters, new PageVo<>());
				if (output != null) {
					String resultJson = output.getString("result");
					List<SubjectBidVo> subjectBidList = JsonUtils.toList(resultJson, SubjectBidVo.class);
					getRequest().setAttribute("subjectBidList", subjectBidList);
				}
			}
		return "ybl/admin/supplier/subject/subjectDetails";
	}
	

	/**
	 * 竞标编辑页面跳转，并加载数据
	 * @param status 竞标的状态
	 * @param parameters 竞标查询条件
	 * @param page 分页对象
	 * @return
	 */
	@RequestMapping({ "/queryBidList" })
	public String queryBidList(SubjectBidVo parameters, PageVo<?> page,String status) {
		// (1)调用服务查询竞标方列表
		JSONObject output = queryLoanBidBySubjectId(parameters, page);
		if (output != null) {
			String pageJson = output.getString("page");
			String resultJson = output.getString("result");
			page = (PageVo<?>) JSONObject.parseObject(pageJson, PageVo.class);
			List<SubjectBidVo> subjectBidList = JsonUtils.toList(resultJson, SubjectBidVo.class);
			getRequest().setAttribute("subjectBidList", subjectBidList);
			getRequest().setAttribute("page", page);
		}
		getRequest().setAttribute("status", status);
		getRequest().setAttribute("parameters", parameters);
		return "ybl/admin/supplier/subject/bidEdit";
	}

	/**
	 * 竞标详情页面跳转，并加载数据
	 * @param parameters 竞标查询条件 
	 * @return
	 */
	@RequestMapping({ "/toBidPage" })
	public String toBidPage(SubjectBidVo parameters) {
		// (1)调用服务查询竞标方列表
		JSONObject output = queryLoanBidBySubjectId(parameters, new PageVo<>());
		if (output != null) {
			String resultJson = output.getString("result");
			List<SubjectBidVo> subjectBidList = JsonUtils.toList(resultJson, SubjectBidVo.class);
			if(CollectionUtils.isNotEmpty(subjectBidList)){
				getRequest().setAttribute("subjectBid", subjectBidList.get(0));
			}
		}
		return "ybl/admin/supplier/subject/bidDetails";
	}

	/**
	 * 查询标的页面的内容
	 * @param id 标的id
	 * @return
	 */
	@RequestMapping({ "/findEditSubjectMessage" })
	public Map<String, Object> findEditSubjectMessage(Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		// (1)获取当前登录人的信息
		UserVo userVo = ControllerUtils.getCurrentUser();
		List<ProductConfigLoanMaterialVo> productList = null;
		if (userVo != null && userVo.getId() != null) {
			//id存在，查询该标的的信息
			if (id != null) {
				// 查询标的详情
				SubjectVo subject = findSubjectByCondition(id,"");
				map.put("subject", subject);
				// 查询融资主体信息
				EnterpriseVo enterprise = findOneEnterprise(subject.getEnterpriseId());
				map.put("enterprise", enterprise);
				// 查询标的凭证信息
				SubjectVoucherVo parameters = new SubjectVoucherVo();
				parameters.setLoanSignId(id);
				JSONObject output = querySubjectVoucherByCondition(parameters, new PageVo<>());
				if (output != null) {
					String pageJson = output.getString("page");
					String resultJson = output.getString("result");
					PageVo<?> page = (PageVo<?>) JSONObject.parseObject(pageJson, PageVo.class);
					List<VoucherVo> subjectVoucherList = JsonUtils.toList(resultJson, VoucherVo.class);
					map.put("subjectVoucherList", subjectVoucherList);
					map.put("page", page);
				}
				// 查询标的已添加的产品贷款信息
				ProductConfigLoanMaterialVo product = new ProductConfigLoanMaterialVo();
				product.setBusinessId(id);
				product.setType("bid");
				productList = queryLoanBySubjectId(product);
				map.put("productList", productList);
			}else{
				// 查询融资主体信息
				EnterpriseVo enterprise = findOneEnterprise(userVo.getEnterpriseId());
				map.put("enterprise", enterprise);
			}
		}
		// 查询所有的贷款资料配置信息
		List<ConfigLoanMaterialVo> loanmaterialList = queryAllLoanMaterial();
		if (CollectionUtils.isNotEmpty(loanmaterialList)) {
			map.put("loanmaterialList", loanmaterialList);
			if (CollectionUtils.isNotEmpty(productList)) {
				for (ProductConfigLoanMaterialVo pp : productList) {
					for (ConfigLoanMaterialVo config : loanmaterialList) {
						if (pp.getCode().equals(config.getCode())) {
							config.setAttribute1(pp.getAttribute1());//已存在的附件url
							config.setAttribute2(pp.getId().toString());//已存在id
							config.setLastUpdateTime(pp.getLastUpdateTime());//上传时间
						}
					}
				}
			}
		}
		return map;
	}

	/**
	 * 根据条件查询标的信息
	 * 
	 * @param request
	 * @param parameters
	 *            标的查询条件
	 * @param page 分页对象
	 * @return
	 */
	@RequestMapping(value = "/querySubjectByCondition")
	@ResponseBody
	public JSONObject querySubjectByCondition(SubjectVo parameters, PageVo<?> page) {
		parameters.setEnable(1);// （0：否，1：是）
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", page);
		map.put("sign", "querySubjectByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("SubjectManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				super.log.info("根据条件查询标的调用querySubjectByCondition服务返回成功，信息：" + erortx);
				return output;
			} else {
				super.log.error("根据条件查询标的调用querySubjectByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return null;
	}

	/**
	 * 查询所有贷款材料
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryAllLoanMaterial")
	@ResponseBody
	public List<ConfigLoanMaterialVo> queryAllLoanMaterial() {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", "");
		map.put("page", new PageVo<>());
		map.put("sign", "queryAllProductLoanMateriaPlatConf");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("ProductsFactoryManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<ConfigLoanMaterialVo> loanMetailsList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				loanMetailsList = JsonUtils.toList(resultJson, ConfigLoanMaterialVo.class);
				super.log.info("查询全部标的调用queryAllProductLoanMateriaPlatConf服务返回成功，信息：" + erortx);
			} else {
				super.log.error("查询全部标的调用queryAllProductLoanMateriaPlatConf服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return loanMetailsList;
	}

	/**
	 * 根据id查询标的信息
	 * 
	 * @param request
	 * @param id
	 *            标的id
	 * @param  number 标的编号
	 * @return
	 */
	@RequestMapping(value = "/findSubjectByCondition")
	@ResponseBody
	public SubjectVo findSubjectByCondition(Long id,String number) {
		SubjectVo parameters = new SubjectVo();
		parameters.setId(id);
		parameters.setNumber(number);
		parameters.setEnable(1);// 有效
		JSONObject output = querySubjectByCondition(parameters, new PageVo<>());
		if (output != null) {
			String resultJson = output.getString("result");
			List<SubjectVo> subjectList = JsonUtils.toList(resultJson, SubjectVo.class);
			if (CollectionUtils.isNotEmpty(subjectList)) {
				parameters = subjectList.get(0);
				return parameters;
			}
		}
		return null;
	}

	/**
	 * 保存/编辑标的数据
	 * 
	 * @param request
	 * @param parameters
	 *            提交的标的数据
	 * @param roleType
	 *            角色类型
	 *            
	 * @param formListObject form表单提交的集合数据
	 * @return
	 */
	@RequestMapping(value = "/addOrUpdateSubject")
	@ResponseBody
	public ControllerResponse addOrUpdateSubject(SubjectVo parameters, String roleType, FormListObject formListObject) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		SubjectBatchVo subjectBatchVo = new SubjectBatchVo();
		// (1)判断是否有数据
		if (parameters == null || StringUtils.isEmpty(parameters.getNumber())) {
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));// 参数错误
			super.log.error("保存/编辑标的数据对象不能为空！");
			return response;
		}
		// (3)新增/编辑操作
		Long subjectId = parameters.getId();
		ControllerUtils.setWho(parameters);// 设置时间、操作人
		parameters.setEnable(1);// 设置有效字段（0：否，1：是）
		parameters.setSign("");// 设置签名字段
		// (4)校验标的编号是否重复（新增时需要判断）
		String number = parameters.getNumber();// 标的编号
		// 查询标的的方法（调用服务，得到用户数据集合）
		// (5)获取当前登录人的信息
		UserVo userVo = ControllerUtils.getCurrentUser();
		SubjectVo subject = null;
		if (userVo != null && userVo.getId() != null) {
			Long enterpriseId = userVo.getEnterpriseId();
			parameters.setEnterpriseId(enterpriseId);
			parameters.setMemberId(userVo.getId());
			subject = findSubjectByCondition(-1L, number);
		}
		// 集合数据提交
		if (formListObject != null) {
			// 标的凭证信息
			List<SubjectVoucherVo> voucherList = formListObject.getSubjectVoucherList();
			List<SubjectVoucherVo> addvoucherList = new ArrayList<SubjectVoucherVo>();
			if (CollectionUtils.isNotEmpty(voucherList)) {
				for (SubjectVoucherVo parameter : voucherList) {
					if (parameters != null && parameter.getVoucherId() != null) {
						ControllerUtils.setWho(parameter);// 设置时间、操作人
						parameter.setEnable(1);// 设置有效字段（0：否，1：是）
						parameter.setSign("");// 设置签名字段
						parameter.setVoucherStatus(Constant.VOUCHER_NOT_CERTIFIED);//未认证
						parameter.setEnterpriseId(userVo.getEnterpriseId());
						addvoucherList.add(parameter);
					}
				}
				subjectBatchVo.setSubjectVoucherList(addvoucherList);
			}else{
				if (subjectId == null || subjectId.intValue() == -1L) { // 新增
					response.setInfo(I18NUtils.getText("sys.client.please.add.voucher"));//请添加凭证信息
					super.log.error("没有添加必要的凭证信息！");
					return response;
				}
			}
			// 贷款材料附件信息
			List<AttachmentVo> attachmentList = formListObject.getAttachmentlist();
			if (CollectionUtils.isNotEmpty(attachmentList)) {
				for (AttachmentVo attachment : attachmentList) {
					ControllerUtils.setWho(attachment);// 设置时间、操作人
					attachment.setType("subjectLoanMetarialCertificate");
					attachment.setSign("");// 设置签名字段
					attachment.setId(null);
					attachment.setEnable(1);// 设置有效字段（0：否，1：是）
					attachment.setEnterpriseId(userVo.getEnterpriseId());
				}
				subjectBatchVo.setAttachmentList(attachmentList);
			}
			// 标的贷款材料关联数据
			List<ProductConfigLoanMaterialVo> loanList = formListObject.getProductConfigLoanMaterialVoList();
			if (CollectionUtils.isNotEmpty(loanList)) {
				for (ProductConfigLoanMaterialVo loan : loanList) {
					ControllerUtils.setWho(loan);// 设置时间、操作人
					loan.setType("bid");// 业务类型(产品：product; 标的：bid)
					loan.setEnterpriseid(userVo.getEnterpriseId());
					loan.setSign("");// 设置签名字段
					loan.setEnable(1);// 设置有效字段（0：否，1：是）
				}
				subjectBatchVo.setProductConfigLoanMaterialVoList(loanList);
			}
		}else{
			if (subjectId == null || subjectId.intValue() == -1L) { // 新增
				response.setInfo(I18NUtils.getText("sys.client.please.add.voucher"));//请添加凭证信息
				super.log.error("没有添加必要的凭证信息！");
				return response;
			}
		}
		Object result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		if (subjectId == null || subjectId.intValue() == -1L) { // 新增
			// 若存在，则给出提示 判断标的编号是否重复
			if (subject != null) {
				response.setInfo(I18NUtils.getText("sys.client.subject.number")+"[" + number + "]"+I18NUtils.getText("sys.client.already.exist"));//标的编号已存在
				super.log.error("标的编号重复！");
				return response;
			}
			// (6)调用服务，进行数据保存
			parameters.setIsLoan("N");// 默认未放款
			subjectBatchVo.setSubject(parameters);
			map.put("paramter", subjectBatchVo);
			map.put("sign", "insertSubjectInfo");// 所调用的服务中的方法
			result = TradeInvokeUtils.invoke("SubjectManagement", map);
			response.setResponseType(ResponseType.SUCCESS_SAVE);
		} else {// 编辑
			// (6)调用服务，进行数据更新
			parameters.setAttribute1("");
			parameters.setAttribute2("");
			subjectBatchVo.setSubject(parameters);
			map.put("paramter", subjectBatchVo);
			map.put("sign", "updateSubjectDetailById");// 所调用的服务中的方法
			result = TradeInvokeUtils.invoke("SubjectManagement", map);
			response.setResponseType(ResponseType.SUCCESS_UPDATE);
		}
		// (6)对调用服务后的返回数据进行解析
		if (result != null) {
			Map<String, Object> jsonMap = JsonUtils.toMap(result);
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			if (sys != null) {
				String status = sys.getString("status");// 状态：'S'成功，'F'失败
				String erortx = sys.getString("erortx");// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setInfo(I18NUtils.getText("sys.client.save.success"));// 设置返回的信息
					super.log.info("新增/编辑insertSubjectInfo/updateSubjectDetailById服务调用信息：" + erortx);
					// 查询新增加的标的详情信息
					subject = findSubjectByCondition(-1L, number);
					response.setObject(subject);// 设置返回结果
				} else {
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.save.error"));
					super.log.error("新增/编辑insertSubjectInfo/updateSubjectDetailById服务调用信息：" + erortx);
				}
			}
		} else {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.client.call.service.fail"));//调用服务失败
			super.log.error("调用服务失败！");
		}
		return response;
	}

	/**
	 * 删除标的信息（by id）
	 * 
	 * @param request
	 * @param ids
	 *            删除的标的主键id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteSubject")
	@ResponseBody
	public ControllerResponse deleteSubjectById(HttpServletRequest request, String ids) throws Exception {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (StringUtils.isEmpty(ids)) {
			super.log.error("id不能为空");
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));// 参数错误
			return response;
		}
		// (2) 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", ids);
		map.put("sign", "deleteSubjectById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("SubjectManagement", map);
		// (3)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setInfo(I18NUtils.getText("sys.client.delete.success"));//删除成功
					response.setResponseType(ResponseType.SUCCESS_DELETE);
					super.log.info("根据id删除标的，调用deleteInboxById服务成功，信息：" + erortx);
				} else {
					response.setInfo(I18NUtils.getText("sys.client.delete.fail"));//删除失败
					super.log.error("根据id删除标的，调用deleteInboxById服务失败，信息：" + erortx);
				}
			}
		} else {
			response.setInfo(I18NUtils.getText("sys.client.call.service.fail"));//调用服务失败
			super.log.error("调用服务失败！");
		}
		return response;
	}

	/**
	 * 删除标的凭证信息（by id）
	 * 
	 * @param request
	 * @param ids
	 *            删除的标的主键id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteSubjectVoucherById")
	@ResponseBody
	public ControllerResponse deleteSubjectVoucherById(HttpServletRequest request, String ids) throws Exception {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (StringUtils.isEmpty(ids)) {
			super.log.error("id不能为空");
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));//参数错误
			return response;
		}
		// (2) 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", ids);
		map.put("sign", "deleteSubjectVoucherByIds");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("SubjectVoucherManagement", map);
		// (3)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setInfo(I18NUtils.getText("sys.client.delete.success"));//标的凭证删除成功！
					response.setResponseType(ResponseType.SUCCESS_DELETE);
					super.log.info("根据id删除标的凭证，调用deleteSubjectVoucherByIds服务成功，信息：" + erortx);
				} else {
					response.setInfo(I18NUtils.getText("sys.client.delete.fail"));//标的凭证删除失败！
					super.log.error("根据id删除标的凭证，调用deleteSubjectVoucherByIds服务失败，信息：" + erortx);
				}
			}
		} else {
			response.setInfo(I18NUtils.getText("sys.client.call.service.fail"));//调用服务失败
			super.log.error("调用服务失败！");
		}
		return response;
	}

	/**
	 * 根据条件查询单个企业
	 * 
	 * @param id 企业id
	 * @return
	 */
	@RequestMapping(value = "/findOneEnterprise")
	@ResponseBody
	public EnterpriseVo findOneEnterprise(Long id) {
		// (1) 判断必要参数是否存在
		if (id == null) {
			super.log.error("id不能为空");
			return null;
		}
		EnterpriseVo parameters = new EnterpriseVo();
		parameters.setId(id);
		parameters.setEnable(1);
		// (2)单个企、企业数据查询
		List<EnterpriseVo> enterpriseList = queryEnterpriseByCondition(parameters);
		if (CollectionUtils.isNotEmpty(enterpriseList)) {
			parameters = enterpriseList.get(0);
			return parameters;
		}
		return null;
	}

	/**
	 * 根据用户信息查询企业信息
	 * 
	 * @param request
	 * @param parameters
	 *            企业查询条件
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/queryEnterpriseByCondition")
	@ResponseBody
	public List<EnterpriseVo> queryEnterpriseByCondition(EnterpriseVo parameters) {
		parameters.setEnable(1);// （0：否，1：是）
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", new PageVo());
		map.put("sign", "queryEnterpriseByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("EnterpriseManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<EnterpriseVo> enterpriseList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				enterpriseList = JsonUtils.toList(resultJson, EnterpriseVo.class);
				super.log.info("根据条件查询企业调用queryEnterpriseByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询企业调用queryEnterpriseByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return enterpriseList;
	}

	/**
	 * 根据条件查询标的凭证信息
	 * 
	 * @param request
	 * @param parameters
	 *            标的凭证查询条件
	 * @param page 分页对象           
	 * @return
	 */
	@RequestMapping(value = "/querySubjectVoucherByCondition")
	@ResponseBody
	public JSONObject querySubjectVoucherByCondition(SubjectVoucherVo parameters, PageVo<?> page) {
		parameters.setEnable(1);// （0：否，1：是）
		if (parameters.getId() == null) {
			parameters.setId(-1L);
		}
		if (parameters.getEnterpriseId() == null) {
			parameters.setEnterpriseId(-1L);
		}
		if (parameters.getLoanSignId() == null) {
			parameters.setLoanSignId(-1L);
		}
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", page);
		map.put("sign", "querySubjectVoucherByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("SubjectVoucherManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				super.log.info("根据条件查询标的凭证调用querySubjectVoucherByCondition服务返回成功，信息：" + erortx);
				return output;
			} else {
				super.log.error("根据条件查询标的凭证调用querySubjectVoucherByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return null;
	}

	/**
	 * 根据条件查询标的产品贷款
	 * 
	 * @param request
	 * @param parameters
	 *            标的产品贷款查询条件
	 * @return
	 */
	@RequestMapping(value = "/queryLoanBySubjectId")
	@ResponseBody
	public List<ProductConfigLoanMaterialVo> queryLoanBySubjectId(ProductConfigLoanMaterialVo parameters) {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", new PageVo<>());
		map.put("sign", "queryProductMaterialById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("SubjectManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<ProductConfigLoanMaterialVo> productList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				productList = JsonUtils.toList(resultJson, ProductConfigLoanMaterialVo.class);
				super.log.info("根据条件查询标的贷款材料调用queryProductMaterialById服务返回成功，信息：" + erortx);
				return productList;
			} else {
				super.log.error("根据条件查询标的贷款材料调用queryProductMaterialById服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return null;
	}

	/**
	 * 根据标的id查询竞标方信息
	 * 
	 * @param request
	 * @param parameters
	 *            竞标方查询条件
	 * @param page 分页对象           
	 * @return
	 */
	@RequestMapping(value = "/queryLoanBidBySubjectId")
	@ResponseBody
	public JSONObject queryLoanBidBySubjectId(SubjectBidVo parameters, PageVo<?> page) {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", page);
		map.put("sign", "queryLoanSignBidByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("BidManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				super.log.info("根据条件查询竞标方信息调用queryLoanSignBidByCondition服务返回成功，信息：" + erortx);
				return output;
			} else {
				super.log.error("根据条件查询竞标方信息调用queryLoanSignBidByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return null;
	}

	/**
	 * 批量更新竞标信息
	 * 
	 * @param request
	 * @param subjectId 标的id
	 * @param id
	 *            中标对象id
	 * @param ids
	 *            未中标对象id字符串
	 * @return
	 */
	@RequestMapping(value = "/updateSubjectBid")
	@ResponseBody
	public ControllerResponse updateSubjectBid(Long subjectId,Long id, String ids) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (!(id != null)) {
			super.log.error("id不能为空！");
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));//参数错误
			return response;
		}
		// (2)调用服务，进行数据更新
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> paramterMap = new HashMap<String, Object>();
		LoanSignBidVo loanSignBid = new LoanSignBidVo();
		loanSignBid.setId(id);
		loanSignBid.setLoanSignId(subjectId);
		loanSignBid.setStatus(Constant.LOAN_SIGN_BID_BIDED);// 中标
		ControllerUtils.setWho(loanSignBid);// 设置时间、操作人
		paramterMap.put("subjectBid", loanSignBid);
		paramterMap.put("ids", ids);
		paramterMap.put("failStatus", Constant.LOAN_SIGN_BID_UNBID);
		map.put("paramter", paramterMap);
		map.put("sign", "updateSubjectBidById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("BidManagement", map);
		// (3)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String estatus = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(estatus)) {// 交易成功
					response.setInfo(I18NUtils.getText("sys.client.update.success"));//竞标信息更新成功
					response.setResponseType(ResponseType.SUCCESS_UPDATE);
					super.log.info("竞标信息更新,调用updateSubjectBidById服务，信息：" + erortx);
				} else {
					response.setInfo(I18NUtils.getText("sys.client.update.fail"));//竞标信息更新失败！
					super.log.error("竞标信息更新,调用updateSubjectBidById服务，信息：" + erortx);
				}
			}
		} else {
			response.setInfo(I18NUtils.getText("sys.client.call.service.fail"));//调用服务失败
			super.log.error("调用服务失败！");
		}
		return response;
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
	@RequestMapping(value = "/updateSubjectStatus")
	@ResponseBody
	public ControllerResponse updateSubjectStatus(String ids,String status) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (StringUtils.isEmpty(ids)) {
			super.log.error("ids不能为空！");
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));//参数错误
			return response;
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
				ControllerUtils.setWho(subject);// 设置时间、操作人
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
					response.setInfo(I18NUtils.getText("sys.client.update.success"));//标的状态信息更新成功！
					response.setResponseType(ResponseType.SUCCESS_UPDATE);
					super.log.info("标的状态信息更新,调用updateSubjectStatusById服务，信息：" + erortx);
				} else {
					response.setInfo(I18NUtils.getText("sys.client.update.fail"));//标的状态信息更新失败！
					super.log.error("标的状态信息更新,调用updateSubjectStatusById服务，信息：" + erortx);
				}
			}
		} else {
			response.setInfo(I18NUtils.getText("sys.client.call.service.fail"));//调用服务失败
			super.log.error("调用服务失败！");
		}
		return response;
	}

	
	/**
	 * 标的详情页面跳转，并加载数据
	 * @param id 标的id
	 * @return
	 */
	@RequestMapping({ "/investdetail" })
	public String investdetail(String id) {
		UserVo user = ControllerUtils.getCurrentUser();
		if(user.getEnterpriseId() < 0 ){
			super.log.error("请先登录");
			return "ybl/admin/index/login";
		}
		Map<String, Object> map = findEditSubjectMessage(Long.valueOf(id));
		if (CollectionUtils.isNotEmpty(map)) {
			getRequest().setAttribute("subject", map.get("subject"));
			getRequest().setAttribute("enterprise", map.get("enterprise"));
			getRequest().setAttribute("subjectVoucherList", map.get("subjectVoucherList"));
			getRequest().setAttribute("page", map.get("page"));
			getRequest().setAttribute("loanmaterialList", map.get("loanmaterialList"));
		}
		
		Map<String,Object> Map = new HashMap<String,Object>();
		Map.put("id_", id);
		Map.put("enterprise_id", user.getEnterpriseId());
		Map.put("loan_sign_id", id);
    	Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", Map);
		maps.put("sign", "queryLoansignDetail");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("BidManagement", maps);					
		
		Map<String,Object> bid = new HashMap<String,Object>();
		
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				JSONObject records = output.getJSONObject("result");
				
				//  查询竞标信息
				if (StringUtils.isNotEmpty(records.getString("loanSign"))) {
					bid = JsonUtils.toMap(records.get("loanSign"));
				}
				//查询竞标次数
				if (StringUtils.isNotEmpty(records.getString("count"))) {
					getRequest().setAttribute("count",Integer.parseInt(records.get("count").toString()));
				}
				//查询当前企业竞标信息
				LoanSignBidVo loanSignBid = new LoanSignBidVo();
				if (StringUtils.isNotEmpty(records.getString("loan_sign_bid"))) {
					loanSignBid = JsonUtils.toObject(records.get("loan_sign_bid").toString(),LoanSignBidVo.class);
				}
				getRequest().setAttribute("loanSignBid", loanSignBid);
				getRequest().setAttribute("bid", bid);
				super.log.error("根据条件查询企业调用queryLoansignDetail服务返回成功，信息："+bid);
			}else{
				super.log.error("根据条件查询企业调用queryLoansignDetail服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("user", user);
 		getRequest().setAttribute("date",new Date().getTime());
		return "ybl/admin/factor/bid/projectDetails";
	}
}
