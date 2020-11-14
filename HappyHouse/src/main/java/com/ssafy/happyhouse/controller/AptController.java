package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xml.sax.SAXException;

import com.ssafy.happyhouse.dao.HouseInfoDao;
import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HouseInfo;
import com.ssafy.happyhouse.dto.HousePageBean;
import com.ssafy.happyhouse.dto.storeDto;
import com.ssafy.happyhouse.saxhandler.storeSaxHandler;
import com.ssafy.happyhouse.service.HouseDealService;
import com.ssafy.happyhouse.util.PageNavigation;

@Controller
public class AptController {
	@Autowired
	HouseDealService service;

	@Autowired
	HouseInfoDao houseDao;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String movemain() {
		return "index";
	}

	@RequestMapping(value = "/apt/mvsearch", method = RequestMethod.GET)
	public String mvlist() {
		return "apt/searchList";
	}
	
	@RequestMapping(value = "/apt/showaroud", method = RequestMethod.GET)
	public String showaround(Model model, String name, String lat, String lng) throws IOException, ParserConfigurationException, SAXException {
		System.out.println(name+" "+lat+" "+lng);
		model.addAttribute("aptName", name);
		model.addAttribute("houseLat", lat);
		model.addAttribute("houseLng", lng);
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B553077/api/open/sdsc"); /*URL*/
        urlBuilder.append("/storeListInRadius");
        urlBuilder.append("?radius=1000&cx="+lng.trim()+"&cy="+lat.trim());
        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=lNoPtBcIcBWWxw5tGa0XpCdCqhxDbpfnNAMGIU%2Fl5vHaoThtg5eRjBvmY0dsNxtaKJBfMu57eh5Z%2FQpqfvbD7A%3D%3D"); /*Service Key*/
        URL url = new URL(urlBuilder.toString());
     //   System.out.println(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
       
        storeSaxHandler handler = new storeSaxHandler();
        SAXParserFactory factory = SAXParserFactory.newInstance();
		SAXParser parser = factory.newSAXParser();
		parser.parse(conn.getInputStream(), handler);
		List<storeDto> list = handler.getStores();
		
	/*	for (storeDto storeDto : list) {
			System.out.println(storeDto.getindsLclsCd());
		}*/
		model.addAttribute("storeList", list);
		
		conn.disconnect();
		
		return "apt/showAround";
	}
	
	
	// 전체검색에 해당하는 부분
	@RequestMapping(value = "/apt/searchAll", method = RequestMethod.GET)
	public String searchAll(HttpServletRequest request, Model model, String reqPageNo) {

		int currentPage = Integer.parseInt(request.getParameter("pg")); // 현재페이지번호
	
		int sizePerPage=10;
		HousePageBean bean = new HousePageBean();
		bean.setDong("");
		bean.setAptname("");

		List<HouseDeal> list = service.searchAll(currentPage, sizePerPage);
		PageNavigation pageNavigation = service.makePageNavigation(currentPage, sizePerPage, bean);
		request.setAttribute("deals", list);
		request.setAttribute("navigation", pageNavigation);
		return "apt/searchList";
	}
	// 
	@RequestMapping(value = "apt/search", method = RequestMethod.GET)
	public String search(HttpServletRequest request, HttpServletResponse response) {
		
		String key = request.getParameter("key");
		String word = request.getParameter("word");
		int currentPage = Integer.parseInt(request.getParameter("pg")); // 현재페이지번호

		int sizePerPage = 10;
		HousePageBean bean = new HousePageBean();

		boolean[] searchType = { true, true, true, true };
		bean.setSearchType(searchType);
		if (key != null) {
			if (key.equals("dongname")) {
				bean.setDong(word);
			} else if (key.equals("aptname")) {
				bean.setAptname(word);
			}else{
				bean.setAptname("");
			}
		}

		List<HouseDeal> list = service.search(currentPage, sizePerPage, bean);

		PageNavigation pageNavigation = service.makePageNavigation(currentPage, sizePerPage, bean);
		request.setAttribute("deals", list);
		request.setAttribute("navigation", pageNavigation);
		request.setAttribute("key", key);
		request.setAttribute("word", word);
		
		if(!request.getParameter("word").equals("")) {
			List<HouseInfo> Infolist = new ArrayList<>();
			for (HouseDeal deal : list) {
				HouseInfo houseinfo = houseDao.searchAllHouseInfo(deal.getAptName());
				Infolist.add(houseinfo);
				System.out.println(houseinfo.getAptName());
			}
			request.setAttribute("infolist", Infolist);
		}
		return "apt/searchList";
	}

	@RequestMapping(value = "/apt/show", method = RequestMethod.GET)
	public String show(Model model, int no) {
		HouseInfo houseInfo = null;

		HouseDeal houseDeal = service.show(no);
		houseInfo = houseDao.searchAllHouseInfo(houseDeal.getAptName());
		model.addAttribute("deal", houseDeal);
		model.addAttribute("houseinfo", houseInfo);
		return "apt/showApt";
	}
	
	@RequestMapping(value = "/apt/json", method = RequestMethod.GET)
	@ResponseBody
	public List<String> auto(HttpServletRequest request) {
		return houseDao.auto(request.getParameter("term"));
	}
	
}
