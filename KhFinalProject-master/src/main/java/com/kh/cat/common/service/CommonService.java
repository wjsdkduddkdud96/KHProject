package com.kh.cat.common.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Locale;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cat.common.dao.CommonInter;

import com.kh.cat.dto.ReviewDTO;
import com.kh.cat.dto.AlarmDTO;
import com.kh.cat.dto.ComplainDTO;
import com.kh.cat.dto.DMDTO;
import com.kh.cat.dto.FollowDTO;
import com.kh.cat.dto.HashDTO;
import com.kh.cat.dto.MemberDTO;
import com.kh.cat.dto.StoreDTO;
import com.kh.cat.dto.TotalDTO;

@Service
public class CommonService {

	@Autowired
	SqlSession sqlSession;
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	CommonInter inter;

	public HashMap<String, Object> receivelist(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int page = Integer.parseInt(params.get("page"));
		String id = params.get("id");
		//총 게시물 수 => 생성 가능 페이지 수
		int allCnt = inter.receivelistallCount(id);
		//생성 가능 페이지 수 : 나머지가 있으면 페이지 하나 더 생성
		int range = allCnt%5 >0 ? Math.round(allCnt/5)+1 : allCnt/5;
		if(page>range) {
			page=range;			
		}
		logger.info("총 개시물 수 : {}",allCnt);
		logger.info("생성 가능 페이지 수 : {}",range);
		int end = page*5;
		int start = end-4;
		logger.info(id);
		map.put("list", inter.receivelist(id,start,end));
		map.put("range", range);
		map.put("currPage",page);
		return map;
	}

	public HashMap<String, Object> sendlist(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int page = Integer.parseInt(params.get("page"));
		String id = params.get("id");
		//총 게시물 수 => 생성 가능 페이지 수
		int allCnt = inter.sendlistallCount(id);
		//생성 가능 페이지 수 : 나머지가 있으면 페이지 하나 더 생성
		int range = allCnt%5 >0 ? Math.round(allCnt/5)+1 : allCnt/5;
		if(page>range) {
			page=range;			
		}
		logger.info("총 개시물 수 : {}",allCnt);
		logger.info("생성 가능 페이지 수 : {}",range);
		int end = page*5;
		int start = end-4;
		logger.info(id);
		map.put("list", inter.sendlist(id,start,end));
		map.put("range", range);
		map.put("currPage",page);
		return map;
	}

	public ModelAndView receivedetail(String idx) {
		inter = sqlSession.getMapper(CommonInter.class);
		logger.info(idx);
		ModelAndView mav = new ModelAndView();
		mav.addObject("name", "보낸사람");
		mav.addObject("detail", inter.receivedetail(idx));
		mav.setViewName("timeline/timeline_messagedetail");
		return mav;
	}

	public ModelAndView senddetail(String idx) {
		inter = sqlSession.getMapper(CommonInter.class);
		logger.info(idx);
		ModelAndView mav = new ModelAndView();
		mav.addObject("name", "받는사람");
		mav.addObject("detail", inter.senddetail(idx));
		mav.setViewName("timeline/timeline_messagedetail");
		return mav;
	}

	@Transactional
	public HashMap<String, Object> pointlist(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int page = Integer.parseInt(params.get("page"));
		String id = params.get("id");
		//총 게시물 수 => 생성 가능 페이지 수
		int allCnt = inter.pointallCount(id);
		//생성 가능 페이지 수 : 나머지가 있으면 페이지 하나 더 생성
		int range = allCnt%5 >0 ? Math.round(allCnt/5)+1 : allCnt/5;
		if(page>range) {
			page=range;			
		}
		logger.info("총 개시물 수 : {}",allCnt);
		logger.info("생성 가능 페이지 수 : {}",range);
		int end = page*5;
		int start = end-4;
		logger.info(id);
		map.put("memberpoint",inter.memberpoint(id));
		map.put("list", inter.pointList(id,start,end));
		map.put("range", range);
		map.put("currPage",page);
		return map;
	}

