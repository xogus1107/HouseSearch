package com.ssafy.happyhouse.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ssafy.happyhouse.dto.MemberDto;
import com.ssafy.happyhouse.service.MemberService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	MemberService service;
	
	@RequestMapping(value = "/mvjoin", method=RequestMethod.GET)
	public String mvjoin() {
		return "user/join";
	}
	
	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public String mvinfo() {
		return "user/info";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(MemberDto user, Model model) {
		
		int scnt = service.join(user);
		if(scnt ==1) {
			return "user/joinsuccess";
		}else {
			model.addAttribute("msg", "회원가입 중 문제가 발생했습니다.");
			return "../error/error.jsp";
		}
		//System.out.println(user.getId());
		//return "user/join";
	}
	
	@RequestMapping(value="/mvlogin", method= RequestMethod.GET)
	public String mvlogin() {
		return "user/login";
	}
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String login(HttpServletRequest request,HttpServletResponse response,  HttpSession session) {
		String userid= request.getParameter("userid");
		String userpwd= request.getParameter("userpwd");
		MemberDto dto = service.login(userid, userpwd);
		if(dto!=null) {
			String idsv = request.getParameter("idsave");
			if("saveok".equals(idsv)) { // 아이디 저장 체크
				Cookie cookie = new Cookie("ssafy_id", userid);
				System.out.println(userid);
				cookie.setPath(request.getContextPath()); // 어느 경로에서 사용할지 설정
				cookie.setMaxAge(60*60*24);
				response.addCookie(cookie);
				System.out.println("쿠키 만들기 성공!");
			}else { // 체크 해제
				Cookie[] cookies = request.getCookies();
				if(cookies != null){
					for(Cookie cookie : cookies){
						if(cookie.getName().equals("ssafy_id")){
							cookie.setPath(request.getContextPath());
							cookie.setMaxAge(0); // 쿠기는 지우는게 없기 때문에 setMaxAge(0) 사용
							response.addCookie(cookie);
							break;
						}
					}
				}
			}
			System.out.println("성공");
			session.setAttribute("userinfo", dto);
			return "redirect:/";
			
		}
		else {
			request.setAttribute("msg", "아이디 또는 비밀번호를 확인하세요");
			return "user/login";
		}
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("userinfo");
		return "redirect:/";
	}
	
	@RequestMapping(value="/mvmodify", method = RequestMethod.GET)
	public String moveModify(String userid, Model model) {
		MemberDto dto = service.getInfo(userid);
		model.addAttribute("info", dto);
		return "user/modify";
	}
	
	@RequestMapping(value="/modify", method = RequestMethod.POST)
	public String modify(MemberDto dto, HttpSession session, Model model) {
		int scnt = service.modifyInfo(dto);
		if(scnt ==1) {
			session.setAttribute("userinfo", dto);
			return "user/modifysuccess";
		}
		else {
			model.addAttribute("msg", "수정중 문제발생");
			return "../error/error.jsp";
		}
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(String userid, HttpSession session, Model model) {
		int scnt = service.delete(userid);
		if(scnt==1) {
			session.removeAttribute("userinfo");
			return "user/deletesuccess";
		}else {
			model.addAttribute("msg", "삭제중 문제발생");
			return "../error/error.jsp";
		}
	}
	
}
