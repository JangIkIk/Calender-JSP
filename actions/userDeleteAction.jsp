<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>

<%
    try{
        String sessionId = (String) session.getAttribute("session_id");
        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        String userScheduleDeleteSQL = "DELETE FROM scheduler WHERE account_idx=?";
        PreparedStatement userScheduleDeleteQuery = connect.prepareStatement(userScheduleDeleteSQL);
        userScheduleDeleteQuery.setString(1,sessionId);
        userScheduleDeleteQuery.executeUpdate();

        String userInfoDeleteSQL = "DELETE FROM account WHERE idx=?";
        PreparedStatement userInfoDeleteQuery = connect.prepareStatement(userInfoDeleteSQL);
        userInfoDeleteQuery.setString(1,sessionId);
        userInfoDeleteQuery.executeUpdate();

        session.invalidate();
    }
    catch(Exception e){
        out.println("<script>alert('회월탈퇴를 할수가 없습니다.'); history.back();</script>");
        return;
    }
    
%>

<script>
    location.href = '/stageus/pages/login.jsp';
</script>