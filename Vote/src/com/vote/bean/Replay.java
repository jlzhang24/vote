package com.vote.bean;

import java.sql.Timestamp;

public class Replay {
	
	private int replayId; //回复ID
	private String replayCode;//回复者代码
	private String replayIp;//回复者IP
	private int oId;//主题Id
	private Timestamp replayTime;//回复时间
	private String remark;//备注
	public int getReplayId() {
		return replayId;
	}
	public void setReplayId(int replayId) {
		this.replayId = replayId;
	}
	public String getReplayCode() {
		return replayCode;
	}
	public void setReplayCode(String replayCode) {
		this.replayCode = replayCode;
	}
	public String getReplayIp() {
		return replayIp;
	}
	public void setReplayIp(String replayIp) {
		this.replayIp = replayIp;
	}
	public int getoId() {
		return oId;
	}
	public void setoId(int oId) {
		this.oId = oId;
	}
	public Timestamp getReplayTime() {
		return replayTime;
	}
	public void setReplayTime(Timestamp replayTime) {
		this.replayTime = replayTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

}
