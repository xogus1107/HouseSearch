package com.ssafy.happyhouse.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HousePageBean;

@Repository
public class HouseDealDaoImpl implements HouseDealDao {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<HouseDeal> searchAll(int currentPage, int sizePerPage) {
		int start = (currentPage - 1) * sizePerPage;
		int last = (sizePerPage);
		HashMap<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("last", last);
		List<HouseDeal> list = sqlSession.selectList("AptMapper.searchAll", map);
		return list;
	}

	@Override
	public List<HouseDeal> search(int currentPage, int sizePerPage, HousePageBean bean) {
		// TODO Auto-generated method stub
		String dong = bean.getDong();
		String aptName = bean.getAptname();
		int start = (currentPage - 1) * sizePerPage;
		int last = (sizePerPage);
	//	System.out.println(dong+" "+aptName);
		//System.out.println(start+" "+last);
		HashMap map = new HashMap<>();
		map.put("start",start);
		map.put("last", last);
		List<HouseDeal> list=null;
		if (dong != null) {
			map.put("dong", dong);
			System.out.println(map.get("dong"));
			System.out.println(map.get("start"));
			list = sqlSession.selectList("AptMapper.searchDong", map);
		} else if (aptName != null) {
			map.put("aptName", aptName);
			list = sqlSession.selectList("AptMapper.searchAptName", map);
		}else {
			list = sqlSession.selectList("AptMapper.searchAll", map);
		}
		return list;
	}



	@Override
	public HouseDeal show(int no) {
		return sqlSession.selectOne("AptMapper.show", no);
	}

	@Override
	public int getTotalCount(HousePageBean bean) {
		// TODO Auto-generated method stub
		if (bean.getDong() != null) {
			String dong = bean.getDong();
			return sqlSession.selectOne("AptMapper.getTotalCountdong", dong);
		} else if (bean.getAptname() != null) {
			String aptName = bean.getAptname();
			return sqlSession.selectOne("AptMapper.getTotalCountname", aptName);
		} else {
			return sqlSession.selectOne("AptMapper.getTotalCount");

		}
	}

}
