package com.kh.cat.review.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cat.dto.AlarmDTO;
import com.kh.cat.dto.ComplainDTO;
import com.kh.cat.dto.RevLikeDTO;
import com.kh.cat.dto.RevReplyDTO;
import com.kh.cat.dto.ReviewDTO;
import com.kh.cat.review.dao.ReviewInter;


@Service
public class ReviewService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired SqlSession sqlSession;
	ReviewInter inter;
	HttpServletRequest request;
	
	//사진 업로드폴더에 저장
	HashMap<String, String> fileList = new HashMap<String, String>();
	public ModelAndView upload(MultipartFile file, String root) {
		
		ModelAndView mav = new ModelAndView();
		String fullPath = root + "resources/upload/";
		logger.info(fullPath);
		
		File dir = new File(fullPath);
		if(!dir.exists()) {
			logger.info("폴더 없음, 생성");
			dir.mkdir();
		}
		
		//파일명 추출
		String fileName = file.getOriginalFilename();
		//새로운 파일명 생성
		String newFileName = System.currentTimeMillis()
				+ fileName.substring(fileName.lastIndexOf("."));
		
		
		//파일 추출
		try {
			byte[] bytes = file.getBytes();
			Path filePath = Paths.get(fullPath+newFileName);//파일 생성 경로
			Files.write(filePath, bytes);//파일 생성
			fileList.put(newFileName, fileName);
			logger.info("저장할 파일 갯수 : {}",fileList.size());
			mav.addObject("path","resources/upload/"+newFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		mav.setViewName("review/uploadForm");
		
		return mav;
	}
	
	//사진 삭제
	public HashMap<String, Integer> fileDel(String root, String fileName) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		int success = 0;
		int result=0;
		String fullPath = root + "resources/upload/"+fileName;
		File file = new File(fullPath);
		if(file.exists()) {
			logger.info("삭제할 파일이 존재 : "+file);
			file.delete();
			result=1;
			logger.info("파일 삭제 완료");
		}else {
			logger.info("이미 삭제된 사진");
			result=1;
		}
		if(fileList.get(fileName) != null) {
			logger.info("리스트가 있음");
			fileList.remove(fileName);//리스트 삭제
			logger.info("삭제 후 남은 파일 갯수 : {}",fileList.size());
			logger.info(fileList.toString());
			success = 1;
		}
		
		map.put("success", success);
		map.put("result", result);
		return map;
	}
	
	//리뷰 작성
	@Transactional
	public String write(String review_storeidx, ArrayList<String> hash_tag, ArrayList<String> review_photo, HashMap<String, String> map, String loginId, HttpSession session) {
		logger.info("리뷰 작성 서비스 도착");
		ModelAndView mav = new ModelAndView();
		String page = "redirect:/reviewWritePage";
		ReviewDTO dto = new ReviewDTO();
		dto.setStore_idx(Integer.parseInt(review_storeidx));
		dto.setReview_profile(map.get("review_profile"));
		logger.info(dto.getReview_profile());
		dto.setReview_storeName(map.get("review_storeName"));
		logger.info(map.get("review_storeName"));
		dto.setId(map.get("id"));
		logger.info(map.get("id"));
		dto.setReview_star(Double.parseDouble(map.get("star-input")));
		logger.info(""+Double.parseDouble(map.get("star-input")));
		dto.setReview_content(map.get("review_content"));
		logger.info(map.get("review_content"));
		
		logger.info("리뷰 작성 slq 시작");
		inter = sqlSession.getMapper(ReviewInter.class);
		System.out.println(review_photo.size());
		if(inter.reviewWrite(dto) == 1) {
			logger.info("리뷰번호 : "+dto.getReview_idx());
			if(hash_tag.size() > 0) {
				for(int i=0; i<hash_tag.size(); i++) {
					String tag = hash_tag.get(i);
					int success = inter.hashtag(tag,dto.getReview_idx());
				}
			}
			if(review_photo.size() > 1) {				
				photoReview_point(loginId);//photoReview_point 메소드(포인트100)
				for(int i=1; i<review_photo.size();i++) {
					String rePhoto = review_photo.get(i);
					int result = inter.reviewPhotoWrite(dto.getReview_idx(),rePhoto);
				}
			}else {				
				review_point(loginId);//review_point 메소드(포인트 50)
			}
			if(Integer.parseInt(review_storeidx) != 0) {
				double star =  inter.starAvg(review_storeidx);
				logger.info("평균 별점"+star);
				inter.storeReviewUpdate(review_storeidx,star);
				inter.totalUpdate(review_storeidx,star);
			}
		}
		
		fileList.clear();
		System.out.println(session.getAttribute("store_Idx"));
		if(session.getAttribute("store_Idx") == null) {
			return "redirect:/";
		}else {
			return "redirect:/storeDetail?store_idx="+session.getAttribute("store_Idx");
		}
		
	}
	
	//리뷰 상호명 검색
	public HashMap<String, Object> revStoreSearch(String params, String page) {
		
		logger.info("리뷰 상호명 검색");
		inter = sqlSession.getMapper(ReviewInter.class);
		int allCnt = inter.storeListCnt(params);
		//생성 가능 페이지 수(나머지가 있으면 페이지 하나 더 생성)
				int rangePage = allCnt%5 >0 ? 
							Math.round(allCnt/5)+1 : allCnt/5;
				int page2=Integer.parseInt(page);
				if(page2>rangePage) {
					page2 = rangePage;
				}
				int end = page2 * 5;	 //5 : 100
				int start = end - 5+1;//5 : 81
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", inter.storeList(params,start,end));
		map.put("range", rangePage);
		map.put("currPage", page);
		
		return map;
	}
	
	//리뷰 리스트
	@Transactional
	public HashMap<String, Object> reviewList(int store_idx, String range, String review_search, String page) {
		logger.info("리뷰 리스트 서비스");
		inter = sqlSession.getMapper(ReviewInter.class);
		
		String search_content_And = review_search.replaceAll(" ", "%");
		String[] search_content_Split = review_search.split(" ");
		HashMap<String, Object> ra = new HashMap<String, Object>();		
		
		//총 게시물 수 => 생성 가능 페이지 수
		int allCnt = 0;
		if(store_idx == 0) {
			allCnt=inter.allCount();
		}else if(store_idx > 0) {
			allCnt = inter.storeReviewCount(store_idx);
		}else {
			allCnt = inter.searchAndReviewCount(search_content_And);
			System.out.println("AND 검색 : "+allCnt);
			if(allCnt == 0) {
				ra.put("review_searchCnt", search_content_Split);
				allCnt = inter.searchOrReviewCount(ra);
				System.out.println("OR 검색 : "+allCnt);
				if(allCnt == 0) {
					allCnt = inter.searchHashReviewCount(ra);
					System.out.println("HASH 검색 : "+allCnt);
				}
			}
		}
		System.out.println(allCnt);
		//생성 가능 페이지 수(나머지가 있으면 페이지 하나 더 생성)
		int rangePage = allCnt%5 >0 ? 
					Math.round(allCnt/5)+1 : allCnt/5;
		int page2=Integer.parseInt(page);
		if(page2>rangePage) {
			page2 = rangePage;
		}
		int end = page2 * 5;	 //5 : 100
		int start = end - 5+1;//5 : 81
		
		ra.put("range", range);
		ra.put("store_idx", String.valueOf(store_idx));
		ra.put("review_search", search_content_And);
		//페이징
		ra.put("start", start);
		ra.put("end", end);
		
		logger.info("*****************");
		logger.info(""+ra.get("store_idx"));
		logger.info(""+ra.get("review_search"));
		HashMap<String, Object> map = new HashMap<String, Object>();

		ArrayList<ReviewDTO> list = inter.reviewList(ra);
		if(store_idx == -1) {
			if(list.isEmpty()) {//and 검색이 안되면
				ra.put("review_search", search_content_Split);//검색어를 or로 바꿔서
				list = inter.reviewList_or(ra);//or검색
				if(list.isEmpty()) {//or 검색이 안되면
					list = inter.reviewList_hash(ra);//해쉬검색
				}
			}
		}
		map.put("reviewList", list);
		map.put("range", rangePage);
		map.put("currPage", page);

		return map;
	}

	//리뷰 해시태그, 사진
	@Transactional
	public HashMap<String, Object> reviewHashPhoto(String review_idx, String root) {
		logger.info("리뷰 해시태그");
		inter = sqlSession.getMapper(ReviewInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("reviewHash", inter.reviewHash(review_idx));
		map.put("reviewPhoto",  inter.reviewPhoto(review_idx));
		logger.info(""+map.get("reviewHash"));
		return map;
	}
	
	
	//사진 미포함 50포인트
	
	public void review_point(String loginId) {
		logger.info("로그인 세션 : {}", loginId);
		
			/*리뷰 좋아요 수 : SELECT review_likecnt FROM review WHERE review_idx=7; 
		 	사진 포함 리뷰 : UPDATE member SET pointcnt = pointcnt + 100 WHERE id='user1';
			사진 미포함 리뷰 : UPDATE member SET pointcnt = pointcnt + 50 WHERE id='user1';	*/
		
		logger.info("리뷰작성 50포인트");
		inter = sqlSession.getMapper(ReviewInter.class);
		inter.review_point(loginId);
		inter.review_pointList(loginId);
	}
	
	//사진 포함 100포인트
	public void photoReview_point(String loginId) {
		logger.info("로그인 세션 : {}", loginId);
		
			/*리뷰 좋아요 수 : SELECT review_likecnt FROM review WHERE review_idx=7; 
		 	사진 포함 리뷰 : UPDATE member SET pointcnt = pointcnt + 100 WHERE id='user1';
			사진 미포함 리뷰 : UPDATE member SET pointcnt = pointcnt + 50 WHERE id='user1';	*/
		
		logger.info("리뷰작성 100포인트");
		inter = sqlSession.getMapper(ReviewInter.class);
		inter.photoReview_point(loginId);
		inter.photoReview_pointList(loginId);
	}
	
	//좋아요 받을 시 포인트 적립
	public void review_likeCnt(String idx) {
		logger.info("리뷰 번호 : {}", idx);
		//리뷰 좋아요 수 : SELECT review_likecnt FROM review WHERE review_idx=리뷰번호; 
		inter = sqlSession.getMapper(ReviewInter.class);
		ArrayList<ReviewDTO> likeCntAndId = inter.review_likeCnt(idx);
		
		int likeCnt = likeCntAndId.get(0).getReview_likeCnt();
		String id = likeCntAndId.get(0).getId();
		
		logger.info("좋아요 : {}", likeCnt);
		logger.info("아이디 : {}", id);
		
		if(likeCnt == 10) {
			inter.likePoint(id);//좋아요 10개면 포인트 1000 지급
			inter.likePointList(id);
		}else if(likeCnt>10) {
			inter.likePointt(id);//좋아요 10개 이상부터는 1개당 100포인트 지급
			inter.likePointListt(id);
		}
	}

	//신고하기
	public HashMap<String, Integer> complain(HashMap<String, String> map) {
		logger.info("신고하기 서비스");
		ComplainDTO dto = new ComplainDTO();
		logger.info(map.get("Id"));
		logger.info(map.get("compId"));
		dto.setId(map.get("Id"));
		dto.setComplain_id(map.get("compId"));
		dto.setComplain_cate(map.get("complain_cate"));
		logger.info(map.get("complain_cate"));
		if(map.get("complain_cate").equals("리뷰")) {
			dto.setReview_idx(Integer.parseInt(map.get("idx")));
		}else {
			dto.setRevReply_idx(Integer.parseInt(map.get("idx")));
		}
		dto.setComplain_type(map.get("complain_type"));
		dto.setComplain_content(map.get("complain_content"));
		System.out.println(dto.getId()+"/"+dto.getComplain_id()+"/"+dto.getComplain_cate()+"/"+dto.getReview_idx()+"/"+dto.getRevReply_idx()+"/"+dto.getComplain_type()+"/"+dto.getComplain_content());
		inter = sqlSession.getMapper(ReviewInter.class);
		HashMap<String, Integer> hash = new HashMap<String, Integer>();
		hash.put("success", inter.complain(dto));
		System.out.println(hash.get("success"));
		return hash;
	}

	//리뷰 별점 가져오기
	public HashMap<String, Object> review_star(String review_idx) {
		logger.info("리뷰 별점");
		inter = sqlSession.getMapper(ReviewInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("reviewStar", inter.reviewStar(review_idx));
		logger.info(""+map.get("reviewStar"));
		return map;
	}

	//리뷰 삭제
	public Integer review_delete(String review_idx) {
		logger.info("리뷰 삭제");
		inter=sqlSession.getMapper(ReviewInter.class);
		int success = inter.review_delete(review_idx);
		return success;
	}

	//리뷰 수정 페이지
	public ModelAndView review_updateForm(String review_idx) {
		logger.info("리뷰 수정 페이지 서비스");
		inter=sqlSession.getMapper(ReviewInter.class);
		//HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<ReviewDTO> arr = new ArrayList<>();
		//map.put("reviewUpdate", inter.review_updateForm(review_idx));
		arr = inter.review_updateForm(review_idx);
		ModelAndView mav = new ModelAndView();
		mav.addObject("review_updateForm", arr.get(0));
		mav.setViewName("review/reviewWrite");
		return mav;
	}

	//리뷰 수정
	@Transactional
	public String review_update(ArrayList<String> hash_tag, ArrayList<String> review_photo, HashMap<String, String> map,
			String loginId) {
		logger.info("리뷰 수정 서비스 도착");
		ModelAndView mav = new ModelAndView();
		String page = "redirect:/reviewWritePage";
		ReviewDTO dto = new ReviewDTO();
		dto.setReview_idx(Integer.parseInt(map.get("review_idx")));
		dto.setReview_storeName(map.get("review_storeName"));
		logger.info(map.get("review_storeName"));
		dto.setId(map.get("id"));
		logger.info(map.get("id"));
		dto.setReview_star(Double.parseDouble(map.get("star-input")));
		logger.info(""+Double.parseDouble(map.get("star-input")));
		dto.setReview_content(map.get("review_content"));
		logger.info(map.get("review_content"));
		
		logger.info("리뷰 수정 시작");
		inter = sqlSession.getMapper(ReviewInter.class);
		
		if(inter.review_update(dto) == 1) {
			logger.info("리뷰번호 : "+dto.getReview_idx());
			inter.review_HashDel(dto.getReview_idx());
			inter.review_PhotoDel(dto.getReview_idx());
			if(hash_tag.size() > 0) {
				for(int i=0; i<hash_tag.size(); i++) {
					String tag = hash_tag.get(i);
					int success = inter.hashtag(tag,dto.getReview_idx());
				}
			}
			if(review_photo.size() > 0) {
				for(int i=1; i<review_photo.size();i++) {
					String rePhoto = review_photo.get(i);
					int result = inter.reviewPhotoWrite(dto.getReview_idx(),rePhoto);
				}
			}else {
				review_point(loginId);//review_point 메소드(포인트 50)
			}
		}
		fileList.clear();
		return "redirect:/";
	}

	//리뷰 좋아요
	@Transactional
	public String reviewLike(String review_idx, String loginid, String name) {
		inter=sqlSession.getMapper(ReviewInter.class);
		String result=inter.likeSel(review_idx,loginid);
		String success="";
		RevLikeDTO dto = new RevLikeDTO();
		logger.info("좋아요 : "+result);
		if(result == null) {
			logger.info("result는 0 insert 해야함");
			
			dto.setReview_idx(Integer.parseInt(review_idx));
			dto.setId(loginid);
			inter.likeInsert(dto);			
			System.out.println("좋아요 idx : "+dto.getRevLike_idx());
			inter.likeCntUp(review_idx);			
			inter.alarmLike(name,dto.getRevLike_idx());
			review_likeCnt(review_idx);
			success = "insert";
		}else {
			logger.info("result는 0이 아님 delete 해야함");
			inter.likeDelete(review_idx, loginid);
			inter.likeCntDown(review_idx);
			success = "delete";
		}
		return success;
	}

	//좋아요리스트(로그인 했을때 좋아요 한 리뷰 표시해두기 위해)
	public ArrayList<RevLikeDTO> reviewLikeSelect(String loginId) {
		inter=sqlSession.getMapper(ReviewInter.class);
		ArrayList<RevLikeDTO> likeList = new ArrayList<>();
		likeList = inter.likeList(loginId);
		return likeList;
	}

	//댓글 리스트
	public HashMap<String, Object> replySelect(String review_idx, String page) {
		inter=sqlSession.getMapper(ReviewInter.class);
		int allCnt = inter.replyAllCnt(review_idx);
		
		//생성 가능 페이지 수(나머지가 있으면 페이지 하나 더 생성)
		int rangePage = allCnt%5 >0 ? 
					Math.round(allCnt/5)+1 : allCnt/5;
		int page2=Integer.parseInt(page);
		if(page2>rangePage) {
			page2 = rangePage;
		}
		int end = page2 * 5;	 //5 : 100
		int start = end - 5+1;//5 : 81
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("replySelect", inter.replySelect(review_idx,start,end));
		map.put("range", rangePage);
		map.put("currPage", page);
		return map;
	}

	//댓글 작성
	@Transactional
	public Integer replyWrite(String review_idx, String loginId, String reply_content,String profile, String name) {
		inter=sqlSession.getMapper(ReviewInter.class);
		RevReplyDTO dto = new RevReplyDTO();
		dto.setReview_idx(Integer.parseInt(review_idx));
		dto.setId(loginId);
		dto.setRevreply_content(reply_content);
		dto.setRevreply_profile(profile);
		int result=inter.replyWrite(dto);		
		inter.replyCntUp(review_idx);
		
		inter.alamReply(name,dto.getRevreply_idx());
		return result;
	}

	//댓글 삭제
	@Transactional
	public Integer Revreply_delete(String reply_idx, String review_idx) {
		logger.info("댓글 삭제");
		inter=sqlSession.getMapper(ReviewInter.class);
		int success = inter.Revreply_delete(reply_idx);
		inter.replyCntDown(review_idx);
		return success;
	}

	//댓글
	public Integer Revreply_update(String reply_content, String reply_idx, String review_idx) {
		logger.info("댓글 수정");
		inter=sqlSession.getMapper(ReviewInter.class);
		int success = inter.Revreply_update(reply_content, reply_idx,review_idx);
		return success;
	}

}
