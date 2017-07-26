
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;


public class Deleteaction extends ActionSupport {//该类继承了ActionSupport类。这样就可以直接使用SUCCESS, LOGIN等变量和重写execute等方法


 private static final long serialVersionUID = 1L;

 @Override
 public String execute() throws Exception {
  ActionContext.getContext().put("message", "删除成功！");
  return "success";
 }
}