package com.kh.cat.board.dao;

import java.util.ArrayList;

import com.kh.cat.dto.BoardDTO;
import com.kh.cat.dto.BoardReplyDTO;

public interface BoardInter {

	BoardDTO boardDetail(String idx);

	int boardWrite(BoardDTO dto);

	int boardUpdate(BoardDTO dto);

	int boardDelete(int idx);

	ArrayList<BoardDTO> boardList(int start, int end);//게시물(문의사항) 리스트

	int boardReplyWrite(BoardReplyDTO dto);//게시판 댓글작성

	ArrayList<BoardReplyDTO> boardReplyList(int i);//게시판 댓글 리스트

	int replyCnt(int board_idx);//게시판 댓글 수

	int boardReplyUpdate(BoardReplyDTO dto);//게시판 댓글 수정

	int boardReplyDelete(int board_idx, int boardReply_idx);//게시판 댓글 삭제

	int boardAllCnt();//페이징을 위한 총 게시물 수

	ArrayList<BoardDTO> boardList2();// 공지사항 리스트

}
