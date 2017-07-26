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
        int num = 0;
        float allcost = 0;
        ShoppingCart shoppingcart = new ShoppingCart();
        String userID = (String)session.getAttribute("userID");
        if(userID != null)
        {
            String sql_select = "select * from shoppingCart where userID='"+userID+"'";
            ResultSet rs=dbBean.executeQuery(sql_select);
            while(rs.next())
           {
              num++;
              allcost+= (Integer.parseInt(rs.getString(4)))*(Float.valueOf(rs.getString(5)));
           }
           rs.close();
        } 
       dbBean.closeConnection();
       request.getSession().setAttribute("item_num", num);
       String total = allcost + "";
       request.getSession().setAttribute("total", total);
      // response.sendRedirect("ShoppingCart_Show.jsp");
   //   response.sendRedirect("subpage.jsp");
       String flag =(String)session.getAttribute("Redirect");
       if(flag == "1")
          response.sendRedirect("cart.jsp");
       else if(flag == "2")
          response.sendRedirect("customer.jsp");
          else if(flag == "3")
           response.sendRedirect("customer.jsp");
     %>
  </body>
</html>
