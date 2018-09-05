package com.kh.cat.member.dao;

import com.kh.cat.dto.MemberDTO;

public interface MemberInter {

	String login(String id, String hash); //로그인

	int join(MemberDTO dto);//회원가입. 

	MemberDTO profileimg(String id);

	MemberDTO profileunder(String id);	

	String overlay(String id); //ID 중복체크
	
	String overlayMail(String email); //Email 중복체크

	String getprofile(String id); //프로필 가져오기

	MemberDTO userdetail(String id);

	String getPw(String id); //암호화된 비밀번호 가져오기

	String idSearchPage(String name, String email);//ID 찾기

	String pw(String id, String name, String email);//비밀번호 조회

	int pwChange(String id, String hash);

	int leave(String id);//회원 탈퇴

	int userupdate(MemberDTO dto);

	int userpwupdate(MemberDTO dto);

	String getaut(String id); //권한 가져오기

	String getemail(String email); //이메일 가져오기

}
