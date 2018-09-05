package com.kh.cat.board.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cat.board.dao.BoardInter;
import com.kh.cat.dto.BoardDTO;
import com.kh.cat.dto.BoardReplyDTO;

@Service
public class BoardService {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired SqlSession sqlSession;
	BoardInter inter;
	
	//게시판 리스트
	public @ResponseBody HashMap<String, Object> boardList(int page) {
		logger.info("페이지 : {}", page);
		logger.info("boardList 서비스 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(BoardInter.class);
		
		int allCnt = inter.boardAllCnt();//페이징을 위한 총 게시물 수
		logger.info("총게시물 수 : {}", allCnt);
		int range = allCnt % 10 > 0 ? Math.round(allCnt/10)+1 : allCnt/10;
		
		if(page > range) {
			page = range;
		}
		
		int end = page * 10;
		int start = end - 10 + 1;
		logger.info("start : {}", start);
		logger.info("end : {}", end);
		logger.info("page : {}", page);
		ArrayList<BoardDTO> list2 = inter.boardList2();//공지사항 리스트
		ArrayList<BoardDTO> list = inter.boardList(start, end);//문의사항 리스트
		logger.info("공지사항 : {}", list2.size());
		logger.info("리스트 확인 : " +list.size());
		map.put("list2", list2);
		map.put("list", list);
		map.put("range", range);
		map.put("currPage", page);
		
		
		return map;
	}

	//게시판 작성
	public @ResponseBody HashMap<String, Object> boardWrite(HashMap<String, String> params) {
		logger.info("boardWrite 서비스 요청");

		HashMap<String, Object> map = new HashMap<String,Object>();
		BoardDTO dto = new BoardDTO();
		
		String cate = params.get("cate");
		String id = params.get("id");
		String subject = params.get("subject");
		String content  = params.get("content");
		
		logger.info("cate : {}", cate);
		logger.info("id : {}", id);
		logger.info("subject : {}", subject);
		logger.info("content : {}", content);
		
		dto.setBoard_cate(cate);
		dto.setId(id);
		dto.setBoard_subject(subject);
		dto.setBoard_content(content);
		
		inter = sqlSession.getMapper(BoardInter.class);
		
		int result = 0;
		result = inter.boardWrite(dto);
		logger.info("result check : "+result);
		
		if(result > 0) {
			map.put("success",dto.getBoard_idx());
		}
		logger.info("idx : {}", dto.getBoard_idx());
		return map;
	}

	//게시판 상세보기
	public ModelAndView boardDetail(String idx) {
		logger.info("boardDetail 서비스 요청");
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(BoardInter.class);
		BoardDTO dto = inter.boardDetail(idx);
		logger.info("idx : {}",idx);

		String page = "board/boardDetail";

		mav.addObject("dto", dto);
		mav.setViewName(page);

		return mav;
	}

	//수정 상세보기
	public ModelAndView updateForm(String idx) {
		logger.info("updateForm 서비스 요청");
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(BoardInter.class);
		BoardDTO dto = inter.boardDetail(idx);
		
		mav.addObject("dto", dto);
		mav.setViewName("board/updateForm");
		return mav;
	}

	//수정 수정하기
	public HashMap<String, Object> boardUpdate(HashMap<String, String> params) {
		logger.info("boardUpdate 서비스 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();
		BoardDTO dto = new BoardDTO();
		String idx = params.get("idx");
		String subject = params.get("subject");
		String content = params.get("content");
		
		logger.info("idx : {}", idx);
		logger.info("subject : {}", subject);
		logger.info("content : {}", content);
		
		dto.setBoard_idx(Integer.parseInt(idx));
		dto.setBoard_subject(subject);
		dto.setBoard_content(content);
		
		inter = sqlSession.getMapper(BoardInter.class);
		int result = 0;
		result = inter.boardUpdate(dto);
		
		if(result > 0) {
			map.put("success", dto.getBoard_idx());
		}
		return map;
	}

	public HashMap<String, Object> boardDelete(int idx) {
		logger.info("boardDelete 서비스 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		inter = sqlSession.getMapper(BoardInter.class);
		int result = 0;
		result = inter.boardDelete(idx);
		
		if(result > 0) {
			map.put("success", result);
		}
		return map;
	}

	//게시판 댓글작성
	public HashMap<String, Object> boardReplyWrite(HashMap<String, String> params, HttpServletRequest request) {
		logger.info("boardReplyWrite 서비스 요청");
		inter = sqlSession.getMapper(BoardInter.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		BoardReplyDTO dto = new BoardReplyDTO();
		dto.setBoard_idx(Integer.parseInt(params.get("idx")));
		dto.setId(params.get("id"));
		dto.setBoardReply_content(params.get("boardReply_content"));
		
		String loginId = (String) request.getSession().getAttribute("loginId");
		logger.info("로그인 세션 체크 : {}", loginId);
		
		
		int replyCnt = inter.replyCnt(dto.getBoard_idx());
		logger.info("댓글 갯수 : {}", replyCnt);
		
		if(replyCnt > 0 || !loginId.equals("관리자")) {
			logger.info("댓글을 작성할 수 없습니다.");
			map.put("replyCnt", replyCnt);
			map.put("loginId", loginId);
		}else{
			int result = inter.boardReplyWrite(dto);
			if(result > 0 ) {
				map.put("success", result);
			}
		}
		
		return map;
	}

	
	
	//게시판 댓글리스트
	public HashMap<String, Object> boardReplyList(String idx) {
		logger.info("게시판 댓글리스트 서비스 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();
		inter = sqlSession.getMapper(BoardInter.class);
		
		ArrayList<BoardReplyDTO> list = inter.boardReplyList(Integer.parseInt(idx));
		logger.info("리스트 : {}", list);
		int replyCnt = inter.replyCnt(Integer.parseInt(idx));
		
		if(replyCnt > 0) {
			map.put("replyCnt", replyCnt);
		}
		logger.info("replyCnt : {}", replyCnt);
		map.put("list", list);
		
		return map;
	}

	//게시판 댓글 수정
	public HashMap<String, Object> boardReplyUpdate(HashMap<String, String> params) {
		logger.info("댓글 수정 서비스 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();
		BoardReplyDTO dto = new BoardReplyDTO();
		dto.setBoard_idx(Integer.parseInt(params.get("board_idx")));
		dto.setBoardReply_idx(Integer.parseInt(params.get("boardReply_idx")));
		dto.setBoardReply_content(params.get("boardReply_content"));
		
		inter = sqlSession.getMapper(BoardInter.class);
		
		int result = inter.boardReplyUpdate(dto);
		if(result > 0) {
			map.put("success", result);
		}
		
		
		return map;
	}

	//게시판 댓글 삭제
	public HashMap<String, Object> boardReplyDelete(HashMap<String, String> params) {
		logger.info("게시판 댓글 삭제 서비스 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int board_idx = Integer.parseInt(params.get("board_idx"));
		int boardReply_idx = Integer.parseInt(params.get("boardReply_idx"));
		
		inter = sqlSession.getMapper(BoardInter.class);
		int result = inter.boardReplyDelete(board_idx, boardReply_idx);
		logger.info("삭제 여부 : {}", result);
		
		
		if(result > 0) {
			map.put("success", result);
		}
		
		return map;
	}

}
