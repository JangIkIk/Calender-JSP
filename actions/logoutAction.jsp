<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    session.removeAttribute("session_id");
    // 세션전체삭제로 변경
%>

<script>
    location.href = '/stageus/pages/login.jsp';
</script>