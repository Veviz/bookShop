<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*,java.util.*"%>
<%@ page import="java.util.LinkedList,com.book"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>

<title>书籍信息修改</title>
</head>

<link rel="stylesheet" type="text/css" href="style.css" />
<jsp:useBean id="DB" scope="session" class="com.DB.DBConnect"></jsp:useBean>
<%
	String grade = (String) session.getAttribute("grade");
	String userID = (String) session.getAttribute("userID");
	String bookNum = request.getParameter("editBookNum");
	session.setAttribute("editBookNum", bookNum);
%>
<body>
	<div id="wrap">
		<div id="wrap">
			<div class="header">
				<div class="logo">
					<a href="bookshop.jsp"><img src="images/logo.gif" alt=""
						title="" border="0" /> </a>
				</div>
				<div id="menu">
					<%
						if (grade.equals("0")) { //管理员身份
					%>
					<ul>
						<li><a href="shopkeeper.jsp">主页</a>
						</li>
						<li><a href="user.action">用户管理</a>
						</li>
						<li class="selected"><a href="bookInfo.action">书籍管理</a>
						</li>
						<li><a href="OrderManage.jsp">订单管理</a>
						</li>
						<li><a href="userInfomation.jsp">个人中心</a>
						</li>
					</ul>
					<%
						} else //顾客身份
						{
					%>
					<ul>
						<li><a href="bookshop.jsp">主页</a>
						</li>
						<li><a href="about.jsp">关于我们</a>
						</li>
						<li class="selected"><a href="bookInfo.action">书籍浏览</a>
						</li>
						<li><a href="userInfomation.jsp">个人中心</a>
						</li>
						<li><a href="GetOrderInfo.jsp">我的订单</a>
						</li>
					</ul>
					<%
						}
					%>
				</div>
			</div>
			<div class="center_content">
				<div class="left_content">
					<div class="title">
						<span class="title_icon"><img src="images/bullet1.gif"
							alt="" title="" /> </span>修改书籍信息
					</div>
					<div class="feat_prod_box_details">
						<p class="details">
							<img src="images/book.jpg">
						</p>
						<div class="contact_form">
							<div class="form_subtitle">修改书籍</div>
							<%
									String sql = "select * from bookInfo where bookNum='" + bookNum
												+ "'";
										String new_used = null;
										DB.connect();
										ResultSet rs = DB.query(sql);
										if (rs.next()) {
											new_used = rs.getString("newOrUsed");
							%>
							<s:form action="bookEdit" theme="simple"
								enctype="multipart/form-data">
								<table align="center" width="100%" border="0" bgcolor="#CCCCCC">
									<tr>
										<td><strong>书籍名称：</strong>
										</td>
										<td><%=rs.getString("bookName")%>
										</td>
									</tr>

									<tr>
										<td><strong>书籍新旧：</strong></td>
										<%
											if (new_used.equals("0")) {
										%>
										<td>旧书</td>
										<%
											} else {
										%>
										<td>新书</td>
										<%
											}
										%>
										</tr>
									<tr>
										<td><strong>作者姓名：</strong></td>
										<td><%=rs.getString("authorName") %>
										</td>
									</tr>
									<tr>
										<td><strong>发布时间：</strong></td>
										<td><%=rs.getString("publishTime") %>
										</td>
									</tr>
									<tr>
										<td><strong>价格(元)：</strong></td>
										<td><input
									  type="text" name="price" value=<%=rs.getString("price") %>>
										</td>
									</tr>
									<tr>
										<td><strong>库存量(本)：</strong></td>
										<td><input
									  type="text" name="stockNum" value=<%=rs.getString("stockNum") %>>
										</td>
									</tr>
									
									<tr>
										<td><strong>发 布 者：</strong></td>
										<td><%=userID%></td>
									</tr>
									<tr>
										<td><strong>书籍图片：</strong></td>
										<td id="picture"><s:file name="file"></s:file></td>
									</tr>
									<tr>
									    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									    
									    </td>
										<td><s:submit value="修改"></s:submit>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<s:reset value=" 重置 "></s:reset>
										</td>
									</tr>
								</table>
							</s:form>
							<%
							}
							 %>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				<!--end of left content-->
				<div class="right_content">
					<div class="languages_box">
					<form action="bookSearch" name="search">
					     <input type="text" name="searBName"/> 
					     <input name="" type="submit" value="" style="border:none;background:url('images/Magnifier2.png') left top no-repeat;width:16px; height:16px;" />
					</form>
				</div>
					<div class="currency">
						<span class="red">你好: </span> <a href="#"><%=userID%></a><a
							href="Login.jsp">退出 </a>
					</div>
					<div class="cart">
						<div class="title">
							<span class="title_icon"><img src="images/cart.gif" alt=""
								title="" /> </span>购物车
						</div>
					<%
					 if(grade.equals("1"))//顾客身份
					{
					 %>
				    <div class="home_cart_content"> 
				          <%=session.getAttribute("item_num") %> x 本书 | <span class="red">总价: <%=session.getAttribute("total") %></span> 
				    </div>
                    <a href="GetShoppingCart.jsp" class="view_cart" onclick="<% session.setAttribute("flag", "true");%>">查看购物车</a> 				
					 <%
					 }else//管理员身份
					 {
					  %>
					  <div class="home_cart_content">
						没有书籍 | <span class="red">总价: 0</span>
					</div>
					  <%
					  }
					   %>
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
				  <marquee direction="up" height="480" scrollamount="2" scrolldelay="80" onmouseover="this.scrollDelay=500" onmouseout="this.scrollDelay=1" width="200">  
					<%
				        	for (int i = 0; i < pList.size(); i++) {
									book sc = pList.get(i);
					%>
					<div class="new_prod_box">
						<a href="details.htm"><%=sc.getBookName() %></a>
						<div class="new_prod_bg">
							<span class="new_icon"><img src="images/promo_icon.gif"
								alt="" title="" />
							</span> <a href="bookInfo.jsp?bookID=<%=sc.getBookNum() %>"><img src="<%=sc.getBookPicture() %>" alt=""
								title="" class="thumb" border="0" width="60" height="90"/>
							</a>
						</div>
					</div>
					<%} %>
					</marquee>
					</div>
					<div class="right_box">
					<div class="title">
						<span class="title_icon"><img src="images/bullet5.gif"
							alt="" title="" /> </span>书籍分类
					</div>
					<ul class="list">
						<li><a href="bookInfo.action?linkName=计算机类">计算机</a></li>
						<li><a href="bookInfo.action?linkName=英语类">英语</a></li>
						<li><a href="bookInfo.action?linkName=数学类">数学</a></li>
						<li><a href="bookInfo.action?linkName=医学类">医学</a></li>
						<li><a href="bookInfo.action?linkName=建筑类">建筑</a></li>
					</ul>
					<div class="title">
						<span class="title_icon"><img src="images/bullet6.gif"
							alt="" title="" /> </span>相关链接
					</div>
					<ul class="list">
          <li><a href="http://www.dangdang.com/" target="_blank">当当网</a></li>
          <li><a href="http://www.amazon.cn/" target="_blank">亚马逊</a></li>
          <li><a href="http://www.taoshu.com/" target="_blank">淘书网</a></li>
          <li><a href="http://www.bookuu.com" target="_blank">博库网</a></li>
          <li><a href="http://www.winxuan.com/" target="_blank">文轩网</a></li>
          <li><a href="http://www.wl.cn/" target="_blank">蔚蓝书店</a></li>
          <li><a href="http://www.china-pub.com" target="_blank">互动出版网</a></li>
          <li><a href="http://book.beifabook.com/" target="_blank">北发图书网</a></li>
          <li><a href="http://www.zazhipu.com" target="_blank">杂志铺</a></li>
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
				<a href="#">主页</a> <a href="#">关于我们</a> <a href="#">服务</a>
				<a href="#">隐私政策</a> <a href="#">联系我们</a>
			</div>
		</div>
	</div>
</body>
</html>
