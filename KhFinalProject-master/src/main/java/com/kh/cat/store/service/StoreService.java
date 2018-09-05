package com.kh.cat.store.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cat.common.dao.CommonInter;
import com.kh.cat.dto.MenuDTO;
import com.kh.cat.dto.StoreDTO;
import com.kh.cat.store.dao.StoreInter;

@Service
public class StoreService {
	
	@Autowired SqlSession sqlSession;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	StoreInter inter;
	CommonInter commonInter;
	
	HashMap<String, String> fileList = new HashMap<String, String>();

	//메뉴 사진 업로드
	public ModelAndView menuUpload(MultipartFile file, String root) {
		ModelAndView mav = new ModelAndView();
		String detailPath = "resources/upload/store/";
		String fullPath = root+detailPath;
		logger.info(fullPath);
		//1. 폴더가 없을 경우 폴더 생성
		File dir = new File(fullPath);
		if(!dir.exists()) {
			logger.info("폴더 생성");
			dir.mkdir();
		}
		//2. 파일명 추출
		String oriFileName = file.getOriginalFilename();
		//3. 새로운 파일명 생성
		String newFileName = System.currentTimeMillis()+oriFileName.substring(oriFileName.lastIndexOf("."));
		//4. 파일 추출
		try {
			byte[] bytes =  file.getBytes();//multupartFilr에서 부터 바이트 추출
			Path filePath = Paths.get(fullPath+newFileName);//파일 생성 경로
			Files.write(filePath, bytes);
			fileList.put(newFileName, oriFileName);
			logger.info("저장할 파일 갯수 : {}",fileList.size());
			mav.addObject("path",detailPath+newFileName);
			mav.addObject("fileCnt",fileList.size());
		} catch (IOException e) {
			e.printStackTrace();
		}
		mav.setViewName("store/menuPhotoForm");
		
		return mav;
	}

	//메뉴 사진 삭제
	public HashMap<String, Integer> fileDel(String root, String fileName) {
		logger.info(fileName);
		int success = 0;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		String detailPath ="resources/upload/store/";
		String fullPath = root+detailPath+fileName;
		logger.info(fullPath);
		File file = new File(fullPath);
		if(file.exists()) {
			file.delete();
		}else {
			logger.info("이미 삭제된 사진입니다.");
		}
		if(fileList.get(fileName)!=null) {//ma에 해당 파일이 존재하면 
			fileList.remove(fileName);
			logger.info("삭제후 남은 파일 갯수 : {}", fileList.size());
			success=1;
		}
		map.put("success", success);
		map.put("fileCnt", fileList.size());
		System.out.println(fileList);
		return map;
	}
	
	//대표사진 등록
	public HashMap<String, Object> photoUpload(MultipartHttpServletRequest multi, String root) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		photoDel("",root);//먼저 초기화
		
