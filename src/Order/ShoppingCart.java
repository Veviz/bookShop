package Order;

public class ShoppingCart {
	private String userID;
    private String bookNumber;
    private String orderBookName;
    private Integer bookCount;
    private double payment;
    private String Imagepath;
    public void setuserID(String userID)
    {
 	   this.userID = userID;
    }
    public String getuserID()
    {
 	   return userID;
    }
    public void setbookNumber(String bookNumber)
    {
 	   this.bookNumber = bookNumber;
    }
    public String getbookNumber()
    {
 	   return bookNumber;
    }
    public void setorderBookName(String orderBookName)
    {
 	   this.orderBookName = orderBookName;
    }
    public String getorderBookName()
    {
 	   return orderBookName;
    }
    public void setbookCount(Integer bookCount)
    {
 	   this.bookCount = bookCount;
    }
    public Integer getbookCount()
    {
 	   return bookCount;
    }
    public void setpayment(double payment)
    {
 	   this.payment = payment;
    }
    public double getpayment()
    {
 	   return payment;
    }
    public void setImagepath(String Imagepath)
    {
 	   this.Imagepath = Imagepath;
    }
    public String getImagepath()
    {
 	   return Imagepath;
    }
}

