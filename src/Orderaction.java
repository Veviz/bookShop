
import com.opensymphony.xwork2.ActionSupport;


public class Orderaction extends ActionSupport {//����̳���ActionSupport�ࡣ�����Ϳ���ֱ��ʹ��SUCCESS, LOGIN�ȱ�������дexecute�ȷ���


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