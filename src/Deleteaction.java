
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;


public class Deleteaction extends ActionSupport {//����̳���ActionSupport�ࡣ�����Ϳ���ֱ��ʹ��SUCCESS, LOGIN�ȱ�������дexecute�ȷ���


 private static final long serialVersionUID = 1L;

 @Override
 public String execute() throws Exception {
  ActionContext.getContext().put("message", "ɾ���ɹ���");
  return "success";
 }
}