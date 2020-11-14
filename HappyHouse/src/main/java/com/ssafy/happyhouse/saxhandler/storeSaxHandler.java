package com.ssafy.happyhouse.saxhandler;

import java.util.LinkedList;
import java.util.List;

import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;

import com.ssafy.happyhouse.dto.storeDto;

public class storeSaxHandler extends DefaultHandler{
	public static int no;
	private List<storeDto> stores;
	
	private storeDto store;
	
	private String temp;
	
	public storeSaxHandler() {
		stores = new LinkedList<storeDto>();
	}
	
	public void startElement(String uri, String localName, String qName, Attributes att0) {
		if(qName.contentEquals("item")) {
			store = new storeDto(no++);
			stores.add(store);
		}
	}
	
	public void characters(char[]ch, int start, int length){
		temp = new String(ch, start, length);
	}
	
//	private String no;
//	private String bizesNm; //상호명
//	private String rdnmAdr; //주소
//	private String indsLclsNm; // 업종 대분류명
//	private String indsMclsCd; // 업종 대분류코드
//	private String lng ; // 경도
//	private String lat; //위도
	
	public void endElement(String uri, String localName, String qName){
		if(qName.equals("bizesNm")) {
			store.setBizesNm(temp);
		}else if(qName.equals("rdnmAdr")) {
			store.setRdnmAdr(temp);
		}else if(qName.equals("indsLclsNm")) {
			store.setIndsLclsNm(temp);
		}else if(qName.equals("indsLclsCd")) {
			store.setindsLclsCd(temp);;
		}else if(qName.equals("lon")) {
			store.setLng(temp);
		}else if(qName.equals("lat")) {
			store.setLat(temp);
		}
	
	}
	
	public List<storeDto> getStores(){
		return stores;
	}
	public void setStores(List<storeDto> stores) {
		this.stores = stores;
	}
}
