package com.naver.kin.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentVO {
	private long cno;
	private long bno;
	private String writer;
	private String content;
	private String regAt;
	private String modAt;
	
	// remove
		public CommentVO(long cno, long bno) {
			this.cno = cno;
			this.bno = bno;
		}
}
