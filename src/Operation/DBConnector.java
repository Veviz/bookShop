package Operation;

import java.sql.*;

public class DBConnector{
       private final String dbDrive = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
       private final String url = "jdbc:sqlserver://localhost:1433;DatabaseName=Bookshop;";
       private final String userName = "sa";
       private final String password = "zw123";
       private Connection con = null;
       public DBConnector()
       {
    	   try{
    		   Class.forName(dbDrive).newInstance();
    	   }catch(Exception ex){
    		   System.out.println("���ݿ����ʧ��");
    	   }
       }
       public boolean creatConnection()
       {
    	   try{
    		   con = DriverManager.getConnection(url, userName, password);
    		   con.setAutoCommit(true);
    	   }catch(SQLException e){ 
    		   System.out.println("���ݿ�����ʧ��");
    	   }
    	   return true;
       }
       public boolean executeUpdate(String sql)
       {
    	   if(con == null)
    	   {
    		   creatConnection();
    	   }
    	   try{
    		   Statement stmt = con.createStatement();
    		   int iCount = stmt.executeUpdate(sql);
    		   System.out.println("�����ɹ�����Ӱ��ļ�¼��Ϊ"+String.valueOf(iCount));
    		   return true;
    	   }catch(SQLException e){
    		   return false;
    	   }
       }
       public ResultSet executeQuery(String sql)
       {
    	   ResultSet rs;
    	   try{
    		   if(con == null)
    		   {
    			   creatConnection();
    		   }
    		   Statement stmt = con.createStatement();
    		   rs = stmt.executeQuery(sql);
    	   }catch(Exception e){
    		   return null;
    	   }
    	   return rs;
       }
       public void closeConnection()
       {
    	   if(con == null){
    		   try{
    			   con.close();
    		   }catch(SQLException e){
    		   }
    	   }
       }
}