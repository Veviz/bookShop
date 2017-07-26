package com.Action;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.DB.DBConnect;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class register extends ActionSupport {

	private String userID;
	private String password1;
	private String password2;
	private String userEmail;
	private String userName;
	private String userSex;
	private String userSchool;
	private String userPhone;
	private boolean legal;       //注册时必须同意我们的条约
	
	
	
	public boolean isLegal() {
		return legal;
	}
	public void setLegal(boolean legal) {
		this.legal = legal;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getPassword1() {
		return password1;
	}
	public void setPassword1(String password1) {
		this.password1 = password1;
	}
	public String getPassword2() {
		return password2;
	}
	public void setPassword2(String password2) {
		this.password2 = password2;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserSex() {
		return userSex;
	}
	public void setUserSex(String userSex) {
		this.userSex = userSex;
	}
	public String getUserSchool() {
		return userSchool;
	}
	public void setUserSchool(String userSchool) {
		this.userSchool = userSchool;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	
	//连接数据库对象
	private DBConnect conn = new DBConnect();
	
	public String execute(){
		String sql = null;
		String sql1 = null;
		String sql2 = null;
		String reason = null;
		boolean status1 = false;
		boolean status2 = false;
		
		ActionContext actionContext = ActionContext.getContext();
		Map<String,Object> sessionMap = actionContext.getSession();

		if(userID.equals(""))
		{
			reason = "用户名不能为空！";
			sessionMap.put("registerError", reason);
			return "failure";
		}
		
		if(password1.equals(""))
		{
			reason = "密码不能为空！";
			sessionMap.put("registerError", reason);
			return "failure";
		}
		
		if(! password1.equals(password2))
		{
			reason = "两次填写的密码不一致！";
			sessionMap.put("registerError", reason);
			return "failure";
		}
		
		if(!legal)
		{
			reason = "不同意我们的条约则无法注册用户！";
			sessionMap.put("registerError", reason);
			return "failure";
		}
		conn.connect();
		sql = "select * from Account where userID='"+userID+"'";
		ResultSet rs = conn.query(sql);
		try {
			if(rs.next())
			{
				reason = "该用户已经存在，请直接登录！";
				sessionMap.put("registerError", reason);
				conn.close();
				return "failure";
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		sql1 = "insert into UserInfo values('"+userID+"','"+userName+"','"+userSex+"','"+userEmail+
				"','"+userSchool+"','"+userPhone+"')";
		sql2 = "insert into Account values('"+userID+"','"+password1+"','1')";
		
		//System.out.print(sql1);
		//System.out.print(sql2);
		status1 = conn.update(sql1);
		status2 = conn.update(sql2);
		if(status1 && status2)
		{
			conn.close();
			return "success";
		}
		reason = "注册失败！";
		sessionMap.put("registerError", reason);
		conn.close();
		
		return "failure";
	}
	
	//更新的信息属于用户信息，不包括密码
	public String update(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String sql = null;
		ActionContext actionContext = ActionContext.getContext();
		Map<String,Object> sessionMap = actionContext.getSession();
		String grade = (String)sessionMap.get("grade");
		String user_ID = (String) sessionMap.get("userID");
		sql = "update userInfo set userName='"+userName+"',userSex='"+userSex+"',userEmail='"
				+userEmail+"',userSchool='"+userSchool+"',userPhone='"+userPhone+"' where userID='"+user_ID+"'";
		//System.out.println(sql);
		boolean status = false;
		String reason = null;
		conn.connect();
		status = conn.update(sql);
		if(status)
		{
			if(grade.equals("1"))
			{
				conn.close();
				return "customer";
			}
			conn.close();
			return "shopkeeper";
		}
		reason = "update database error!";
		sessionMap.put("reas", reason);
		conn.close();
		return "failure1";
	}
	
	
}
