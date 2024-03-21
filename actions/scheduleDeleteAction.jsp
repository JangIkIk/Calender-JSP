<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.regex.Pattern"%>

<%
    String getYears;
    String getMonth;
    String getDay;
    try{
        String sessionId = (String) session.getAttribute("session_id");
        if(sessionId == null){
            out.println("<script>alert('회원만 가능'); window.location.href='/stageus/pages/login.jsp';</script>");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        String getIdx = request.getParameter("idx");
        getYears = request.getParameter("years");
        getMonth = request.getParameter("month");
        getDay = request.getParameter("day");

        String sessionIdCheckSQL = "SELECT id FROM account WHERE idx=?";
        PreparedStatement sessionIdCheckQuery = connect.prepareStatement(sessionIdCheckSQL);
        sessionIdCheckQuery.setString(1,sessionId);
        ResultSet idResult = sessionIdCheckQuery.executeQuery();
        if(!idResult.next()) throw new Exception();

        String scheduleDeleteSQL = "DELETE FROM scheduler WHERE idx=? AND account_idx=?";
        PreparedStatement scheduleDeleteQuery = connect.prepareStatement(scheduleDeleteSQL);
        scheduleDeleteQuery.setString(1,getIdx);
        scheduleDeleteQuery.setString(2,sessionId);
        scheduleDeleteQuery.executeUpdate();
    }
    catch(Exception e){
        out.println("<script>alert('일정수정 실패'); history.back();</script>");
        return;
    }
%>

<script>
    const getYears = "<%=getYears%>";
    const getMonth = "<%=getMonth%>";
    const getDay = "<%=getDay%>";
    location.href = "/stageus/pages/scheduleInfoModal.jsp?" + "year=" + getYears + "&month=" + getMonth + "&day=" + getDay;
</script>