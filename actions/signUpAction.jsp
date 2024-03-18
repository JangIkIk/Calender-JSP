<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.regex.Pattern"%>

<%
    try{
        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        String getUserId = request.getParameter("userId");
        String getUserPw = request.getParameter("userPw");
        String getUserName = request.getParameter("userName");
        String getUserEmail = request.getParameter("userEmail");
        String getUserTim = request.getParameter("userTim");
        String getUserRank = request.getParameter("userRank");

        String idPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$";
        boolean idRegex = Pattern.matches(idPattern, getUserId);
        if(!idRegex) throw new Exception();

        String pwPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$";
        boolean pwRegex = Pattern.matches(pwPattern, getUserPw);
        if(!pwRegex) throw new Exception();

        String namePattern = "^[가-힣a-zA-Z]{2,10}$";
        boolean nameRegex = Pattern.matches(namePattern, getUserName);
        if(!nameRegex) throw new Exception();

        String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{1,30}$";
        boolean emailRegex = Pattern.matches(emailPattern, getUserEmail);
        if(!emailRegex) throw new Exception();

        if(getUserTim == "") throw new Exception();
        if(getUserRank == "") throw new Exception();

        String accountIdCheckSQL = "SELECT id FROM account WHERE id=?";
        PreparedStatement accountIdCheckQuery = connect.prepareStatement(accountIdCheckSQL);
        accountIdCheckQuery.setString(1,getUserId);
        ResultSet idResult = accountIdCheckQuery.executeQuery();
        if(idResult.next()) throw new Exception();

        String accountEmailCheckSQL = "SELECT email FROM account WHERE email=?";
        PreparedStatement accountEmailCheckQuery = connect.prepareStatement(accountEmailCheckSQL);
        accountEmailCheckQuery.setString(1,getUserEmail);
        ResultSet emailResult = accountEmailCheckQuery.executeQuery();
        if(emailResult.next()) throw new Exception();

        String accountSQL = "INSERT INTO account (id, password, name, email, tim, rank) VALUES (?, ?, ?, ?, ? ,?)";
        PreparedStatement accountQuery = connect.prepareStatement(accountSQL);
        accountQuery.setString(1,getUserId);
        accountQuery.setString(2,getUserPw);
        accountQuery.setString(3,getUserName);
        accountQuery.setString(4,getUserEmail);
        accountQuery.setString(5,getUserTim);
        accountQuery.setString(6,getUserRank);
        accountQuery.executeUpdate();
    }
    catch(Exception e){
        out.println("<script>alert('가입실패'); history.back();</script>");
        return;
    } 
%>
<script>
    alert("회원가입 완료!");
    window.location.href='/stageus/pages/login.jsp';
</script>

