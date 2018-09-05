package com.kh.cat.point.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.cat.point.service.PointService;

@Controller
public class PointController {

	private static final Logger logger = LoggerFactory.getLogger(PointController.class);
	@Autowired PointService pointService;

	//쿠폰샵 페이지 이동
	@RequestMapping(value="/couponShopPage")
	public String couponShopPage() {
		logger.info("쿠폰샵 페이지 요청");
		return "point/couponShop";
	}
	
	/*//쿠폰샵 리스트
	@RequestMapping(value="/couponShop")
	public @ResponseBody HashMap<String, Object> couponShop() {
		logger.info("couponShop 요청");
		return pointService.couponShopList();
	}*/
	
	//쿠폰 구매
	@RequestMapping(value="/couponPurchase")
	public @ResponseBody HashMap<String, Object> couponPurchase(@RequestParam("price") String price, 
			@RequestParam("name") String name, HttpServletRequest request) {
		logger.info("couponPurchase 요청");
		logger.info("code : {}", price);
		logger.info("name : {}", name);
		
		String loginId = (String) request.getSession().getAttribute("loginId");
		logger.info("세션 : {}", loginId);
		return pointService.couponPurchase(price, name, loginId);
	} 
	
}
