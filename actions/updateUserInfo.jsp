<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.regex.Pattern"%>

<%
    String getDateValue;
    String getTimeValue;
    String getContentValue;
    String getIdx;
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

        getDateValue = request.getParameter("date");
        getTimeValue = request.getParameter("time");
        getContentValue = request.getParameter("content");
        getIdx = request.getParameter("idx");
        getYears = request.getParameter("years");
        getMonth = request.getParameter("month");
        getDay = request.getParameter("day");

        String datePattern = "\\d{4}-\\d{2}-\\d{2}";
        boolean dateRegex = Pattern.matches(datePattern, getDateValue);
        if(!dateRegex) throw new Exception();

        String timePattern = "([01]\\d|2[0-3]):([0-5]\\d)";
        boolean timeRegex = Pattern.matches(timePattern, getTimeValue);
        if(!timeRegex) throw new Exception();

        String contentPattern = "^.{1,20}$";
        boolean contentRegex = Pattern.matches(contentPattern, getContentValue);
        if(!contentRegex) throw new Exception();

        String sessionIdCheckSQL = "SELECT id FROM account WHERE idx=?";
        PreparedStatement sessionIdCheckQuery = connect.prepareStatement(sessionIdCheckSQL);
        sessionIdCheckQuery.setString(1,sessionId);
        ResultSet idResult = sessionIdCheckQuery.executeQuery();
        if(!idResult.next()) throw new Exception();

        String scheduleUpdateSQL = "UPDATE scheduler SET date=?, time=?, content=? WHERE idx=? AND account_idx=?";
        PreparedStatement scheduleUpdateQuery = connect.prepareStatement(scheduleUpdateSQL);
        scheduleUpdateQuery.setString(1,getDateValue);
        scheduleUpdateQuery.setString(2,getTimeValue);
        scheduleUpdateQuery.setString(3,getContentValue);
        scheduleUpdateQuery.setString(4,getIdx);
        scheduleUpdateQuery.setString(5,sessionId);
        scheduleUpdateQuery.executeUpdate();
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