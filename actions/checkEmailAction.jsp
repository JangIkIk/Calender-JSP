<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.regex.Pattern"%>

<%
    String getUserEmail;
    String parseUserEmail;
    boolean isUserEmail;
    try{
        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        getUserEmail = request.getParameter("userEmail");
        parseUserEmail = "\"" + getUserEmail + "\"";

        String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{1,30}$";
        boolean emailRegex = Pattern.matches(emailPattern, getUserEmail);
        if(!emailRegex) throw new Exception();
        
        String accountSQL = "SELECT email FROM account WHERE email=?";
        PreparedStatement accountQuery = connect.prepareStatement(accountSQL);
        accountQuery.setString(1,getUserEmail);
        ResultSet result = accountQuery.executeQuery();
        isUserEmail = result.next();   
    }
    catch(Exception e){
        out.println("<script>alert('올바르지 않은 값입니다'); self.close();</script>");
        return;
    } 

    
%>
<script>
        const isUserEmail = <%=isUserEmail%>;
        const parseUserEmail = <%=parseUserEmail%>;

        try{
            if(isUserEmail) throw ("사용중인 이메일입니다");
            const CONFIRM = confirm("사용가능한 이메일입니다. 사용하시겠습니까?");
            if(!CONFIRM) throw ("");
            opener.emailCheck(parseUserEmail);

        }catch(error){
            if(error)alert(error);

        }finally{
            self.close();
        }
</script>
