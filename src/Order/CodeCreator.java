package Order;

import java.text.SimpleDateFormat;
import java.util.Date;
public class CodeCreator {
       public String createAccountcode(String userID)
       {
    	   SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    	   String accountCode = sdf.format(new Date()).toString();
    	   accountCode = accountCode + userID;
    	   return accountCode;
       }
}
