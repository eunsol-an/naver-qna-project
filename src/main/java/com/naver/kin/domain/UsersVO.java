package com.naver.kin.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UsersVO {
	private String email;
	private String pwd;
	private String nickName;
	private int grade;
	private String regAt;
}
