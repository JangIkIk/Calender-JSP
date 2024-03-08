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
    String getUserName = request.getParameter("userName");
    String getUserEmail = request.getParameter("userEmail");

    // Java에서 mySql 데이터베이스와의 연결을 위해 필요한 작업
    Class.forName("com.mysql.jdbc.Driver");
    // mySql 데이터 베이스와의 연결 (dbURL, sql 계정아이디, sql 계정비번)
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

    // 쿼리문정의
    String SQL = "SELECT id FROM user WHERE name=? AND email=?";
    // 미리 컴파일된 sql문 객체를 생성
    PreparedStatement query = connect.prepareStatement(SQL);
    query.setString(1,getUserName);
    query.setString(2,getUserEmail);
    ResultSet result = query.executeQuery();
    boolean isExists = result.next();
    String isUser;
    if(!isExists){
        isUser = null;
    }else{
        isUser = "\"" + result.getString(1) + "\"";
    }
%>

<script>
    const userId = <%=isUser%>;
    if(!userId){
        alert("존재하지 않은 회원");
        history.back();
    }else{
        alert("회원님의 아이디:" + userId);
        window.location.href='/stageus/pages/login.jsp';
    }
</script>
<%-- 
    확인필요
    서버측에 유효성검사
 --%>