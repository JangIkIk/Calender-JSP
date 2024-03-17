<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%-- Connector 파일을 찾는 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>
<%-- 데이터베이스에 연결하는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- sql을 전송하는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement"%>
<%-- Table 데이터 저장하는 라이브러리 --%>
<%@ page import="java.sql.ResultSet"%>
<%-- 정규 표현식 --%>
<%@ page import="java.util.regex.Pattern"%>

<%
    request.setCharacterEncoding("UTF-8");
    String getUserId = request.getParameter("userId");
    String getUserEmail = request.getParameter("userEmail");

    String idPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$";
    String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{1,30}$";

    boolean idRegex = Pattern.matches(idPattern, getUserId);
    boolean emailRegex = Pattern.matches(emailPattern, getUserEmail);

    try{
        if(!idRegex) throw new Exception();
        if(!emailRegex) throw new Exception();
    }
    catch(Exception e){
        out.println("<script>alert('올바르지 않은값입니다'); history.back();</script>");
        return;
    } 

    
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");
    String SQL = "SELECT password FROM user WHERE id=? AND email=?";
    PreparedStatement query = connect.prepareStatement(SQL);
    query.setString(1,getUserId);
    query.setString(2,getUserEmail);
    ResultSet result = query.executeQuery();
    boolean isExists = result.next();
    String userPw;
    if(!isExists){
        userPw = null;
    }else{
        userPw = "\"" + result.getString(1) + "\"";
    }
%>

<%-- 
    [재확인]
    1. scropt영역에서 load 이벤트 제거 ?
    2. 임시비밀번호로 돌려줘야할지?
 --%>
<script>
    const userPw = <%=userPw%>;
    if(!userPw){
        alert("존재하지 않은 회원");
        history.back();
    }else{
        alert("회원님의 비밀번호:" + userPw);
        window.location.href='/stageus/pages/login.jsp';
    }
</script>