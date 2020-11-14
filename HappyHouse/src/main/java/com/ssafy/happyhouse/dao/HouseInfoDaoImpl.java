package com.ssafy.happyhouse.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.dto.HouseInfo;

@Repository
public class HouseInfoDaoImpl implements HouseInfoDao {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public HouseInfo searchAllHouseInfo(String Aptname){
		List<HouseInfo> list= sqlSession.selectList("AptMapper.getInfo", Aptname);
		return list.get(0);
	}
	
	@Override
	public List<String> auto(String term) {
		return sqlSession.selectList("AptMapper.auto", term);
	}
}
