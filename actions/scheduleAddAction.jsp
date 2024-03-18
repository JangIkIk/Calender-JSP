<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Connector 파일을 찾는 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>
<%-- 데이터베이스에 연결하는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- sql을 전송하는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement"%>
<%-- 정규 표현식 --%>
<%@ page import="java.util.regex.Pattern"%>


<%  
    // 세션확인
    String sessionId = (String) session.getAttribute("session_id");

    // 세션이 있어야할것같음
    request.setCharacterEncoding("UTF-8");
    String getModalDate = request.getParameter("modalDate");
    String getModalTime = request.getParameter("modalTime");
    String getModalContent = request.getParameter("modalContent");


    String datePattern = "\\d{4}-\\d{2}-\\d{2}";
    boolean dateRegex = Pattern.matches(datePattern, getModalDate);

    String timePattern = "([01]\\d|2[0-3]):([0-5]\\d)";
    boolean timeRegex = Pattern.matches(timePattern, getModalTime);

    String contentPattern = "^.{1,20}$";
    boolean contentRegex = Pattern.matches(contentPattern, getModalContent);

    try{
        if(!dateRegex) throw new Exception();
        if(!dateRegex) throw new Exception();
        if(!dateRegex) throw new Exception();
    }
    catch(Exception e){
        out.println("<script>alert('일정등록 실패'); history.back();</script>");
        return;
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

    String schedulerSQL = "INSERT INTO scheduler (date, time, content, account_idx) VALUES (?, ?, ?, ?)";
    PreparedStatement schedulerQuery = connect.prepareStatement(schedulerSQL);
    schedulerQuery.setString(1,getModalDate);
    schedulerQuery.setString(2,getModalTime);
    schedulerQuery.setString(3,getModalContent);
    schedulerQuery.setString(4,sessionId);
    schedulerQuery.executeUpdate();
%>

<script>
    alert("글쓰기 추가");
    window.location.href = "/stageus/pages/schedule.jsp";
</script>