package com.kh.cat.member.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cat.dto.MemberDTO;
import com.kh.cat.member.dao.MemberInter;


@Service
public class MemberService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired SqlSession sqlSession;
	@Autowired JavaMailSender mailSender;
	
	MemberInter inter;
		
	String hash = "";
	
	
	//회원가입
	public ModelAndView join(HashMap<String, String> map,@RequestParam("userPw") String pass) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		hash = encoder.encode(pass);				
		
		inter = sqlSession.getMapper(MemberInter.class);
		/*map -> dto*/
		MemberDTO dto = new MemberDTO();
		dto.setId(map.get("userId"));
		//dto.setPw(map.get("userPw"));
		dto.setPw(hash);
		dto.setName(map.get("userName"));
		dto.setEmail(map.get("userEmail"));
		dto.setPhone(map.get("userPhone"));
		dto.setProfile(map.get("hiddenProfile"));
		
		/*for(String key:fileList.keySet()) {//map에서 키를 뽑아온다.
			dto.setProfile(key);
		}*/
		
		int success = inter.join(dto);
		logger.info("결과값 : {}",success);
		//실패할 경우 page, msg
		String page ="joinForm";
		String msg = "회원가입에 실패 했습니다.";
		
		if(success == 1) {//회원가입 성공시
			page ="member/loginForm";
			msg = "회원가입에 성공 했습니다.";
		}
		//Model + view 한꺼번에 담을 수 있다.
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg",msg);//모델에 들어갈 내용
		mav.setViewName(page);//반환 페이지 내용
		return mav;
	}
	
	
	//로그인
	public ModelAndView login(HashMap<String, String> params,HttpSession session) {
		logger.info("로그인 체크요청");
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		//MemberDTO dto = new MemberDTO();
		inter = sqlSession.getMapper(MemberInter.class);
		
		String id = params.get("id");//로그인 아이디
		String pw = params.get("pw");//평문화 비밀번호 가져옴
		hash = inter.getPw(id);//id를 넣어서 암호화 비밀번호 가져옴 - 성공
		logger.info(hash);		
		logger.info("아이디 : "+id+" / 평문화 비밀번호 : "+pw);//확인
		logger.info("아이디 : "+id+" / 암호화 비밀번호 : "+hash);//확인
		String page = "member/loginForm";
		ModelAndView mav = new ModelAndView();
		//String msg = "로그인 실패";
		if(hash!=null) {//hash 값이 있다->id가 유효하다.------->회원가입된 id가 있다
			boolean success = encoder.matches(pw, hash);//암호화 시켜서 hash값과 비교
			logger.info("일치 여부 : "+success);//비밀번호가 맞았다 -> 로그인
			if(success) {//로그인 성공시     ------------------->id,pw가 맞다
				String profile = inter.getprofile(id);//프로필 가져오기 -logger확인없음
				String aut = inter.getaut(id);//권한 가져오기
				String email = inter.getemail(id);//이메일 가져오기
				//msg = "로그인 성공";
				page = "main";
				session.setAttribute("loginId", id);
				session.setAttribute("loginProfile", profile);	
				session.setAttribute("loginAut", aut);
				session.setAttribute("loginEmail", email);
				logger.info("세션값 체크 : {}", session.getAttribute("loginId"));
				logger.info("세션값 체크 : {}", session.getAttribute("loginProfile"));
				logger.info("세션값 체크 : {}", session.getAttribute("loginAut"));
				logger.info("세션값 체크 : {}", session.getAttribute("loginEmail"));
				logger.info("이동할 페이지 : {}", page);			
			}else {//--------------->id가 있지만 pw가 안맞다
				String msg = "비밀번호가 일치하지 않습니다.";
				mav.addObject("msg", msg);//모델에 들어갈 내용
				logger.info("발생할 메시지 2: {}", msg);		
			}
		}else {//------------------>회원가입된 id가 아니다
			String msg = "등록된 ID가 아닙니다.";
			mav.addObject("msg", msg);//모델에 들어갈 내용
			logger.info("발생할 메시지 2: {}", msg);
		}
		logger.info("이동할 페이지 2 : {}", page);	
		mav.setViewName(page);//반환 페이지
		return mav;
	}
	
	
	//ID 중복 체크
    public Map<String, String> overlay(String id) {
        inter = sqlSession.getMapper(MemberInter.class);
        Map<String, String> json = new HashMap<String, String>();
        String use = "N";        
        if(inter.overlay(id) == null){
            use = "Y";
        }        
        json.put("use", use);
        return json;
    }
   
    
    //이메일 중복 체크
    public Map<String, String> overlayMail(String email,HttpSession session) {
    	inter = sqlSession.getMapper(MemberInter.class);
        Map<String, String> json = new HashMap<String, String>();
        String mail = inter.getemail(email);
        String use = "N";
        //logger.info("세션에 담긴 이메일 확인 : {}",session.getAttribute("loginEmail"));
        logger.info("세션에 담긴 아이디 확인 : {}",session.getAttribute("loginId"));
        //logger.info("테스트 : {}",mail.equals("가"));
        //logger.info("조건문 확인 : {}",mail.equals(session.getAttribute("loginId")));
        /*if(mail == session.getAttribute("loginId")) {
    		use = "O";
    	}*/
        /*if(inter.overlayMail(email) == null){//중복되는 이메일 주소가 없을때
            use = "Y";
        }*/
        if(mail != null) {//입력한 메일주소에 해당하는 ID가 있을때
        	if(mail.equals(session.getAttribute("loginId"))){//세션에 있는 ID랑 일치한다면
        		use = "O";
        	}
        	
        }else {//입력한 메일주소에 해당하는 ID가 없을때
        	use = "Y";
        }
        
        json.put("use", use);
        return json;
    }

    
	//파일올리기
	HashMap<String, String> fileList = new HashMap<String, String>();

	public ModelAndView fileUpload(MultipartFile file, String root) {
		ModelAndView mav = new ModelAndView();
		String fullPath = root+"resources/upload/";
		logger.info(fullPath);
		//1. 폴더가 없을 경우 폴더 생성
		File dir = new File(fullPath);
		if(!dir.exists()) {
			logger.info("fileUpload 서비스메서드, 폴더 없음, 생성 시작");
			dir.mkdir();
		}
		//2. 파일명 추출
		String oriFileName = file.getOriginalFilename();
		//3. 새로운 파일명 생성
		String newFileName = System.currentTimeMillis()+oriFileName.substring(oriFileName.lastIndexOf("."));
		//4. 새 파일명으로 파일 변경
		try {
			byte[] bytes = file.getBytes(); //MultipartFile에서부터 바이트 추출
			Path filePath = Paths.get(fullPath+newFileName); //파일 생성 경로
			Files.write(filePath, bytes); //파일 생성
			fileList.put(newFileName, oriFileName);
			logger.info("저장할 파일 개수 : {}", fileList.size());
			logger.info("사진 파일 저장경로 : ",filePath);
			mav.addObject("path", "resources/upload/"+newFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		mav.setViewName("member/fileUploadForm");
		return mav;
		//자바 nio는 자바 버전 7 이상에서 쓸수있음... io보다 빠름
		//파일 업로드 자체는 db 쓰지 않기때문에 interface 안가도 된다!
	}


	public HashMap<String, Object> profileimg(Map<String, String> params) {
		inter = sqlSession.getMapper(MemberInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id=params.get("id");
		logger.info(id);
		map.put("profileimg", inter.profileimg(id));
		return map;
	}


	public HashMap<String, Object> profileunder(Map<String, String> params) {
		inter = sqlSession.getMapper(MemberInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id=params.get("id");
		logger.info(id);
		map.put("profile", inter.profileunder(id));
		return map;
	} 
	
	/*//ID 찾기
	public String findId(Map<String, String> params, HttpSession session,Model model) {
		inter = sqlSession.getMapper(MemberInter.class);
		HashMap<String, String> map = new HashMap<String, String>();
		String name = params.get("userName");
		String email = params.get("userEmail");
		logger.info("이름 : "+name+" / 이메일 : "+email);
		String find = inter.findId(name,email);
		int find2 = inter.findId2(name,email);
		logger.info("찾는 id : " +find);
		logger.info("찾는 id 일치 갯수 : " +find2);
		
		StringBuffer sb = new StringBuffer(find);
		
		if(find.length()==5) {
			sb.replace(2, find.length()-1, "**");
		}else if(find.length()==6) {
			sb.replace(2, find.length()-1, "***");
		}else if(find.length()==7) {
			sb.replace(2, find.length()-1, "****");
		}else if(find.length()==8) {
			sb.replace(2, find.length()-1, "*****");
		}else if(find.length()>8) {
			sb.replace(2, find.length()-1, "******");
		}
		 //session.setAttribute("findId", sb);

	
		logger.info("치환된 문자열 : "+sb);
		map.put("test", find);
		
		//String msg = "";
		
		if(find2>0){
			if(sb != null ) {
				logger.info("ID는 "+sb+"입니다.");
			}
		}
		model.addAttribute("find",find);
		model.addAttribute("findId",sb);
		model.addAttribute("findId2",find2);
		return "member/findIdForm";	
		
		}*/

	public HashMap<String, Object> timelineuserupdate(HashMap<String, String> params) {
		inter = sqlSession.getMapper(MemberInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id=params.get("id");
		logger.info(id);
		map.put("update", inter.userdetail(id));
		return map;
	}

   //아이디 찾기 요청 서비스
   public String idSearchPage(String[] allData) {
      logger.info("아이디 찾기 요청");
      
      inter = sqlSession.getMapper(MemberInter.class);
      
      String name = allData[0]; 
      String email = allData[1];
      String success="";
      
      String result = inter.idSearchPage(name, email);
      if(result!=null || result=="") {//result값이 있을때
          StringBuffer sb = new StringBuffer(result);
          logger.info("sb 값 체크 : {}",sb);
        	if(result.length()==5) {
    			sb.replace(2, result.length()-1, "**");
    		}else if(result.length()==6) {
    			sb.replace(2, result.length()-1, "***");
    		}else if(result.length()==7) {
    			sb.replace(2, result.length()-1, "****");
    		}else if(result.length()==8) {
    			sb.replace(2, result.length()-1, "*****");
    		}else if(result.length()>8) {
    			sb.replace(2, result.length()-1, "******");
    		}
        	success = "당신의 아이디는 ' "+sb+" ' 입니다.";
      }else {
    	  success = "아이디가 존재하지 않습니다.";
      }

      return success;
   }
   
    //비밀번호 찾기 서비스
   	public HashMap<String, Object> pwFind(HashMap<String, String> params) {
		logger.info("비밀번호 찾기 서비스");
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(MemberInter.class);
		
		String hash = "";
		int pwChange = 0;
		
		String id = params.get("id");
		String name = params.get("name");
		String email = params.get("email");
		
		logger.info("아이디 : {}", id);
		logger.info("이름 : {}", name);
		logger.info("이메일 : {}", email);
		
		String pass = inter.pw(id, name, email);
		logger.info(pass);
		
		String setFrom = "jaewook-@naver.com";//보내는 사람 이메일
	    String toMail  = email;// 받는 사람 이메일
	    String title   = "";// 제목
	    String content = "";// 내용
		
	    try {
		      MimeMessage message = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper 
		                        = new MimeMessageHelper(message, true, "UTF-8");
		 
		      if(pass != null) {//조회된 비밀번호가 있으면
		    	  Random rnd = new Random();
		    	  StringBuffer tmpPw = new StringBuffer();

		    	  for(int i = 0; i < 8; i++){
		    		  if(rnd.nextBoolean()){
		    			  tmpPw.append((char)((int)(rnd.nextInt(26))+97));
		    			  logger.info("소문자 : {}", tmpPw);
		    		  }else if(rnd.nextBoolean()){
		    			  tmpPw.append((char)((int)(rnd.nextInt(26))+65));
		    			  logger.info("대문자 : {}", tmpPw);
		    		  }else {
		    			  tmpPw.append((rnd.nextInt(10)));
		    			  logger.info("숫자 : {}", tmpPw);
		    		  }
		    	  }

		    	  logger.info("임시 비밀번호 : {}", tmpPw);
		    	  BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		    	  hash = encoder.encode(tmpPw);//임시 비밀번호 암호화
		    	  pwChange = inter.pwChange(id, hash);//암호화된 비밀번호 DB 에 저장
		    	  logger.info("암호화된 임시 비빌번호 DB 저장 결과 : {}", pwChange);
		    	  if(pwChange > 0) {
		    		  title = "CAT 사이트에 요청한 임시 비밀번호 발급 안내입니다.";
		    		  content = id+" 님의 임시 비밀번호는 ["+tmpPw+"] 입니다.";
		    		  messageHelper.setFrom(setFrom, "CAT");  // 보내는사람 생략하거나 하면 정상작동을 안함
				      messageHelper.setTo(toMail);     // 받는사람 이메일
				      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				      messageHelper.setText(content);  // 메일 내용
		    	  }  
		    	  map.put("msg", "해당 이메일로 임시비밀번호가 전송되었습니다.");
		    	  map.put("changeResult", pwChange);
		      }else {
		    	  map.put("msg", "일치하는 정보가 없습니다.");
		    	  map.put("changeResult", pwChange);
		      }

		      mailSender.send(message);
		    } catch(Exception e){
		      System.out.println(e);
		    }
		return map;
	}


	public ModelAndView newfileUpload(MultipartFile file, String root) {
		HashMap<String, String> fileList = new HashMap<String, String>();
		ModelAndView mav = new ModelAndView();
		String fullPath = root+"resources/upload/";
		logger.info(fullPath);
		//1.폴더가 없을 경우 폴더 생성
		File dir = new File(fullPath);
		if(!dir.exists()) {
			logger.info("폴더 없음 생성 시작");
			dir.mkdir();
		}
		//2.파일명을  추출
		String fileName=file.getOriginalFilename();
		//3.새로운 파일명 생성
		String newFileName = System.currentTimeMillis()+fileName.substring(fileName.lastIndexOf("."));
		//4.파일 추출
		try {
			byte[] bytes=file.getBytes();//MultipartFile 에서 부터 바이트 추출
			Path filePath=Paths.get(fullPath+newFileName);//파일 생성 경로
			Files.write(filePath, bytes);//파일 생성
			fileList.put(newFileName, fileName);
			logger.info("저장할 파일 갯수 : {}",fileList.size());
			mav.addObject("path","resources/upload/"+newFileName);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		mav.setViewName("member/profileupload");
		return mav;
	}


	public HashMap<String, Integer> fileDel(String root, String fileName) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		int success = 0;
		try {
			String fullPath = root+"resources/upload/"+fileName;
			File file = new File(fullPath);
			if(file.exists()) {
				file.delete();
				success=1;
			}else {
				logger.info("이미 삭제된 사진");
			}
		}catch(Exception e){
			System.out.println(e.toString());
			success = 0;
		}finally {
			map.put("success", success);
		}		
		return map;
	}
		
		
	//회원 탈퇴
		public ModelAndView leave(String id, String pw,HttpSession session) {
		logger.info("회원탈퇴 요청");
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		MemberDTO dto = new MemberDTO();
		inter = sqlSession.getMapper(MemberInter.class);
		
		/*String id = params.get("userId");
		String pw = params.get("userPw");*/
		//String result = inter.login(id, pw);
		//logger.info("result는 ? : "+result);
		hash = inter.getPw(id);
		logger.info(hash);		
		logger.info("아이디 : "+id+" / 평문화 비밀번호 : "+pw);
		logger.info("아이디 : "+id+" / 암호화 비밀번호 : "+hash);
		
		String page = "member/leaveForm";
		//String page = "redirect:/leaveForm";
		String message = "비밀번호가 일치하지 않습니다.";
		if(hash!=null) {//hash 값이 있다->id가 유효하다.
			boolean success = encoder.matches(pw, hash);//암호화 시켜서 hash값과 비교
			logger.info("일치 여부 : "+success);//비밀번호가 맞았다 
			if(success) {// 성공시
				int leave = inter.leave(id);
				if(leave>0) {
					logger.info("로거 테스트 : {}",leave);
					message = "회원 탈퇴가 성공 되었습니다.";
					page = "member/leaveAlert";
					session.invalidate();
					System.out.println("세션 로그아웃 처리 완료");
					//logger.info("세션값 체크 : {}", session.getAttribute("loginId"));
					logger.info("이동할 페이지 : {}", page);
				}	
			}
		}
		
		logger.info("이동할 페이지 2 : {}", page);
		//logger.info("발생할 메시지 2: {}", msg);
		ModelAndView mav = new ModelAndView();
		mav.addObject("message", message);//모델에 들어갈 내용
		mav.setViewName(page);//반환 페이지
		
		return mav;
	}
	public HashMap<String, Object> userupdate(HashMap<String, String> params, String newpw) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(MemberInter.class);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		MemberDTO dto = new MemberDTO();
		String photo = params.get("fileName");
		String id = params.get("id");
		String pw = params.get("nowpw");
		String username = params.get("username");
		String useremail = params.get("useremail");
		String userphone = params.get("hp1")+"-"+params.get("hp2")+"-"+params.get("hp3");
		
		boolean success = encoder.matches(pw, hash);
		logger.info("일치 여부 : "+success);
		int insert = 0;
		dto.setId(id);		
		dto.setName(username);
		dto.setEmail(useremail);
		dto.setPhone(userphone);
		dto.setProfile(photo);
		String msg = "회원정보수정이 실패 하였습니다";
		if(success==true) {
			if(newpw.equals("0")) {
				logger.info(""+newpw);
				insert = inter.userupdate(dto);
			}else if(!newpw.equals("0")){
				logger.info("성원"+newpw);
				hash = encoder.encode(newpw);
				dto.setPw(hash);
				insert = inter.userpwupdate(dto);
			}
			msg = "회원정보수정이 성공 하였습니다";
		}
		map.put("success", insert);
		map.put("msg",msg);
		return map;
	}
    
}