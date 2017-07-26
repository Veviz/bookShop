<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Store_Order.jsp' starting page</title>
    
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
        String sql_update = null;
        dbBean.creatConnection();
        String userID = (String)session.getAttribute("userID");
        String accountcode = (String)session.getAttribute("ordercode");
        String receiverName = request.getParameter("receiverName");
        String contactWay = request.getParameter("contactWay");
        String receiveAddr = request.getParameter("receiveAddr");
        String payMoney = (String)session.getAttribute("all_cost");
        System.out.print("测试"+(String)session.getAttribute("ischange"));
        String isChange = (String)session.getAttribute("ischange");
        if(isChange != null && isChange.equals("true"))
        {
            System.out.print("!!!!!!!!!!!!!!!!");
            String sql_delete = "delete from orderInfo where userID='"+userID+"' and orderID='"+accountcode+"'";
            dbBean.executeUpdate(sql_delete);
            session.setAttribute("ischange", "false");
        }
        sql_update = "insert into orderInfo values('"+accountcode+"','"+userID+"','"+receiverName+"','"+contactWay+"','"+receiveAddr+"',"+payMoney+","+"0)";
        dbBean.executeUpdate(sql_update);
        dbBean.closeConnection();
     //   response.sendRedirect("../Choose.jsp");
        response.sendRedirect("order_temp.jsp");
     %>
  </body>
</html>
