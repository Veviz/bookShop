<%@ page language="java" import="java.util.*,java.sql.*,javax.sql.*,javax.naming.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Sign_For.jsp' starting page</title>
    
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
        String[] selectedOrder = request.getParameterValues("orderID");
        String userID = (String)session.getAttribute("userID");
        System.out.print(session.getAttribute("update_or_delete"));
        if(selectedOrder != null)
        {
            for(int i=0;i<selectedOrder.length;i++)
            {
                   String sql_update = "update orderInfo set orderStatus=1 where userID='"+userID+"' and orderID='"+selectedOrder[i]+"'";
                   dbBean.executeUpdate(sql_update);
            }
        }
        dbBean.closeConnection();
        response.sendRedirect("GetOrderInfo.jsp");
     %>
  </body>
</html>
