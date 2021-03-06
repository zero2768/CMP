package com.cmp.controller;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cmp.DatatableResponse;
import com.cmp.MenuItem;
import com.cmp.model.Role;
import com.cmp.service.RoleService;

@Controller
@RequestMapping(value="/admin/role")
public class AdminRoleController extends BaseController {
	private static Log log = LogFactory.getLog(AdminRoleController.class);
	@Autowired
	private RoleService roleService;
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String viewList(Model model) {
		setActiveMenu(model, MenuItem.ADMIN_ROLE);
		return "admin/role";
	}
	
	/**
	 * 取得Cust資料
	 * 
	 * @param start
	 * @param length
	 * @return DatatableResponse
	 */
	@RequestMapping(value="getRole4Admin.json", method = RequestMethod.GET, produces="application/json")
	public @ResponseBody DatatableResponse getCust4Admin(
			@RequestParam(name="start", required=false, defaultValue="0") Integer start,
			@RequestParam(name="length", required=false, defaultValue="10") Integer length) {
//		SecurityUser securityUser = SecurityUtil.getSecurityUser();
//		String userId = SecurityUtil.getSecurityUser().getUser().getId();
		List<Role> datalist = roleService.listRole(start, length);
		long total = roleService.countRole();
		return new DatatableResponse(total, datalist, total);
	}

}
