<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*,java.util.*"%>
<%@ page import="java.util.LinkedList,com.book"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<!-- 该页面用于显示本书店所有的书籍的总体信息 -->
<title>书籍信息</title>
</head>
<%
	int count = 0;
	String picPath = null;
	String hasBook = null;
	book Book = new book();
	String grade = (String)session.getAttribute("grade");
	String userID = (String) session.getAttribute("userID");
	LinkedList<book> list = new LinkedList<book>();
	list = (LinkedList<book>) session.getAttribute("book");
	hasBook = (String) session.getAttribute("noBook");
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
					if (grade == null)//该用户只是游客身份，没有登录
					{
				%>
				<ul>
					<li><a href="bookshop.jsp">主页</a>
					</li>
					<li><a href="about.jsp">关于我们</a>
					</li>
					<li class="selected"><a href="bookInfo.action">书籍浏览</a>
					</li>
					<li><a href="Login.jsp">我的账户</a>
					</li>
					<li><a href="Login.jsp">登录</a>
					</li>
				</ul>
				<%
					} else if (grade.equals("0"))//该用户是管理员
					{
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
				}else//该用户是顾客
				{
				 %>
				<ul>
					<li><a href="customer.jsp">主页</a>
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
					<span class="title_icon"><img src="images/bullet2.gif"
						alt="" title="" /> </span>所有书籍
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
				<%
				if(userID != null)
				{
				    if(grade.equals("0"))
				    {
				 %>
				<div class="title">
					<span class="title_icon"><img src="images/bullet2.gif"
						alt="" title="" /> </span><a href="bookAdd.jsp">书籍添加</a>
				</div>
				<%
				}else
				{
				 %>
				<div class="title">
					<span class="title_icon"><img src="images/bullet2.gif"
						alt="" title="" /> </span><a href="bookAdd.jsp">旧书发布</a>
				</div>
				<%
				 }
				 }
				  %>
				<div class="new_products">
					<s:iterator value="#session.book" var="book">
						<div class="new_prod_box">
							<%
								Book = list.get(count);
									count++;
									picPath = Book.getBookPicture();
							%>
							<a href="bookInfo.jsp?bookID=<%=Book.getBookNum()%>"><s:property
									value="#book.bookName" /> </a>
							<div class="new_prod_bg">
								<%
									String new_used = Book.getNewOrUsed();
										if (new_used.equals("1")) {
								%>
								<span class="new_icon"><img src="images/new_icon.gif"
									alt="" title="" /> </span>
								<%
									}
								%>
								<a href="bookInfo.jsp?bookID=<%=Book.getBookNum()%>"><img
									src="<%=picPath%>" alt="" title="" class="thumb" width="60"
									height="80" border="0" /> </a>
							</div>
						</div>
					</s:iterator>
					<%
					String Records = (String)request.getAttribute("totalRecords");
					int totalRecords = 0;
					if(Records.equals("0"))//数据库中没有记录
					{
					 %>
					 <img alt="" src="images/book.jpg" width="450" height="200">
					<br>
					<br>
					<br>
					<br>
					<br> <font color="red" size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					对不起，本书店还没有书籍！</font>
					<%
					 }else
					 {
					     totalRecords = Integer.parseInt(Records);
					     int pages = totalRecords / 15 + 1;     //一共会需要pages个页面
					     if(totalRecords >15)   //总记录在一页中无法显示
					     {
					        String curPage = (String) request.getAttribute("curPage");
					        int cur_page = 0;
					        if(curPage != null)
					             cur_page = Integer.parseInt(curPage);//先获取本页的页数
					        //System.out.println("book.jsp 获取的curPage = "+curPage);
					        if(curPage == null || cur_page == 1 )//表明该页属于第一页
					        {
					            cur_page = 1;
					  %>
					<div class="new_prod_box">
						<a href="bookInfo.action?curPage=<%=cur_page+1 %>"
							class="checkout">下一页</a>
					</div>
					<%
					        }
					        else  if(pages == cur_page)    //表明该页是最后一页
					        {
					           
					   %>
					<div class="new_prod_box">
						<a href="bookInfo.action?curPage=<%=cur_page-1 %>"
							class="continue">上一页</a>
					</div>
					<%
					        }else
					       {
					   %>
					<div class="new_prod_box">
						<a href="bookInfo.action?curPage=<%=cur_page-1 %>"
							class="continue">上一页</a> <a
							href="bookInfo.action?curPage=<%=cur_page+1 %>" class="checkout">下一页</a>
					</div>
					<% 
					       }
					     }
					   }
					    %>
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
					<span class="red"> 您还未登录: </span> <a href="Login.jsp">登录</a>
					<%
						} else {
					%>
					<span class="red"> 你好, </span>
					<%=userID %><a href="Logout.action">退出</a>
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
				          <%=session.getAttribute("item_num") %> x 种书 | <span class="red">总价: <%=session.getAttribute("total") %></span> 
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
