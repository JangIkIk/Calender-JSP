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
    String getModalDate = request.getParameter("modalDate");
    String getModalTime = request.getParameter("modalTime");
    String getModalContent = request.getParameter("modalContent");
    
%>




<script>
    alert("글쓰기 추가");
    console.log("<%=getModalDate%>");
    console.log("<%=getModalTime%>");
    console.log("<%=getModalContent%>");
    window.location.href = "/stageus/pages/schedule.jsp";
</script>