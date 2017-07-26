
import com.opensymphony.xwork2.ActionSupport;


public class Orderaction extends ActionSupport {//该类继承了ActionSupport类。这样就可以直接使用SUCCESS, LOGIN等变量和重写execute等方法


 private static final long serialVersionUID = 1L;

 public String order_edit() throws Exception {
  return "success";
 }
 public String store_order() {
	 return "store";
 }
 public String change_order(){
	 return "change";
 }
 public String show_order(){
	 return "show";
 }
 public String payMoney(){
	 return "paymoney";
 }
 public String updateorder(){
	 return "updateorder";
 }
 public String deleteorder(){
	 return "deleteorder";
 }
}