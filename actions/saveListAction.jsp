<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Connector 파일을 찾는 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>
<%-- 데이터베이스에 연결하는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- sql을 전송하는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement"%>


<%
    // 세션이 있어야할것같음
    request.setCharacterEncoding("UTF-8");
    String getDate = request.getParameter("date");
    String getTime = request.getParameter("time");
    String getContent = request.getParameter("content");
%>




<script>
    console.log("<%=getDate%>");
    console.log("<%=getTime%>");
    console.log("<%=getContent%>");
    // 보고있던 년,월,일의 상세보기 모달창으로 돌아가야함
    window.location.href = "/stageus/pages/scheduleInfoModal.jsp";
</script>