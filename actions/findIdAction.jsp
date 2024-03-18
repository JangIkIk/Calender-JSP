<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.regex.Pattern"%>


<%  
    String userId = null;
    try{
        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        String getUserName = request.getParameter("userName");
        String getUserEmail = request.getParameter("userEmail");

        String namePattern = "^[가-힣a-zA-Z]{2,10}$";
        boolean nameRegex = Pattern.matches(namePattern, getUserName);
        if(!nameRegex) throw new Exception();

        String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{1,30}$";
        boolean emailRegex = Pattern.matches(emailPattern, getUserEmail);
        if(!emailRegex) throw new Exception();

        String accountSQL = "SELECT id FROM account WHERE name=? AND email=?";
        PreparedStatement accountQuery = connect.prepareStatement(accountSQL);
        accountQuery.setString(1,getUserName);
        accountQuery.setString(2,getUserEmail);
        ResultSet result = accountQuery.executeQuery();
        boolean isExists = result.next();
        if(isExists) userId = "\"" + result.getString(1) + "\"";

    }
    catch(Exception e){
        out.println("<script>alert('올바르지 않은값입니다'); history.back();</script>");
        return;
    } 
%>

<script>
    const userId = <%=userId%>;
    
     if(!userId){
            alert("존재하지 않은 회원");
            history.back();
        }else{
            alert("회원님의 아이디:" + userId);
            window.location.href='/stageus/pages/login.jsp';
        }
</script>
