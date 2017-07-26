<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*,java.util.*"%>
<%@ page import="java.util.LinkedList,com.book"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<!-- 该页面用于显示某本书籍的具体信息 -->
<title>书籍信息</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<link rel="stylesheet" href="lightbox.css" type="text/css"
	media="screen" />
<script src="js/prototype.js" type="text/javascript"></script>
<script src="js/scriptaculous.js?load=effects" type="text/javascript"></script>
<script src="js/lightbox.js" type="text/javascript"></script>
<script type="text/javascript" src="js/java.js"></script>

</head>
<jsp:useBean id="DB" scope="session" class="com.DB.DBConnect"></jsp:useBean>
<%
    
	String userID = (String)session.getAttribute("userID");
	String grade = (String)session.getAttribute("grade");
	String bookID = request.getParameter("bookID");//书籍编号的获取，下面就需要显示该书籍的全部信息
	String sql = "select * from bookInfo where bookNum='" + bookID
			+ "'";
%>
<link rel="stylesheet" type="text/css" href="style.css" />


<body>
	<div id="wrap">
		<div class="header">
			<div class="logo">
				<a href="bookshop.jsp"><img src="images/logo.gif" alt=""
					title="" border="0" /> </a>
			</div>
			<div id="menu">
			<%
			if(grade == null)//游客身份
			{
			 %>
				<ul>
					<li><a href="bookshop.jsp">主页</a></li>
					<li><a href="about.jsp">关于我们</a></li>
					<li class="selected"><a href="bookInfo.action">书籍浏览</a></li>
					<li><a href="Login.jsp">我的账户</a></li>
					<li><a href="Login.jsp">登录</a></li>
				</ul>
				<%
					} else if (grade.equals("0")) {  //管理员身份
				%>
				 <ul>
					<li><a href="shopkeeper.jsp">主页</a></li>
					<li><a href="user.action">用户管理</a></li>
					<li class="selected"><a href="bookInfo.action">书籍管理</a></li>
					<li><a href="OrderManage.jsp">订单管理</a></li>
					<li><a href="userInfomation.jsp">个人中心</a></li>
				</ul>
				 <%
				 }else   //顾客身份
				 {
				  %>
				  <ul>
					<li><a href="customer.jsp">主页</a></li>
					<li><a href="about.jsp">关于我们</a></li>
					<li class="selected"><a href="bookInfo.action">书籍浏览</a></li>
					<li><a href="userInfomation.jsp">个人中心</a></li>
					<li><a href="GetOrderInfo.jsp">我的订单</a></li>
				</ul>
				  <%
				  }
				   %>
			</div>
		</div>
		<div class="center_content">
			<div class="left_content">
				<div class="crumb_nav">
					<a href="bookInfo.action">书籍管理</a> &gt;&gt;书籍信息
				</div>
				<%
					String kind = null; //获取书籍种类
					String num = null; //获取书籍编号
					String name = null; //获取书籍的名称
					String publisherID = null; //获取发表者的ID号
					String picPath = null;
					DB.connect();
					ResultSet rs = DB.query(sql);
					String stockNum = null;
					if (rs.next()) {
						picPath = rs.getString("bookPicture");
						String new_used = rs.getString("newOrUsed");
						kind = rs.getString("bookKind");
						num = rs.getString("bookNum");
						publisherID = rs.getString("publisherID");
						name = rs.getString("bookName");
						stockNum = rs.getString("stockNum");
				%>
				<div class="title">
					<span class="title_icon"><img src="images/bullet1.gif"
						alt="" title="" /> </span><%=rs.getString("bookName")%>
					<%
						if (stockNum.equals("0")) {
					%>
					<font color="red">(已售空！)</font>
					<%
						}
					%>
				</div>
				<div class="feat_prod_box_details">
					<div class="prod_img">
						<a href="bookInfo.jsp"><img src="<%=picPath%>" alt=""
							title="" border="0" width="98" height="150" /> </a> <br /> <br />
						<a href="<%=picPath%>" rel="lightbox"><img
							src="images/zoom.gif" alt="" title="" border="0" /> </a>
					</div>
					<div class="prod_det_box">
						<div class="box_top"></div>
						<div class="box_center">
							<div class="prod_title">书籍简介</div>
							<p class="details">
								<%=rs.getString("briefInfo")%>
							</p>
							<div class="price">
								<strong>价格:</strong> <span class="red"><%=rs.getString("price")%>
									$</span>
							</div>
							<div class="price">
								<%
										if (grade == null)
											;
										else if(grade.equals("1")){
										session.setAttribute("buyBookNum", num);
								%>
								<s:form action="buy">
									<strong>数量(本):</strong>
									<input name="bookCount" type="text" value="1"/>
									<s:submit value="加入购物车"></s:submit>
								</s:form>
								<%
									}
								%>
							</div>
							<div class="clear"></div>
						</div>
						<div class="box_bottom"></div>
					</div>
					<div class="clear"></div>
				</div>
				<div id="demo" class="demolayout">
					<ul id="demo-nav" class="demolayout">
						<li><a class="active" href="#tab1">详细信息</a>
						</li>
						<li><a class="" href="#tab2">相关书籍</a></li>
						<%
						if(grade == null)
						      ;
						else if(grade.equals("0") || userID.equals(publisherID))
						 {
						 %>
						<li><a class="" href="#tab3">书籍操作</a></li>
						<%
						}
						 %>
					</ul>
					<div class="tabs-container">
						<div style="display: block;" class="tab" id="tab1">
							<br>
							<div>
								<label class="contact"><strong>书籍编号:</strong> </label> <input
									disabled="disabled" type="text"
									value=<%=rs.getString("bookNum")%>>
							</div>
							<br>
							<div>
								<label class="contact"><strong>书籍名称:</strong> </label> <input
									disabled="disabled" type="text"
									value=<%=rs.getString("bookName")%>>
							</div>
							<br>
							<div>
								<label class="contact"><strong>书籍新旧:</strong> </label>
								<%
									if (new_used.equals("0")) {
								%>
								<input disabled="disabled" type="text" value="旧书">
								<%
									} else {
								%>
								<input disabled="disabled" type="text" value="新书">
								<%
									}
								%>
							</div>
							<br>
							<div>
								<label class="contact"><strong>作者姓名:</strong> </label> <input
									disabled="disabled" type="text"
									value=<%=rs.getString("authorName")%>>
							</div>
						    <br>
							<div>
								<label class="contact"><strong>出版社:</strong> </label> <input
									disabled="disabled" type="text"
									value=<%=rs.getString("press")%>>
							</div>
							<br>
							<div>
								<label class="contact"><strong>出版时间:</strong> </label> <input
									disabled="disabled" type="text"
									value=<%=rs.getString("publishTime")%>>
							</div>
							<br>
							<div>
								<label class="contact"><strong>书籍价格:</strong> </label> <input
									disabled="disabled" type="text"
									value="<%=rs.getString("price")%> 元">
							</div>
							<br>
							<div>
								<label class="contact"><strong>存储量:</strong> </label> <input
									disabled="disabled" type="text"
									value=<%=rs.getString("stockNum")%>>
							</div>
							<br>
							<div>
								<label class="contact"><strong>发布者:</strong> </label> <input
									disabled="disabled" type="text"
									value=<%=publisherID%>>
							</div>
							<%
								}
							%>
						</div>
						<div style="display: none;" class="tab" id="tab2">
							<%
								String sql2 = "select * from bookInfo where bookKind='" + kind
										+ "' and bookNum!='" + num + "'";
								ResultSet rs2 = DB.query(sql2);
								while (rs2.next()) {
							%>
							<div class="new_prod_box">
								<a href="bookInfo.jsp?bookID=<%=rs2.getString("bookNum")%>"><%=rs2.getString("bookName")%></a>
								<div class="new_prod_bg">
									<a href="bookInfo.jsp?bookID=<%=rs2.getString("bookNum")%>"><img
										src="<%=rs2.getString("bookPicture")%>" alt="" title=""
										class="thumb" border="0" width="60" height="80" /> </a>
								</div>
							</div>
							<%
								}
								DB.close();
							%>

							<div class="clear"></div>
						</div>
						
						<%
						if(grade == null)
						   ;
						else if(grade.equals("0") || userID.equals(publisherID))
						{
						 %>
						<div style="display: none;" class="tab" id="tab3">
							<div class="new_prod_box">
									<h3>
										书籍名称：<%=name%></h3>
								<div class="new_prod_bg">
									<img src="<%=picPath%>" alt="" title="" class="thumb"
										width="60" height="80" border="0" />
								</div>
								<div>
									<a href="bookEdit.jsp?editBookNum=<%=num %>" class="continue">修改</a> <a
										href="bookDel.action?delBookNum=<%=num %>" class="checkout">删除</a>
								</div>
							</div>
							<div class="clear"></div>
						</div>
						<%} %>
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
					<%
						if (userID == null) {
					%>
					<span class="red">
						您还未登录: </span> <a href="Login.jsp">登录</a>
					<%
						} else {
					%>
					<span class="red">
						你好, </span>
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
					<%
					if(grade == null)  //游客身份
					{
					 %>
					<div class="home_cart_content">
						没有书籍 | <span class="red">总价: 0</span>
					</div>
					<%
					} else if(grade.equals("1"))//顾客身份
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

<script type="text/javascript">

var tabber1 = new Yetii({
id: 'demo'
});

</script>

</html>
