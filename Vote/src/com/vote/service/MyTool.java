package com.vote.service;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.NumberFormat;

public class MyTool {
	public int UpdateCol(String table, String col1, String val1, String col2,
			String val2) throws Exception {
		DBConnection db = null;
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		int result = 0;
		try {
			db = new DBConnection();
			con = db.getConnection();
			sql.append("update ");
			sql.append(table);
			sql.append(" set ");
			sql.append(col1);
			sql.append(" ='");
			sql.append(val1);
			sql.append("' where " + col2 + "='");
			sql.append(val2);
			sql.append("'");
			System.out.println(sql.toString());
			stm = con.createStatement();
			result = stm.executeUpdate(sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.closeAll(con, stm, rs);
		}
		return result;

	}

	public String getCo2(String table, String col1, String where)
			throws Exception {
		DBConnection db = null;
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		String val1 = "";
		try {
			db = new DBConnection();
			con = db.getConnection();
			sql.append("select ");
			sql.append(col1);
			sql.append(" from ");
			sql.append(table);
			sql.append(where);
			System.out.println(sql.toString());
			stm = con.createStatement();
			rs = stm.executeQuery(sql.toString());
			while (rs.next()) {
				val1 = rs.getString(col1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.closeAll(con, stm, rs);
		}
		return val1;

	}

	public static String replaceAll(String ystr, String yt, String t) {
		String s = "";
		int b = 0;
		int e = 0;
		int c = ystr.length();
		e = ystr.indexOf(yt);
		while (e != -1) {
			s += ystr.substring(0, e);
			if (e != -1) {
				s += t;
			}
			b = e + yt.length();
			ystr = ystr.substring(b, c);
			e = ystr.indexOf(yt);
			c = ystr.length();
		}
		s += ystr.substring(0, c);
		return s;
	}

	/**
	 * 百分比计算
	 * @param p1
	 * @param p2
	 * @return
	 */
	public static String percent(double p1, double p2) {
		String str;
		double p3 =0;
		if(p2==0.0d)
			p3=0;
		else
			p3=p1 / p2;
		NumberFormat nf = NumberFormat.getPercentInstance();
		nf.setMinimumFractionDigits(0);//控制小数点位数
		str = nf.format(p3);
		return str;
	}
	
	/**
	 * 除法取整
	 * @param p1
	 * @param p2
	 * @return
	 */
	public static double division(double p1, double p2) {
		double r = 0;
		double p3 =0;
		if(p2==0.0d)
			p3=0;
		else
			p3=p1 / p2;
		BigDecimal bd = new BigDecimal(p3*100);
	    bd = bd.setScale(0, BigDecimal.ROUND_HALF_UP);//四舍五入处理
	    r = bd.doubleValue();
		return r;
	}

	public static void main(String[] arg) {
		String s = new MyTool().percent(0,0);
		System.out.println(s);
	}
}
