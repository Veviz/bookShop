<%@ page language="java" import="java.util.*,Order.ShoppingCart,java.sql.*,javax.sql.*,javax.naming.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'orderBook_show.jsp' starting page</title>
    
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
        List<ShoppingCart> list = new ArrayList<ShoppingCart>(); 
        ShoppingCart bookInfo = new ShoppingCart();
        String ordercode = request.getParameter("show_order");
        String sql_select_order = "select * from orderedBook where orderNumber='"+ordercode+"'";
        ResultSet rs=dbBean.executeQuery(sql_select_order);
        while(rs.next())
       {
           String sql_select_book = "select * from bookInfo where bookNum='"+rs.getString(2)+"'";
           ResultSet rs_book = dbBean.executeQuery(sql_select_book);
           rs_book.next();
           ShoppingCart temp = new ShoppingCart();
           temp.setuserID((String)session.getAttribute("user_ID"));
           temp.setbookNumber(rs.getString(2));
           temp.setorderBookName(rs.getString(3));
           temp.setbookCount(Integer.parseInt(rs.getString(4)));
           temp.setpayment(Float.parseFloat(rs.getString(5)));
           temp.setImagepath(rs_book.getString(12));
           list.add(temp); 
           rs_book.close();
       }
       rs.close(); 
       dbBean.closeConnection();
       request.getSession().setAttribute("order_context", list);
      // response.sendRedirect("ShoppingCart_Show.jsp");
   //   response.sendRedirect("subpage.jsp");
   response.sendRedirect("order_detail.jsp");
     %>
  </body>
</html>
