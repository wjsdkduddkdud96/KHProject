package com.kh.cat.admin.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cat.admin.service.AdminService;

@Controller
public class AdminController {

	private Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired AdminService adminService;
	
	//신고된 리뷰 새창열기
	@RequestMapping(value = "/comp_review_moveWin")
	public ModelAndView sendMessage(@RequestParam HashMap<String, String> params) {
		logger.info("신고된 리뷰 새창 요청");
		ModelAndView mav = new ModelAndView();
		mav.addObject("rev_idx", params.get("rev_idx"));
		mav.addObject("revReply_idx", params.get("revReply_idx"));
		mav.addObject("id", params.get("id"));
		mav.addObject("complain_id", params.get("complain_id"));
		mav.addObject("complain_idx", params.get("complain_idx"));
		mav.setViewName("admin/complainReviewList");
		return mav;
	}
	
	//게시물 삭제시 쪽지보내기
	@RequestMapping(value = "/rev_revRe_delDM")
	public ModelAndView rev_revRe_delDM(@RequestParam HashMap<String, String> params) {
		logger.info("신고된 리뷰 새창 요청");
		ModelAndView mav = new ModelAndView();
		mav.addObject("rev_idx", params.get("rev_idx"));
		mav.addObject("revReply_idx", params.get("revReply_idx"));
		mav.addObject("id", params.get("id"));
		mav.addObject("complain_id", params.get("complain_id"));
		mav.setViewName("admin/rev_revRe_delDM");
		return mav;
	}
	
	@RequestMapping(value = "/dm_writePage")
	public String dm_writePage() {
		logger.info("쪽지 새창 요청");	
		return "admin/dm_write";
	}
	
	// 관리자-쪽지보내기
	@RequestMapping(value = "/dm_write")
	public @ResponseBody HashMap<String, Object> dm_write(@RequestParam HashMap<String, String> params) {
		logger.info("쪽지보내기 요청");
		return adminService.dm_write(params);
	}
	
	
	
	// 게시물 삭제시 쪽지 보내기
	@RequestMapping(value = "/dm_write_rev_revRe_del")
	public @ResponseBody HashMap<String, Object> dm_write_rev_revRe_del(@RequestParam HashMap<String, String> params,
			HttpServletRequest request) {
		logger.info("게시물 삭제시 쪽지보내기 요청");
		String loginId = (String) request.getSession().getAttribute("loginId");
		return adminService.dm_write_rev_revRe_del(params, loginId);
	}
	
	
	
	//가게 등록 취소시 새창열기
	@RequestMapping(value = "/registNoWin")
	public ModelAndView registNoWin(@RequestParam HashMap<String, String> params) {
		logger.info("가게 등록 거절 새창 요청");
		ModelAndView mav = new ModelAndView();
		mav.addObject("store_idx", params.get("store_idx"));
		mav.addObject("id", params.get("id"));
		mav.setViewName("admin/registNo");
		return mav;
	}
	
	
	// 신고 리스트(관리자)
	@RequestMapping(value = "/complainList")
	public @ResponseBody HashMap<String, Object> complainList(@RequestParam HashMap<String, String> params) {
		logger.info("신고 리스트 요청");
		return adminService.ComplainList(params);
	}

	//가게 등록 리스트(관리자)
	@RequestMapping(value = "/storeRegistList")
	public @ResponseBody HashMap<String, Object> storeRegistList(@RequestParam HashMap<String, String> params) {
		logger.info("가게 등록 리스트 요청");
		return adminService.storeRegistList(params);
	}
	
	//블랙리스트 추가(관리자)
	@RequestMapping(value = "/blackListAdd")
	public @ResponseBody HashMap<String, Object> blackListAdd(@RequestParam HashMap<String, String> params) {
		logger.info("블랙리스트 추가 요청");
		logger.info("리뷰 idx : {}", params.get("rev_idx"));
		logger.info("리뷰 댓글 idx : {}", params.get("revReply_idx"));
		logger.info("신고한 아이디 : {}", params.get("id"));
		logger.info("신고 idx : {}", params.get("complain_idx"));
		return adminService.blackListAdd(params);
	}

	//신고 취하(관리자)
	@RequestMapping(value = "/comp_cancel")
	public @ResponseBody HashMap<String, Object> comp_cancel(@RequestParam HashMap<String, String> params) {
		logger.info("신고 취하 요청");
		logger.info("리뷰 idx : {}", params.get("rev_idx"));
		logger.info("리뷰 댓글 idx : {}", params.get("revReply_idx"));
		logger.info("신고한 아이디 : {}", params.get("id"));
		return adminService.comp_cancel(params);
	}

	//가게 등록 승인(관리자)
	@RequestMapping(value = "/registYes")
	public @ResponseBody HashMap<String, Object> registYes(@RequestParam HashMap<String, String> params, HttpServletRequest request) {
		logger.info("가게 등록 승인 요청");
		logger.info("스토어 idx : {}", params.get("store_idx"));
		logger.info("아이디 : {}", params.get("id"));
		
		String loginId = (String) request.getSession().getAttribute("loginId");
		
		return adminService.registYes(params, loginId);
	}
	
	//가게 등록 거절(관리자)
	@RequestMapping(value = "/dm_write_regNo")
	public @ResponseBody HashMap<String, Object> dm_write_regNo(@RequestParam HashMap<String, String> params, HttpServletRequest request) {
		logger.info("가게 등록 거절 요청");
		logger.info("스토어 idx : {}", params.get("store_idx"));
		logger.info("아이디 : {}", params.get("id"));
		
		String loginId = (String) request.getSession().getAttribute("loginId");
		
		return adminService.registNo(params, loginId);
	}
	
		
	// 신고된 리뷰 리스트(관리자)
	@RequestMapping(value = "/complain_review_move")
	public @ResponseBody HashMap<String, Object> complain_review_move(@RequestParam HashMap<String, String> params) {
		logger.info("신고 리뷰 리스트 요청");
		logger.info("리뷰 idx : {}", params.get("rev_idx"));
		logger.info("리뷰 댓글 idx : {}", params.get("revReply_idx"));
		
		String rev_idx = params.get("rev_idx");
		String revReply_idx = params.get("revReply_idx");
		
		
		return adminService.complain_reviewList(params);
	}
	//신고된 리뷰 해시태그, 사진
	@RequestMapping(value = "/comp_rev_hash_photo")
	public @ResponseBody HashMap<String, Object> reviewHashPhoto(
			@RequestParam HashMap<String, String> params) {
		logger.info("리뷰 해시태그, 사진 요청");
		logger.info("리뷰 idx : {}", params.get("rev_idx"));
		return adminService.reviewHashPhoto(params);
	}

}
