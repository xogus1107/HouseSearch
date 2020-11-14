package com.ssafy.happyhouse.dao;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.dto.HouseInfo;

public interface HouseInfoDao {

	/**HouseInfo DB에 위도 경도 입력하기 위해서  등록된 모든 집의 동과 지번을 추출한다.  */
	public HouseInfo searchAllHouseInfo(String Aptname);
	public List<String> auto(String term);
}
