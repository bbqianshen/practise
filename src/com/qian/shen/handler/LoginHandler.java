package com.qian.shen.handler;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qian.shen.service.UserService;

@Controller
public class LoginHandler {

	@Autowired
	private UserService userService;

	@ResponseBody
	@RequestMapping(value = "/validateLogin", method = RequestMethod.POST)
	public String validateLogin(
			@RequestParam(value = "username", required = true) String username,
			@RequestParam(value = "password", required = true) String password,
			HttpSession httpSession ) throws IOException {
		System.out.println("success");
		boolean flag = true;
		
    	Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(username,password);
		try {
			// 执行认证操作
			subject.login(token);
			userService.updateUserLastLogTime(username, new Date());
		} catch (Exception e) {
			System.out.println("登陆失败:" + e.getMessage());
			flag = false;
		}
		
		Map<String, Boolean> map = new HashMap<>();
		map.put("valid", flag);
		ObjectMapper mapper = new ObjectMapper();
		String resultString = "";
		
		try {
			resultString = mapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return resultString;
	}
	
	@RequestMapping("/index")
	public String loginSuccess(HttpSession httpSession){
		return "index";
	}
	
	
	@RequestMapping("/login")
	public String login(){
		return "login";
	}
}
