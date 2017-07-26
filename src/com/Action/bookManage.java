package com.Action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.User;
import org.apache.struts2.ServletActionContext;

import com.book;
import com.DB.DBConnect;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class bookManage extends ActionSupport{

	private DBConnect conn = new DBConnect();
	
	
	private String searBName;              //搜索时候的书籍名称
	private String bookNum;                //书籍编号
	private String bookName;               //书籍名称
	private String bookKind;               //书籍种类
	private String newOrUsed;                //新书还是旧书
	private String authorName;             //书籍作者名称
	private String press;                  //书籍的出版社
	private String publishTime;            //出版时间
	private String price;                  //书籍价格
	private String stockNum;                  //储藏量
	private String briefInfo;              //书籍简介
	private String publisherID;            //上传者昵称
	//下面的属性为存储文件的
	private List<File> file;
    private List<String> fileFileName;     //获取上传图片的文件名
    private List<String> fileContentType;
    private List<String> dataUrl;
    
    private String bookCount;                //购买书籍的数量
    /////////////////////////////////////////////////////////
    //set and get 
    
    

	public String getBookNum() {
		return bookNum;
	}
	public String getPress() {
		return press;
	}
	public void setPress(String press) {
		this.press = press;
	}
	public String getBookCount() {
		return bookCount;
	}
	public void setBookCount(String bookCount) {
		this.bookCount = bookCount;
	}
	public String getSearBName() {
		return searBName;
	}
	public void setSearBName(String searBName) {
		this.searBName = searBName;
	}
	public String getBookKind() {
		return bookKind;
	}
	public void setBookKind(String bookKind) {
		this.bookKind = bookKind;
	}
	public void setBookNum(String bookNum) {
		this.bookNum = bookNum;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	
	public String getNewOrUsed() {
		return newOrUsed;
	}
	public void setNewOrUsed(String newOrUsed) {
		this.newOrUsed = newOrUsed;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getStockNum() {
		return stockNum;
	}
	public void setStockNum(String stockNum) {
		this.stockNum = stockNum;
	}
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	public String getPublishTime() {
		return publishTime;
	}
	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}
	
	public String getBriefInfo() {
		return briefInfo;
	}
	public void setBriefInfo(String briefInfo) {
		this.briefInfo = briefInfo;
	}
	public String getPublisherID() {
		return publisherID;
	}
	public void setPublisherID(String publisherID) {
		this.publisherID = publisherID;
	}
	public List<File> getFile() {
		return file;
	}
	public void setFile(List<File> file) {
		this.file = file;
	}
	public List<String> getFileFileName() {
		return fileFileName;
	}
	public void setFileFileName(List<String> fileFileName) {
		this.fileFileName = fileFileName;
	}
	public List<String> getFileContentType() {
		return fileContentType;
	}
	public void setFileContentType(List<String> fileContentType) {
		this.fileContentType = fileContentType;
	}
	public List<String> getDataUrl() {
		return dataUrl;
	}
	public void setDataUrl(List<String> dataUrl) {
		this.dataUrl = dataUrl;
	}
	//增加书籍的处理函数
    public String execute() throws Exception{

    	//处理图片上传的函数
    	String relativePath = null;
    	dataUrl = new ArrayList<String>();
        String imgpath = "upload/";
        for (int i = 0; i < file.size(); ++i) {
            InputStream is = new FileInputStream(file.get(i));
            String path = ServletActionContext.getServletContext().getRealPath("/");
            dataUrl.add(imgpath+this.getFileFileName().get(i));
            relativePath = imgpath+this.getFileFileName().get(i);
            
            
            File destFile = new File(path+imgpath, this.getFileFileName().get(i));
            OutputStream os = new FileOutputStream(destFile);

            byte[] buffer = new byte[1000000];
            int length = 0;
            while ((length = is.read(buffer)) > 0) {
                os.write(buffer, 0, length);
            }
            is.close();
            os.close();
        }
        
    	//下面开始将数据存储到数据库中
    	ActionContext actionContext = ActionContext.getContext();
		Map<String,Object> sessionMap = actionContext.getSession();
		

	    //书籍编号是按照时间产生的随便编号，而且不会重复
		Date dt=new Date();
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String nowTime="";
        nowTime= df.format(dt);
        bookNum = nowTime;
		String reason = null;
		publisherID = (String)sessionMap.get("userID");
    	String sql = "insert into bookInfo values('"+bookNum+"','"+bookName+"','"+bookKind+"',"+newOrUsed+",'"+authorName+"','"+
    			press+"','"+publishTime+"',"+price+","+stockNum+",'"+briefInfo+"','"+publisherID+"','"+relativePath+"')";
    	//System.out.println(sql);
    	conn.connect();
    	boolean status = false;
    	status = conn.update(sql);
    	if(status)
    	{
    		conn.close();
			return "success";
    	}
    	reason = "发布书籍失败！";
		sessionMap.put("reason", reason);
		conn.close();
		
		return "failure";
    }
	
    
    //显示所有图书的信息
    public String showBookInfo() throws SQLException, UnsupportedEncodingException
    {
        LinkedList<book> list1  = new LinkedList<book>();
        HttpServletRequest request = ServletActionContext.getRequest();
        String linkName = request.getParameter("linkName");
    	boolean hasBook = false;
    	String curPage = (String) request.getParameter("curPage"); //从jsp文件中获取当前页面的页数
    	//System.out.println("bookManage.java 获取的curPage = "+curPage);
    	request.setAttribute("curPage", curPage);
    	String records = null;             //记录当前bookInfo表中的记录总数
    	int cur_page;
    	if(curPage == null )              //表示当前页面为第一页
    	{
    	     cur_page = 1;               //当前页面的页数
    	}
    	else                            //表示当前页面不是第一页，需要从JSP文件中获取当前页面的页数
    	{
    		cur_page = Integer.parseInt(curPage);
    	}
    	int top_records = 1+(cur_page-1)*15;  //一个临时变量，用于下面的sql语句换页功能
    	//System.out.println("top_records = "+top_records);
    	String sql1 = null;
    	String sql2 = null;
		if (linkName == null) {
			sql1 = "select top 15 * from bookInfo where bookNum <= "
					+ "(select min(bookNum) from bookInfo where bookNum in("
					+ "select top " + top_records
					+ " bookNum from bookInfo order by bookNum desc) )"
					+ " order by bookNum desc";
			// System.out.println("sql1为："+sql1);
			sql2 = "select count(*) as total from bookInfo";// 获取bookInfo表单中记录数量
		} else {
			linkName = new String(linkName.getBytes("iso-8859-1"), "utf-8");
			sql1 = "select top 15 * from bookInfo where bookNum <= "
					+ "(select min(bookNum) from bookInfo where bookNum in("
					+ "select top " + top_records
					+ " bookNum from bookInfo where bookKind='"+linkName+"' order by bookNum desc) )"
					+ "and bookKind='"+linkName+"' order by bookNum desc";// 从数据库中查找符合条件的所有书籍
			sql2 = "select count(*) as total from bookInfo where bookKind='"
					+ linkName + "'";// 获取bookInfo表单中记录数量
		}
		//System.out.println("sql1为："+sql1);
		//System.out.println("sql2为："+sql2);
    	conn.connect();//连接数据库
    	//获取bookInfo表中记录数
    	ResultSet rs2 =  conn.query(sql2);
    	rs2.next();
    	records = rs2.getString("total");    //records中记录的是数据库中纪录的总数
    	request.setAttribute("totalRecords", records);//将该总数存储在session变量totalRecords中
    	//System.out.println("一共的记录数为："+records);
    	//获取bookInfo表中的所有记录
    	ResultSet rs = conn.query(sql1);
    	try{
    		while(rs.next())
    		{
    			hasBook = true;
    			book Book = new book();
    			Book.setBookNum(rs.getString("bookNum"));
    			Book.setBookName(rs.getString("bookName"));
    			Book.setNewOrUsed(rs.getString("newOrUsed"));
    			Book.setPublishTime(rs.getString("publishTime"));
    			Book.setStockNum(rs.getString("stockNum"));
    			Book.setAuthorName(rs.getString("authorName"));
    			Book.setPress(rs.getString("press"));
    			Book.setPrice(rs.getString("price"));
    			Book.setBookPicture(rs.getString("bookPicture"));
    			Book.setBriefInfo(rs.getString("briefInfo"));
    			Book.setPublisherID(rs.getString("publisherID"));
    			list1.add(Book);
    		}
    	}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	Map session=ActionContext.getContext().getSession();
	    session.put("book", list1);
	    if(!hasBook)
	    	session.put("noBook", "1");
	    else
	    	session.put("noBook", "0");
	    return "success";
    }
   
    //删除书籍的处理函数，参数为bookNum
    public String delBook()
    {
    	Map session=ActionContext.getContext().getSession();  
    	HttpServletRequest request = ServletActionContext.getRequest();
		String bookNum = request.getParameter("delBookNum");
		String grade = (String) session.get("grade");
    	String sql = "delete from bookInfo where bookNum='"+bookNum+"'";
    	//System.out.println(sql);
    	boolean status = false;
    	conn.connect();
    	status = conn.update(sql);
    	if(status)
    	{
    		conn.close();
    		if(grade.equals("0"))
    			return "shopkeeper";
    		else if(grade.equals("1"))
    			return "customer";
    	}
    	conn.close();
    	String reason = "删除书籍失败！";
    	session.put("reas", reason);
    	return "failure";
    }
    
    public String editBook() throws IOException
    {
    	String relativePath = null;
    	dataUrl = new ArrayList<String>();
        String imgpath = "upload/";
        for (int i = 0; i < file.size(); ++i) {
            InputStream is = new FileInputStream(file.get(i));
            String path = ServletActionContext.getServletContext().getRealPath("/");
            dataUrl.add(imgpath+this.getFileFileName().get(i));
            relativePath = imgpath+this.getFileFileName().get(i);
            
            
            File destFile = new File(path+imgpath, this.getFileFileName().get(i));
            OutputStream os = new FileOutputStream(destFile);

            byte[] buffer = new byte[1000000];
            int length = 0;
            while ((length = is.read(buffer)) > 0) {
                os.write(buffer, 0, length);
            }
            is.close();
            os.close();
        }
        
    	//下面开始将数据存储到数据库中
        ActionContext actionContext = ActionContext.getContext();
		Map<String,Object> sessionMap = actionContext.getSession();
		String grade = (String)sessionMap.get("grade");
		String bookNum = (String)sessionMap.get("editBookNum");
    	String sql = "update bookInfo set price="+price+",stockNum="+stockNum+",bookPicture='"+relativePath+"' where bookNum='"+bookNum+"'";
    	//System.out.println(sql);
    	conn.connect();
    	boolean status = false;
    	status = conn.update(sql);
    	if(status)
    	{
    		if(grade.equals("0"))
    		{
    			conn.close();
    			return "shopkeeper";
    		}
			return "customer";
    	}
    	return "failure";
    }
    
    public String searchBook() throws SQLException, UnsupportedEncodingException
    {
    	boolean hasBook = false;
        LinkedList<book> bookList  = new LinkedList<book>();
        HttpServletRequest request = ServletActionContext.getRequest();
    	Map session=ActionContext.getContext().getSession();
    	String SBName = request.getParameter("searBName");
    	SBName=new String(SBName.getBytes("iso-8859-1"),"utf-8");
    	String sql = "select * from bookInfo where bookName='"+SBName+"'";
    	//System.out.println(sql);
    	conn.connect();
    	ResultSet rs = conn.query(sql);
    	while(rs.next())
    	{
			hasBook = true;
    		book Book = new book();
			Book.setBookNum(rs.getString("bookNum"));
			Book.setBookName(rs.getString("bookName"));
			Book.setNewOrUsed(rs.getString("newOrUsed"));
			Book.setPublishTime(rs.getString("publishTime"));
			Book.setStockNum(rs.getString("stockNum"));
			Book.setPress(rs.getString("press"));
			Book.setAuthorName(rs.getString("authorName"));
			Book.setPrice(rs.getString("price"));
			Book.setBookPicture(rs.getString("bookPicture"));
			Book.setBriefInfo(rs.getString("briefInfo"));
			Book.setPublisherID(rs.getString("publisherID"));
    		bookList.add(Book);
    	}
	    session.put("searchBook", bookList);
	    if(!hasBook)
	    	session.put("searchNoBook", "1");
	    else
	    	session.put("searchNoBook", "0");
    	return "success";
    }
    
    public String buy() throws SQLException
    {
    	Map session=ActionContext.getContext().getSession();
    	String userID = (String) session.get("userID");
    	String bookNum = (String) session.get("buyBookNum");
    	String sql1 = "select * from bookInfo where bookNum='"+bookNum+"'";
    	//System.out.print(sql1);
    	int newStockNum = 0;
    	String sql2 = null;
    	String sql3 = null;
    	boolean status = false;
    	boolean status2 = false;
    	String reason = null;
    	conn.connect();
    	ResultSet rs1 = conn.query(sql1);
    	while(rs1.next())
    	{
    		sql2 = "insert into shoppingCart values('"+userID+"','" +bookNum+"','"+rs1.getString("bookName")+
    				"',"+bookCount+","+rs1.getString("price")+",'"+rs1.getString("bookPicture")+"')";
    		newStockNum = Integer.parseInt(rs1.getString("stockNum")) - Integer.parseInt(bookCount);
    		if(newStockNum < 0)
    		{
    			reason = "书店库存不足，请减少购买的书籍数量！";
    			session.put("reas", reason);
    			conn.close();
    			return "failure";
    		}
    		sql3 = "update bookInfo set stockNum="+newStockNum+" where bookNum='"+bookNum+"'";
    		//System.out.println(sql2);
    		//System.out.println("购买书籍后更新书籍数量："+sql3);
    		status = conn.update(sql2);
    		status2 = conn.update(sql3);
    		if(status && status2)
    		{
    			conn.close();
    		    session.put("Redirect", "3");
    			return "success";
    		}
    	    else
    	    {
    			conn.close();
    			return "failure";
    		}
    	}
    	return "failure";
    }
}
