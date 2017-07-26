package Order;

public class OrderInfo {
	private String orderID;
	private String userID;
	private String receiverName;
	private String contactWay;
	private String receiveAddr;
	private float payMoney;
	private int orderStatus;
	
	public void setorderID(String orderID)
	{
		this.orderID = orderID;
	}
	public String getorderID()
	{
		return this.orderID;
	}
	public void setuserID(String userID)
	{
		this.userID = userID;
	}
	public String getuserID()
	{
		return this.userID;
	}
	public void setreceiverName(String receiverName)
	{
		this.receiverName = receiverName;
	}
	public String getreceiverName()
	{
		return this.receiverName;
	}
	public void setcontactWay(String contactWay)
	{
		this.contactWay = contactWay;
	}
	public String getcontactWay()
	{
		return this.contactWay;
	}
	public void setreceiveAddr(String receiveAddr)
	{
		this.receiveAddr = receiveAddr;
	}
	public String getreceiveAddr()
	{
		return this.receiveAddr;
	}
	public void setpayMoney(float payMoney)
	{
		this.payMoney = payMoney;
	}
	public float getpayMoney()
	{
		return this.payMoney;
	}
	public void setorderStatus(int orderStatus)
	{
		this.orderStatus = orderStatus;
	}
	public int getorderStatus()
	{
		return this.orderStatus;
	}
}
