package com.ssafy.happyhouse.dao;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HousePageBean;

public interface HouseDealDao {
	public List<HouseDeal> searchAll(int currentPage, int sizePerPage);
	public HouseDeal show(int no);
	public int getTotalCount(HousePageBean bean) ;
	public List<HouseDeal> search(int currentPage, int sizePerPage,HousePageBean  bean) ;
	
}
