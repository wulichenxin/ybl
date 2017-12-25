package com.bpm.framework.controller.usermanage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.DepartmentVo;
import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;
import jxl.biff.ContinueRecord;

@Controller
@RequestMapping({ "/departmentController" })
public class DepartmentController extends AbstractController {

	private static final long serialVersionUID = -8363040837974811451L;

	/**
	 * 打开部门管理页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/depetManage")
	public String main(HttpServletRequest request) {
		return "ybl/admin/department/departmentManage";
	}

	/**
	 * 查询同一企业下的所有组织结构
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/queryAllDepartment")
	@ResponseBody
	public List<?> queryAllDepartment() {
		Map<String, Object> map = new HashMap<String, Object>();
		DepartmentVo departmentVo = new DepartmentVo();
		departmentVo.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		// 调用服务，进行数据查询
		map.put("paramter", departmentVo);
		map.put("sign", "queryDeptByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("BusinessDeptManagement", map);
		List<DepartmentVo> deptList = null;
		if (result!=null && result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject)result.getOutput();
				String resultJson = output.getString("result");
				deptList= JsonUtils.toList(resultJson, DepartmentVo.class);
				super.log.info("查询所有组织结构调用queryAllDept服务成功，信息：" + erortx);
			} else {
				super.log.error("查询所有组织结构调用queryAllDept服务失败，信息：" + erortx);
			}
		}
		return deptList;
	}

	/**
	 * 根据父节点ID查询组织结构集合 根结点的ID为0 ztree树使用异步加载
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/queryListByParentId")
	@ResponseBody
	public List<?> queryListByParentId(Long parentId) {
		Map<String, Object> map = new HashMap<String, Object>();
		DepartmentVo dept = new DepartmentVo();	
		dept.setId(-1L);//考虑整形参数传递到数据库的过程中 ，如果不传，则会默认为0，故设置味-1L		
		dept.setParentId(parentId);
		//用户只能查询自己企业的部门信息
		Long enterpriseId = ControllerUtils.getCurrentUser().getEnterpriseId();
		dept.setEnterpriseId(enterpriseId);
		dept.setEnable(1);//1是有效数据
		// 调用服务，进行数据查询
		map.put("paramter", dept);
		map.put("sign", "queryDeptByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("BusinessDeptManagement", map);
		
		//查询当前登录用户的企业信息
		Map<String, Object> paramter = new HashMap<String,Object>();
		//(1)判断必要参数
		if(enterpriseId == null){			
			super.log.error("查询企业信息时，企业id为空！");
			return null;
		}
		paramter.put("id_", enterpriseId);
		//调用服务，进行企业认证表数据查询	
		Map<String,Object> enterpriseMap = new HashMap<String,Object>();
		enterpriseMap.put("paramter", paramter);
		enterpriseMap.put("sign", "queryEnterprise");//所调用的服务中的方法
		ResBody enterpriseResult = TradeInvokeUtils.invoke("CustomerManagement", enterpriseMap);	
		
		List<DepartmentVo> deptList = null;
		if(result!=null){
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					JSONObject output = (JSONObject) result.getOutput();
					String resultJson = output.getString("result");
					deptList= JsonUtils.toList(resultJson, DepartmentVo.class);				
					super.log.info("查询所有组织结构调用queryDeptByCondition服务成功，信息：" + erortx);
				} else {
					super.log.error("查询所有组织结构调用queryDeptByCondition服务失败，信息：" + erortx);
				}
			}
		}
		
		if(enterpriseResult != null){
			if(enterpriseResult.getSys() != null){
				String status = enterpriseResult.getSys().getStatus();
				String erortx = enterpriseResult.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					JSONObject output = (JSONObject) enterpriseResult.getOutput();
					String resultJson = output.getString("result");
					Map<String, Object> map2 = JsonUtils.toMap(resultJson);
					super.getSession().setAttribute("enterpriseName", map2.get("enterprise_name"));
					super.log.info("查询所有组织结构调用queryDeptByCondition服务成功，信息：" + erortx);
				} else {
					super.log.error("查询所有组织结构调用queryDeptByCondition服务失败，信息：" + erortx);
				}
			}
		}
		
		return deptList;
	}

	/**
	 * 根据id查询部门信息
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/getOne")
	@ResponseBody
	public Object getOne(HttpServletRequest request, Long id) {
		// (1)判断必要参数
		if (id == null) {
			super.log.error("id不能为空");
			return null;
		}
		// (2)部门数据查询
		List<?> list = queryAllDepartment();
		if (CollectionUtils.isNotEmpty(list)) {
			for(Object obj:list){
				DepartmentVo dept = (DepartmentVo)obj;
				if(id.longValue()==dept.getId().longValue()){				 
					return dept;
				}
			}		
		}
		return null;
	}

	/**
	 * 根据ID删除本门信息 前提条件,部门无子节点 id,deptCode,deptName
	 * 
	 * @param request
	 * @param department
	 * @return
	 */
	@RequestMapping(value = "/deleteById")
	@ResponseBody
	public ControllerResponse deleteById(HttpServletRequest request, Long id) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (id == null) {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("ybl.web.paramter.error"));//参数错误
			super.log.error("id不能为空");
			return response;
		}
		//(2)查询是否有该记录
		DepartmentVo department = (DepartmentVo)getOne(getRequest(),id); 
		if(department!=null){
			Long departParentId = department.getParentId();
			// (3)部门下有子部门(不含enable=0)的记录不允许直接删除
			if(department.getIsLeaf()==0){
				response.setResponseType(ResponseType.ERROR);
				response.setInfo(I18NUtils.getText("delete.child.node"));//删除失败,请先删除子节点
				super.log.error("删除失败,请先删除子节点");
				return response;		
			}
			// (4)部门下有用户(不含enable=0)的记录不允许直接删除
			UserVo userparameters = new UserVo();
			userparameters.setDeptId(id);
			userparameters.setEnable(1);// 用户数据需要增加enable		
			List<?> userlist = queryUserByCondition(userparameters);
			if(CollectionUtils.isNotEmpty(userlist)){
				response.setResponseType(ResponseType.ERROR);
				response.setInfo(I18NUtils.getText("delete.this.depart.user"));//删除失败,请先删除该部门下用户
				super.log.error("删除失败,请先删除该部门下用户"); 
				return response; 
			}	
			
			// (5)删除部门信息（物理删除）
			Map<String, Object> map = new HashMap<String, Object>();
			DepartmentVo deptpart = new DepartmentVo();
			deptpart.setEnable(1);
			deptpart.setId(id);
			map.put("paramter", deptpart);
			map.put("sign", "deleteDeptById");
			ResBody result = TradeInvokeUtils.invoke("BusinessDeptManagement", map);
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功	
					response.setResponseType(ResponseType.SUCCESS_DELETE);
					response.setInfo(I18NUtils.getText("ybl.web.delete.success"));//删除成功
					super.log.info("删除部门调用deleteDeptById服务成功，信息：" + erortx);
					//(6)查询当前被删除的子节点的父节点是否还有子节点
					if (departParentId != null) {											
						List<?> departList = queryListByParentId(departParentId);
						//(7)如果该子节点的父节点没有子节点了，isleaf置为1
						if(CollectionUtils.isEmpty(departList)){
							deptpart = new DepartmentVo();
							deptpart.setIsLeaf(1);
							deptpart.setEnable(1);
							deptpart.setId(departParentId);
							updateDept(deptpart);
						}																										
					}
				} else {
					response.setInfo(I18NUtils.getText("ybl.web.delete.error"));//删除失败
					super.log.error("删除部门调用deleteDeptById服务失败，信息：" + erortx);
				}
			}	
		}else{// 不存在，则删除失败
			super.log.error("删除失败,记录不存在");	
			response.setInfo(I18NUtils.getText("delete.this.depart.user"));//删除失败,请先解绑该菜单下角色
		}
					
		return response;
	}

	/**
	 * 保存或更新部门信息 前台参数 id,deptCode,deptName
	 * 
	 * @param request
	 * @param department
	 * @return
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public ControllerResponse saveOrUpdate(HttpServletRequest request, DepartmentVo department) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断是否有数据
		if (department == null) {
			response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("新增/编辑时,部门对象不能为空");
			return response;
		}
		Long departmentId = department.getId();// 部门id
		String deptName = department.getName();// 部门名称
		String deptCode = department.getCode();// 部门编码
		Long parentId = department.getParentId();// 父组织id
		Long superParentId = null;//父组织的parentId
		int superIsLeaf = 1;//父菜单的节点标志，默认为叶子结点
		// (2)表单数据后台二次校验
		if (StringUtils.isEmpty(deptName)) {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("depart.name.is.not.null"));//部门名称不能为空
			super.log.error("新增/编辑时,部门名称不能为空");
			return response;
		}
		if (StringUtils.isEmpty(deptCode)) {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("depart.code.is.not.null"));//部门编号不能为空
			super.log.error("新增/编辑时,部门编号不能为空");
			return response;
		}
		if (parentId == null) {
			parentId=0L;
		}
		// (3)校验部门编码是否存在
		List<?> deptList = queryAllDepartment();
		if (CollectionUtils.isNotEmpty(deptList)) {
			for (Object obj : deptList) {
				DepartmentVo parameters = (DepartmentVo)obj;
				if(null == parameters) continue;
				if (parameters != null) {//是否有重复的编码（排除自己）
					if (parameters.getCode().equals(deptCode) && parameters.getEnterpriseId().equals(ControllerUtils.getCurrentUser().getEnterpriseId()) && ( departmentId == null || parameters.getId().longValue()!=departmentId.longValue())) {
						response.setResponseType(ResponseType.ERROR);
						response.setInfo(I18NUtils.getText("depart.code.already.exist"));//部门编码已存在
						super.log.error("部门编码" + deptCode + "已存在.");
						return response;
					}					
				}
			}
		}
		
		// (4)新增/修改操作
		Map<String, Object> map = new HashMap<String, Object>();
		department.setEnable(1);//是否有效：0、否;1、否是
		department.setParentId(parentId);//设置符部门id
		//插入当前用户的企业id
		department.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		ControllerUtils.setWho(department);// 设置创建人、修改人、创建时间、修改时间
		if(parentId == null || parentId == 0L){
			department.setHierarchy("1");//如果parentId为0或者null，则层级为顶级
		}else{
			//查询父部门的层级，当前部门的层级在父部门的层级上加1
			DepartmentVo departmentVo = (DepartmentVo)getOne(request, parentId);
			Integer parentHierarchy = Integer.valueOf(departmentVo.getHierarchy());
			String currentHierarchy = String.valueOf(parentHierarchy + 1);
			department.setHierarchy(currentHierarchy);
		}
		ResBody result = null;
		// (5)调用服务，进行数据保存
		map.put("paramter", department);
		if (departmentId == null) { // 新增
			department.setIsLeaf(1);//默认新增的节点是叶子节点。是否叶子节点：0、否;1、是 
			map.put("sign", "insertDeptInfo");// 所调用的服务中的方法
			response.setResponseType(ResponseType.SUCCESS_SAVE);
		} else {
			department.setIsLeaf(1);//假设当前节点为叶子节点 
			for (Object object : deptList) {
				//判断当前更新的部门节点是否为叶子节点
				DepartmentVo departmentVo	= (DepartmentVo)object;
				//如果当前编辑的部门节点id作为parentId出现，则当前节点应该为非叶子节点
				if (departmentVo.getParentId().longValue() == department.getId().longValue()) {
					department.setIsLeaf(0);
					break;
				}
			}
			map.put("sign", "updateDeptInfoById");// 所调用的服务中的方法
			response.setResponseType(ResponseType.SUCCESS_UPDATE);
		}
		result = TradeInvokeUtils.invoke("BusinessDeptManagement", map);
		// (6)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setObject(result);// 设置返回结果
					response.setInfo(I18NUtils.getText("sys.client.save.success"));// 设置返回的信息
					super.log.info("新增/编辑insertDeptInfo/updateDeptInfoById服务调用信息：" + erortx);
					//(7)更新父部门的isLeaf为0
					boolean ifOk = false;
					//判断父节点的isleaf是否已经为0
					DepartmentVo parentDepartment = new DepartmentVo();
					for (int i=0;(i<deptList.size()) && !ifOk; i++) {
						parentDepartment = (DepartmentVo)deptList.get(i); 
						if (parentDepartment != null) {//获取父节点信息
							if (parentDepartment.getId().longValue()==parentId.longValue()) {
								superIsLeaf = parentDepartment.getIsLeaf(); 
								ifOk=true;
							}					
						}
					}
					//如果当前部门是顶级部门或者当前部门的父节点的isleaf已经为0则不需要再更新父部门的isLeaf
					if(parentId!=0 && superIsLeaf != 0){
						parentDepartment.setIsLeaf(0);
						updateDept(parentDepartment);
					}					
				} else {
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.save.fail"));
					super.log.error("新增/编辑insertDeptInfo/updateDeptInfoById服务调用信息：" + erortx);
				}
			}
		} else {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.client.save.fail"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
	}

	/**
	 * 根据节点一层一层往上找,用于快速定位树节点 返回格式 从根节点开始返回 1,101,1001
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/queryUpDept")
	@ResponseBody
	public List<Long> queryParentIds(HttpServletRequest request, Long id) {
		List<Long> lists = new ArrayList<Long>();
		if (id == null) {
			return lists;
		}
		lists.add(id);
		return lists;
	}

	/**
	 * 打开部门编辑页面
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/edit.htm")
	public String openEditPage(HttpServletRequest request, Long id) {
		DepartmentVo dept = (DepartmentVo)getOne(getRequest(),id);
		if(dept!=null){
			DepartmentVo parentDept = (DepartmentVo)getOne(getRequest(),dept.getParentId());
			getRequest().setAttribute("parentDept", parentDept);
		}		
		getRequest().setAttribute("dept", dept);
		return "ybl/admin/department/edit";
	}

	/**
	 * 更新部门信息（根据id）
	 * @param id
	 * @param isLeaf 是否也叶子节点（0：否；1：是）
	 * @return
	 */
	@RequestMapping(value = "/updateDept")
	@ResponseBody
	public void updateDept(DepartmentVo department) {
		// (1)判断必要对象参数
		if (department == null) {
			super.log.error("department不能为空");
			return;
		}
		//考虑整形参数传递到数据库的过程中 ，如果不传，则会默认为0，故设置味-1L				
		if(department.getParentId()==null){//不传parentId时				
			department.setParentId(-1L);
		}				
		// (2)部门数据更新
		Map<String, Object> map = new HashMap<String, Object>();	
		ControllerUtils.setWho(department);// 设置创建人、修改人、创建时间、修改时间		
		ResBody result = null;
		// (3)调用服务，进行数据保存
		map.put("paramter", department);
		map.put("sign", "updateDeptInfoById");// 所调用的服务中的方法
		result = TradeInvokeUtils.invoke("BusinessDeptManagement", map);
		// (4)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					super.log.info("更新updateDeptInfoById服务调用信息：" + erortx);
					return;
				} else {
					super.log.error("更新updateDeptInfoById服务调用信息：" + erortx);
					return;
				}
			}
		}
	}
	/**
	 * 根据用户信息查询用户
	 * @param request
	 * @param parameters 用户查询条件
	 * @return
	 */
	private List<UserVo> queryUserByCondition(UserVo parameters){
		parameters.setEnable(1);//（0：否，1：是）
		//调用服务，进行数据查询	
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", parameters);
		map.put("sign", "queryMemberByCondition");//所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("MemberManagement", map);
		List<UserVo> userList = null;
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功	
					JSONObject output = (JSONObject)result.getOutput();
					String resultJson = output.getString("result");
					userList= JsonUtils.toList(resultJson, UserVo.class);
					super.log.info("根据条件查询用户调用queryMemberByCondition服务返回成功，信息："+erortx);
				}else{
					super.log.error("根据条件查询用户调用queryMemberByCondition服务返回失败，信息："+erortx);
					return null;
				}
			}
		}		
		return userList;
	}
}
