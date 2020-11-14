package com.ssafy.happyhouse.dao;

import java.util.List;

import com.ssafy.happyhouse.dto.QnA;

public interface QnADAO {
	List<QnA> selectQnA();
	public boolean writeQnA(QnA qna);
	public QnA detailQnA(int no);
	public boolean deleteQnA(int no);
	public boolean updateQnA(QnA qna);
}
