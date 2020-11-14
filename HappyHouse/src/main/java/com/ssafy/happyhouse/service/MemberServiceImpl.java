package com.ssafy.happyhouse.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dao.MemberDao;
import com.ssafy.happyhouse.dto.MemberDto;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberDao dao;
	
	@Override
	public MemberDto getPwd(String id, String name, String phone) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int join(MemberDto memberDto)  {
		// TODO Auto-generated method stub
		return dao.join(memberDto);
	}

	@Override
	public MemberDto login(String userid, String userpwd) {
		// TODO Auto-generated method stub
		if(userid == null || userpwd == null)
			return null; // DB가 일 할 필요가 없다.
		return dao.login(userid, userpwd);

	}

	@Override
	public int modifyInfo(MemberDto memberDto)  {
		// TODO Auto-generated method stub
		return dao.modifyInfo(memberDto);
	}

	@Override
	public MemberDto getInfo(String userid) {
		// TODO Auto-generated method stub
		return dao.getInfo(userid);
	}

	@Override
	public int delete(String userid)  {
		// TODO Auto-generated method stub
		return dao.delete(userid);
	}

	

}
