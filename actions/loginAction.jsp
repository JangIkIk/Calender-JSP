<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.regex.Pattern"%>

<%
    boolean isExists;
    try{
        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        String getUserId = request.getParameter("userId");
        String getUserPw = request.getParameter("userPw");

        String idPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$";
        boolean idRegex = Pattern.matches(idPattern, getUserId);
        if(!idRegex) throw new Exception();

        String pwPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$";
        boolean pwRegex = Pattern.matches(pwPattern, getUserPw);
        if(!pwRegex) throw new Exception();

        String accountSQL = "SELECT * FROM account WHERE id=? AND password=?";
        PreparedStatement accountQuery = connect.prepareStatement(accountSQL);
        accountQuery.setString(1,getUserId);
        accountQuery.setString(2,getUserPw);
        ResultSet result = accountQuery.executeQuery();
        isExists = result.next();
        if(isExists) session.setAttribute("session_id", result.getString("idx"));
    
    }
    catch(Exception e){
        out.println("<script>alert('올바르지 않은 값입니다'); history.back();</script>");
        return;
    } 
%>

<script>
    const isExists = <%=isExists%>;

    if(!isExists){
        alert("로그인 실패");
        history.back();
    }else{
        window.location.href='/stageus/pages/schedule.jsp';
    }
</script>
