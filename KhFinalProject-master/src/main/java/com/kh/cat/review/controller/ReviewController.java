package com.kh.cat.review.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cat.dto.RevLikeDTO;
import com.kh.cat.review.service.ReviewService;

@Controller
public class ReviewController {

	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired ReviewService service;
	
	@RequestMapping(value = "/reviewWritePage")
	public String reviewWritePage() {
		
		System.out.println("리뷰 작성 페이지 요청");
		return "review/reviewWrite";
	}
	
	@RequestMapping(value = "/uploadForm")
	public String uploadForm() {
		logger.info("파일 업로드 페이지 이동");
		return "review/uploadForm";
	}
	
	@RequestMapping(value = "/fileupload", method = RequestMethod.POST)
	public ModelAndView fileupload(MultipartFile file, HttpSession session) {
		System.out.println("파일 업로드 요청");
		String root = session.getServletContext().getRealPath("/");
		return service.upload(file,root);
	}
	
	@RequestMapping(value = "/fileDel")
	public @ResponseBody HashMap<String, Integer> 
		fileDel(@RequestParam("fileName") String fileName, HttpSession session) {
		logger.info("file delete 요청");
		String root = session.getServletContext().getRealPath("/");
		
		return service.fileDel(root,fileName);
	}
	@RequestMapping(value= "/reviewWrite")
	public String wirte(@RequestParam(value ="review_storeidx", required = false, defaultValue = "0") String review_storeidx,@RequestParam("hash_tag") ArrayList<String> hash_tag,
			@RequestParam(value ="review_photo", required = false, defaultValue = "0") ArrayList<String> review_photo,@RequestParam HashMap<String, String>map, HttpServletRequest request,HttpSession session) {
		logger.info("글쓰기 or 수정 요청");	
		logger.info(""+review_storeidx);
		String loginId = (String) request.getSession().getAttribute("loginId");
		String profile = (String) request.getSession().getAttribute("loginProfile");
		logger.info(map.get("review_idx"));
		if(map.get("review_idx") != "") {
			return service.review_update(hash_tag, review_photo, map, loginId);
		}else {
			return service.write(review_storeidx,hash_tag, review_photo, map, loginId,session);
		}
	}
	
	@RequestMapping(value = "/revStoreSearch/5/{page}")
	public @ResponseBody HashMap<String, Object> revStoreSearch(@RequestParam("review_storeName") String params,@PathVariable String page) {
		logger.info("가게 리스트 요청");
		logger.info(params);
		return service.revStoreSearch(params,page);
	}
	
	/*@RequestMapping(value= "/reviewWrite")
	public ModelAndView wirte(@RequestParam HashMap<String, Object> hash_tag) {
		logger.info("글쓰기 요청");	
		logger.info("해시태그:" + hash_tag.get("hash_tag"));
		return null;
	}*/
	
	//리뷰 리스트 페이지
	@RequestMapping(value = "/reviewListPage")
	public String reviewListPage() {		
		System.out.println("리뷰 리스트 페이지 요청");
		return "review/reviewList";
	}
	@RequestMapping(value = "/reviewList/5/{page}")
	public @ResponseBody HashMap<String, Object> reviewList(@RequestParam("review_search") String review_search, @RequestParam("store_idx") int store_idx, @RequestParam("range") String range, @PathVariable String page) {
		logger.info("리뷰 리스트 요청");
		logger.info("페이지 : "+page);
		logger.info("최신순 : "+range);
		return service.reviewList(store_idx, range, review_search,page);
	}
	@RequestMapping(value = "/reviewHashPhoto")
	public @ResponseBody HashMap<String, Object> reviewHashPhoto(@RequestParam("review_idx") String review_idx,HttpSession session) {
		logger.info("리뷰 해시태그, 사진 요청");
		String root = session.getServletContext().getRealPath("/");
		return service.reviewHashPhoto(review_idx,root);
	}
	
