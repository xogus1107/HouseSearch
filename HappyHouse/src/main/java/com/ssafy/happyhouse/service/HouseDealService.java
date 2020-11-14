package com.ssafy.happyhouse.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HousePageBean;
import com.ssafy.happyhouse.util.PageNavigation;


public interface HouseDealService {
	public List<HouseDeal> searchAll(int currentPage, int sizePerPage) ;
	public List<HouseDeal> search(int currentPage, int sizePerPage, HousePageBean bean);

	public HouseDeal show(int no);
	public PageNavigation makePageNavigation(int pg, int sizePerPage, HousePageBean bean) ;
	
}
