package com.ssafy.happyhouse.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.QnA;

@Repository
public class QnADAOImpl implements QnADAO {

	@Autowired
	SqlSession sqlSession;
	
	
	@Override
	public List<QnA> selectQnA() {
		// TODO Auto-generated method stub
		List<QnA> list = sqlSession.selectList("QnA.selectQnA");
	
		return list;
	}


	@Override
	public boolean writeQnA(QnA qna) {
		// TODO Auto-generated method stub
		int t= sqlSession.insert("QnA.insertQnA", qna);
		if(t==1) return true;
		else return false;
	}


	@Override
	public QnA detailQnA(int no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("QnA.detailQnA", no);
	}


	@Override
	public boolean deleteQnA(int no) {
		// TODO Auto-generated method stub
		int t = sqlSession.delete("QnA.deleteQnA", no);
		if(t==1) return true;
		else return false;
	}


	@Override
	public boolean updateQnA(QnA qna) {
		// TODO Auto-generated method stub
		int t = sqlSession.update("QnA.updateQnA", qna);
		if(t==1) return true;
		else return false;
	}

}
