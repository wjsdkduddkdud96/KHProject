package com.kh.cat.store.controller;

import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cat.store.service.StoreService;

@Controller
public class StoreController {
	
	@Autowired StoreService storeService;

	private static final Logger logger = LoggerFactory.getLogger(StoreController.class);
	
	//가게등록 페이지 이동
	@RequestMapping(value = "/storeRegistForm", method = RequestMethod.GET)
	public String storeRegistForm() {
		logger.info("가게등록 페이지 요청.");
		storeService.listReset();
		return "store/storeRegistForm";
	}
	
	//메뉴 사진 추가 페이지
	@RequestMapping(value = "/menuPhotoForm", method = RequestMethod.GET)
	public String menuPhotoForm() {
		logger.info("가게등록 페이지 요청.");
		return "store/menuPhotoForm";
	}
	
	//메뉴 사진 업로드 
	@RequestMapping(value = "/menuUpload")
	public ModelAndView upload(MultipartFile file, HttpSession session) {
		logger.info("메뉴 사진 업로드 요청.");
		String root = session.getServletContext().getRealPath("/");
		return	storeService.menuUpload(file, root);
	}
	
	//메뉴 사진 삭제
	@RequestMapping(value = "/menuDel")
	public @ResponseBody HashMap<String, Integer> 
	menuDel(@RequestParam("fileName") String fileName, HttpSession session) {
		logger.info("메뉴 삭제 요청.");
		String root = session.getServletContext().getRealPath("/");
		return storeService.fileDel(root, fileName);
	}
	
	//대표 사진 업로드 
	@RequestMapping(value = "/photoUpload")
	public @ResponseBody HashMap<String, Object> photoUpload(MultipartHttpServletRequest multi) {
		logger.info("대표 사진 업로드 요청.");
		String root = multi.getSession().getServletContext().getRealPath("/");
		return storeService.photoUpload(multi, root);
	}
		
	//대표 사진 초기화
	@RequestMapping(value = "/photoDel")
	public @ResponseBody HashMap<String, Object> photoDel(@RequestParam("storePhoto") String storePhoto,HttpSession session) {
		logger.info("대표 사진 초기화 요청.");
		String root = session.getServletContext().getRealPath("/");
		return storeService.photoDel(storePhoto,root);
	}
	
	//맛집 등록
	@RequestMapping(value = "/storeRegist")
	public @ResponseBody HashMap<String, Object> 
	storeRegist(@RequestParam (value="tagList[]") String[] tagArr	
			,@RequestParam HashMap<String, String> data, HttpServletRequest session) {
		logger.info("맛집 등록 요청.");
		String loginId = (String) session.getSession().getAttribute("loginId");
		
		return storeService.storeRegist(loginId, tagArr, data);
	}
	
	//맛집 상세보기
	@RequestMapping(value = "/storeDetail", method = RequestMethod.GET)
	public ModelAndView storeDetail(@RequestParam("store_idx") int store_idx, HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		logger.info("가게 상세 페이지 요청.");
		
		
		
		String aut = (String) request.getSession().getAttribute("loginAut");
		int registSF = storeService.registSF(store_idx);//등록 여부 판단
		if(aut==null) {//비로그인시 권한을 unLogin 처리
			aut="unLogin";	
		}
		
		if(!aut.equals("admin")) {
			String sIdx = Integer.toString(store_idx);
			int sf = storeService.uphitSF(sIdx, request);//조회 유무 판단
			if(sf==0&&registSF==1) {
				Cookie ck = new Cookie("StoreDetail"+store_idx, sIdx);
				ck.setMaxAge(24*60*60);
				ck.setPath("/");
				response.addCookie(ck);  
				storeService.storeUphits(store_idx);//조회수 증가
			}
		}
		return storeService.storeDetail(store_idx,aut,registSF,session);
	}
	
	//찜 확인
	@RequestMapping(value = "/storeLikeChk")
	public @ResponseBody HashMap<String, Object> 
	storeLikeChk(@RequestParam("store_idx") int store_idx, HttpServletRequest session) {
			logger.info("맛집 찜 여부 요청.");
			String loginId = (String) session.getSession().getAttribute("loginId");
			return storeService.storeLikeChk(loginId, store_idx);
	}
	
	//찜 하기
		@RequestMapping(value = "/storeLike")
		public @ResponseBody HashMap<String, Object> 
		storeLike(@RequestParam("store_idx") int store_idx, HttpServletRequest session) {
				logger.info("맛집 찜 요청.");
				String loginId = (String) session.getSession().getAttribute("loginId");
				return storeService.storeLike(loginId, store_idx);
		}
}
