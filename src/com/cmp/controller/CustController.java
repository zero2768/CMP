package com.cmp.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cmp.DatatableResponse;
import com.cmp.MenuItem;
import com.cmp.form.CustForm;
import com.cmp.model.Customer;
import com.cmp.security.SecurityUtil;
import com.cmp.service.CustService;

@Controller
@RequestMapping(value="/cust")
public class CustController extends BaseController {
	private static Log log = LogFactory.getLog(CustController.class);
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Autowired
	private CustService custService;
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String viewList(Model model) {
		setActiveMenu(model, MenuItem.MY_CUST);
		return "cust/list";
	}
	
	/**
	 * 
	 * 取得轉檔原始檔資料
	 * 
	 * @param start
	 * @param length
	 * @return
	 */
	@RequestMapping(value="getCust4Admin.json", method = RequestMethod.GET, produces="application/json")
	public @ResponseBody DatatableResponse getCust4Admin(
			@RequestParam(name="start", required=false, defaultValue="0") Integer start,
			@RequestParam(name="length", required=false, defaultValue="10") Integer length) {
//		SecurityUser securityUser = SecurityUtil.getSecurityUser();
		List<Customer> custList = custService.findCustByUserId(null, start, length);
		long total = custService.countCustByUserId(null);
		return new DatatableResponse(total, trans2CustFormList(custList), total);
	}
	
	
	/**
	 * 
	 * 取得轉檔原始檔資料
	 * 
	 * @param start
	 * @param length
	 * @return
	 */
	@RequestMapping(value="getCustByUserId.json", method = RequestMethod.GET, produces="application/json")
	public @ResponseBody DatatableResponse getCustByUserId(
			@RequestParam(name="start", required=false, defaultValue="0") Integer start,
			@RequestParam(name="length", required=false, defaultValue="10") Integer length) {
//		SecurityUser securityUser = SecurityUtil.getSecurityUser();
		String userId = SecurityUtil.getSecurityUser().getUser().getId();
		List<Customer> custList = custService.findCustByUserId(userId, start, length);
		
		long total = custService.countCustByUserId(userId);
		return new DatatableResponse(total, trans2CustFormList(custList), total);
	}
	
	private List<CustForm> trans2CustFormList(List<Customer> custList) {
		List<CustForm> custFormList = new ArrayList<CustForm>();
		CustForm cf = null;
		for (Customer c : custList) {
			cf = new CustForm();
			BeanUtils.copyProperties(c, cf);
			cf.setCreateDateStr(sdf.format(new Date(cf.getCreateTime().getTime())));
			cf.setUpdateDateStr(sdf.format(new Date(cf.getUpdateTime().getTime())));
			custFormList.add(cf);
		}
		
		return custFormList;
	}
}
