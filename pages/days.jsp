<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    String testPar = request.getParameter("test");
    // 부모요소에서 파라미터를 전달받아 일에대한 개수와 데이터를 같이 넣어야한다
%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/utility.css" rel="stylesheet" type="text/css">
    </head>
    <body>
            <%-- 여기서 데이터 --%>
            <ul id="days">
            </ul>
            <p id="testText"></p>
    </body>
    <script>
        
    </script>
</html>