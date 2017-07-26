<%@ page language="java" import="java.util.*,Order.CodeCreator,Order.ShoppingCart,java.sql.*,javax.sql.*,javax.naming.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'PayMoney.jsp' starting page</title>
    
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
        String userID = (String)session.getAttribute("userID");
        String accountcode = (String)session.getAttribute("ordercode");
        String sql_select = "select * from shoppingCart where userID='"+userID+"'";
        ResultSet rs=dbBean.executeQuery(sql_select);
        while(rs.next())
        {
           String bookNumber = rs.getString(2);
           String orderBookName = rs.getString(3);
           String bookCount = rs.getString(4);
           String paymoney = rs.getString(5);
           String sql_insert = "insert into orderedBook values('"+accountcode+"','"+bookNumber+"','"+orderBookName+"',"+bookCount+","+paymoney+")";
           dbBean.executeUpdate(sql_insert);
        }
        rs.close();
        String sql_delete = "delete from shoppingCart where userID='"+userID+"'";
        dbBean.executeUpdate(sql_delete);
        dbBean.closeConnection();
        session.setAttribute("flag", "true");
        response.sendRedirect("GetShoppingCart.jsp");
    %>
  </body>
</html>
