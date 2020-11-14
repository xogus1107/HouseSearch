package com.ssafy.happyhouse.dto;

public class storeDto {
	private String no;
	private String bizesNm; //상호명
	private String rdnmAdr; //주소
	private String indsLclsNm; // 업종 대분류명
	private String indsLclsCd; // 업종 대분류코드
	private String lng ; // 경도
	private String lat; //위도
	
	public storeDto() {};
	@Override
	public String toString() {
		return "storeDto [no=" + no + ", bizesNm=" + bizesNm + ", rdnmAdr=" + rdnmAdr + ", indsLclsNm=" + indsLclsNm
				+ ", indsLclsCd=" + indsLclsCd + ", lng=" + lng + ", lat=" + lat + "]";
	}
	public storeDto(String no, String bizesNm, String rdnmAdr, String indsLclsNm, String indsLclsCd, String lng,
			String lat) {
		super();
		this.no = no;
		this.bizesNm = bizesNm;
		this.rdnmAdr = rdnmAdr;
		this.indsLclsNm = indsLclsNm;
		this.indsLclsCd = indsLclsCd;
		this.lng = lng;
		this.lat = lat;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getBizesNm() {
		return bizesNm;
	}
	public void setBizesNm(String bizesNm) {
		this.bizesNm = bizesNm;
	}
	public String getRdnmAdr() {
		return rdnmAdr;
	}
	public void setRdnmAdr(String rdnmAdr) {
		this.rdnmAdr = rdnmAdr;
	}
	public String getIndsLclsNm() {
		return indsLclsNm;
	}
	public void setIndsLclsNm(String indsLclsNm) {
		this.indsLclsNm = indsLclsNm;
	}
	public String getindsLclsCd() {
		return indsLclsCd;
	}
	public void setindsLclsCd(String indsLclsCd) {
		this.indsLclsCd = indsLclsCd;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public storeDto(int no) {
		this.no = ""+no;
	}

}
