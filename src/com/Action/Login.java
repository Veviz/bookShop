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
	private String userID;    //��¼ʱ���û�ID��Ψһ��ʶ��ͬ�û��ı�־
	private String password;  //�û�������
	
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
				sessionMap.put("userID", userID);                  //�ڸ�session�У���һֱ�ǵø�userID��grade
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
		reason = "�ʺŻ��������������µ�¼��";
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
