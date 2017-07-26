package com.DB;
import java.sql.*;

public class DBConnect {
	Connection conn = null;
	String url = "jdbc:sqlserver://127.0.0.1:1433;DataBaseName =Bookshop ";
	String user = "sa";
	String  passwo = "zw123";
	
	public DBConnect()
	{
		super();
	}
	//////////////////////////////////////////////////////////////////////////
	//加载数据库驱动程序，并链接数据库
	public boolean connect()
	{
		try{
			//加载数据库驱动
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn = DriverManager.getConnection(url,user,passwo);
		}catch(Exception e)
		{
			System.out.println("Driver load error!");
			return false;
		}
		return true;
	}
	////////////////////////////////////////////////////////////////////////////
	//执行数据库查询，传入的是查询语句
	public ResultSet query(String sql)
	{
		ResultSet rs = null;
		Statement stmt = null;
		//检查数据库是否已经链接上
		if(null == conn)
		{
			connect();
		}
		try{
			//得到Statement对象
			stmt = conn.createStatement();
			//执行SQL语句，并得到执行结果
			rs = stmt.executeQuery(sql);
			return rs;
		}catch(SQLException e)
		{//出错处理
			e.printStackTrace();
			return null;
		}
	}
	//////////////////////////////////////////////////////////////////////////
	//执行数据库更新操作，传入的是更新语句,[数据更新包括 增、删、改]
	public boolean update(String sql)
	{
		Statement stmt = null;
		int mcount = 0;
		//检查数据库是否已经连接上
		if(null == conn)
		{
			connect();
		}
		try{
			stmt = conn.createStatement();
			mcount = stmt.executeUpdate(sql);
			if(mcount == 0)
				return false;
		}catch(SQLException e)
		{
			e.printStackTrace();
		}
		return true;
	}
	///////////////////////////////////////////////////////////////////////////////
	////回收资源，只有数据库链接conn是全局资源，只需关闭conn
	public boolean close()
	{
		try{
			conn.close();
		}catch(SQLException e)
		{
			e.printStackTrace();
		}
		conn = null;
		return true;
	}
}
