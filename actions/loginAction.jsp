<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%-- Connector 파일을 찾는 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>
<%-- 데이터베이스에 연결하는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- sql을 전송하는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement"%>
<%-- Table 데이터 저장하는 라이브러리 --%>
<%@ page import="java.sql.ResultSet"%>

<%
    request.setCharacterEncoding("UTF-8");
    String getUserId = request.getParameter("userId");
    String getUserPw = request.getParameter("userPw");

    // Java에서 mySql 데이터베이스와의 연결을 위해 필요한 작업
    Class.forName("com.mysql.jdbc.Driver");
    // mySql 데이터 베이스와의 연결 (dbURL, sql 계정아이디, sql 계정비번)
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

    // 쿼리문정의
    String SQL = "SELECT idx FROM user WHERE id=? AND password=?";
    // 미리 컴파일된 sql문 객체를 생성
    PreparedStatement query = connect.prepareStatement(SQL);
    query.setString(1,getUserId);
    query.setString(2,getUserPw);
    ResultSet result = query.executeQuery();
    boolean isExists = result.next();
    if(isExists){
        session.setAttribute("session_id", getUserId);
    }
%>
<script>
     if(<%=isExists%>){
        alert("로그인성공");
        window.location.href='/stageus/pages/schedule.jsp';
    }else{
        alert("로그인 실패");
        history.back();
    }
</script>
<%-- 
    확인필요
    1. 서버측에 유효성검사
    2. 직급에 대한정보를 클라이언트측에서 알고있어야 할것같다.
    3. 세션정보는 아이디를 저장하는게 맞는걸까 ?
 --%>