		String detailPath = "resources/upload/store/";
		String fullPath = root+detailPath;
		logger.info(fullPath);
		//1. 폴더가 없을 경우 폴더 생성
		File dir = new File(fullPath);
		if(!dir.exists()) {
			logger.info("폴더 생성");
			dir.mkdir();
		}
		Iterator<String> files = multi.getFileNames();
		while(files.hasNext()){
			String uploadFile = files.next();
			MultipartFile file = multi.getFile(uploadFile);
			String oriFileName = file.getOriginalFilename();
			if(!oriFileName.equals("")) {
				String newFileName = System.currentTimeMillis()+oriFileName.substring(oriFileName.lastIndexOf("."));
				try {
					byte[] bytes =  file.getBytes();//multupartFilr에서 부터 바이트 추출
					Path filePath = Paths.get(fullPath+newFileName);//파일 생성 경로
					Files.write(filePath, bytes);
					map.put("storePhoto", newFileName);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	             
		return map;
	}
	
	//대표 사진 초기화, 삭제
	public HashMap<String, Object> photoDel(String storePhoto, String root) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if(!storePhoto.equals("")) {
			String detailPath ="resources/upload/store/";
			String fullPath = root+detailPath+storePhoto;
			logger.info(fullPath);
			File file = new File(fullPath);
			if(file.exists()) {
				file.delete();
			}else {
				logger.info("이미 삭제되었거나 파일업로드를 취소하였습니다.");
			}
			map.put("storePhoto", "");
		}
		return map;
	}

	//가게 등록
	@Transactional
	public HashMap<String, Object> storeRegist(String loginId, String[] tagArr, HashMap<String, String> data) {
		inter = sqlSession.getMapper(StoreInter.class);
		commonInter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		StoreDTO dto = new StoreDTO();
		String storePhoto = data.get("store_photo");
		if(storePhoto.equals("")) {
			storePhoto="storeD.png";
		}
		dto.setId(loginId);
		dto.setStore_photo(storePhoto);
		dto.setStore_name(data.get("store_name"));
		dto.setStore_ceo(data.get("store_ceo"));
		dto.setStore_phone(data.get("store_phone"));
		dto.setStore_addr(data.get("store_addr"));
		dto.setStore_food(data.get("store_food"));
		dto.setStore_price(Integer.parseInt(data.get("store_price")));
		dto.setStore_time(data.get("store_time"));
		dto.setStore_rest(data.get("store_rest"));
		inter.storeRegist(dto);//가게 등록
		for(String tag:tagArr) {
			inter.storeHashTag(dto.getStore_idx(),tag);//태그 추가
		}
		for(String file:fileList.keySet()) {
			inter.storeMenu(dto.getStore_idx(),file);//메뉴판 추가
		}
		fileList.clear();
		map.put("success", 1);
		
		Date today = new Date();
        SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
        String sysdate = date.format(today);
		
		commonInter.insertStat(dto.getStore_idx(),0,sysdate);//통계 추가
		
		return map;
	}

	//파일리스트 리셋
	public void listReset() {
		fileList.clear();
	}

	//맛집 상세 보기
	public ModelAndView storeDetail(int store_idx, String aut, int registSF, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(StoreInter.class);
		
		
		
		if(registSF==0 && !aut.equals("admin")) {
			mav.addObject("message", "아직 등록된 맛집이 아닙니다.");//메뉴사진 리스트	
			mav.setViewName("main");
		}else {
			StoreDTO storeDto = inter.storeDetail(store_idx);
			System.out.println("store_name"+storeDto.getStore_name());
			session.setAttribute("store_Name", storeDto.getStore_name());
			session.setAttribute("store_Idx", storeDto.getStore_idx());
			mav.addObject("storeDetail", storeDto);//가게 기본 정보
			mav.addObject("storeHash", inter.storeHash(store_idx));//해쉬태그 
			
			ArrayList<MenuDTO> dtoList = inter.menuPhoto(store_idx);
			ArrayList<String> menuList = new ArrayList<String>();
			if(dtoList.size()==0) {
				mav.addObject("storeMenuD", "storeMenuD.png");//기본 메뉴 사진
			}else{
				for(MenuDTO dto : dtoList) {
					menuList.add(dto.getMenu_photo());
				}
				Collections.sort(menuList);
				mav.addObject("storeMenuD", menuList.get(0));//첫 메뉴 사진
			}
			mav.addObject("storeMenu", menuList);//메뉴사진 리스트	
		
			mav.setViewName("store/storeDetail");
		}
		
		return mav;
	}

	//가게 찜 확인
	public HashMap<String, Object> storeLikeChk(String loginId, int store_idx) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(StoreInter.class);
		String chk;
		int likeChk=0;
		if(loginId!=null) {
			chk = inter.storeLikeChk(loginId, store_idx);
			if(chk!=null) {
				likeChk=1;
			}
		}
		map.put("likeChk", likeChk);
		map.put("loginId", loginId);
		return map;
	}

	//찜하기
	@Transactional
	public HashMap<String, Object> storeLike(String loginId,  int store_idx) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(StoreInter.class);
		String msg;
		String likeChk =inter.storeLikeChk(loginId, store_idx);
		if(likeChk==null) {//찜을 아직 안했을 경우
			inter.storeLike(loginId, store_idx);
			msg="찜 했습니다.";
			inter.storeLikeCntUp(store_idx);
		}else {
			inter.storeLikeDel(loginId, store_idx);
			msg="찜 취소했습니다.";
			inter.storeLikeCntDown(store_idx);
		}
		int cnt = inter.storeLikeCnt(store_idx);
		map.put("msg", msg);
		map.put("likeCnt", cnt);
		return map;
	}
	
	//조회수 증가 판단
	public int uphitSF(String sIdx, HttpServletRequest request) {
		int sf=0;
		Cookie[] cookies = request.getCookies();
		for(Cookie ck: cookies) {
			if(ck.getValue().equals(sIdx)) {
				sf++;
			}
		}
		return sf;
	}

	//조회수 증가
	public void storeUphits(int store_idx) {
		inter = sqlSession.getMapper(StoreInter.class);
		inter.storeUphits(store_idx);
		commonInter = sqlSession.getMapper(CommonInter.class);
		commonInter.uphitStat(store_idx);//통계 추가
	}

	//등록여부 판단
	public int registSF(int store_idx) {
		inter = sqlSession.getMapper(StoreInter.class);
		return inter.registSF(store_idx);
	}

}
