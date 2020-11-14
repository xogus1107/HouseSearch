package com.ssafy.happyhouse.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dao.HouseDealDao;
import com.ssafy.happyhouse.dao.HouseDealDaoImpl;
import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HousePageBean;
import com.ssafy.happyhouse.util.PageNavigation;

@Service
public class HouseDealServiceImpl implements HouseDealService {

	@Autowired
	HouseDealDao dao;

	@Override
	public List<HouseDeal> searchAll(int currentPage, int sizePerPage) {
		return dao.searchAll(currentPage, sizePerPage);
	}

	public List<HouseDeal> search(int currentPage, int sizePerPage, HousePageBean bean) {

		return dao.search(currentPage, sizePerPage, bean);

	}



	@Override
	public HouseDeal show(int no) {
		return dao.show(no);
	}

	public PageNavigation makePageNavigation(int currentPage, int sizePerPage, HousePageBean bean) {
		// TODO Auto-generated method stub
		PageNavigation pageNavigation = new PageNavigation();
		int naviSize = 10; // 페이지 개수
		pageNavigation.setCurrentPage(currentPage);
		pageNavigation.setNaviSize(naviSize);
		int totalCount = dao.getTotalCount(bean); // 총 게시글
		System.out.println(totalCount);
		pageNavigation.setTotalCount(totalCount);
		int totalPageCount = (totalCount - 1) / sizePerPage + 1; // 총 페이지 수
		pageNavigation.setTotalPageCount(totalPageCount);
		boolean startRange = currentPage <= naviSize; // startRange true : 이전 X false : 이전 누를 수 O
		pageNavigation.setStartRange(startRange);
		boolean endRange = (totalPageCount - 1) / naviSize * naviSize < currentPage; // endRange true : 다음 X false : 다음
																						// O
		pageNavigation.setEndRange(endRange);
		pageNavigation.makeNavigator();
		return pageNavigation;
	}

}