	public HashMap<String, Object> couponlist(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int page = Integer.parseInt(params.get("page"));
		String id = params.get("id");
		//총 게시물 수 => 생성 가능 페이지 수
		int allCnt = inter.couponallCount(id);
		//생성 가능 페이지 수 : 나머지가 있으면 페이지 하나 더 생성
		int range = allCnt%5 >0 ? Math.round(allCnt/5)+1 : allCnt/5;
		if(page>range) {
			page=range;			
		}
		logger.info("총 개시물 수 : {}",allCnt);
		logger.info("생성 가능 페이지 수 : {}",range);
		int end = page*5;
		int start = end-4;
		logger.info(id);
		//ArrayList<Object> list=inter.couponlist(id,start,end)
		map.put("list", inter.couponlist(id,start,end));
		map.put("range", range);
		map.put("currPage",page);
		return map;
	}

	public HashMap<String, Object> messagesendidcheck(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = params.get("id");
		logger.info(id);
		boolean idcheck = false;
		if (inter.messagesendidcheck(id) != null) {
			idcheck = true;
		}
		map.put("id", idcheck);
		return map;
	}

	@Transactional
	public HashMap<String, Object> sendmsg(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		DMDTO dto = new DMDTO();
		String userid = params.get("userid");
		String id = params.get("id");
		String content = params.get("content");
		dto.setId(userid);
		dto.setDm_id(id);
		dto.setDm_content(content);
		logger.info(userid + "/" + id + "/" + content);
		int a = inter.sendmsg(dto);
		if (a > 0) {
			inter.alarmdminsert(dto.getDm_idx(), id);
		}
		map.put("success", a);
		return map;
	}

	public HashMap<String, Object> maintimeline(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = params.get("id");
		int a = inter.reviewtimelinecnt(id);
		int b = inter.liketimelinecnt(id);
		int c = inter.storeliketimelinecnt(id);
		int d = inter.followtimelinecnt(id);
		map.put("review", a);
		map.put("reviewlike", b);
		map.put("storelike", c);
		map.put("follow", d);
		return map;
	}

	public HashMap<String, Object> timelinereviewlist(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int page = Integer.parseInt(params.get("page"));
		String id = params.get("id");
		//총 게시물 수 => 생성 가능 페이지 수
		int allCnt = inter.reviewtimelinecnt(id);
		//생성 가능 페이지 수 : 나머지가 있으면 페이지 하나 더 생성
		int range = allCnt%10 >0 ? Math.round(allCnt/10)+1 : allCnt/10;
		if(page>range) {
			page=range;
		}
		logger.info("총 개시물 수 : {}",allCnt);
		logger.info("생성 가능 페이지 수 : {}",range);
		int end = page*10;
		int start = end-9;
		logger.info(id);
		//ArrayList<Object> list=inter.couponlist(id,start,end)
		map.put("list", inter.timelinereviewlist(id,start,end));
		map.put("range", range);
		map.put("currPage",page);
		return map;
	}

	@Transactional
	public HashMap<String, Object> followinsert(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		FollowDTO dto = new FollowDTO();
		String userid = params.get("userid");
		String id = params.get("id");
		dto.setId(userid);
		dto.setFollow_id(id);
		logger.info(userid + "/" + id + "/");
		int a = inter.followinsert(dto);
		System.out.println("a" + a);
		System.out.println(dto.getFollow_idx());
		if (a > 0) {
			inter.alarminsert(dto.getFollow_idx(), id);
		}
		map.put("success", a);
		return map;
	}

	public HashMap<String, Object> followcheck(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String userid = params.get("userid");
		String id = params.get("id");
		logger.info(id);
		boolean followcheck = false;
		if (inter.followcheck(userid, id) != null) {
			followcheck = true;
		}
		map.put("id", followcheck);
		return map;
	}

	public HashMap<String, Object> followdelete(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String userid = params.get("userid");
		String id = params.get("id");
		logger.info(userid + "/" + id + "/");
		int a = inter.followdelete(userid, id);
		map.put("success", a);
		return map;
	}

	/*
	 * public ModelAndView storeSearch(Map<String, String> params) { inter =
	 * sqlSession.getMapper(CommonInter.class); String search_content =
	 * params.get("search_content"); String search_content_And =
	 * search_content.replaceAll(" ", "%"); String[] search_content_Split =
	 * search_content.split(" ");
	 * 
	 * HashMap<String, Object> search_content_Map = new HashMap<String, Object>();
	 * search_content_Map.put("map", params.get("search_map"));
	 * search_content_Map.put("content", search_content_And);
	 * search_content_Map.put("sort", "리뷰 최신 순");
	 * 
	 * ArrayList<StoreDTO> result = inter.storeSearch_And(search_content_Map);
	 * if(result.isEmpty()) { search_content_Map.put("content",
	 * search_content_Split); result = inter.storeSearch_Or(search_content_Map);
	 * if(result.isEmpty()) { result = inter.storeSearch_Hash(search_content_Map); }
	 * }
	 * 
	 * ArrayList<ArrayList<HashDTO>> result_hash = new
	 * ArrayList<ArrayList<HashDTO>>(); for(int i=0; i<result.size(); i++) {
	 * result_hash.add(inter.storeHash(result.get(i).getStore_idx())); }
	 * 
	 * ModelAndView mav = new ModelAndView(); mav.addObject("list", result);
	 * mav.addObject("list_hash", result_hash);
	 * mav.setViewName("include/common/search"); return mav; }
	 */

