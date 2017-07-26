<%@ page language="java" import="java.util.*,java.sql.*,javax.sql.*,javax.naming.*,Order.ShoppingCart" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'GetShoppingCart.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>&nbsp; 
  <jsp:useBean id="dbBean" scope="page" class="Operation.DBConnector" />
    <% 
        dbBean.creatConnection();
        List<ShoppingCart> list = new ArrayList<ShoppingCart>(); 
        ShoppingCart shoppingcart = new ShoppingCart();
        shoppingcart.setuserID((String)session.getAttribute("userID"));
        String sql_select = "select * from shoppingCart where userID='"+shoppingcart.getuserID()+"'";
        ResultSet rs=dbBean.executeQuery(sql_select);
        while(rs.next())
       {
           ShoppingCart temp = new ShoppingCart();
           temp.setuserID(shoppingcart.getuserID());
           temp.setbookNumber(rs.getString(2));
           temp.setorderBookName(rs.getString(3));
           temp.setbookCount(Integer.parseInt(rs.getString(4)));
           temp.setpayment(Float.valueOf(rs.getString(5)));
           temp.setImagepath(rs.getString(6));
           list.add(temp); 
       }
       rs.close(); 
       dbBean.closeConnection();
       request.getSession().setAttribute("ShoppingCart", list);
      // response.sendRedirect("ShoppingCart_Show.jsp");
   //   response.sendRedirect("subpage.jsp");
    session.setAttribute("Redirect", "1");
   response.sendRedirect("ShoppingCartInfo.jsp");
     %>
  </body>
</html>
