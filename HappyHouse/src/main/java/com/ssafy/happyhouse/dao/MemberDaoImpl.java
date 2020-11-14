package com.ssafy.happyhouse.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.dto.MemberDto;
@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public MemberDto getPwd(String id, String name, String phone) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int join(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("UserMapper.insert", memberDto);
	}

	@Override
	public MemberDto login(String userid, String userpwd) {
		// TODO Auto-generated method stub
		Map<String,String> map = new HashMap<String, String>();
		map.put("param1", userid);
		map.put("param2", userpwd);
		return sqlSession.selectOne("UserMapper.login", map);
	}

	@Override
	public int modifyInfo(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return sqlSession.update("UserMapper.modify", memberDto);
	}

	@Override
	public MemberDto getInfo(String userid)  {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.getInfo", userid);
	}

	@Override
	public int delete(String userid)  {
		// TODO Auto-generated method stub
		return sqlSession.delete("UserMapper.delete", userid);
	}

}
