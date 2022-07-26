package com.naver.kin.repository;

import java.util.List;

import com.naver.kin.domain.PagingVO;
import com.naver.kin.domain.UsersVO;

public interface UsersDAO {
	int insert(UsersVO uvo);
	UsersVO selectOne(UsersVO uvo);
	List<UsersVO> selectList(PagingVO pgvo);
	UsersVO selectDetail(String email);
	int update(UsersVO uvo);
	int delete(String email);
	int selectEmail(String email);
	int selectTotalCount(PagingVO pgvo);
}
