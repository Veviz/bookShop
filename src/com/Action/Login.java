package com.Action;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import com.DB.DBConnect;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class Login extends ActionSupport{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userID;    //登录时的用户ID，唯一标识不同用户的标志
	private String password;  //用户的密码
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	private DBConnect conn = new DBConnect();
	
	public String execute(){
		
		int grade;
		String sql = "select * from Account where userID='"+userID+"' and password='"+password+"'";
		String reason = null;
		
		ActionContext actionContext = ActionContext.getContext();
		Map<String,Object> sessionMap = actionContext.getSession();
		
		conn.connect();
		ResultSet rs = conn.query(sql);
		try {
			if(rs.next())
			{
				grade = rs.getInt(3);
				sessionMap.put("userID", userID);                  //在该session中，会一直记得该userID和grade
				sessionMap.put("grade", String.valueOf(grade));
				if(0 == grade)
					return "shopkeeper";
				else if(1 == grade)
				{
					sessionMap.put("Redirect", "2");
					return "customer";
				}
				else
				{
					return "failure";
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		reason = "帐号或密码有误，请重新登录！";
		sessionMap.put("loginError", reason);
		conn.close();
		return "failure";
	}
	
	public String logout()
	{
    	Map session=ActionContext.getContext().getSession(); 
    	session.put("userID", null);
    	session.put("grade", null);
    	session.put("loginError", null);
		return "success";
	}

}
