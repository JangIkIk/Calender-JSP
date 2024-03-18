<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.regex.Pattern"%>

<%  
    try{
        String sessionId = (String) session.getAttribute("session_id");
        if(sessionId == null){
            out.println("<script>alert('회원만 가능'); window.location.href='/stageus/pages/login.jsp';</script>");
            return;
        };

        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        String getModalDate = request.getParameter("modalDate");
        String getModalTime = request.getParameter("modalTime");
        String getModalContent = request.getParameter("modalContent");

        String datePattern = "\\d{4}-\\d{2}-\\d{2}";
        boolean dateRegex = Pattern.matches(datePattern, getModalDate);
        if(!dateRegex) throw new Exception();

        String timePattern = "([01]\\d|2[0-3]):([0-5]\\d)";
        boolean timeRegex = Pattern.matches(timePattern, getModalTime);
        if(!timeRegex) throw new Exception();

        String contentPattern = "^.{1,20}$";
        boolean contentRegex = Pattern.matches(contentPattern, getModalContent);
        if(!contentRegex) throw new Exception();

        String sessionIdCheckSQL = "SELECT id FROM account WHERE idx=?";
        PreparedStatement sessionIdCheckQuery = connect.prepareStatement(sessionIdCheckSQL);
        sessionIdCheckQuery.setString(1,sessionId);
        ResultSet idResult = sessionIdCheckQuery.executeQuery();
        if(!idResult.next()) throw new Exception();
        
        String schedulerSQL = "INSERT INTO scheduler (date, time, content, account_idx) VALUES (?, ?, ?, ?)";
        PreparedStatement schedulerQuery = connect.prepareStatement(schedulerSQL);
        schedulerQuery.setString(1,getModalDate);
        schedulerQuery.setString(2,getModalTime);
        schedulerQuery.setString(3,getModalContent);
        schedulerQuery.setString(4,sessionId);
        schedulerQuery.executeUpdate();
    }
    catch(Exception e){
        out.println("<script>alert('일정등록 실패'); history.back();</script>");
        return;
    }    
%>

<script>
    window.location.href = "/stageus/pages/schedule.jsp";
</script>