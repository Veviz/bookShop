﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.*,com.book,Order.CodeCreator,Order.ShoppingCart,java.sql.*,javax.sql.*,javax.naming.*"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<%
    String userID = (String) session.getAttribute("userID");
	String grade = (String) session.getAttribute("grade");
 %>
<body>
	<script type="text/javascript">
    function PayMoney()
    {
        var form = document.forms[0];
        form.action = "payMoney";
        form.submit();
    }
    function Ischange()
    {
        session.setAttribute("ischange", "true"); 
    }
    </script>
	<div id="wrap">
		<div class="header">
			<div class="logo">
				<a href="bookshop.jsp"><img src="images/logo.gif" alt="" title=""
					border="0" /> </a>
			</div>
			<div id="menu">
				<ul>
					<li><a href="bookshop.jsp">主页</a></li>
					<li class="selected"><a href="about.jsp">关于我们</a></li>
					<li><a href="bookInfo.action">书籍浏览</a></li>
					<li><a href="userInfomation.jsp">个人中心</a></li>
					<li><a href="GetOrderInfo.jsp">订单</a></li>
				</ul>
			</div>
		</div>
		<div class="center_content">
			<div class="left_content">
				<div class="title">
					<span class="title_icon"><img src="images/bullet1.gif"
						alt="" title="" /> </span>确认订单
				</div>
				<div class="feat_prod_box_details">
					<p class="details">
						<img src="images/register.jpg" alt="" width="450" height="100" />
					</p>
					<div class="contact_form">
						<div class="form_subtitle">订单详情</div>
						<jsp:useBean id="dbBean" scope="page"
							class="Operation.DBConnector" />
						<%
							dbBean.creatConnection();
							String accountcode = (String) session.getAttribute("ordercode");
							String receiverName = null;
							String contactWay = null;
							String receiveAddr = null;
							String payMoney = (String) session.getAttribute("all_cost");
							String sql_select = "select * from orderInfo where userID='"
									+ userID + "' and orderID='" + accountcode + "'";
							ResultSet rs = dbBean.executeQuery(sql_select);
							rs.next();
							receiverName = rs.getString(3);
							contactWay = rs.getString(4);
							receiveAddr = rs.getString(5);
							rs.close();
							dbBean.closeConnection();
						%>
						<div class="form_row">
							<label class="contact"><strong>订单号:</strong> </label>
							<%=accountcode%>
						</div>
						<div class="form_row">
							<label class="contact"><strong>用户名:</strong> </label>
							<%=userID%>
						</div>
						<div class="form_row">
							<label class="contact"><strong>收件人:</strong> </label>
							<%=receiverName%>
						</div>
						<div class="form_row">
							<label class="contact"><strong>联系方式:</strong> </label>
							<%=contactWay%>
						</div>
						<div class="form_row">
							<label class="contact"><strong>收货地址:</strong> </label>
							<%=receiveAddr%>
						</div>
						<div class="form_row">
							<label class="contact"><strong>应付金额:</strong> </label>
							<%=payMoney%>
						</div>
						<div class="form_row">
							<form action="change" method="post">
								<td><a href="order_edit.jsp?ischange=true" class="continue">修改</a>
								</td>
								<td><input type="submit" class="register" value="缴费"
									name="paymoney" onclick="PayMoney()">
								</td>
							</form>
						</div>
						</form>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<!--end of left content-->
			<div class="right_content">
				<div class="languages_box">
					<form action="bookSearch" name="search">
						<input type="text" name="searBName" /> <input name=""
							type="submit" value=""
							style="border:none;background:url('images/Magnifier2.png') left top no-repeat;width:16px; height:16px;" />
					</form>
				</div>
				<div class="currency">
					<%
						if (userID == null) {
					%>
					<span class="red"> 您还未登录: </span> <a href="Login.jsp">登录</a>
					<%
						} else {
					%>
					<span class="red"> 你好, </span>
					<%=userID%><a href="Logout.action">退出</a>
					<%
						}
					%>
				</div>
				<div class="cart">
					<div class="title">
						<span class="title_icon"><img src="images/cart.gif" alt=""
							title="" /> </span>购物车
					</div>
					<div class="home_cart_content">
						<%=session.getAttribute("item_num")%>
						x items | <span class="red">TOTAL: <%=session.getAttribute("total")%></span>
					</div>
					<a href="GetShoppingCart.jsp" class="view_cart"
						onclick="<%session.setAttribute("flag", "true");%>">查看购物车</a>
				</div>
				<div class="title">
					<span class="title_icon"><img src="images/bullet3.gif"
						alt="" title="" /> </span>好好读书
				</div>
				<div class="about">
					<p>
						<img src="images/about.gif" alt="" title="" class="right" />
						富家不用买良田，书中自有千钟粟。&nbsp;&nbsp; 安居不用架高堂，书中自有黄金屋。 &nbsp;&nbsp;
						出门无车毋须恨，书中有马多如簇。&nbsp;&nbsp; 娶妻无媒毋须恨，书中有女颜如玉。 &nbsp;&nbsp;
						男儿欲遂平生志，勤向窗前读六经。
					</p>
				</div>
				<div class="right_box">
					<div class="title">
						<span class="title_icon"><img src="images/bullet4.gif"
							alt="" title="" /> </span>促销书籍
					</div>
					<%
						@SuppressWarnings("unchecked")
						List<book> pList = (List<book>) request.getSession().getAttribute("Books");
					%>
					<marquee direction="up" height="480" scrollamount="2"
						scrolldelay="80" onmouseover="this.scrollDelay=500"
						onmouseout="this.scrollDelay=1" width="200"> <%
				        	for (int i = 0; i < pList.size(); i++) {
									book sc = pList.get(i);
					%>
					<div class="new_prod_box">
						<a href="details.htm"><%=sc.getBookName() %></a>
						<div class="new_prod_bg">
							<span class="new_icon"><img src="images/promo_icon.gif"
								alt="" title="" /> </span> <a
								href="bookInfo.jsp?bookID=<%=sc.getBookNum() %>"><img
								src="<%=sc.getBookPicture() %>" alt="" title="" class="thumb"
								border="0" width="60" height="90" /> </a>
						</div>
					</div>
					<%} %> </marquee>
				</div>
				<div class="right_box">
					<div class="title">
						<span class="title_icon"><img src="images/bullet5.gif"
							alt="" title="" /> </span>书籍分类
					</div>
					<ul class="list">
						<li><a href="bookInfo.action?linkName=计算机类">计算机</a>
						</li>
						<li><a href="bookInfo.action?linkName=英语类">英语</a>
						</li>
						<li><a href="bookInfo.action?linkName=数学类">数学</a>
						</li>
						<li><a href="bookInfo.action?linkName=医学类">医学</a>
						</li>
						<li><a href="bookInfo.action?linkName=建筑类">建筑</a>
						</li>
					</ul>
					<div class="title">
						<span class="title_icon"><img src="images/bullet6.gif"
							alt="" title="" /> </span>相关链接
					</div>
					<ul class="list">
						<li><a href="http://www.dangdang.com/" target="_blank">当当网</a>
						</li>
						<li><a href="http://www.amazon.cn/" target="_blank">亚马逊</a>
						</li>
						<li><a href="http://www.taoshu.com/" target="_blank">淘书网</a>
						</li>
						<li><a href="http://www.bookuu.com" target="_blank">博库网</a>
						</li>
						<li><a href="http://www.winxuan.com/" target="_blank">文轩网</a>
						</li>
						<li><a href="http://www.wl.cn/" target="_blank">蔚蓝书店</a>
						</li>
						<li><a href="http://www.china-pub.com" target="_blank">互动出版网</a>
						</li>
						<li><a href="http://book.beifabook.com/" target="_blank">北发图书网</a>
						</li>
						<li><a href="http://www.zazhipu.com" target="_blank">杂志铺</a>
						</li>
					</ul>
				</div>
			</div>
			<!--end of right content-->
			<div class="clear"></div>
		</div>
		<!--end of center content-->
		<div class="footer">
			<div class="left_footer">
				<img src="images/footer_logo.gif" alt="" title="" /><br />
			</div>
			<div class="right_footer">
				<a href="#">主页</a> <a href="#">关于我们</a> <a href="#">服务</a> <a
					href="#">隐私政策</a> <a href="#">联系我们</a>
			</div>
		</div>
	</div>
</body>
</html>
