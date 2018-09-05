package com.kh.cat.point.service;

import java.util.HashMap;
import java.util.Random;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.cat.dto.CouponBoxDTO;
import com.kh.cat.point.dao.PointInter;

@Service
public class PointService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired SqlSession sqlSession;
	PointInter inter;
	
	/*//쿠폰샵 리스트
	public @ResponseBody HashMap<String, Object> couponShopList() {
		logger.info("couponShop 서비스 실행");
		inter = sqlSession.getMapper(PointInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<CouponBoxDTO> list = inter.couponShopList();
		map.put("list", list);
		return map;
	}*/

	//쿠폰 구매
	@Transactional
	public HashMap<String, Object> couponPurchase(String price, String name, String loginId) {
		logger.info("couponPurchase 서비스 실행");
		inter = sqlSession.getMapper(PointInter.class);
		CouponBoxDTO dto = new CouponBoxDTO();
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//쿠폰코드 랜덤으로 섞기**********************************************
		int certNumLength = 8;
		Random random = new Random(System.currentTimeMillis());
		int range = (int) Math.pow(10, certNumLength);
		int trim = (int) Math.pow(10, certNumLength-1);
		int code = random.nextInt(range)+trim;
		if(code > range) {
			code = code - trim;
		}
		//************************************************************
		java.sql.Date today = new java.sql.Date(new java.util.Date().getTime());
		logger.info("현재시간 : {}", today);
		int a =0;
		logger.info("랜덤 코드 : {}",code);
		dto.setCouponBox_code(code);
		dto.setId(loginId);
		dto.setCouponBox_price(Long.parseLong(price));
		dto.setCouponBox_name(name);
		dto.setCouponBox_use(a);
		
		int myPoint = inter.myPoint(loginId);//내포인트 조회
		logger.info("내 포인트 : {}", myPoint);
		
		int couponPrice = Integer.parseInt(price);//쿠폰 가격
		if(myPoint < couponPrice) {//내 포인트가 쿠폰가격보다 작으면
			logger.info("포인트가 부족합니다.");
			map.put("msg", "포인트가 부족합니다.");
		}else {
			int result = inter.couponPurchase(loginId, couponPrice);//쿠폰구매 쿼리
			map.put("couponPurchaseMsg", result);//쿠폰구매여부
			int success = inter.myCoupon(dto);//쿠폰함 추가 쿼리
			int pointListAdd = inter.pointListAdd(loginId, couponPrice);//포인트 리스트에 추가
			map.put("couponBoxMsg", success);//쿠폰함 추가 여부
			map.put("msg", "쿠폰 구매 완료");
		}
		return map;
	}

}
