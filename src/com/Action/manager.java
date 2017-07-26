package com.Action;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.User;
import com.DB.DBConnect;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class manager extends ActionSupport{

	String sql = "select * from userInfo";
	private DBConnect conn = new DBConnect();
	private LinkedList<User> userList  = new LinkedList<User>();
	
	public String execute()
	{
		conn.connect();
		ResultSet rs = conn.query(sql);
	      try {
			while(rs.next())
			  {
			  
			      User user = new User();
			      user.setUserID(rs.getString("userID"));
			      user.setUserName(rs.getString("userName"));
			      user.setUserSex(rs.getString("userSex"));
			      user.setUserEmail(rs.getString("userEmail"));
			      user.setUserSchool(rs.getString("userSchool"));
			      user.setUserPhone(rs.getString("userPhone"));
			      /*System.out.print(user.getUserID());
			      System.out.print(user.getUserName());
			      System.out.print(user.getUserSex());
			      System.out.print(user.getUserEmail());
			      System.out.print(user.getUserSchool());
			      System.out.println(user.getUserPhone());*/
			      userList.add(user);
			  }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	     /* java.util.Iterator<User> it = list.iterator();
	      while(it.hasNext())
	      {
	    	  User us = it.next();
	    	  System.out.print(us.getUserID());
	    	  System.out.print(us.getUserName());
	    	  System.out.print(us.getUserSex());
	    	  System.out.print(us.getUserEmail());
	    	  System.out.print(us.getUserSchool());
	    	  System.out.println(us.getUserPhone());
	      }
	      */
	    Map session=ActionContext.getContext().getSession();  
	    session.put("userList", userList);
	    return "success";
	}
	
	public String delete()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		String userID = request.getParameter("userID");
		String sql1 = "delete from userInfo where userID='"+userID+"'";
		String sql2 = "delete from Account where userID='"+userID+"'";
		boolean status1 = false;
		boolean status2 = false;
		conn.connect();
		status1 = conn.update(sql1);
		status2 = conn.update(sql2);
		if(status1 && status2)
		{
			conn.close();
			return "success";
		}
		return "failure";
	}
}