	public HashMap<String, Object> storeSearchSort(HashMap<String, String> params, String page) {
		inter = sqlSession.getMapper(CommonInter.class);
		logger.info("넘어온 정렬 : " + params.get("data"));
		logger.info("넘어온 검색어 : " + params.get("search_content"));
		String search_content = params.get("search_content");
		String search_content_And = search_content.replaceAll(" ", "%");
		String[] search_content_Split = search_content.split(" ");
		String mapSearch = params.get("search_map");
		
		HashMap<String, Object> search_content_Map = new HashMap<String, Object>();
		if(mapSearch == null) {
			mapSearch = "";
		}
		search_content_Map.put("map", mapSearch);
		search_content_Map.put("content", search_content_And);
		search_content_Map.put("sort", params.get("data"));
		search_content_Map.put("mainStore", params.get("mainStore"));
		
		//총 게시물 수 => 생성 가능 페이지 수
		int allCnt = 0;
		if(params.get("search_content").equals("") && mapSearch.equals("전체")) {
			allCnt=inter.allCount(search_content_Map);
			System.out.println("전체 가게 수 : "+allCnt);
		}else {
			search_content_Map.put("store_searchCnt", search_content_And);
			allCnt = inter.searchAndStoreCount(search_content_Map);
			System.out.println("AND 검색 : "+allCnt);
			if(allCnt == 0) {
				search_content_Map.put("store_searchCnt", search_content_Split);
				allCnt = inter.searchOrStoreCount(search_content_Map);
				System.out.println("OR 검색 : "+allCnt);
				if(allCnt == 0) {
					allCnt = inter.searchHashStoreCount(search_content_Map);
					System.out.println("HASH 검색 : "+allCnt);
				}
			}
		}
		//생성 가능 페이지 수(나머지가 있으면 페이지 하나 더 생성)
		int rangePage = allCnt%6 >0 ? 
					Math.round(allCnt/6)+1 : allCnt/6;
		int page2=Integer.parseInt(page);
		if(page2>rangePage) {
			page2 = rangePage;
		}
		int end = page2 * 6;	 //5 : 100
		int start = end - 6+1;//5 : 81
		
		//페이징 시작,끝
		search_content_Map.put("start", start);
		search_content_Map.put("end", end);
		System.out.println("오오오오오"+allCnt+"/"+start+"/"+end);

		ArrayList<StoreDTO> result = inter.storeSearch_And(search_content_Map);
		if (result.isEmpty()) {
			search_content_Map.put("content", search_content_Split);
			result = inter.storeSearch_Or(search_content_Map);
			if (result.isEmpty()) {
				result = inter.storeSearch_Hash(search_content_Map);
			}
		}

		ArrayList<ArrayList<HashDTO>> result_hash = new ArrayList<ArrayList<HashDTO>>();
		for (int i = 0; i < result.size(); i++) {
			result_hash.add(inter.storeHash(result.get(i).getStore_idx()));
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("range", rangePage);
		map.put("currPage", page);
		map.put("list", result);
		map.put("size", result.size());
		map.put("list_hash", result_hash);
		return map;
	}

	public HashMap<String, Object> timelinelikereview(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = params.get("id");
		int page = Integer.parseInt(params.get("page"));
		//총 게시물 수 => 생성 가능 페이지 수
		ArrayList<Integer> review = inter.timelinereview(id);
		//생성 가능 페이지 수 : 나머지가 있으면 페이지 하나 더 생성]
		int allCnt = review.size();
		System.out.println(review.size());
		int range = allCnt%10 >0 ? Math.round(allCnt/10)+1 : allCnt/10;
		if(page>range) {
			page=range;
		}		
		int end = page*10;
		int start = end-9;
		ArrayList<Integer> reviewpage = inter.timlinepagereview(id,start,end);
		
		ArrayList<ArrayList<ReviewDTO>> list = new ArrayList<ArrayList<ReviewDTO>>();
		for (int i = 0; i < reviewpage.size(); i++) {			
			list.add(inter.timelinelikereview(reviewpage.get(i)));
		}		
		map.put("list",list);
		map.put("range", range);
		map.put("currPage",page);
		return map;
	}

	public HashMap<String, Object> timeline_reply(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = params.get("id");
		int page = Integer.parseInt(params.get("page"));
		ArrayList<Integer> review = inter.my_reply(id);
		logger.info("review " + review.size());
		
		HashSet<Integer> set = new HashSet<Integer>(review);
		review = new ArrayList<Integer>(set);
		ArrayList<ArrayList<ReviewDTO>> list = new ArrayList<ArrayList<ReviewDTO>>();
		int range = 0;
		if(review.size()>0) {
			int allCnt = review.size();
			range = allCnt%10 >0 ? Math.round(allCnt/10)+1 : allCnt/10;
			if(page>range) {
				page=range;
			}		
			int end = page*10;
			int start = end-9;
			ArrayList<Integer> reviewpage = inter.timlinepagereviewreply(id,start,end);
			set = new HashSet<Integer>(reviewpage);
			reviewpage = new ArrayList<Integer>(set);
			
			// ArrayList<ReviewDTO> list = new ArrayList<ReviewDTO>();
			
			for (int i = 0; i < reviewpage.size(); i++) {
				list.add(inter.timelinelikereview(reviewpage.get(i)));
			}
		}		
		map.put("list", list);
		map.put("range", range);
		map.put("currPage",page);
		return map;
	}

	public HashMap<String, Object> timelinprofile(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = params.get("id");
		logger.info(id);
		map.put("profile", inter.timelinprofile(id));
		return map;
	}

	public HashMap<String, Object> timelinereviewreply(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String idx = params.get("idx");
		logger.info(idx);
		map.put("replylist", inter.timelinereviewreply(idx));
		return map;
	}

	/*
	 * //관리자 신고 리스트 public HashMap<String, Object> timeLineComplainList(Map<String,
	 * String> params) { logger.info("신고 리스트 서비스 요청"); inter =
	 * sqlSession.getMapper(CommonInter.class); HashMap<String, Object> map = new
	 * HashMap<String, Object>(); ArrayList<ComplainDTO> list =
	 * inter.complainList(); map.put("list", list); return map; }
	 * 
	 * //가게 등록 리스트(관리자) public HashMap<String, Object>
	 * timeLineStoreRegistList(Map<String, String> params) {
	 * logger.info("가게 등록 리스트 서비스 요청"); inter =
	 * sqlSession.getMapper(CommonInter.class); HashMap<String, Object> map = new
	 * HashMap<String, Object>(); ArrayList<StoreDTO> list =
	 * inter.storeRegistList(); map.put("list", list); return map; }
	 */

	public HashMap<String, Object> reply_update(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int idx = Integer.parseInt(params.get("revreply_idx"));
		String content = params.get("content");
		logger.info(idx + "/" + content);
		int a = inter.reply_update(idx, content);
		boolean updatecheck = false;
		if (a > 0) {
			updatecheck = true;
		}
		map.put("update", updatecheck);
		return map;
	}

	public HashMap<String, Object> reply_delete(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int idx = Integer.parseInt(params.get("revreply_idx"));
		logger.info("idx" + idx);
		int a = inter.reply_delete(idx);
		boolean deletecheck = false;
		if (a > 0) {
			deletecheck = true;
		}
		map.put("del", deletecheck);
		return map;
	}

	public HashMap<String, Object> timelinelikestore(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = params.get("id");
		int page = Integer.parseInt(params.get("page"));
		ArrayList<Integer> likestore = inter.likestore(id);
		
		ArrayList<ArrayList<StoreDTO>> list = new ArrayList<ArrayList<StoreDTO>>();
		ArrayList<ArrayList<HashDTO>> list_hash = new ArrayList<ArrayList<HashDTO>>();
		int range = 0;
		if(likestore.size()>0) {
			int allCnt = likestore.size();
			range = allCnt%6 >0 ? Math.round(allCnt/6)+1 : allCnt/6;
			if(page>range) {
				page=range;
			}		
			int end = page*6;
			int start = end-5;
			ArrayList<Integer> likestorepage = inter.timlinepagestore(id,start,end);
			// ArrayList<ReviewDTO> list = new ArrayList<ReviewDTO>();
			
			for (int i = 0; i < likestorepage.size(); i++) {
				list.add(inter.timelinelikestore(likestorepage.get(i)));
				list_hash.add(inter.likestorehash(likestorepage.get(i)));
			}
		}		
		map.put("list", list);
		map.put("list_hash", list_hash);
		map.put("range", range);
		map.put("currPage",page);
		return map;
	}

	// 등록한 가게 리스트
	public HashMap<String, Object> statList(String id) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("storeList", inter.statList(id));

		return map;
	}

