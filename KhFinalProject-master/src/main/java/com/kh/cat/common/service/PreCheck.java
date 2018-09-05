package com.kh.cat.common.service;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class PreCheck extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("세션 검사");
		RequestDispatcher rd = request.getRequestDispatcher("loginForm");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("loginId");
		boolean pass = false;
		if(id==null) {
			System.out.println("로그인 안됨");
			//response.sendRedirect("/cat/loginForm");
			request.setAttribute("msg", "로그인이 필요한 서비스입니다");
			rd.forward(request, response);
		}else {
			System.out.println("로그인 됨");
			pass = true;
		}
		return pass;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView mav) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
	
}
