package com.kh.cat.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cat.member.service.MemberService;

@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired MemberService memberService;

	String hash = "";
	
	//회원 가입
	@RequestMapping(value="join", method=RequestMethod.POST)
	public ModelAndView join(@RequestParam HashMap<String, String> map,@RequestParam("userPw") String pass) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		hash = encoder.encode(pass);
		logger.info("회원 가입 요청");
		
		logger.info("profile : {}",map.get("hiddenProfile"));
		logger.info("id : {}",map.get("userId"));
		logger.info("pw : {}",map.get("userPw"));
		logger.info("name : {}",map.get("userName"));
		logger.info("email : {}",map.get("userEmail"));
		logger.info("phone : {}",map.get("userPhone"));
		//logger.info("profile : {}",map.get("profile"));
		//성공 = result.jsp, 실패 = writeForm.jsp
		
		//salt 값으로 인하여 같은 평문도 다른 해시로 만든다.
		logger.info("암호문 : "+hash);
		logger.info("암호문 길이: "+hash.length());
		return memberService.join(map,pass);
	}	
	
	//pw 찾기 새창 열기
	@RequestMapping("/pwFindWin")
	public String pwFindWin(){
		logger.info("pwFindWin 요청");
		return "member/pwFind";
	}
	
	//pw 찾기
	@RequestMapping("/pwFind")
	public @ResponseBody HashMap<String, Object> pwFind(@RequestParam HashMap<String, String> params){
		logger.info("pwFind 요청");
		return memberService.pwFind(params);
	}
	//로그인 폼
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public ModelAndView loginForm(HttpServletRequest request) {
		logger.info("loginForm 페이지 요청");
		String msg = (String) request.getAttribute("msg");
		ModelAndView mav = new ModelAndView();
		logger.info(msg);
		mav.addObject("msg", msg);
		mav.setViewName("member/loginForm");
		return mav;
	}
	
	//로그인
	@RequestMapping(value = "/login")
	public ModelAndView loginConfirmPage (@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("login 요청");
		return memberService.login(params, session);
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request ){
		session = request.getSession(false);		
		if(session != null) {
			session.invalidate();
			System.out.println("로그아웃 처리 완료");
		}
		return "home";
	}
	
	//회원 가입폼
	@RequestMapping(value = "/joinForm", method = RequestMethod.GET)
	public String joinForm() {
		logger.info("joinForm 페이지 요청");
		return "member/joinForm";
	}	
	
	//파일 업로드 폼
	@RequestMapping(value = "/fileUploadForm")
	public String fileUploadForm() {
		logger.info("파일 업로드 페이지 이동");
		return "member/fileUploadForm";
	}

	//파일 업로드
	@RequestMapping(value = "/fileUpload")
	public ModelAndView fileUpload(MultipartFile file, HttpSession session) {
		logger.info("fileUpload 요청");
		String root = session.getServletContext().getRealPath("/");
		return memberService.fileUpload(file,root);
	}
	
	@RequestMapping(value = "/profileimg")
	public @ResponseBody HashMap<String, Object> profileimg(@RequestParam Map<String,String> params) {
		logger.info("프로필 사진 불러오기 요청");			
		return memberService.profileimg(params);
	}
	
	@RequestMapping(value = "/profileunder")
	public @ResponseBody HashMap<String, Object> profileunder(@RequestParam Map<String,String> params) {
		logger.info("프로필 사진 불러오기 요청");			
		return memberService.profileunder(params);
	}
	
	//ID 찾기 폼
	@RequestMapping(value = "/findIdForm", method = RequestMethod.GET)
	public String findIdForm() {
		logger.info("ID 찾기 페이지 요청");
		return "member/findIdForm";
	}
	
	//ID 찾기
   @RequestMapping(value="/idSearchPage")
   public @ResponseBody HashMap<String, String> idSearchPage(@RequestParam HashMap<String, String> params) {
      logger.info("아이디 찾기");
      String allData[] = {params.get("name"), params.get("email")};
      String findId = null;
      HashMap<String, String> map = new HashMap<String, String>();
      findId = memberService.idSearchPage(allData);
      map.put("findId", findId);
      return map;
   }
		
	//회원정보수정
	@RequestMapping(value = "/timelineuserupdate")
	public @ResponseBody HashMap<String, Object> timelineuserupdate (@RequestParam HashMap<String,String> params) {
		logger.info("회원 정보 요청");
		return memberService.timelineuserupdate(params);
	}
	
	//회원 탈퇴폼
	@RequestMapping(value = "/leaveForm", method = RequestMethod.GET)
	public String leaveForm() {
		logger.info("leaveForm 페이지 요청");
		return "member/leaveForm";
	}	
	
	//회원 탈퇴
	@RequestMapping(value = "/leave")
	public ModelAndView leave (@RequestParam("userId") String id, @RequestParam("userPw") String pw,HttpSession session) {
		logger.info("회원 탈퇴 요청");
		return memberService.leave(id,pw,session);
	}
	
	//파일 업로드 폼
	@RequestMapping(value = "/profileupload")
	public String profileupload() {
		logger.info("파일 업로드 페이지 이동");
		return "member/profileupload";
	}
	@RequestMapping(value = "/newfileUpload")
	public ModelAndView newfileUpload(MultipartFile file, HttpSession session) {
		logger.info("fileUpload 요청");
		String root = session.getServletContext().getRealPath("/");
		return memberService.newfileUpload(file,root);
	}
	@RequestMapping(value = "/profileDel")
	public @ResponseBody HashMap<String, Integer> fileDel(@RequestParam("fileName") String fileName,HttpSession session) {
		logger.info("fileDel 요청");	
		String root = session.getServletContext().getRealPath("/");		
		return memberService.fileDel(root,fileName);
	}
	
	@RequestMapping(value = "/userupdate")
	public @ResponseBody HashMap<String, Object> userupdate(@RequestParam(value = "newpw", required = false, defaultValue = "0") String newpw,@RequestParam HashMap<String, String> params) {
		logger.info("userupdate 요청");
		return memberService.userupdate(params,newpw);
	}

}
