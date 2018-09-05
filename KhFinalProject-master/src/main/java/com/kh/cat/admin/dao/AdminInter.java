package com.kh.cat.admin.dao;

import java.util.ArrayList;

import com.kh.cat.dto.ComplainDTO;
import com.kh.cat.dto.DMDTO;
import com.kh.cat.dto.HashDTO;
import com.kh.cat.dto.RevPhotoDTO;
import com.kh.cat.dto.RevReplyDTO;
import com.kh.cat.dto.ReviewDTO;
import com.kh.cat.dto.StoreDTO;

public interface AdminInter {

	ArrayList<ComplainDTO> complainList(int start, int end);//신고리스트(관리자)

	ArrayList<StoreDTO> storeRegistList(int start, int end);//가게 등록 리스트(관리자)

	ArrayList<ReviewDTO> comp_reviewList(String rev_idx);//신고된 리뷰 리스트

	ArrayList<HashDTO> reviewHash(String rev_idx);//신고된 리뷰의 해시태그

	ArrayList<RevPhotoDTO> reviewPhoto(String rev_idx);//신고된 리뷰의 사진

	int blackListAdd(String complain_id);//블랙리스트 추가

	int registYes(String store_idx);//가게 등록 승인

	void regY_dm_Write(DMDTO dto);//등록 승인 시 쪽지보내기

	int regNo_dmWrite(DMDTO dto);//등록 거절 시 쪽지 보내기

	void storeDel(String store_idx);//등록 거절 시 삭제

	int complainDel(String rev_idx, String id);//신고 취소

	int review_del(String rev_idx);//리뷰 삭제

	int review_del_dm(DMDTO dto);//게시물 삭제시 신고당한 사람에게 쪽지

	void review_del_dm2(DMDTO dto2);//게시물 삭제시 신고한 사람에게 쪽지

	ArrayList<RevReplyDTO> comp_revReplyList(String rev_idx);//신고된 리뷰댓글 리스트

	void revReply_del_dm3(DMDTO dto2);

	int complainDel2(String revReply, String id);

	int revReply_del(String revReply_idx);//댓글 삭제

	void alarm_registYN(DMDTO dto);//가게 등록 승인,거절 시 쪽지 알람

	void comp_black(String complain_idx);//블랙리스트 추가시 신고black 1로 변경

	void black_review_del(String complain_id);//블랙추가시 리뷰삭제

	void black_revReply_del(String complain_id);//블랙추가시 리뷰댓글 삭제

	void black_board_del(String complain_id);//블랙추가시 게시판 삭제

	int complainAllCnt();//페이징을 위한 신고리스트 총 갯수

	int storeRegistAllCnt();//페이징을 위한 가게 등록 리스트 총 갯수

	int dm_write(DMDTO dto);//쪽지보내기

	void alarm_dm(DMDTO dto);//쪽지보낼 때 알람 등록

	void review_del_dm2_alarm(DMDTO dto2);//리뷰 삭제시 쪽지보내기 알람 추가하기(신고한사람)

	void revReply_del_dm3_alarm(DMDTO dto2);//리뷰댓글 삭제시 쪽지보내기 알람 추가(신고한사람)

	void review_del_dm_alarm(DMDTO dto);//신고받은 사람 쪽지보내고 알람추가

	//int reviewIdxChk(String revReply_idx);//리뷰댓글 삭제시 리뷰idx 조회

	

	


	


	


}
