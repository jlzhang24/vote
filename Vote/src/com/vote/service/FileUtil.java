package com.vote.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

public class FileUtil {
	public void readFile(String fileName) throws Exception{
		readFile(fileName,null);
	}
	public void readFile(String fileName,String charsetName) throws Exception{
		InputStream in=new FileInputStream(fileName);
		InputStreamReader reader;
		if(charsetName==null)
			reader=new InputStreamReader(in);
		else
			reader=new InputStreamReader(in,charsetName);
		BufferedReader br=new BufferedReader(reader);
		String data;
		while((data=br.readLine())!=null)
			System.out.println(data);
		br.close();
	}
	public void copyFile(String from,String charsetFrom,String to,String charsetTo,String wj) throws Exception{
		InputStream in=new FileInputStream(from);
		InputStreamReader reader;
		if(charsetFrom==null)
			reader=new InputStreamReader(in);
		else
			reader=new InputStreamReader(in,charsetFrom);
		BufferedReader br=new BufferedReader(reader);
		OutputStream out=new FileOutputStream(to);
		OutputStreamWriter writer=new OutputStreamWriter(out,charsetTo);
		BufferedWriter bw=new BufferedWriter(writer);
		PrintWriter pw=new PrintWriter(bw,true);
		char s[]=wj.toCharArray();
		pw.write(s);
		String data;
		while((data=br.readLine())!=null)
			pw.println(data);
		br.close();
		pw.close();
	}
	public static void main(String[] args) throws Exception {
		FileUtil util=new FileUtil();
		//util.readFile("D:\\test.txt");
		util.copyFile("D:\\lm.sql",null,"D:\\out.txt","utf-8","<%String id=\"141\"; %>");
		//util.readFile("D:\\out.txt");
		//util.readFile("d:\\out.txt","gbk");

	}

}
