package com.kh.cat.common.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cat.common.service.CommonService;

@Controller
public class CommonController {

	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	@Autowired CommonService commonservice;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		return "main";
	}
	
	/*@RequestMapping(value = "/search")
	public ModelAndView search(@RequestParam HashMap<String,String> params) {
		logger.info("검색 페이지 이동");
		logger.info("지역 : "+params.get("search_map"));
		logger.info("검색어 : "+params.get("search_content"));
		return commonservice.storeSearch(params);
	}*/
	
	@RequestMapping(value = "/search")
	public String search(@RequestParam HashMap<String,String> params) {
		logger.info("검색 페이지 이동");
		logger.info("지역 : "+params.get("search_map"));
		logger.info("검색어 : "+params.get("search_content"));
		return "include/common/search";
	}
	
	@RequestMapping(value = "/searchSort/6/{page}")
	public @ResponseBody HashMap<String,Object> searchSort(@RequestParam HashMap<String,String> params, @PathVariable String page) {
		logger.info("검색 정렬 페이지 이동");
		logger.info("지역 : "+params.get("search_map"));
		logger.info("정렬 : "+params.get("data"));
		logger.info("검색어 : "+params.get("search_content"));
		logger.info("메인인지 검색인지 : "+params.get("mainStore"));
		logger.info("페이지 : "+page);
		return commonservice.storeSearchSort(params,page);
	}
	
	@RequestMapping(value = "/receivelist")
	public @ResponseBody HashMap<String, Object> receivelist(@RequestParam Map<String,String> params) {
		logger.info("받은 메세지 확인");
		String msg= params.get("msg");
		logger.info("msg : {}",msg);		
		return commonservice.receivelist(params);
	}
	@RequestMapping(value = "/sendlist")
	public @ResponseBody HashMap<String, Object> sendlist(@RequestParam Map<String,String> params) {
		logger.info("보낸 메세지 확인");
		//String id = params.get("id");
		String msg= params.get("msg");
		//logger.info("id : {}",id);
		logger.info("msg : {}",msg);		
		return commonservice.sendlist(params);
	}
	@RequestMapping(value = "/sendMessage")
	public ModelAndView sendMessage(@RequestParam("id") String id) {
		logger.info("메세지 보내기 페이지 이동");
		ModelAndView mav = new ModelAndView();
		mav.addObject("id",id);
		mav.setViewName("timeline/timeline_sendMessage");
		return mav;
	}
	@RequestMapping(value = "/receivedetail")
	public ModelAndView receivedetail(@RequestParam("idx") String idx) {
		logger.info("{}번 메세지 요청",idx);
		return commonservice.receivedetail(idx);
	}
	@RequestMapping(value = "/senddetail")
	public ModelAndView senddetail(@RequestParam("idx") String idx) {
		logger.info("{}번 메세지 요청",idx);
		return commonservice.senddetail(idx);
	}
	@RequestMapping(value = "/pointlist")
	public @ResponseBody HashMap<String, Object> pointlist(@RequestParam Map<String,String> params) {
		logger.info("포인트 리스트 요청");		
		return commonservice.pointlist(params);
	}
	@RequestMapping(value = "/couponlist")
	public @ResponseBody HashMap<String, Object> cuponlist(@RequestParam Map<String,String> params) {
		logger.info("쿠폰 리스트 요청");		
		return commonservice.couponlist(params);
	}
	@RequestMapping(value = "/messagesendidcheck")
	public @ResponseBody HashMap<String, Object> messagesendidcheck(@RequestParam Map<String,String> params) {
		logger.info("포인트 리스트 요청");		
		return commonservice.messagesendidcheck(params);
	}
	@RequestMapping(value = "/sendmsg")
	public @ResponseBody HashMap<String, Object> sendmsg(@RequestParam Map<String,String> params) {
		logger.info("포인트 리스트 요청");		
		return commonservice.sendmsg(params);
	}
	@RequestMapping(value = "/timeline")
	public ModelAndView timeline(@RequestParam("id") String id,HttpSession session) {
		System.out.println("타임라인 요청");
		String userid=(String)session.getAttribute("loginId");
		logger.info(userid);
		ModelAndView mav = new ModelAndView();
		mav.addObject("id",id);
		mav.setViewName("timeline/timeline_main");
		return mav;
	}
	@RequestMapping(value = "/maintimeline")
	public @ResponseBody HashMap<String, Object> maintimeline(@RequestParam Map<String,String> params) {
		logger.info("타임라인 메인 리뷰,좋아요,찜한가게,팔로우 목록 요청");		
		return commonservice.maintimeline(params);
	}
	@RequestMapping(value = "/timelinereviewlist")
	public @ResponseBody HashMap<String, Object> timelinereviewlist(@RequestParam Map<String,String> params) {
		logger.info("리뷰 리스트 요청");		
		return commonservice.timelinereviewlist(params);
	}
	@RequestMapping(value = "/followinsert")
	public @ResponseBody HashMap<String, Object> followinsert(@RequestParam Map<String,String> params) {
		logger.info("팔로우 요청");		
		return commonservice.followinsert(params);
	}
	@RequestMapping(value = "/followcheck")
	public @ResponseBody HashMap<String, Object> followcheck(@RequestParam Map<String,String> params) {
		logger.info("팔로우 체크");		
		return commonservice.followcheck(params);
	}
	@RequestMapping(value = "/followdelete")
	public @ResponseBody HashMap<String, Object> followdelete(@RequestParam Map<String,String> params) {
		logger.info("팔로우 취소 요청");		
		return commonservice.followdelete(params);
	}
	@RequestMapping(value = "/timelinelikereview")
	public @ResponseBody HashMap<String, Object> timelinelikereview(@RequestParam Map<String,String> params) {
		logger.info("좋아요 리뷰 리스트 요청");		
		return commonservice.timelinelikereview(params);
	}
	@RequestMapping(value = "/timeline_reply")
	public @ResponseBody HashMap<String, Object> timeline_reply(@RequestParam Map<String,String> params) {
		logger.info("댓글 리뷰 리스트 요청");		
		return commonservice.timeline_reply(params);
	}
	@RequestMapping(value = "/timelinprofile")
	public @ResponseBody HashMap<String, Object> timelinprofile(@RequestParam Map<String,String> params) {
		logger.info("댓글 리뷰 리스트 요청");		
		return commonservice.timelinprofile(params);
	}
	@RequestMapping(value = "/timelinereviewreply")
	public @ResponseBody HashMap<String, Object> timelinereviewreply(@RequestParam Map<String,String> params) {
		logger.info("댓글 리뷰 리스트 요청");		
		return commonservice.timelinereviewreply(params);
	}
	/*//신고 리스트(관리자)
	@RequestMapping(value = "/complainList")
	public @ResponseBody HashMap<String, Object> complainList(@RequestParam Map<String,String> params) {
		logger.info("신고 리스트 요청");		
		return commonservice.timeLineComplainList(params);
	}

	//가게 등록 리스트(관리자)
	@RequestMapping(value = "/storeRegistList")
	public @ResponseBody HashMap<String, Object> storeRegistList(@RequestParam Map<String,String> params) {
		logger.info("가게 등록 리스트 요청");		
		return commonservice.timeLineStoreRegistList(params);
	}*/
	
	@RequestMapping(value = "/reply_update")
	public @ResponseBody HashMap<String, Object> reply_update(@RequestParam Map<String,String> params) {
		logger.info("댓글 수정 요청");		
		return commonservice.reply_update(params);
	}
	@RequestMapping(value = "/reply_delete")
	public @ResponseBody HashMap<String, Object> reply_delete(@RequestParam Map<String,String> params) {
		logger.info("댓글 수정 요청");		
		return commonservice.reply_delete(params);
	}
	@RequestMapping(value = "/timelinelikestore")
	public @ResponseBody HashMap<String, Object> timelinelikestore(@RequestParam Map<String,String> params) {
		logger.info("댓글 수정 요청");		
		return commonservice.timelinelikestore(params);
	}
	
	//등록한 가게 리스트
	@RequestMapping(value = "/statList")
	public @ResponseBody HashMap<String, Object> statList(@RequestParam("id") String id) {
		logger.info("등록한 가게 리스트 요청");		
		return commonservice.statList(id);
	}
	
	//가게 통계 보기
	@RequestMapping(value = "/showStat", method = RequestMethod.GET)
	public ModelAndView storeDetail(@RequestParam("store_idx") int store_idx, @RequestParam("store_name") String store_name) {
		logger.info("가게 통계 페이지 요청.");

		return commonservice.showStat(store_idx, store_name);
	}
	@RequestMapping(value = "/timelinefallowlist")
	public @ResponseBody HashMap<String, Object> timelinefallowlist(@RequestParam Map<String,String> params) {
		logger.info("팔로우 리스트 요청");		
		return commonservice.timelinefollowlist(params);
	}
	@RequestMapping(value = "/alarmlist")
	public @ResponseBody HashMap<String, Object> alarmlist(@RequestParam Map<String,String> params) {
		logger.info("알람 리스트 요청");		
		return commonservice.alarmlist(params);
	}
	@RequestMapping(value = "/alarmtimeline")
	public ModelAndView alarmtimeline(@RequestParam Map<String,String> params) {
		System.out.println("알람 타임라인 요청");
		String id=params.get("id");
		String cate=params.get("cate");
		ModelAndView mav = new ModelAndView();
		mav.addObject("id",id);
		mav.addObject("cate",cate);
		mav.setViewName("timeline/timeline_main");
		return mav;
	}
	@RequestMapping(value = "/alarmread")
	public @ResponseBody HashMap<String, Object> alarmread(@RequestParam Map<String,String> params) {
		logger.info("알람 읽기 요청");		
		return commonservice.alarmread(params);
	}
	@RequestMapping(value = "/alarmcnt")
	public @ResponseBody HashMap<String, Object> alarmcnt(@RequestParam Map<String,String> params) {
		logger.info("알람 개수 요청");		
		return commonservice.alarmcnt(params);
	}
}
