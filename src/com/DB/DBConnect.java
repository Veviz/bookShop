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
	//�������ݿ��������򣬲��������ݿ�
	public boolean connect()
	{
		try{
			//�������ݿ�����
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
	//ִ�����ݿ��ѯ��������ǲ�ѯ���
	public ResultSet query(String sql)
	{
		ResultSet rs = null;
		Statement stmt = null;
		//������ݿ��Ƿ��Ѿ�������
		if(null == conn)
		{
			connect();
		}
		try{
			//�õ�Statement����
			stmt = conn.createStatement();
			//ִ��SQL��䣬���õ�ִ�н��
			rs = stmt.executeQuery(sql);
			return rs;
		}catch(SQLException e)
		{//������
			e.printStackTrace();
			return null;
		}
	}
	//////////////////////////////////////////////////////////////////////////
	//ִ�����ݿ���²�����������Ǹ������,[���ݸ��°��� ����ɾ����]
	public boolean update(String sql)
	{
		Statement stmt = null;
		int mcount = 0;
		//������ݿ��Ƿ��Ѿ�������
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
	////������Դ��ֻ�����ݿ�����conn��ȫ����Դ��ֻ��ر�conn
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
