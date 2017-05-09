package com.vote.service;

import java.awt.Color;
import java.awt.Font;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.NumberFormat;

import javax.servlet.http.HttpSession;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.entity.StandardEntityCollection;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.PiePlot3D;
import org.jfree.chart.servlet.ChartDeleter;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.general.DefaultPieDataset;

public class ChartUtil {
	public static String generatePieChart(DefaultPieDataset dataset,
			String titleName, int width, int height, HttpSession session,
			PrintWriter pw) {

		String filename = null;
		try {
			if (session != null) {
				ChartDeleter deleter = (ChartDeleter) session
						.getAttribute("JFreeChart_Deleter");
				session.removeAttribute("JFreeChart_Deleter");
				session.setAttribute("JFreeChart_Deleter", deleter);
			}
			// chart
			JFreeChart chart = ChartFactory.createPieChart3D(
					titleName, // title
					dataset,   // data
					false,      // include legend
					true, 
					false);
			
			PiePlot3D plot = (PiePlot3D) chart.getPlot();
			// 图片中显示百分比:默认方式
			// plot.setLabelGenerator(new
			// StandardPieSectionLabelGenerator(StandardPieToolTipGenerator.DEFAULT_TOOLTIP_FORMAT));
			// 图片中显示百分比:自定义方式，{0} 表示选项， {1} 表示数值， {2} 表示所占比例 ,小数点后两位
			plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0}={1}({2})", NumberFormat.getNumberInstance(),new DecimalFormat("0%")));
			// 图例显示百分比:自定义方式， {0} 表示选项， {1} 表示数值， {2} 表示所占比例
			//plot.setLegendLabelGenerator(new StandardPieSectionLabelGenerator("{0}={1}({2})"));
			// 设置背景色为白色
			chart.setBackgroundPaint(Color.white);
			// 指定图片的透明度(0.0-1.0)
			plot.setForegroundAlpha(1.0f);
			// 指定显示的饼图上圆形(false)还椭圆形(true)
			plot.setCircular(true);
			// 定义字体格式
			Font font = new java.awt.Font("黑体", java.awt.Font.CENTER_BASELINE, 12);
			Font titleFont = new java.awt.Font("黑体", java.awt.Font.CENTER_BASELINE, 15);
			TextTitle title = new TextTitle(titleName);
			title.setFont(titleFont);
			// 设置字体,非常关键不然会出现乱码的,下方的字体
			//chart.getLegend().setItemFont(font);
			// 设置图片的地址Pie图的字体
			plot.setLabelFont(font);
			chart.setTitle(title);
			
			// Write the chart image to the temporary directory
			ChartRenderingInfo info = new ChartRenderingInfo(
					new StandardEntityCollection());
			// If the last parameter is null, the chart is a "one time"-chart
			// and will be deleted after the first serving.
			// If the last parameter is a session object, the chart remains
			// until session time out.
			filename = ServletUtilities.saveChartAsPNG(chart, width, height,
					info, session);
			// Write the image map to the PrintWriter
			ChartUtilities.writeImageMap(pw, filename, info, true);
			pw.flush();
		} catch (Exception e) {
			System.out.println("Exception - " + e.toString());
			e.printStackTrace(System.out);
			filename = "picture_error.png";
		}
		return filename;
	}
}