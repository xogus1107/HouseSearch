package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dao.QnADAO;
import com.ssafy.happyhouse.dto.QnA;

@Service
public class QnAServiceImpl implements QnAService {

	@Autowired
	private QnADAO dao;
	
	@Override
	public List<QnA> retrieveQnA() {
		// TODO Auto-generated method stub
		return dao.selectQnA();
	}

	@Override
	public boolean writeQnA(QnA qna) {
		// TODO Auto-generated method stub
		return dao.writeQnA(qna);
	}

	@Override
	public QnA detailQnA(int no) {
		// TODO Auto-generated method stub
		return dao.detailQnA(no);
	}

	@Override
	public boolean deleteQnA(int no) {
		// TODO Auto-generated method stub
		return dao.deleteQnA(no);
	}

	@Override
	public boolean updateQnA(QnA qna) {
		// TODO Auto-generated method stub
		return dao.updateQnA(qna);
	}

}
