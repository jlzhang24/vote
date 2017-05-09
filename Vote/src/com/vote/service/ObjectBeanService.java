package com.vote.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import com.vote.bean.ObjectBean;

public class ObjectBeanService {
	// 新建问卷
	public static int intsertObjectBean(ObjectBean bean) throws Exception {
		DBConnection db = new DBConnection();
		Connection con=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		String sql = "";
		int id = 0;
		try {
			con = db.getConnection();
			sql = "insert into wj_object(title,discribe,createtime,state,remark,anonymousFlag) values(?,?,?,?,?,?)";
			System.out.println(sql);
			stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, bean.getTitle());
			stmt.setString(2, bean.getDiscribe());
			stmt.setTimestamp(3, currentTime);
			stmt.setInt(4, bean.getState());
			stmt.setString(5, bean.getRemark());
			stmt.setString(6, bean.getAnonymousFlag());
			
			stmt.executeUpdate();
			rs = stmt.getGeneratedKeys();
			if(rs.next()) id = rs.getInt(1);
			System.out.println("id:"+id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.closeAll(con, stmt,rs);
		}
		return id;
	}

	// 修改问卷
	public static int updateObjectBean(ObjectBean bean) {
		DBConnection dbcon = new DBConnection();
		String sql1 = "update wj_object set title = '" + bean.getTitle()
				+ "',discribe = '" + bean.getDiscribe() + "',anonymousFlag = '" + bean.getAnonymousFlag() + "'" +
				" where oid="+ bean.getOid();
		try {
			int i = dbcon.update(sql1, dbcon.getConnection());
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
	
	// 删除问卷
	public static boolean delObjectBean(int oid) throws Exception {
		DBConnection dbcon = new DBConnection();
		boolean flag = false;
		Connection conn = dbcon.getConnection();
		conn.setAutoCommit(false);
		String sql1 = "delete from wj_object where oid="+oid;
		String sql2 = "delete from wj_question where oid="+oid;
		String sql3 = "delete from wj_replay where oid="+oid;
		String sql4 = "delete from wj_answer where oid="+oid;
		String sql5 = "delete from wj_selecter where oid="+oid;
		try {
			dbcon.update(sql1, conn);
			dbcon.update(sql2, conn);
			dbcon.update(sql3, conn);
			dbcon.update(sql4, conn);
			dbcon.update(sql5, conn);
			conn.commit();
			flag = true;
		} catch (Exception e) {
			conn.rollback();
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
				dbcon.closeAll(conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return flag;
	}

	public static ObjectBean getObjectBean(int oid) {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		ObjectBean ob = null;
		int result = 0;
		try {
			con = dbcon.getConnection();
			stm = con.createStatement();
			String sql = " select * from wj_object where oid=" + oid;
			System.out.println(sql);
			rs = stm.executeQuery(sql);
			while (rs.next()) {
				String title = rs.getString("title");
				ob = new ObjectBean();
				ob.setOid(oid);
				ob.setTitle(title);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, stm, rs);
		}
		return ob;
	}
    
	//	 查看问卷;
	public static List ListObjectBean() {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		List objList=new LinkedList();
		try {
			String sql = "select oid,title,createtime,state from wj_object order by oid desc";
			con=dbcon.getConnection();
			stm=con.createStatement();
			rs = stm.executeQuery(sql);
			while(rs.next()){
				ObjectBean ob=new ObjectBean();
				int oid=rs.getInt("oid");
				String title=rs.getString("title");
				java.sql.Timestamp createtime=rs.getTimestamp("createtime");
				int state=rs.getInt("state");
				ob.setOid(oid);
				ob.setTitle(title);
				ob.setCreateTime(createtime);
				ob.setState(state);
				
				objList.add(ob);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
				dbcon.closeAll(con,stm,rs);
		}
		return objList;
	}

	// 根据编号查找标题和内容
	public static ObjectBean findObjectBeanByID(int ID) {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		ObjectBean ob=new ObjectBean();
		
		try {
			String sql = "select oid,title,discribe,state,anonymousFlag from wj_object where oid='" + ID
			+ "'";
			con=dbcon.getConnection();
			stm=con.createStatement();
			 rs = stm.executeQuery(sql);
			 while(rs.next()){
		     int oid = rs.getInt("oid");
			 String title = rs.getString("title");
			 String discribe = rs.getString("discribe");
			 String anonymousFlag = rs.getString("anonymousFlag");
			 int state=rs.getInt("state");
			 ob.setOid(oid);
			 ob.setState(state);
			 ob.setTitle(title);
			 ob.setDiscribe(discribe);
			 ob.setAnonymousFlag(anonymousFlag);
			 }
			
			return ob;
		} catch (Exception e) {
		
			e.printStackTrace();
			return null;
		} finally {
			dbcon.closeAll(con,stm,rs);
		}

	}
	
	
	/**
	 * 查找发布后的问卷
	 * @param ID
	 * @return
	 */
	public static ObjectBean findPublishedObjectBeanByID(int ID) {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		ObjectBean ob=new ObjectBean();
		
		try {
			String sql = "select oid,title,discribe,state,anonymousFlag from wj_object where oid='" + ID
			+ "' and state in(1,2)";
			System.out.println("查询发布后的主题： "+sql);
			con=dbcon.getConnection();
			stm=con.createStatement();
			 rs = stm.executeQuery(sql);
			 while(rs.next()){
		     int oid = rs.getInt("oid");
			 String title = rs.getString("title");
			 String discribe = rs.getString("discribe");
			 String anonymousFlag = rs.getString("anonymousFlag");
			 int state=rs.getInt("state");
			 ob.setOid(oid);
			 ob.setState(state);
			 ob.setTitle(title);
			 ob.setDiscribe(discribe);
			 ob.setAnonymousFlag(anonymousFlag);
			 }
			
			return ob;
		} catch (Exception e) {
		
			e.printStackTrace();
			return null;
		} finally {
			dbcon.closeAll(con,stm,rs);
		}

	}

	
    //查找问卷一共几条数据
	public static int getCount(int oid) {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		int count=0;
		String sql = "select count(*) from wj_question where oid = '" + oid	+ "'";
		try {
			con=dbcon.getConnection();
			stm=con.createStatement();
			 rs = stm.executeQuery(sql);
			while(rs.next()){
				count=rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, stm, rs);
		}
		return count;
	}
}
