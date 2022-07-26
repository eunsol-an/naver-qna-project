package com.naver.kin;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.naver.kin.domain.PagingVO;
import com.naver.kin.domain.UsersVO;
import com.naver.kin.repository.UsersDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.naver.kin.config.RootConfig.class})
public class UsersReposTest {
	private static Logger log = LoggerFactory.getLogger(UsersReposTest.class);
	
	@Inject
	private UsersDAO udao;
	
	@Test
	public void deleteUsersTest() throws Exception {
		int isUp = udao.delete("tester@tester.com");
		log.info(">>> Test of delete Users : {} ", isUp > 0 ? "OK" : "FAIL");
	}
	
	@Test
	public void updateUsersTest() throws Exception {
		UsersVO uvo = new UsersVO();
		uvo.setEmail("tester@tester.com");
		uvo.setPwd("2222");
		uvo.setNickName("tester2");
		int isUp = udao.update(uvo);
		log.info(">>> Test of update Users : {} ", isUp > 0 ? "OK" : "FAIL");
	}
	
	@Test
	public void loginUsersTest() throws Exception {
		UsersVO uvo = new UsersVO();
		uvo.setEmail("tester@tester.com");
		uvo.setPwd("1111");
		UsersVO loginUser = udao.selectOne(uvo);
		log.info(">>> {} ", loginUser);
	}
	
	@Test
	public void getDetailUsersTest() throws Exception {
		UsersVO uvo = udao.selectDetail("tester@tester.com");
		log.info(">>> {} ", uvo);
	}
	
	@Test
	public void getListUsersTest() throws Exception {
		List<UsersVO> list = udao.selectList(new PagingVO());
		for (UsersVO uvo : list) {
			log.info(">>> {} ", uvo);
		}
	}
	
	@Test
	public void insertUsersDummies100() throws Exception {
		for (int i = 1; i <= 100; i++) {
			UsersVO uvo = new UsersVO();
			uvo.setEmail("tester" + i + "@tester.com");
			uvo.setPwd("1111");
			uvo.setNickName("tester" + i);
			udao.insert(uvo);
		}
	}
	
	@Test
	public void insertUserTest() throws Exception {
		UsersVO uvo = new UsersVO();
		uvo.setEmail("tester@tester.com");
		uvo.setPwd("1111");
		uvo.setNickName("tester1");
		int isUp = udao.insert(uvo);
		log.info(">>> Test of insert Users : {} ", isUp > 0 ? "OK" : "FAIL");
	}
}
