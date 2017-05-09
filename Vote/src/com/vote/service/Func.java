package com.vote.service;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

public class Func {
	
	/**
	 * 格式化样式
	 */
	private static String formatPattern = "yyyy-MM-dd";
	
	private static SimpleDateFormat formatDate = new SimpleDateFormat(formatPattern);
	
	/**
	 * 格式化日期 将字符串转换为日期
	 * @param datestr 日期字符串
	 * @return 格式化后的日期
	 */
	public static Date formatDate(String datestr){
		Date date = null;
		try {
			date = formatDate.parse(datestr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	
	/**
	 * 将日期格式化为yyyy-MM-dd格式的字符串
	 * @param date 日期
	 * @return yyyy-MM-dd格式的字符串
	 */
	public static String formatString(Date date){
		String datestr = null;
		datestr = formatDate.format(date);
		return datestr;
	}
	
	/**
	   * 获取当前日期
	   * @param format 格式化模板
	   * @return 格式化之后的日期字符串
	   */
	  public static String getCurrDate(String format)
	  {
	    SimpleDateFormat sdfDate = new SimpleDateFormat(format);
	    return sdfDate.format(Calendar.getInstance().getTime());
	  }
	  
	  /**
	   * 获取当前日期
	   * @return 当前日期字符串
	   */
	  public static String getCurrDate()
	  {
	    SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy年MM年dd日");
	    return sdfDate.format(Calendar.getInstance().getTime());
	  }
	  
	  /**
	   * 获取当前年份
	   * @return 当前年份字符串
	   */
	  public static String getCurrYear()
	  {
	    SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy");
	    return sdfDate.format(Calendar.getInstance().getTime());
	  }
	
	  /**
	   * 如果传入的字符串参数为null或者""，那么返回" "，否则返回传入的字符串
	   * @param s 传入的字符串
	   * @return 处理后字符串
	   * @throws Exception
	   */
	   public static String getBlankSpaceString(String s) 
	   {
	     if(s==null)
	       return " ";
	     else if(s.equals(""))
	       return " ";
	     else
	       return s;
	   }  
	  
	  /**
	   * 如果传入的字符串参数为null，那么返回""，否则返回传入的字符串
	   * @param o 传入的字符串对象
	   * @return String
	   * @throws Exception
	   */
	   public static String getString(Object o) 
	   {
	     if(o==null)
	       return "";
	     else
	       return String.valueOf(o);
	   }
	   
	   /**
	    * 如果传入的数字参数为0，那么返回""，否则返回传入的数字
	    * @param d
	    * @return
	    */
	   public static String getString(Double d) 
	   {
	     if(d==0)
	       return "";
	     else if(String.valueOf(d).indexOf(".0")>-1)
	     {
	    	 return String.valueOf(d).substring(0,String.valueOf(d).indexOf(".0"));
	     }
	     else
	       return String.valueOf(d);
	   }
	   
	   /**
	    * 将字符串数组解析成[ 'a','b' ]返回，若字符串数组的长度为0，那么返回""
	    * @param a
	    * @return [ 'a','b' ]形式的字符串
	    */
	   public static String arrayToSqlIn(String[] a) 
	   {
	     String sR = "";
	     if(a.length==0)
	       sR = "";
	     else
	     {
	       for(int i=0;i<a.length;i++)
	       {
	         sR += "'" + a[i]+"',";
	       }
	       sR = sR.substring(0, sR.length()-1);
	     }
	     
	     return sR;
	   }  
	   
	   /**
	    * 将整数数组解析成[ a,b ]返回，若数组的长度为0，那么返回""
	    * @param a
	    * @return
	    */
	   public static String arrayToSqlIn(int[] a) 
	   {
	     String sR = "";
	     if(a.length==0)
	       sR = "";
	     else
	     {
	       for(int i=0;i<a.length;i++)
	       {
	         sR += a[i]+",";
	       }
	       sR = sR.substring(0, sR.length()-1);
	     }
	     return sR;
	   } 
	   
	   /**
	    * 获取固定长度的自增长序号
	    * @param curr 当前已使用的序号数值
	    * @param digit 长度
	    * @return 自增长序号
	    * @throws Exception
	    */
	   public static String getNewIndex(long curr, int digit) throws Exception
	   {
	     long idx = curr + 1;
	     long s = 1;
	     for (int i = 0; i < digit; i++)
	       s = s * 10;
	     if(idx>=s)
	       throw new Exception("自增长的顺序号超出范围["+s+"]");
	     
	     String sIdx = String.valueOf(s + idx).substring(1);

	     return sIdx;
	   }
	   
	   /**
	    * 判断日期合法性
	    * @param dateStr 日期字符串 8位数字(yyyyMMdd)
	    * @return 如果是正确的日期返回true，否则返回false
	    */
	   public  static boolean checkDate(String dateStr) throws Exception
	   {
	     if(!isFixLengthNum(dateStr,8)) return false;
	     dateStr = dateStr.substring(0, 4)+"-"+dateStr.substring(4, 6)+"-"+dateStr.substring(6, 8);
	     DateFormat df = DateFormat.getDateInstance();
	     df.setLenient(false);
	     try
	     {
	       Date date = df.parse(dateStr);
	       return (date != null);
	     }
	     catch (Exception e)
	     {
	       return false;
	     }
	   }
	   
	   /**
	    * 计算字符串长度 一个中文字符的长度为2
	    * @param str 字符串
	    * @return 字符串长度
	    * @throws Exception
	    */
	   public static int getStringLength(String str) throws Exception
	   {
	     String s = getString(str);
	     int length = 0;
	     length = s.getBytes("GBK").length;
	     return length;
	   }
	   
	   /**
	    * 字符串是否是固定长度的数字
	    * @param str 字符串
	    * @param length 长度
	    * @return 如果是返回true 否则返回false
	    * @throws Exception
	    */
	   public static boolean isFixLengthNum(String str,int length) throws Exception
	   {
	     String regexNum = "\\d{"+length+"}"; // 比较用正则表达式
	     Pattern patternNum = Pattern.compile(regexNum); // 格式化比较规则
	     Matcher isNum = patternNum.matcher(str);
	     return isNum.matches();
	   }
	   
	  
	  /**
	   * 将java.util.date转换为java.sql.date
	   * @param date java.util.date
	   * @return 转换后的java.sql.date
	   */
	  public static java.sql.Date toSQLDate(Date date) 
	  {
	    if(date==null) return null;
	    java.sql.Date sqlDate = null;
	    try
	    {
	      sqlDate = new java.sql.Date(date.getTime());
	    }
	    catch(Exception ex)
	    {
	      ;
	    }
	    return sqlDate;
	  }
	  
	  /**
	   * 计算2个日期之间间隔的年数
	   * @param startDate 日期1
	   * @param endDate 日期2
	   * @return 间隔的年数
	   * @throws Exception
	   */
	  public static long getYearsBetween(Date startDate,Date endDate) throws Exception
	  {
	    if(startDate == null || endDate == null) return 0;
	    long years = 0;
	    long passtime = endDate.getTime() - startDate.getTime();
	    years = passtime / (24 * 60 * 60 * 1000)/365;
	    return years;
	  }
	  
	  /**
	   * 保留小数
	   * @param value 数值
	   * @param scale 小数位数
	   * @return 四舍五入后的结果值
	   * @throws Exception
	   */
	  public static double changeDecimal(double value, int scale) throws Exception
	  {
	    if(scale < 0)
	    {
	      throw new IllegalArgumentException("The scale must be a positive integer or zero");
	    }
	    BigDecimal bd = new BigDecimal(value);
	    bd = bd.setScale(scale, BigDecimal.ROUND_HALF_UP);//四舍五入处理
	    double num = bd.doubleValue();
	    return num;
	  }	
	
	/**
	 * 获取用户真实IP
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) { 
	     String ip = request.getHeader("x-forwarded-for"); 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	         ip = request.getHeader("Proxy-Client-IP"); 
	     } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	         ip = request.getHeader("WL-Proxy-Client-IP"); 
	     } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	          ip = request.getRemoteAddr(); 
	      } 
	     return ip; 
	  }


}
