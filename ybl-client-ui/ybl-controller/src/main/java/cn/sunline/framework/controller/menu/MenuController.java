package cn.sunline.framework.controller.menu;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

import cn.sunline.framework.controller.vo.MenuVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.RoleMenuVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 
 * @author guotai guotai@sunline.cn
 * @date 2017年5月9日
 * @version 1.0.0
 * @Description 云保理业务端菜单管理控制层
 */
@Controller
@RequestMapping({ "/menuController" })
public class MenuController extends AbstractController {

	private static final long serialVersionUID = -7281758589045856889L;
	
	/**
	 * 查询菜单列表
	 * 
	 * @param request
	 * @return list 菜单列表数据集合
	 * @throws Exception
	 */
	@RequestMapping({ "/list.htm" })
	public String menuManage(MenuVo menuVo,PageVo pageVo) {	
		Map<String,Object> map = new HashMap<String,Object>();
		//用户只能查询自己企业的菜单信息。
		menuVo.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		if(menuVo.getParentId()==null){
			menuVo.setParentId(-1L);
		}
		map.put("paramter", menuVo);
		map.put("page", pageVo);
		map.put("sign", "queryMenuByCondition");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("BusinessMenuManagement", map);					
		PageVo page=null;
		List<MenuVo> menuList=null;
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				menuList=JsonUtils.toList(records,MenuVo.class);
			}			
		}
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("menuList", menuList);
		getRequest().setAttribute("menuVo", menuVo);
        return "ybl/admin/menu/menuList";
	}
	/**
	 * 异步加载菜单信息
	 * @param
	 * @return
	 * @throws
	 */
	@RequestMapping({ "/loadMenuByAsync" })
	public String loadMenuByAsync(HttpServletRequest request) {
		MenuVo menuVo = new MenuVo();
		menuVo.setMenuName(request.getParameter("menuName"));
		//用户只能查询自己企业的菜单信息。
		menuVo.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		PageVo<MenuVo> pageVo = new PageVo<>();
		Map<String,Object> map = new HashMap<String,Object>();
		if(menuVo.getParentId()==null){
			menuVo.setParentId(-1L);
		}
		map.put("paramter", menuVo);
		map.put("page", pageVo);
		map.put("sign", "queryMenuByCondition");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("BusinessMenuManagement", map);					
		PageVo page=null;
		List<MenuVo> menuList=null;
		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				menuList=JsonUtils.toList(records,MenuVo.class);
			}			
		}
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("menuList", menuList);
		getRequest().setAttribute("menuVo", menuVo);
		return "ybl/admin/menu/menuListTable";
	}

	/**
	 * 增加菜单
	 * 
	 * @param request
	 * @param type
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addOrUpdateMenu")
	@ResponseBody
	public ControllerResponse addOrUpdateMenu(HttpServletRequest request, MenuVo menuVo) throws Exception {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断对象是否为空
		if (menuVo == null) {
			response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("新增/编辑时，menuVo不能为空");
			return response;
		}
		//新增时，如果没有选择上级菜单，默认为顶级菜单，parentId=0
		if(menuVo.getParentId() == null ){
			menuVo.setParentId(0L);
		}
		// (2)判断必填参数是否填写
		if (StringUtils.isNotEmpty(menuVo.getMenuName()) && StringUtils.isNotEmpty(menuVo.getMenuCode())
				&& StringUtils.isNotEmpty(menuVo.getLink())) {
		} else {
			response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("新增/编辑时，必填参数不能为空");
			return response;
		}
		//获取页面上一些参数
		Long menuId = menuVo.getId();
		Long menuPartId = menuVo.getParentId();
		Long superParentId = null;//父菜单的parentId
		int superIsLeaf = 1;//父菜单的节点标志，默认为叶子结点
		int isLeaf = 1;//现节点的标识，默认为叶子结点
		//(3)判断是否存在相同菜单编号的数据
		MenuVo parameters = new MenuVo();
		parameters.setMenuCode(menuVo.getMenuCode());
		parameters.setEnable(1);// 1：有效；0：无效
		//同一企业下菜单编码不能重复
		parameters.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		List<MenuVo> menuList = getMenuList(parameters);
		if (CollectionUtils.isNotEmpty(menuList)) {
			for(Object obj:menuList){
				MenuVo menu = (MenuVo)obj;
				if(menuVo.getMenuCode().equals(menu.getMenuCode()) && (menuVo.getId() == null || menuVo.getId().longValue()!=menu.getId().longValue())){				 					
					response.setInfo("菜单号已经存在");//菜单编号已存在
					super.log.error("菜单编号"+menuVo.getMenuCode()+"已存在");
					return response;
				}
			}
		}
		//顶级菜单不需要更新
		if(menuPartId!=0){
			MenuVo menuPara = (MenuVo)getMenu(menuPartId);
			if (menuPara != null) {//获取父节点的叶子节点和parentId			
				superParentId = menuPara.getParentId();
				superIsLeaf = menuPara.getIsLeaf(); 							
			}
		}
		if(menuVo.getIsLeaf()!=null){
			isLeaf = menuVo.getIsLeaf();
		}
		// (4)新增/更新操作		
		ControllerUtils.setWho(menuVo);// 设置时间、操作人
		menuVo.setEnable(1);// 是否有效(1：有效；0：无效)
		menuVo.setIsLeaf(isLeaf);//是否叶子结点(1:是；0：不是)
		menuVo.setSign("");// 签名字段
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", menuVo);
		if (menuId == null) { // 新增
			// 调用服务，进行数据新增
			//用户只能查询自己企业的菜单信息。
			menuVo.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
			map.put("sign", "insertMenuInfo");// 所调用的服务中的方法
			response.setResponseType(ResponseType.SUCCESS_SAVE);
		} else {
			// 调用服务，进行数据更新
			map.put("sign", "updateMenuInfoById");// 所调用的服务中的方法
			response.setResponseType(ResponseType.SUCCESS_UPDATE);
		}
		ResBody result = TradeInvokeUtils.invoke("BusinessMenuManagement", map);
		// (5)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys()!= null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setObject(result);// 设置返回结果
					response.setInfo(erortx);// 设置返回的信息
					super.log.info("新增/编辑时，调用insertMenuInfo/updateMenuInfoById服务成功，信息：" + erortx);
					// (6)更新父部门的isLeaf为0
					if (menuPartId != 0 && superIsLeaf!=0) {// 顶级菜单和已经为父节点的菜单不需要在更新isLeaf
						menuVo = new MenuVo();
						menuVo.setIsLeaf(0);
						menuVo.setEnable(1);
						menuVo.setId(menuPartId);
						menuVo.setParentId(superParentId);
						updateMenu(menuVo);
					}
					response.setResponseType(ResponseType.SUCCESS);
					response.setInfo(I18NUtils.getText("sys.client.save.success"));
				} else {
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.save.fail"));
					super.log.error("新增/编辑时，调用insertMenuInfo/updateMenuInfoById服务失败，信息：" + erortx);
				}
			}
		} else {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.client.save.fail"));		
			super.log.error("调用服务失败！");
		}
		return response;
	}

	/**
	 * 编辑菜单信息（by id）
	 * 
	 * @param request
	 * @param id
	 *            编辑的菜单主键id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( "operator/{operatorId}" )
	public String editMenu(HttpServletRequest request, @PathVariable String operatorId) throws Exception {
		if("add".equals(operatorId)){
			return "ybl/admin/menu/menuEdit";
		}
		if("edit".equals(operatorId)){
			String menuId = super.getParameter("menuId");
			MenuVo menuVo = getMenu(Long.valueOf(menuId));
			MenuVo parentMenu = (MenuVo)getMenu(menuVo.getParentId());	
			getRequest().setAttribute("parentMenu",parentMenu);
			getRequest().setAttribute("menu", menuVo);
			getRequest().setAttribute("id", menuId);
			return "ybl/admin/menu/menuEdit";
		}
		//TODO 返回404页面或者不合法的操作页面
		return null;
	}

	/**
	 * 删除菜单信息（by id）
	 * 
	 * @param request
	 * @param id
	 *            删除的菜单主键id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteMenu")
	@ResponseBody
	public ControllerResponse deleteMenu(HttpServletRequest request,Long id[]) throws Exception {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (id == null) {
			super.log.error("id不能为空");
			response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			return response;
		}
		// (2)查询菜单是否存在,判断菜单是否已绑定角色
		for (Long _id : id) {
			MenuVo menuVo = (MenuVo) getMenu(Long.valueOf(_id));
			if (menuVo != null) { // 若存在，则删除
				// (3)菜单下有子菜单的记录不允许直接删除
				int isleaf = menuVo.getIsLeaf();
				if(isleaf==0){
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("delete.child.node"));//删除失败,请先删除子节点
					super.log.error("删除失败,请先删除子节点");
					return response;										
				}					
				menuVo = new MenuVo();
				menuVo.setEnable(1);// 1：有效；0：无效
				menuVo.setId(Long.valueOf(_id));
				//(4)菜单下关联了角色的不允许直接删除	
				List<?> list = queryGrantRoleMenu(menuVo.getId()); 
				if(CollectionUtils.isNotEmpty(list)) {
					super.log.error("删除失败,该菜单已关联角色,请先解除关联再删除"); 
					response.setInfo(I18NUtils.getText("delete.unbind.role.menu"));//删除失败,该菜单已关联角色,请先解除关联再删除
					return response; 
				}
			}
		}
		//(5) 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", id);
		map.put("sign", "deleteMenuById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("BusinessMenuManagement", map);
		// (6)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setInfo(I18NUtils.getText("sys.client.delete.success"));
					response.setResponseType(ResponseType.SUCCESS_DELETE);
					super.log.info("根据id删除菜单，调用deleteMenuById服务成功，信息：" + erortx);
					//TODO (7)查询当前被删除的子节点的父节点是否还有子节点
				} else {
					response.setResponseType(ResponseType.FAILURE);
					response.setInfo(I18NUtils.getText("sys.client.delete.fail"));
					super.log.error("根据id删除菜单，调用deleteMenuById服务失败，信息：" + erortx);
				}
			}
		}
		return response;
	}

	/**
	 * 根据菜单id查询单个菜单
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/getMenu")
	@ResponseBody
	public MenuVo getMenu(Long id) {			
		//(1) 判断必要参数是否存在
		if (id == null) {
			super.log.error("id不能为空");
			return null;
		}
		//(2)单个菜单数据查询
		MenuVo parameters = new MenuVo();
		parameters.setId(id);
		List<MenuVo> menuList = getMenuList(parameters);
		if (CollectionUtils.isNotEmpty(menuList)) {
			for(Object obj:menuList){
				MenuVo menu = (MenuVo)obj;
				if(id.longValue()==menu.getId().longValue()){				 
					return menu;
				}
			}		
		}
		return null;
	}

	/**
	 * 获取符合查询条件的菜单信息集合数据
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getMenuList")
	@ResponseBody
	public List<MenuVo> getMenuList(MenuVo parameters) {
		//(1)判断必要参数对象是否存在
		if (parameters == null) {
			super.log.error("menu对象不能为空");
			return null;
		}
		//考虑整形参数传递到数据库的过程中 ，如果不传，则会默认为0，故设置味-1L
		if(parameters!=null){
			if(parameters.getParentId()==null){//不传parentId时				
				parameters.setParentId(-1L);
			}
			if(parameters.getId()==null){//不传id时				
				parameters.setId(-1L);
			}
		}
		// (2)调用服务，进行数据保存
		List<MenuVo> menuList = null;
		parameters.setEnable(1);// 1：有效；0：无效
		//用户只能查看自己企业的菜单信息
		parameters.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("paramter", parameters);
		map.put("sign", "queryMenuByCondition");// 所调用的服务中的方法queryMenuByCondition	
		ResBody result = TradeInvokeUtils.invoke("BusinessMenuManagement", map);
		// (3)对调用服务后的返回数据进行解析	
		if (result != null) {	
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					JSONObject output = (JSONObject)result.getOutput();
					String resultJson = output.getString("result");
					menuList= JsonUtils.toList(resultJson, MenuVo.class);				
					super.log.info("根据条件查询菜单信息，调用queryMenuByCondition服务成功，信息：" + erortx);
				} else {
					super.log.error("根据条件查询菜单信息，调用queryMenuByCondition服务失败，信息：" + erortx);
				}
			}
		}
		return menuList;
	}

	/**
	 * 更新菜单信息（根据id）
	 * @param id
	 * @param isLeaf 是否也叶子节点（0：否；1：是）
	 * @return
	 */
	@RequestMapping(value = "/updateMenu")
	@ResponseBody
	public void updateMenu(MenuVo menuVo) {
		// (1)判断必要对象参数
		if (menuVo == null) {
			super.log.error("menuVo不能为空");
			return;
		}
		//考虑整形参数传递到数据库的过程中 ，如果不传，则会默认为0，故设置味-1L		
		if(menuVo.getParentId()==null){//不传parentId时				
			menuVo.setParentId(-1L);
		}
	
		// (2)菜单数据更新
		Map<String, Object> map = new HashMap<String, Object>();	
		ControllerUtils.setWho(menuVo);// 设置创建人、修改人、创建时间、修改时间		
		ResBody result = null;
		// (3)调用服务，进行数据保存
		map.put("paramter", menuVo);
		map.put("sign", "updateMenuInfoById");// 所调用的服务中的方法
		result = TradeInvokeUtils.invoke("BusinessMenuManagement", map);
		// (4)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					super.log.info("更新updateMenuInfoById服务调用信息：" + erortx);
					return;
				} else {
					super.log.error("更新updateMenuInfoById服务调用信息：" + erortx);
					return;
				}
			}
		}
	}
	/**
	 * 加载菜单树的信息
	 * @param roleId
	 * @param parentId
	 * @return
	 */
	@RequestMapping(value = "/meunTree1")
	@ResponseBody
	public List<MenuVo> getMeunListByRoleId(Long roleId,Long parentId){
		//(1)判断必要参数对象是否存在
		if (roleId == null) {
					super.log.error("roleId不能为空");
					return null;
				}
		RoleMenuVo rm=new RoleMenuVo();
		rm.setRoleId(roleId);
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("paramter", rm);
		map.put("sign", "queryRoleMenuInfoByRoleId");// 所调用的服务中的方法queryMenuByCondition	
		ResBody result = TradeInvokeUtils.invoke("BusinessRoleMenuManagement", map);
		 List<MenuVo> menuList = null;
		 if (result != null) {
				JSONObject output = (JSONObject)result.getOutput();
				if (result.getSys() != null) {
					String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
					String erortx = result.getSys().getErortx();// 错误信息
					if ("S".equals(status)) {// 交易成功
						JSONObject resultJson = (JSONObject)output.get("result");
						String menuId = resultJson.getString("menuId");
						menuList= JsonUtils.toList(menuId, MenuVo.class);
						
						super.log.info("根据条件查询菜单信息，调用queryRoleMenuInfoByRoleId服务成功，信息：" + erortx);
					} else {
						super.log.error("根据条件查询菜单信息，调用queryRoleMenuInfoByRoleId服务失败，信息：" + erortx);
					}
				}
			}
		 MenuVo mv=new MenuVo();
		 mv.setId(-1L);
		 mv.setParentId(parentId);
		 mv.setEnable(1);
		 List<MenuVo> allMenuList = getMenuList(mv);
		 if(CollectionUtils.isNotEmpty(menuList)){
			 for (MenuVo menuVo : allMenuList) {
					for (MenuVo menuVo1 : menuList) {
						if(menuVo.getId().equals(menuVo1.getId())){
							menuVo.setAttribute1("1");//使用备有字段attribute1,1代表被选中
						}
					}
				}
		 }
		return allMenuList;
	}
	/**
	 * 跳转菜单树页面
	 * @param request
	 * @param roleId
	 * @return
	 */
	@RequestMapping(value = "/meunTree")
	public String showMenuTree(HttpServletRequest request,Long roleId){
		getRequest().setAttribute("roleId",roleId);
		return "ybl/admin/role/menuTree";
	}

	/**
	 * 查询菜单下绑定的角色信息
	 * @param request
	 * @param menuId 菜单id
	 * @return
	 */
	@RequestMapping(value="/queryGrantRoleMenu")
	@ResponseBody
	public List<MenuVo> queryGrantRoleMenu(Long menuId){	
		Map<String, Object> map=new HashMap<String, Object>();
		List<MenuVo> menuList = null;
		RoleMenuVo roleMenuVo  = new RoleMenuVo();
		//(1)判断必要参数是否存在
		if(menuId!=null){
			roleMenuVo.setMenuId(menuId);
			roleMenuVo.setEnable(1);
			map.put("paramter", roleMenuVo);
			map.put("sign", "queryRoleMenuInfoByMenuId");
			//(2)调用服务，进行数据保存
			ResBody result = TradeInvokeUtils.invoke("BusinessRoleMenuManagement", map);
			//(3)解析返回数据
			if(result!=null){
				JSONObject output = (JSONObject)result.getOutput();				
				if (result.getSys() != null) {
					String status = result.getSys().getStatus();
					String erortx = result.getSys().getErortx();// 错误信息
					if ("S".equals(status)) {// 交易成功
						JSONObject resultJson = (JSONObject)output.get("result");
						String menuIds = resultJson.getString("fwRoleMenus");
						menuList= JsonUtils.toList(menuIds, MenuVo.class);						
						super.log.info("查询角色信息，调用queryRoleMenuInfoByRoleId服务成功："+erortx);
					}else{						
						super.log.error("查询菜单下绑定的角色信息，调用 queryRoleMenuInfoByRoleId服务失败："+erortx);
					}
				}
			}else{								
				super.log.error("调用服务失败！");
			}
		}else{			
			super.log.error("必要参数不能为空！");
		}	
		return menuList;
	}
	
	 
    /**
     * 查询所有菜单数据
     * @return
     */
    @ResponseBody
    @RequestMapping("/queryAllMenu")
	public ControllerResponse queryAllMenu() {
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)调用服务，进行数据保存
		List<MenuVo> menuList = null;
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("paramter", "");
		map.put("sign", "queryAllMenu");// 所调用的服务中的方法queryAllMenu	
		ResBody result = TradeInvokeUtils.invoke("BusinessMenuManagement", map);
		// (2)对调用服务后的返回数据进行解析	
		if (result != null) {	
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				response.setInfo(erortx);// 设置返回的信息
				if ("S".equals(status)) {// 交易成功
					JSONObject output = (JSONObject)result.getOutput();
					String resultJson = output.getString("result");
					menuList= JsonUtils.toList(resultJson, MenuVo.class);
					response.setObject(menuList);// 设置返回结果
					response.setResponseType(ResponseType.SUCCESS);
					super.log.info("查询所有菜单信息，调用queryAllMenu服务成功，信息：" + erortx);
				} else {
					super.log.error("查询所有菜单信息，调用queryAllMenu服务失败，信息：" + erortx);
				}
			}
		}else{			
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！			
			super.log.error("调用服务失败！");
		}
		return response;
	}

}
