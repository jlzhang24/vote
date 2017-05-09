package com.vote.service;

import java.security.MessageDigest;

public class MD5Util {

	/**
	 * 密码加密
	 * @param inStr
	 * @return
	 * @throws Exception
	 */
	public static String MD5Encrypt(String inStr) throws Exception {
		MessageDigest md = MessageDigest.getInstance("MD5"); // 可以选中其他的算法如SHA
		byte[] digest = md.digest(inStr.getBytes()); // 返回的是byet[]，要转化为String存储比较方便
		String outStr = byteToString(digest);
		return outStr;
	}

	/**
	 * byteToString
	 * @param digest
	 * @return
	 * @throws Exception
	 */
	private static String byteToString(byte[] digest) throws Exception {
		String str = "";
		String tempStr = "";
		StringBuffer sb = new StringBuffer("");
		for (int i = 1; i < digest.length; i++) {
			tempStr = (Integer.toHexString(digest[i] & 0xff));
			if (tempStr.length() == 1) {
				sb.append("0");
				sb.append(tempStr);
			} else {
				sb.append(tempStr);
			}
		}
		str = sb.toString().toUpperCase();
		return str;
	}
}
