package com.kh.cat.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.cat.admin.dao.AdminInter;
import com.kh.cat.dto.ComplainDTO;
import com.kh.cat.dto.DMDTO;
import com.kh.cat.dto.HashDTO;
import com.kh.cat.dto.RevPhotoDTO;
import com.kh.cat.dto.RevReplyDTO;
import com.kh.cat.dto.ReviewDTO;
import com.kh.cat.dto.StoreDTO;

@Service
public class AdminService {
	
	@Autowired SqlSession sqlSession;	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	AdminInter inter;
	
	//신고 리스트
	public HashMap<String, Object> ComplainList(HashMap<String, String> params) {
		logger.info("신고 리스트 서비스 요청");
		
		int page = Integer.parseInt(params.get("page"));
		
		inter = sqlSession.getMapper(AdminInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int allCnt = inter.complainAllCnt();//신고리스트 총 갯수
		int range = allCnt % 10 > 0 ? Math.round(allCnt/10)+1 : allCnt/10;
		
		if(page > range) {
			page = range;
		}
		
		int end = page * 10;
		int start = end - 10 + 1;
		
		
		ArrayList<ComplainDTO> list = inter.complainList(start, end);
		logger.info("start : {}", start);
		logger.info("end : {}", end);
		logger.info("page : {}", page);
		
		map.put("list", list);
		map.put("range", range);
		map.put("currPage", page);
		return map;
	}

	//가게 등록 리스트
	public HashMap<String, Object> storeRegistList(HashMap<String, String> params) {
		logger.info("가게 등록 리스트 서비스 요청");
		
		int page = Integer.parseInt(params.get("page"));
		inter = sqlSession.getMapper(AdminInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		int allCnt = inter.storeRegistAllCnt();
		int range = allCnt % 10 > 0 ? Math.round(allCnt/10)+1 : allCnt/10;
		
		if(page > range) {
			page = range;
		}
		
		int end = page * 10;
		int start = end - 10 + 1;
		ArrayList<StoreDTO> list = inter.storeRegistList(start, end);
		logger.info("가게 등록 리스트 총 갯수 : {}", allCnt);
		logger.info("start : {}", start);
		logger.info("end : {}", end);
		logger.info("page : {}", page);
		
		map.put("list", list);
		map.put("range", range);
		map.put("currPage", page);
		
		return map;
	}
	
	//블랙리스트 추가
	public HashMap<String, Object> blackListAdd(HashMap<String, String> params) {
		logger.info("블랙리스트 추가 서비스 실행");
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(AdminInter.class);
		String rev_idx = params.get("rev_idx");
		String revReply_idx = params.get("revReply_idx");
		String id = params.get("id");
		String complain_id = params.get("complain_id");
		String complain_idx = params.get("complain_idx");
		logger.info("신고된 아이디 : {}", complain_id);
		logger.info("신고 idx : {}", complain_idx);
		logger.info("리뷰 idx : "+rev_idx+" / "+"리뷰 댓글 idx : "+revReply_idx+" / "+id);
		
		if(rev_idx != null && revReply_idx.equals("0")) {
			int result = inter.blackListAdd(complain_id);//블랙리스트에 추가
			if(result > 0) {
				map.put("result", result);
				map.put("msg", "블랙리스트 추가 완료");
				inter.comp_black(complain_idx);//신고내역에서 블랙유무 변경
				inter.black_review_del(complain_id);
				inter.black_revReply_del(complain_id);
				inter.black_board_del(complain_id);
				//inter.complainDel(rev_idx, id);//신고내역에서 지우기
				logger.info("블랙리스트 추가(리뷰) 여부 : {}", result);
			}
		}
		
		if(rev_idx.equals("0") && revReply_idx != null) {
			int result = inter.blackListAdd(complain_id);//블랙리스트에 추가
			if(result > 0) {
				map.put("result", result);
				map.put("msg", "블랙리스트 추가 완료");
				inter.comp_black(complain_idx);//신고내역에서 블랙유무 변경
				inter.black_review_del(complain_id);
				inter.black_revReply_del(complain_id);
				inter.black_board_del(complain_id);
				//inter.complainDel2(revReply_idx, id);//신고내역에서 지우기
				logger.info("블랙리스트 추가(리뷰) 여부 : {}", result);
			}
		}
		
		return map;
	}

	//신고된 리뷰리스트
	public HashMap<String, Object> complain_reviewList(HashMap<String, String> params) {
		logger.info("신고된 리뷰 서비스 요청");
		
		String rev_idx = params.get("rev_idx");
		String revReply_idx = params.get("revReply_idx");
		
		logger.info("리뷰 idx : {}", rev_idx);
		logger.info("리뷰 댓글 idx : {}", revReply_idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(AdminInter.class);
		
		if(rev_idx != null && revReply_idx.equals("0")) {
			ArrayList<ReviewDTO> list1 = inter.comp_reviewList(rev_idx);
			map.put("list1", list1);
		}
		if(rev_idx.equals("0") && revReply_idx != null) {
			//SELECT * FROM revReply WHERE review_idx=#{param1} ORDER BY revReply_date 
			ArrayList<RevReplyDTO> list2 = inter.comp_revReplyList(revReply_idx);
			map.put("list2", list2);
		}
		
		return map;
	}

	//신고된 리뷰 해시, 사진
	public HashMap<String, Object> reviewHashPhoto(HashMap<String, String> params) {
		logger.info("리뷰 해시태그,사진 서비스 실행");
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(AdminInter.class);
		String rev_idx = params.get("rev_idx");
		logger.info("리뷰 idx : {}", rev_idx);
		ArrayList<HashDTO> hashList =  inter.reviewHash(rev_idx);
		ArrayList<RevPhotoDTO> photoList = inter.reviewPhoto(rev_idx);
		 
		map.put("hash", hashList);
		map.put("photo", photoList);
		return map;
	}

	//가게 등록 승인
	public HashMap<String, Object> registYes(HashMap<String, String> params, String loginId) {
		logger.info("가게 등록 승인 서비스");
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(AdminInter.class);
		
		String store_idx = params.get("store_idx");
		String id = params.get("id");
		
		DMDTO dto = new DMDTO();
		dto.setId(loginId);
		dto.setDm_id(id);
		
		
		
		int result = inter.registYes(store_idx);
		if(result > 0) {
			inter.regY_dm_Write(dto);//가게 등록 승인시 쪽지
			logger.info("쪽지 idx : {}", dto.getDm_idx());
			logger.info("받을 아이디 : {}", id);
			inter.alarm_registYN(dto);
			map.put("msg", "승인 완료");
		}
		return map;
	}

	//가게 등록 거절
	public HashMap<String, Object> registNo(HashMap<String, String> params, String loginId) {
		logger.info("가게 등록 거절 서비스");
		
		String store_idx = params.get("store_idx");
		String id = params.get("id");
		String dm_content = params.get("dm_content");
		
		DMDTO dto = new DMDTO();
		dto.setId(loginId);
		dto.setDm_id(id);
		dto.setDm_content(dm_content);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(AdminInter.class);
		//id = 받는사람, loginId = 보내는사람, dm_content = 쪽지 내용
		int result = inter.regNo_dmWrite(dto);
		if(result > 0) {
			inter.storeDel(store_idx);
			inter.alarm_registYN(dto);
			map.put("msg", "등록 취소 완료");
		}
		
		return map;
	}

	//신고 취하
	public HashMap<String, Object> comp_cancel(HashMap<String, String> params) {
		logger.info("신고 취소 서비스 실행");
		
		String rev_idx = params.get("rev_idx");
		String revReply_idx = params.get("revReply_idx"); 
		String id = params.get("id");
		
		logger.info("리뷰 idx : "+rev_idx+" / "+"리뷰댓글 idx : "+revReply_idx+" / "+"신고한 아이디 : "+id);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(AdminInter.class);
		
		//리뷰 신고 내역 삭제
		if(rev_idx !=null && revReply_idx.equals("0")) {
			int result = inter.complainDel(rev_idx, id);
			if(result > 0) {
				map.put("result", result);
				map.put("msg", "리뷰 신고 취하 완료");
			}
		}
		if(rev_idx.equals("0") && revReply_idx != null) {
			int result = inter.complainDel2(revReply_idx, id);//신고내역 지우기
			if(result > 0) {
				map.put("result", result);
				map.put("msg", "리뷰댓글 신고 취하 완료");
			}
		}
		
		return map;
	}

	//게시물 삭제
	/*public HashMap<String, Object> comp_rev_reply_del(HashMap<String, String> params) {
		logger.info("게시물(리뷰&댓글) 삭제 서비스");
		
		String rev_idx = params.get("rev_idx");
		String revReply_idx = params.get("revReply_idx"); 
		String id = params.get("id");
		
		logger.info("리뷰 idx : "+rev_idx+" / "+"리뷰댓글 idx : "+revReply_idx+" / "+"신고한 아이디 : "+id);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(AdminInter.class);
		return map;
	}*/

	//게시물 삭제시 쪽지보내기
	public HashMap<String, Object> dm_write_rev_revRe_del(HashMap<String, String> params, String loginId) {
		logger.info("게시물 삭제시 쪽지보내기 서비스");
		DMDTO dto = new DMDTO();
		DMDTO dto2 = new DMDTO();
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(AdminInter.class);
		
		String rev_idx = params.get("review_idx");
		String revReply_idx = params.get("reviewReply_idx"); 
		String id = params.get("id");
		String complain_id = params.get("complain_id");
		String dm_content = params.get("dm_content");
		
		dto.setId(loginId);
		dto.setDm_id(complain_id);
		dto.setDm_content(dm_content);
		
		//신고한 게시물 삭제시 신고한 사람에게 쪽지보내기
		dto2.setId(loginId);
		dto2.setDm_id(id);
		
		logger.info("rev_idx : {}", rev_idx);
		logger.info("revReply_idx : {}", revReply_idx);
		logger.info("id : {}", id);
		logger.info("complain_id : {}", complain_id);
		logger.info("dm_content : {}", dm_content);
		
		if(rev_idx != null && revReply_idx.equals("0")) {//리뷰 삭제
			//complain_id = 받는사람(신고당한사람), loginId = 보내는사람(관리자), dm_content = 쪽지 내용
			int review_del_dm = inter.review_del_dm(dto);
			if(review_del_dm > 0) {
				inter.review_del_dm_alarm(dto);//신고받은 사람 쪽지알람 추가(리뷰)
				//id = 신고한사람, loginId = 관리자
				inter.review_del_dm2(dto2);//게시물 삭제후 신고한 사람에게 쪽지 보내기
				inter.review_del_dm2_alarm(dto2);//신고한 사람 알람추가
				int review_del = inter.review_del(rev_idx);//리뷰 삭제
				inter.complainDel(rev_idx, id);//신고내역에서 지우기
				map.put("result", review_del);//리뷰 삭제 결과 result 에 저장
				map.put("msg", "리뷰가 삭제되었습니다.");
			}
		}
		if(rev_idx.equals("0")&& revReply_idx != null) {//댓글 삭제
			int review_del_dm = inter.review_del_dm(dto);
			if(review_del_dm > 0) {
				inter.review_del_dm_alarm(dto);//신고받은 사람 쪽지알람 추가(댓글)
				inter.revReply_del_dm3(dto2);//게시물 삭제후 신고한 사람에게 쪽지
				inter.revReply_del_dm3_alarm(dto2);//신고한사람 알람추가
				int revReply_del = inter.revReply_del(revReply_idx);//신고된 댓글 삭제
				inter.complainDel2(revReply_idx, id);//신고내역 지우기
				//int reviewIdx = inter.reviewIdxChk(revReply_idx);
				//inter.replyCntDown(reviewIdx);
				map.put("result", revReply_del);
				map.put("msg", "신고된 댓글이 삭제되었습니다.");
			}
		}
		
		return map;
	}

	//관리자 쪽지 보내기
	public HashMap<String, Object> dm_write(HashMap<String, String> params) {
		logger.info("쪽지 보내기 서비스 실행");
		DMDTO dto = new DMDTO();
		String user1 = params.get("user1");
		String user2 = params.get("user2");
		String dm_content = params.get("dm_content");
		dto.setDm_id(user1);
		dto.setId(user2);
		dto.setDm_content(dm_content);
		
		logger.info("받는 사람 : {}", user1);
		logger.info("보내는 사람 : {}", user2);
		logger.info("쪽지 내용 : {}", dm_content);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(AdminInter.class);
		int result = inter.dm_write(dto);
		logger.info("쪽지 번호 : {}", dto.getDm_idx());
		if(result > 0) {
			inter.alarm_dm(dto);
			map.put("msg", "메세지 보내기 성공");
			map.put("result", result);
		}
		return map;
	}


	

}
