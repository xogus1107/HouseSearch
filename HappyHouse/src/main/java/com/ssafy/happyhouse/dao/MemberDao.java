package com.ssafy.happyhouse.dao;

import java.sql.SQLException;

import com.ssafy.happyhouse.dto.MemberDto;

public interface MemberDao {
	public MemberDto getPwd(String id, String name, String phone) ;
	public int join(MemberDto memberDto);
	public MemberDto login(String userid, String userpwd);
	public int modifyInfo(MemberDto memberDto) ;
	public MemberDto getInfo(String userid) ;
	public int delete(String userid) ;
}
