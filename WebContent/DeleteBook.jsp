<%@ page language="java" import="java.util.*,Operation.DBConnector,java.sql.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'DelectBook.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <jsp:useBean id="dbBean" scope="page" class="Operation.DBConnector" />
    <%
        dbBean.creatConnection();
        String[] selectedBook = request.getParameterValues("bookNumber");
        String userID = (String)session.getAttribute("userID");
        session.setAttribute("flag", "true");
        if(selectedBook != null)
        {
            for(int i=0;i<selectedBook.length;i++)
            {
                String sql_delete = "delete from shoppingCart where userID='"+userID+"' and bookNumber='"+selectedBook[i]+"'";
                String sql_select = "select * from shoppingCart where userID='"+userID+"' and bookNumber='"+selectedBook[i]+"'";
                ResultSet rs=dbBean.executeQuery(sql_select);
                rs.next();
                String sql_update = "update bookInfo set stockNum = isnull(stockNum,0) + "+rs.getString(4)+" where bookNum='"+selectedBook[i]+"'";
                dbBean.executeUpdate(sql_update);
                dbBean.executeUpdate(sql_delete);
                rs.close();
            }
        }
        dbBean.closeConnection();
        response.sendRedirect("GetShoppingCart.jsp");
     %>
  </body>
</html>
