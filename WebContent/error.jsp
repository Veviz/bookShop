<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,com.book,java.util.*"%>

<html>
  <head>
    
    <title>出错了....</title>

  </head>
  <%
	String grade = (String) session.getAttribute("grade");
	String userID = (String) session.getAttribute("userID");
    String reason = (String) session.getAttribute("reas");
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
			if(grade == null)//表明当前用户是游客
			{
			 %>
				<ul>
					<li><a href="bookshop.jsp">主页</a></li>
					<li><a href="about.jsp">关于我们</a></li>
					<li><a href="bookInfo.action">书籍浏览</a></li>
					<li><a href="Login.jsp">我的账户</a></li>
					<li><a href="Login.jsp">登录</a></li>
				</ul>
				<%
				}else if(grade.equals("1"))//表明当前用户是顾客
				{
				 %>
				 <ul>
					<li><a href="bookshop.jsp">主页</a></li>
					<li><a href="about.jsp">关于我们</a></li>
					<li><a href="bookInfo.action">书籍浏览</a></li>
					<li><a href="userInfomation.jsp">个人中心</a></li>
					<li><a href="GetOrderInfo.jsp">我的订单</a></li>
				</ul>
				<%
				}else
				{
				 %>
				 <ul>
					<li><a href="shopkeeper.jsp">主页</a></li>
					<li><a href="user.action">用户管理</a></li>
					<li><a href="bookInfo.action">书籍管理</a></li>
					<li><a href="OrderManage.jsp">订单管理</a></li>
					<li><a href="userInfomation.jsp">个人中心</a></li>
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
						alt="" title="" /> </span>出错了...
				</div>
				<div class="feat_prod_box_details">
					<p class="details">
						<img src="images/book.jpg">
					</p>
					<br><br><br><br><br>
					<p><font color="red" size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;对不起！
					<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=reason %></font></p>
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
					<span class="red"> 您还未登录: </span> <a href="Login.jsp">登录</a>
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
						0 x items | <span class="red">TOTAL: 0</span>
					</div>
					<%
					} else if(grade.equals("1"))//顾客身份
					{
					 %>
				    <div class="home_cart_content"> 
				          <%=session.getAttribute("item_num") %> x items | <span class="red">TOTAL: <%=session.getAttribute("total") %></span> 
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
						alt="" title="" />
					</span>好好读书
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
							alt="" title="" />
						</span>促销书籍
					</div>
					<%
						@SuppressWarnings("unchecked")
						List<book> bList = (List<book>) request.getSession().getAttribute("Books");
					%>
				 <marquee direction="up" height="480" scrollamount="2" scrolldelay="80" onmouseover="this.scrollDelay=500" onmouseout="this.scrollDelay=1" width="200">  
					<%
				        	for (int i = 0; i < bList.size(); i++) {
									book sc = bList.get(i);
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
