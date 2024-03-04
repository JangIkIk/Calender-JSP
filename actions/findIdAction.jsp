<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userName = request.getParameter("userName");
    String userEmail = request.getParameter("userEmail");

%>

<script>
    console.log("<%=userName%>");
    console.log("<%=userEmail%>");
</script>