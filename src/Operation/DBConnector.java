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
    		   System.out.println("数据库加载失败");
    	   }
       }
       public boolean creatConnection()
       {
    	   try{
    		   con = DriverManager.getConnection(url, userName, password);
    		   con.setAutoCommit(true);
    	   }catch(SQLException e){ 
    		   System.out.println("数据库连接失败");
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
    		   System.out.println("操作成功，所影响的记录数为"+String.valueOf(iCount));
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