	// 현재 날짜 기준으로 통계 데이터 가져오기
	public ModelAndView showStat(int store_idx, String store_name) {
		inter = sqlSession.getMapper(CommonInter.class);
		ModelAndView mav = new ModelAndView();
		ArrayList<TotalDTO> statList = inter.showStat(store_idx);
		mav.addObject("store_name",store_name);
		mav.addObject("statList",statList);
		mav.setViewName("store/showStat");
		return mav;
	}

	@Scheduled(cron = "0 0 0 * * * ") // 0시에 실행
	public void cron() {
		inter = sqlSession.getMapper(CommonInter.class);
		ArrayList<StoreDTO> storeList = inter.storeList();
		
		Date today = new Date();
        SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
        String sysdate = date.format(today);
        
		int idx;
		for (StoreDTO dto : storeList) {
			idx = dto.getStore_idx();
			double starAvg = inter.getStarAvg(idx);
			inter.insertStat(idx,starAvg,sysdate);
		}

	}

	public HashMap<String, Object> timelinefollowlist(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = params.get("id");
		ArrayList<String> followlist = inter.followlist(id);
		ArrayList<String> following = inter.following(id);
		ArrayList<ArrayList<MemberDTO>> list = new ArrayList<ArrayList<MemberDTO>>();
		ArrayList<ArrayList<MemberDTO>> listing = new ArrayList<ArrayList<MemberDTO>>();
		int page = Integer.parseInt(params.get("page"));
		System.out.println(page+"페이지");
		int allCnt1 = followlist.size();
		int allCnt2 = following.size();
		int range1 = allCnt1%6 >0 ? Math.round(allCnt1/6)+1 : allCnt1/6;
		int range2 = allCnt2%6 >0 ? Math.round(allCnt2/6)+1 : allCnt2/6;
		int page1 = 0;
		int page2=0;
		if(page>range1) {
			page1=range1;
		}
		if(page>range2) {
			page2=range2;
		}
		int end = page*6;
		int start = end-5;
		ArrayList<String> pagefollowlist = inter.pagefollowlist(id,start,end);
		ArrayList<String> pagefollowing = inter.pagefollowing(id,start,end);
		for (int i = 0; i < pagefollowlist.size(); i++) {
			list.add(inter.followlistprofile(pagefollowlist.get(i)));
		}
		for (int j = 0; j < pagefollowing.size(); j++) {
			listing.add(inter.followingprofile(pagefollowing.get(j)));
		}
		map.put("followlist", list);
		map.put("following", listing);
		map.put("range1", range1);
		map.put("range2", range2);
		map.put("currPage1",page1);
		map.put("currPage2",page2);
		return map;
	}

	public HashMap<String, Object> alarmlist(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = params.get("id");
		int page = Integer.parseInt(params.get("page"));
		int allCnt = inter.alarmcnt(id);
		int range = allCnt%5 >0 ? Math.round(allCnt/5)+1 : allCnt/5;
		if(page>range) {
			page=range;
		}		
		int end = page*5;
		int start = end-4;
		map.put("list", inter.alarmlist(id,start,end));
		map.put("range", range);
		map.put("currPage",page);
		return map;
	}

	public HashMap<String, Object> alarmread(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int idx = Integer.parseInt(params.get("idx"));
		int a = inter.alarmread(idx);
		boolean alarmread = false;
		if (a > 0) {
			alarmread = true;
		}
		map.put("success", alarmread);
		return map;

	}

	public HashMap<String, Object> alarmcnt(Map<String, String> params) {
		inter = sqlSession.getMapper(CommonInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = params.get("id");
		int alarmCnt = inter.alarmcnt(id);
		map.put("cnt", alarmCnt);
		return map;
	}

}
