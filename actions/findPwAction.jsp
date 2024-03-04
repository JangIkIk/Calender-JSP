<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userId = request.getParameter("userId");
    String userEmail = request.getParameter("userEmail");

%>

<script>
    console.log("<%=userId%>");
    console.log("<%=userEmail%>");
</script>