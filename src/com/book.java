package com;

public class book {

	private String bookNum;                //书籍编号
	private String bookName;               //书籍名称
	private String newOrUsed;                //新书还是旧书
	private String authorName;             //书籍作者名称
	private String press;
	private String publishTime;            //出版时间
	private String price;                  //书籍价格
	private String stockNum;                  //储藏量
	private String briefInfo;              //书籍简介
	private String publisherID;            //上传者昵称
	private String bookPicture;             //书籍图片的相对路径
	
	
	public String getPress() {
		return press;
	}
	public void setPress(String press) {
		this.press = press;
	}
	public String getBookNum() {
		return bookNum;
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
	public String getBookPicture() {
		return bookPicture;
	}
	public void setBookPicture(String bookPicture) {
		this.bookPicture = bookPicture;
	}
}
