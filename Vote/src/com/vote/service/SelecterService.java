package com.vote.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import com.vote.bean.Selecter;

public class SelecterService {
//	 根据题目顺序查找选项的值 返回一个结果集

	public List listSelecterBySeq(int seq, int oid) {
		DBConnection dbcon = null;
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		List selList=new LinkedList();
		String sql = "select qseq,selseq,content from wj_selecter where qseq = '"
				+ seq + "' and oid = '" + oid + "' order by selseq asc";
		 System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			stm=con.createStatement();
			rs=stm.executeQuery(sql);
			while(rs.next()){
				Selecter sel=new Selecter();
				int qseq=rs.getInt("qseq");
				int selseq=rs.getInt("selseq"); 
				String content=rs.getString("content");
				sel.setQseq(qseq);
				sel.setSelseq(selseq);
				sel.setContent(content);
				selList.add(sel);
			}
			return selList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			dbcon.closeAll(con,stm, rs);
		}
	}
//	 插入选项
	public int addSelecter(int oid, int seq, String content, int seq_selecter) {
		DBConnection dbcon = null;
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		String sql = "insert into wj_selecter(oid,qseq,content,selseq) values('"
				+ oid
				+ "','"
				+ seq
				+ "','"
				+ content
				+ "','"
				+ seq_selecter
				+ "')";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			stm=con.createStatement();
			int i = stm.executeUpdate(sql);
			return i;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			dbcon.closeAll(con,stm,rs);
		}
	}
	
//	 往选项表插入内容的时候先修改选项表中所属的题目的顺序号
	public int updateSelecterSeq(int oid, int qseq) {
		DBConnection dbcon = null;
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		String sql = "update wj_selecter set qseq=(qseq+1) where oid = '" + oid
				+ "'and qseq > '" + qseq + "'";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			stm=con.createStatement();
			int i = stm.executeUpdate(sql);
			return i;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				dbcon.closeAll(dbcon.getConnection());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
//	 传进来问卷编号和试题的顺序号 删除该题所对应的选项表中的数据
	public int deleteSelecter(int seq, int oid) {
		DBConnection dbcon = null;
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		String sql = "delete from wj_selecter where oid=" + oid + " and qseq="
				+ seq ;
		int count=0;
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			stm=con.createStatement();
			 count = stm.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			dbcon.closeAll(con, stm, rs);
		}
		return count;

	}
	

	// 根据传进来的问卷编号和题目的序号 修改选项表中题目的顺序
	public int updateSseq(int seq, int oid) {
		DBConnection dbcon = null;
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		int count=0;
		String sql = "update wj_selecter set qseq=(qseq-1) where oid = " + oid
				+ " and qseq > " + seq ;
		System.out.print(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			stm=con.createStatement();
			count = stm.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			dbcon.closeAll(con, stm, rs);
		}
		return count;
	}

}
