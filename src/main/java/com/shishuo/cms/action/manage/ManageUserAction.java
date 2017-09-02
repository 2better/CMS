/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.action.manage;

import com.shishuo.cms.entity.User;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.UserService;
import com.shishuo.cms.util.SSUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/manage/user")
public class ManageUserAction extends ManageBaseAction{

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/manage.htm", method = RequestMethod.GET)
	public String manage() {
		return "manage/user/manage";
	}

	@RequestMapping(value = "/list.json", method = RequestMethod.POST)
	@ResponseBody
	public PageVo<User> list(@RequestParam(value = "p", defaultValue = "1") int pageNum)
	{
		int rows = configService.getIntKey("pagination_num");
		return userService.getAllListPage(pageNum,rows);
	}


	@ResponseBody
	@RequestMapping(value = "/addNew.json", method = RequestMethod.POST)
	public JsonVo<String> addNewUser(
			@RequestParam(value = "userName") String userName,
			@RequestParam(value = "password") String password) {
		JsonVo<String> json = new JsonVo<String>();
		try {
			if (userName.equals("")) {
				json.getErrors().put("userName", "名称不能为空");
			}
			if (StringUtils.isBlank(password)) {
				json.getErrors().put("password", "密码不能为空");
			} else if (password.length() < 6) {
				json.getErrors().put("password", "密码不能小于6位");
			} else if (password.length() > 16) {
				json.getErrors().put("password", "密码不能大于16位");
			}
			User user = userService.getUserByName(userName);
			if (user != null) {
				json.getErrors().put("userName", "该账号已存在");
			}
			// 检测校验结果
			validate(json);
			userService.addUser(SSUtils.toText(userName.trim()),
					password);
			json.setResult(true);
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
			json.setResult(false);
			json.setMsg(e.getMessage());
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/delete.json", method = RequestMethod.POST)
	public JsonVo<String> delete(@RequestParam(value = "userId") long userId) {
		JsonVo<String> json = new JsonVo<String>();
		try {
			userService.deleteUser(userId);
			json.setResult(true);
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
			json.setResult(false);
			json.setMsg(e.getMessage());
		}
		return json;
	}

}
