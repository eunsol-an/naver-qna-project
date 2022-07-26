package com.naver.kin;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.naver.kin.domain.CommentVO;
import com.naver.kin.service.CommentService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { com.naver.kin.config.RootConfig.class })
public class CommentSvcTest {

	@Inject
	private CommentService csv;

	@Test
	public void insertCommentDummiesTest() throws Exception {
		for (int j = 1; j <= 256; j++) {
			int x = (int) (Math.random() * 256);
			for (int i = 0; i < x; i++) {
				CommentVO cvo = new CommentVO();
				cvo.setBno(j);
				cvo.setWriter("tester" + ((int) (Math.random() * 256)) + "@tester.com");
				cvo.setContent("Comment Dummy Content for" + j);
				csv.post(cvo);
			}
		}
	}
}
