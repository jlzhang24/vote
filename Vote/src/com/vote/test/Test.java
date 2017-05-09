package com.vote.test;

import com.vote.service.MD5Util;

public class Test {

	public static void main(String[] args) {
		try {
			System.out.println(MD5Util.MD5Encrypt("jiaowuchudata"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
