<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userId = request.getParameter("userId");
    String userPw = request.getParameter("userPw");
    String userName = request.getParameter("userName");
    String userEmail = request.getParameter("userEmail");
    String userTim = request.getParameter("userTim");
    String userRank = request.getParameter("userRank");

%>

<script>
    console.log("<%=userId%>");
    console.log("<%=userPw%>");
    console.log("<%=userName%>");
    console.log("<%=userEmail%>");
    console.log("<%=userTim%>");
    console.log("<%=userRank%>");
</script>