	@RequestMapping(value = "/review_star")
	public @ResponseBody HashMap<String, Object> review_star(@RequestParam("review_idx") String review_idx) {
		logger.info("별점 요청");
		return service.review_star(review_idx);
	}
	
	@RequestMapping(value = "/complainPage")
	public ModelAndView complainPage(@RequestParam("complain_Id") String complain_Id,@RequestParam("idx") String idx,@RequestParam("complain_cate") String complain_cate) {		
		System.out.println("신고 페이지 요청");
		logger.info(complain_Id);
		logger.info(idx);
		logger.info(complain_cate);
		ModelAndView mav = new ModelAndView();
		mav.addObject("complain_Id",complain_Id);
		mav.addObject("idx",idx);
		mav.addObject("complain_cate",complain_cate);
		mav.setViewName("review/complainForm");		
		return mav;
	}
	
	@RequestMapping(value = "/complain")
	public @ResponseBody HashMap<String, Integer> complain(@RequestParam HashMap<String, String>map) {		
		System.out.println("신고 요청");
		//logger.info(""+service.complain(map).get("success"));
		return service.complain(map);
	}
	
	
	@RequestMapping(value = "/review_delete")
	public @ResponseBody Integer review_delete(@RequestParam("review_idx") String review_idx) {		
		System.out.println("리뷰 삭제 요청");
		
		return service.review_delete(review_idx);
	}
	
	
	@RequestMapping(value = "/review_updateForm")
	public ModelAndView review_updateForm(@RequestParam("review_idx") String review_idx){
		logger.info("리뷰 수정 페이지 이동");
		return service.review_updateForm(review_idx);
	}
	
	@RequestMapping(value = "/reviewLike")
	public @ResponseBody String reviewLike(@RequestParam("review_idx") String review_idx,@RequestParam("loginId") String loginId,@RequestParam("name") String name) {		
		logger.info("리뷰 좋아요 요청");
		return service.reviewLike(review_idx,loginId,name);
	}
	
	@RequestMapping(value = "/reviewLikeSelect")
	public @ResponseBody ArrayList<RevLikeDTO> reviewLikeSelect(@RequestParam("loginId") String loginId) {		
		logger.info("리뷰 좋아요 select요청");
		return service.reviewLikeSelect(loginId);
	}
	
	@RequestMapping(value = "/replySelect/5/{page}")
	public @ResponseBody HashMap<String, Object> replySelect(@RequestParam("review_idx") String review_idx,@PathVariable String page) {
		logger.info("리뷰댓글 리스트 요청");
		logger.info(page);
		return service.replySelect(review_idx,page);
	}
	
	@RequestMapping(value = "/replyWrite")
	public @ResponseBody Integer replyWrite(@RequestParam("review_idx") String review_idx,@RequestParam("loginId") String loginId,@RequestParam("reply_content") String reply_content,@RequestParam("profile") String profile,@RequestParam("name") String name) {		
		logger.info("리뷰 댓글 작성");
		System.out.println(review_idx+"/"+loginId+"/"+reply_content+"/"+profile);
		return service.replyWrite(review_idx,loginId,reply_content,profile,name);
	}
	
	@RequestMapping(value = "/Revreply_delete")
	public @ResponseBody Integer Revreply_delete(@RequestParam("reply_idx") String reply_idx,@RequestParam("review_idx") String review_idx) {		
		System.out.println("댓글 삭제 요청");		
		return service.Revreply_delete(reply_idx,review_idx);
	}
	
	@RequestMapping(value = "/Revreply_update")
	public @ResponseBody Integer Revreply_update(@RequestParam("reply_content") String reply_content,@RequestParam("reply_idx") String reply_idx,@RequestParam("review_idx") String review_idx) {		
		System.out.println("댓글 수정 요청");		
		return service.Revreply_update(reply_content,reply_idx,review_idx);
	}
}
