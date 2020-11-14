package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.dto.QnA;



public interface QnAService {
	public boolean writeQnA(QnA qna);
	public boolean deleteQnA(int no);
	List<QnA> retrieveQnA();
	public QnA detailQnA(int no);
	public boolean updateQnA(QnA qna);
}
