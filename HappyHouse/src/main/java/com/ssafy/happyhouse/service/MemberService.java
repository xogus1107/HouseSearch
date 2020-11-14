package com.ssafy.happyhouse.service;

import java.sql.SQLException;

import com.ssafy.happyhouse.dto.MemberDto;

public interface MemberService {
	public MemberDto getPwd(String id, String name, String phone);
	public int join(MemberDto memberDto) ;
	public MemberDto login(String userid, String userpwd) ;
	public int modifyInfo(MemberDto memberDto) ;
	public MemberDto getInfo(String userid) ;
	public int delete(String userid) ;
}
