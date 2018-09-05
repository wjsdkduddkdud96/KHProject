package com.kh.cat.review.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.cat.dto.ComplainDTO;
import com.kh.cat.dto.HashDTO;
import com.kh.cat.dto.RevLikeDTO;
import com.kh.cat.dto.RevPhotoDTO;
import com.kh.cat.dto.RevReplyDTO;
import com.kh.cat.dto.ReviewDTO;
import com.kh.cat.dto.StoreDTO;

public interface ReviewInter {

	int reviewWrite(ReviewDTO dto);

	int hashtag(String tag, int review_idx);

	int reviewPhotoWrite(int review_idx, String rePhoto);

	ArrayList<StoreDTO> storeList(String params, int start, int end);
	
	int storeListCnt(String params);

	ArrayList<ReviewDTO> reviewList(HashMap<String, Object> ra);
	
	ArrayList<ReviewDTO> reviewList_or(HashMap<String, Object> ra);
	
	ArrayList<ReviewDTO> reviewList_hash(HashMap<String, Object> ra);

	ArrayList<HashDTO> reviewHash(String review_idx);

	ArrayList<RevPhotoDTO> reviewPhoto(String review_idx);

	void review_point(String loginId);//리뷰 작성시 50포인트

	void photoReview_point(String loginId);//리뷰 작성시 100포인트

	ArrayList<ReviewDTO> review_likeCnt(String idx);//리뷰 좋아요 수

	void likePoint(String id);//좋아요 수 포인트(1000)

	Integer complain(ComplainDTO dto);

	Double reviewStar(String review_idx);

	int review_delete(String review_idx);

	ArrayList<ReviewDTO> review_updateForm(String review_idx);

	int review_update(ReviewDTO dto);

	void review_HashDel(int review_idx);

	void review_PhotoDel(int review_idx);

	String likeSel(String review_idx, String id);

	int likeInsert(RevLikeDTO dto);

	int likeDelete(String review_idx, String loginid);

	ArrayList<RevLikeDTO> likeList(String loginId);

	void likeCntUp(String review_idx);

	void likeCntDown(String review_idx);

	ArrayList<RevReplyDTO> replySelect(String review_idx, int start, int end);

	int replyWrite(RevReplyDTO dto);

	void replyCntUp(String review_idx);

	int Revreply_delete(String review_idx);

	void replyCntDown(String review_idx);

	void likePointt(String id);//좋아요 10개 이상 100포인트

	void alamReply(String name, int revreply_idx);

	void alarmLike(String name, int revLike_idx);

	void alarmLikeDel(int alarm_idx);

	int Revreply_update(String reply_content, String reply_idx, String review_idx);

	void storeReviewUpdate(String review_storeidx, double star);

	Double starAvg(String review_storeidx);

	void totalUpdate(String review_storeidx, double star);

	int allCount();

	int storeReviewCount(int store_idx);

	int searchAndReviewCount(String search_content_And);

	int searchOrReviewCount(HashMap<String, Object> ra);

	int searchHashReviewCount(HashMap<String, Object> ra);

	int replyAllCnt(String review_idx);

	void likePointList(String id);//좋아요 10개 되면 1000포인트 지급되면 포인트리스트에 추가하기

	void likePointListt(String id);//포인트 지급되면 포인트리스트에 추가하기(좋아요 당 100 포인트)

	void review_pointList(String loginId);

	void photoReview_pointList(String loginId);




	


}
