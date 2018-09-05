package com.kh.cat.common.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import com.kh.cat.dto.AlarmDTO;
import com.kh.cat.dto.ComplainDTO;
import com.kh.cat.dto.CouponBoxDTO;
import com.kh.cat.dto.DMDTO;
import com.kh.cat.dto.FollowDTO;
import com.kh.cat.dto.HashDTO;
import com.kh.cat.dto.MemberDTO;
import com.kh.cat.dto.PointListDTO;
import com.kh.cat.dto.RevReplyDTO;
import com.kh.cat.dto.ReviewDTO;
import com.kh.cat.dto.StoreDTO;
import com.kh.cat.dto.TotalDTO;

public interface CommonInter {

	ArrayList<DMDTO> sendlist(String id, int start, int end);

	DMDTO receivedetail(String idx);

	DMDTO senddetail(String idx);

	String memberpoint(String id);	

	String messagesendidcheck(String id);

	ArrayList<StoreDTO> storeSearch_And(HashMap<String, Object> search_content_AndMap);

	ArrayList<StoreDTO> storeSearch_Or(HashMap<String, Object> search_content_OrMap);

	ArrayList<StoreDTO> storeSearch_Hash(HashMap<String, Object> search_content_Hash);
	
	int reviewtimelinecnt(String id);

	int liketimelinecnt(String id);

	int storeliketimelinecnt(String id);

	int followtimelinecnt(String id);

	ArrayList<ReviewDTO> timelinereviewlist(String id, int start, int end);

	String followcheck(String userid, String id);

	int followdelete(String userid, String id);

	ArrayList<Integer> timelinereview(String id);

	ArrayList<ReviewDTO> timelinelikereview(Integer integer);

	ArrayList<Integer> my_reply(String id);

	Object timelinprofile(String id);

	ArrayList<HashDTO> storeHash(int store_idx);

	ArrayList<RevReplyDTO> timelinereviewreply(String idx);


	//ArrayList<ComplainDTO> complainList();//신고 리스트(관리자)

	//ArrayList<StoreDTO> storeRegistList();//가게 등록 리스트(관리자)

	int reply_update(int idx, String content);

	int reply_delete(int idx);

	ArrayList<Integer> likestore(String id);

	ArrayList<StoreDTO> timelinelikestore(Integer integer);

	ArrayList<HashDTO> likestorehash(Integer integer);

	ArrayList<StoreDTO> statList(String id);//내가 등록한 가게 리스트
	
	ArrayList<String> followlist(String id);

	ArrayList<String> following(String id);

	ArrayList<MemberDTO> followlistprofile(String string);

	ArrayList<MemberDTO> followingprofile(String string);

	int followinsert(FollowDTO dto);

	void alarminsert(int follow_idx, String id);

	int alarmread(int idx);

	int sendmsg(DMDTO dto);

	void alarmdminsert(int dm_idx, String id);

	ArrayList<StoreDTO> storeList();//store idx 셀렉
	
	double getStarAvg(int idx);//평균 별점 가져오기

	void insertStat(int idx, double starAvg, String sysdate);//통계 0으로 자정에 추가

	ArrayList<TotalDTO> showStat(int store_idx);//통계 가져오기

	void uphitStat(int store_idx);//통계에 조회수 증가;
	
	ArrayList<CouponBoxDTO> couponlist(String id, int start, int end);

	int couponallCount(String id);

	int receivelistallCount(String id);

	ArrayList<DMDTO> receivelist(String id, int start, int end);

	int sendlistallCount(String id);

	int allCount(HashMap<String, Object> search_content_Map);

	int searchAndStoreCount(HashMap<String, Object> search_content_Map);

	int searchOrStoreCount(HashMap<String, Object> search_content_Map);

	int searchHashStoreCount(HashMap<String, Object> search_content_Map);

	int pointallCount(String id);

	ArrayList<PointListDTO> pointList(String id, int start, int end);

	ArrayList<Integer> timlinepagereview(String id, int start, int end);

	ArrayList<Integer> timlinepagestore(String id, int start, int end);

	ArrayList<String> pagefollowlist(String id, int start, int end);

	ArrayList<String> pagefollowing(String id, int start, int end);

	int alarmcnt(String id);

	ArrayList<AlarmDTO> alarmlist(String id, int start, int end);

	ArrayList<Integer> timlinepagereviewreply(String id, int start, int end);

}
