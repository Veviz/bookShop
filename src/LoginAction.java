import com.opensymphony.xwork2.ActionSupport;


public class LoginAction extends ActionSupport {//����̳���ActionSupport�ࡣ�����Ϳ���ֱ��ʹ��SUCCESS, LOGIN�ȱ�������дexecute�ȷ���


 private static final long serialVersionUID = 1L;

 private String username;
 private String password;
 
 public String getUsername() {
  return username;
 }
 public void setUsername(String username) {
  this.username = username;
 }
 public String getPassword() {
  return password;
 }
 public void setPassword(String password) {
  this.password = password;
 }

 @Override
 public String execute() throws Exception {
  if("haha".equals(username) && "hehe".equals(password))//�����¼���û���=haha��������=hehe���ͷ���SUCCESS�����򣬷���LOGIN
   return SUCCESS;
  return LOGIN;
 }
}
