package com.bpm.framework.controller.v4.drools;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.FormAttachmentListVo;
import cn.sunline.framework.controller.vo.v4.drools.StockHolderListVO;
import cn.sunline.framework.controller.vo.v4.drools.StockHolderVO;
import cn.sunline.framework.controller.vo.v4.drools.V4AutoAddVo;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_AUTH_STATUS;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_AUTH_TYPE;
import cn.sunline.framework.util.ParameterValidateUtil;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 业务认证V4
 * 
 * @author pc
 *
 */
@Controller
@RequestMapping(value = "/serviceAuthenticationController")
public class ServiceAuthenticationController extends AbstractController {

    private static final long serialVersionUID = -6782540433001178569L;

    @InitBinder
    public void InitBinder(WebDataBinder dataBinder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        dataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    /**
     * 业务认证页面跳转：1、判断用户是否登录 2、判断用户是否完成身份认证 3、判断用户已经做了那些角色认证，认证的状态是什么
     * 
     * @return 业务认证页面
     */
    @RequestMapping(value = "/authHtml", method = { RequestMethod.GET, RequestMethod.POST })
    public String authHtml() {
        // (1) 用户登录判断
        UserVo user = ControllerUtils.getCurrentUser();
        if (user == null) {
            super.log.error("请先登录");
            return "ybl4.0/admin/doorl/login";
        }
        if (user.getEnterpriseId() == null || user.getEnterpriseId() <= 0) {
            super.log.error("请先完成身份认证");
            String prompt = "请先完成身份认证！";
            getRequest().setAttribute("errorInfo", "unfinishedError");
            getRequest().setAttribute("prompt", prompt);
            return "ybl4.0/admin/doorl/serviceAuth/serviceAuthList";
        }
        // (2) 调用服务，进行数据查询，身份认证判断，判断用户已经做了那些角色认证，认证的状态是什么
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("param", user.getEnterpriseId());
        map.put("sign", "queryByCondition");// 所调用的服务中的方法
        ResBody result = TradeInvokeUtils.invoke("AuthenticationManagement", map);
        // (3)对调用服务后的返回数据进行解析
        if (result != null) {
            if (result.getSys() != null) {
                String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
                String erortx = result.getSys().getErortx();// 错误信息
                if ("S".equals(status)) {
                    JSONObject output = (JSONObject) result.getOutput();
                    // 返回信息
                    String businessJson = output.getString("result");
                    // (4)对调用服务后的返回数据进行解析，判断是否身份认证通过
                    if ("authFalse".equals(businessJson)) {// 身份认证失败
                        super.log.error("请先完成身份认证");
                        String prompt = "身份认证信息审核中，请耐心等待，审核通过后再进行业务认证！";
                        getRequest().setAttribute("errorInfo", "auditingError");
                        getRequest().setAttribute("prompt", prompt);
                        return "ybl4.0/admin/doorl/serviceAuth/serviceAuthList";
                    }
                    // (5)身份认证通过
                    List<V4BusinessAuthVO> list = new ArrayList<>();
                    list = JsonUtils.toList(businessJson, V4BusinessAuthVO.class);
                    // 逻辑判断
                    if (list.size() > 0) {
                        for (int i = 0, j = list.size(); i < j; i++) {
                            V4BusinessAuthVO businessAuthVO = null;
                            businessAuthVO = list.get(i);
                            if (businessAuthVO.getAuthType() == E_V4_AUTH_TYPE.COREENTERPRISE.getStatus()) {// 业务认证类型1-融资方2-资金方3-核心企业
                                ControllerUtils.getRequest().setAttribute("coreEnterprise", businessAuthVO);
                                continue;
                            }
                            if (businessAuthVO.getAuthType() == E_V4_AUTH_TYPE.FUNDSIDE.getStatus()) {
                                ControllerUtils.getRequest().setAttribute("fundSide", businessAuthVO);
                                continue;
                            }
                            if (businessAuthVO.getAuthType() == E_V4_AUTH_TYPE.FINANCINGPARTY.getStatus()) {
                                ControllerUtils.getRequest().setAttribute("financingParty", businessAuthVO);
                                continue;
                            }
                        }
                    }
                    super.log.error("根据条件查询业务基础信息，调用queryByCondition成功 ，信息" + erortx);
                } else {
                    super.log.error("根据条件查询业务基础信息，调用queryByCondition失败 ，信息" + erortx);
                }
            }
        }
        return "ybl4.0/admin/doorl/serviceAuth/serviceAuthList";
    }

    /**
     * 业务认证图片点击或查看点击
     * 
     * @param type
     *            业务认证类型：1-融资方2-资金方3-核心企业
     * @param id
     *            业务认证实体ID
     * @param authStatus
     *            业务认证所处的状态 1：认证中，2：认证成功，3：认证失败
     * @return 业务认证详情页面
     */
    @RequestMapping(value = "/serviceAuth", method = { RequestMethod.GET, RequestMethod.POST })
    public String serviceAuth(Integer type, Long id, Integer authStatus) {
        // (1) 用户登录判断
        UserVo user = ControllerUtils.getCurrentUser();
        if (user == null) {
            super.log.error("请先登录");
            return "ybl4.0/admin/doorl/login";
        }
        // (2) 身份认证判断
        if (user.getEnterpriseId() == null || user.getEnterpriseId() == 0) {
            super.log.error("EnterpriseId 参数错误");
            return null;
        }
        // (3) 调用服务，进行数据查询
        Map<String, Object> map = new HashMap<String, Object>();

        if (id != null) {// 已认证，进行查看
            V4BusinessAuthVO v4BusinessAuthVO = new V4BusinessAuthVO();
            v4BusinessAuthVO.setAuthType(type);
            v4BusinessAuthVO.setAuthStatus(authStatus);
            v4BusinessAuthVO.setId(id);
            v4BusinessAuthVO.setEnterpriseId(user.getEnterpriseId());
            map.put("param", v4BusinessAuthVO);
            map.put("sign", "queryBusinessAuthInfo");// 所调用的服务中的方法
            ResBody result = TradeInvokeUtils.invoke("AuthenticationManagement", map);
            if (result != null) {
                if (result.getSys() != null) {
                    String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
                    String erortx = result.getSys().getErortx();// 错误信息
                    if ("S".equals(status)) {
                        JSONObject output = (JSONObject) result.getOutput();
                        // 业务认证公共信息
                        String businessJson = output.getString("businessAuthInfo");
                        if (businessJson != null) {
                            V4BusinessAuthVO businessAuth = JsonUtils.toObject(businessJson, V4BusinessAuthVO.class);
                            ControllerUtils.getRequest().setAttribute("businessAuth", businessAuth);
                        }
                        // 股东信息
                        String StockHolderJson = output.getString("stockHolderInfoList");
                        if (StockHolderJson != null) {
                            List<StockHolderVO> stockHolderList = new ArrayList<>();
                            stockHolderList = JsonUtils.toList(StockHolderJson, StockHolderVO.class);
                            if (stockHolderList.size() > 0) {
                                ControllerUtils.getRequest().setAttribute("stockholerList", stockHolderList);
                            }
                        }

                        // 附件信息
                        String fwAttachmentJson = output.getString("fwAttachmentList");
                        if (fwAttachmentJson != null) {
                            List<AttachmentVo> attachmentList = new ArrayList<>();
                            attachmentList = JsonUtils.toList(fwAttachmentJson, AttachmentVo.class);
                            if (attachmentList.size() > 0) {
                                ControllerUtils.getRequest().setAttribute("attachmentList", attachmentList);
                            }
                        }

                        super.log.error("根据条件查询业务信息，调用queryBusinessAuthInfo成功 ，信息" + erortx);
                    } else {
                        super.log.error("根据条件查询业务信息，调用queryBusinessAuthInfo失败 ，信息" + erortx);
                    }
                }
            }
            ControllerUtils.getRequest().setAttribute("looktype", "look");
        } else {// 没认证，进入页面认证
            V4BusinessAuthVO v4BusinessAuthVO = new V4BusinessAuthVO();
            v4BusinessAuthVO.setEnterpriseId(user.getEnterpriseId());
            map.put("param", v4BusinessAuthVO);
            map.put("sign", "queryBusinessStockholer");// 所调用的服务中的方法
            ResBody result = TradeInvokeUtils.invoke("BusinessStockholderManagment", map);
            // (4)对调用服务后的返回数据进行解析
            if (result != null) {
                if (result.getSys() != null) {
                    String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
                    String erortx = result.getSys().getErortx();// 错误信息
                    if ("S".equals(status)) {
                        JSONObject output = (JSONObject) result.getOutput();
                        // 业务认证公共信息
                        String businessJson = output.getString("business");
                        if (businessJson != null) {
                            V4BusinessAuthVO businessAuth = JsonUtils.toObject(businessJson, V4BusinessAuthVO.class);
                            ControllerUtils.getRequest().setAttribute("businessAuth", businessAuth);
                        }

                        // 股东信息
                        String resultJson = output.getString("result");
                        if (resultJson != null) {
                            List<StockHolderVO> list = new ArrayList<>();
                            list = JsonUtils.toList(resultJson, StockHolderVO.class);
                            ControllerUtils.getRequest().setAttribute("stockholerList", list);
                        }
                        super.log.error("根据条件查询业务基础信息，调用queryByCondition成功 ，信息" + erortx);
                    } else {
                        super.log.error("根据条件查询业务基础信息，调用queryByCondition失败 ，信息" + erortx);
                    }
                }
            }
        }
        // (5)根据不同类型跳转到不同认证页面
        ControllerUtils.getRequest().setAttribute("authType", type);
        if (type == E_V4_AUTH_TYPE.FINANCINGPARTY.getStatus()) {
            return "ybl4.0/admin/doorl/serviceAuth/financingPartyAuth";
        }
        if (type == E_V4_AUTH_TYPE.FUNDSIDE.getStatus()) {
            return "ybl4.0/admin/doorl/serviceAuth/fundSideAuth";
        }
        if (type == E_V4_AUTH_TYPE.COREENTERPRISE.getStatus()) {
            return "ybl4.0/admin/doorl/serviceAuth/coreEnterpriseAuth";
        }
        return null;
    }

    /**
     * 业务认证实体保存
     * 
     * @param parameters
     *            业务认证实体
     * @param stockHolderList
     *            股东实体列表
     * @param attachmentList
     *            附件实体列表
     * @param registerDateString
     *            业务认证时间——临时接受参数(注：因实体对象是时间类型，实体直接接受有问题，故用String转化)
     * @param legalAgeStr
     *            法人年龄——临时接受参数(注：因实体对象是Integer，实体直接接受有问题，故用String转化)
     * @param legalWorkYearStr
     *            法人工作年限——临时接受参数
     * @param controllerAgeStr
     *            实际控制人年龄——临时接受参数
     * @param controllerWorkYearStr
     *            实际控制人工作年限——临时接受参数
     * @return 业务认证结果
     */
    @RequestMapping(value = "/addOrUpdateAuth")
    @ResponseBody
    @Log(operation = OperationType.Exe, info = "保存/编辑企业数据")
    public ControllerResponse addOrUpdateAuth(V4BusinessAuthVO parameters, StockHolderListVO stockHolderList,
            FormAttachmentListVo attachmentList, String registerDateString, String legalAgeStr, String legalWorkYearStr,
            String controllerAgeStr, String controllerWorkYearStr) {
        ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
        UserVo user = ControllerUtils.getCurrentUser();
        V4AutoAddVo v4AutoAddVo = new V4AutoAddVo();
        // (1)判断是否有数据
        if (parameters == null) {
            response.setInfo("参数错误");// 参数错误
            super.log.error("保存/编辑企业数据对象不能为空！");
            return response;
        }
        // (2)业务认证
        // 2.1 业务认证VO参数校验
        String validate = ParameterValidateUtil.validate(parameters);
        if (null == parameters.getAuthType() && parameters.getAuthType() == 0) {
            response.setInfo("业务认证类型格式错误！");
            return response;
        }
        if (validate.length() > 0) {
            response.setInfo(validate);
            return response;
        }
        if (null != legalAgeStr && legalAgeStr.length() > 0) {
            try {
                parameters.setLegalAge(Integer.valueOf(legalAgeStr));
            } catch (Exception e) {
                response.setInfo("法人年龄格式错误！");
                return response;
            }
        }
        if (null != legalWorkYearStr && legalWorkYearStr.length() > 0) {
            try {
                parameters.setLegalWorkYear(Integer.valueOf(legalWorkYearStr));
            } catch (Exception e) {
                response.setInfo("法人从业年限格式错误！");
                return response;
            }
        }
        if (null != controllerAgeStr && controllerAgeStr.length() > 0) {
            try {
                parameters.setControllerAge(Integer.valueOf(controllerAgeStr));
            } catch (Exception e) {
                response.setInfo("实际控制人年龄格式错误！");
                return response;
            }
        }
        if (null != controllerWorkYearStr && controllerWorkYearStr.length() > 0) {
            try {
                parameters.setControllerWorkYear(Integer.valueOf(controllerWorkYearStr));
            } catch (Exception e) {
                response.setInfo("实际控制人从业年限格式错误！");
                return response;
            }
        }
        if (registerDateString != null) {
            try {
                Date registerDate = super.getParameter("registerDateString", Date.class);
                parameters.setRegisterDate(registerDate);
            } catch (Exception e) {
                response.setInfo("注册日期格式错误");// 参数错误
                return response;
            }
        }
        ControllerUtils.setWho(parameters);// 设置时间、操作人
        parameters.setEnterpriseId(user.getEnterpriseId());// 设置企业ID
        parameters.setEnable(1);// 设置有效字段（0：否，1：是）
        parameters.setSign("");// 设置签名字段
        Long businessAuthId = parameters.getId();
        
        // 2.2 股东数据判断
        if (stockHolderList != null && CollectionUtils.isNotEmpty(stockHolderList.getStockHolderList())) {
            List<StockHolderVO> shList = stockHolderList.getStockHolderList();
            if (CollectionUtils.isNotEmpty(shList)) {
                List<StockHolderVO> tempList = new ArrayList<StockHolderVO>();
                for (int i = 0, j = shList.size(); i < j; i++) {
                    StockHolderVO shVo = shList.get(i);
                    if (shVo != null && shVo.emptyStockHolderVO(shVo)) {// 防止页面空数据进入
                        // 参数校验
                        String stockHolderValidate = ParameterValidateUtil.validate(shVo);
                        if (stockHolderValidate.length() > 0) {
                            response.setInfo(stockHolderValidate);
                            return response;
                        }
                        ControllerUtils.setWho(shVo);// 设置时间、操作人
                        if (shVo.getRegisterDateTemp() != null && !"".equals(shVo.getRegisterDateTemp())) {
                            try {
                                Date registerDate = DateUtils.toDate(shVo.getRegisterDateTemp());
                                shVo.setRegisterDate(registerDate);
                            } catch (Exception e) {
                                response.setInfo("股东信息注册日期格式错误");// 参数错误
                                return response;
                            }
                        }
                        shVo.setEnable(1);
                        tempList.add(shVo);
                    }
                }
                if (tempList.size() > 0) {
                    v4AutoAddVo.setStockHolderList(tempList);
                }
            }
        }
        // 2.3 附件集合判断
        if (attachmentList != null && CollectionUtils.isNotEmpty(attachmentList.getAttachmentList())) {
            List<AttachmentVo> amList = attachmentList.getAttachmentList();
            if (CollectionUtils.isNotEmpty(amList)) {
                List<AttachmentVo> tempList = new ArrayList<AttachmentVo>();
                for (int i = 0, j = amList.size(); i < j; i++) {
                    AttachmentVo attachmentVo = amList.get(i);
                    if (attachmentVo != null && attachmentVo.getOldName() != null) {// 防止页面空数据进入
                        attachmentVo.setEnterpriseId(user.getEnterpriseId());
                        ControllerUtils.setWho(attachmentVo);// 设置时间、操作人
                        attachmentVo.setEnable(1);
                        tempList.add(attachmentVo);
                    }
                }
                if (tempList != null && CollectionUtils.isNotEmpty(tempList) && tempList.size() > 0) {
                    v4AutoAddVo.setAttachmentList(tempList);
                } else {
                    response.setInfo("资料清单不能为空");
                    return response;
                }
            }
        }
        // (3)新增/编辑操作
        ResBody result = null;
        Map<String, Object> map = new HashMap<String, Object>();
        if (businessAuthId == null) { // 新增
            parameters.setAuthStatus(E_V4_AUTH_STATUS.AUDITING.getStatus());// 设置认证状态（1-审核中2-审核成功3-审核失败）
            v4AutoAddVo.setBusinessAuth(parameters);
            // (4)调用服务，进行数据保存
            map.put("param", v4AutoAddVo);
            map.put("sign", "addOrUpdateAuth");// 所调用的服务中的方法
            result = TradeInvokeUtils.invoke("AuthenticationManagement", map);
            response.setResponseType(ResponseType.SUCCESS_SAVE);
        } else {// 编辑
            // (4)调用服务，进行数据更新
            //暂无重新编辑功能，故代码空缺
        }
        // (5)对调用服务后的返回数据进行解析
        if (result != null) {
            Map<String, Object> jsonMap = JsonUtils.toMap(result);
            JSONObject sys = (JSONObject) jsonMap.get("sys");
            if (sys != null) {
                String status = sys.getString("status");// 状态：'S'成功，'F'失败
                String erortx = sys.getString("erortx");// 错误信息
                if ("S".equals(status)) {// 交易成功
                    JSONObject output = (JSONObject)result.getOutput();
                    Boolean businessJson = output.getBoolean("result");
                    if(!businessJson){
                        response.setInfo("业务认证已经存在，不能重复认证");// 设置返回结果
                        return response;
                    }
                    response.setObject(result);// 设置返回结果
                    if (businessAuthId == null) {
                        response.setInfo("添加成功");// 添加成功
                    } else {
                        response.setInfo("修改成功");// 修改成功
                    }
                    super.log.info("新增/编辑addOrUpdateAuth/updateCustomerById服务调用信息：" + erortx);
                } else {
                    response.setResponseType(ResponseType.ERROR);
                    if (businessAuthId == null) {
                        response.setInfo("添加失败");// 添加失败
                    } else {
                        response.setInfo(" 修改失败");// 修改失败
                    }
                    super.log.error("新增/编辑addOrUpdateAuth/updateCustomerById服务调用信息：" + erortx);
                }
            }
        } else {
            response.setResponseType(ResponseType.ERROR);
            response.setInfo("调用服务失败");// 调用服务失败
            super.log.error("调用服务失败！");
        }
        return response;
    }
}
