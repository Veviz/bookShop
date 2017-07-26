<%@ page language="java" import="java.util.*,Operation.DBConnector,Order.OrderInfo,java.sql.*,javax.sql.*,javax.naming.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'GetOrderInfo.jsp' starting page</title>
    
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
        List<OrderInfo> list = new ArrayList<OrderInfo>(); 
        OrderInfo orderinfo = new OrderInfo();
        orderinfo.setuserID((String)session.getAttribute("userID"));
        String sql_select = "select * from orderInfo";
        ResultSet rs=dbBean.executeQuery(sql_select);
        while(rs.next())
       {
           OrderInfo temp = new OrderInfo();
           temp.setuserID(orderinfo.getuserID());
           temp.setorderID(rs.getString(1));
           temp.setreceiverName(rs.getString(3));
           temp.setcontactWay(rs.getString(4));
           temp.setreceiveAddr(rs.getString(5));
           temp.setpayMoney(Float.valueOf(rs.getString(6)));
           temp.setorderStatus(Integer.parseInt(rs.getString(7)));
           list.add(temp); 
       }
       rs.close(); 
       dbBean.closeConnection();
       request.getSession().setAttribute("OrderInfo", list);
    //   response.sendRedirect("../Order_Show.jsp");
       response.sendRedirect("show_order.jsp");
     %>
  </body>
</html>
