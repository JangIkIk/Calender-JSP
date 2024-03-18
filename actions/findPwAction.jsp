<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.regex.Pattern"%>

<%
    String userPw = null;
    try{
        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        String getUserId = request.getParameter("userId");
        String getUserEmail = request.getParameter("userEmail");

        String idPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$";
        boolean idRegex = Pattern.matches(idPattern, getUserId);
        if(!idRegex) throw new Exception();

        String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{1,30}$";
        boolean emailRegex = Pattern.matches(emailPattern, getUserEmail);
        if(!emailRegex) throw new Exception();

        String accountSQL = "SELECT password FROM account WHERE id=? AND email=?";
        PreparedStatement accountQuery = connect.prepareStatement(accountSQL);
        accountQuery.setString(1,getUserId);
        accountQuery.setString(2,getUserEmail);
        ResultSet result = accountQuery.executeQuery();
        boolean isExists = result.next();
        if(isExists) userPw = "\"" + result.getString(1) + "\"";

    }
    catch(Exception e){
        out.println("<script>alert('올바르지 않은값입니다'); history.back();</script>");
        return;
    } 
%>

<script>
    const userPw = <%=userPw%>;

    if(!userPw){
        alert("존재하지 않은 회원");
        history.back();
    }else{
        alert("회원님의 비밀번호:" + userPw);
        window.location.href='/stageus/pages/login.jsp';
    }
</script>