package com.naver.kin;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.naver.kin.domain.BoardVO;
import com.naver.kin.repository.BoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.naver.kin.config.RootConfig.class})
public class BoardReposTest {

	@Inject
	private BoardDAO bdao;
	
	@Test
	public void insertBoardDummiesTest() throws Exception {
		for (int i = 1; i <= 256; i++) {
			BoardVO bvo = new BoardVO();
			bvo.setCategory("컴퓨터");
			bvo.setTitle("Board Title" + i);
			bvo.setWriter("tester" + i + "@tester.com");
			bvo.setDescription("This is Test");
			bdao.insert(bvo);
		}
	}
	
	@Test
	public void insertBoardTest() throws Exception {
		BoardVO bvo = new BoardVO();
		bvo.setCategory("컴퓨터");
		bvo.setTitle("test");
		bvo.setWriter("tester@tester.com");
		bvo.setDescription("This is Test");
		int isUp = bdao.insert(bvo);
		log.info(">>> Test of insert Board : {] ", isUp > 0 ? "OK" : "FAIL");
	}
}
