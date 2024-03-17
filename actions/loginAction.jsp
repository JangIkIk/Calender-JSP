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
    String getUserPw = request.getParameter("userPw");

    String idPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$";
    String pwPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$";

    boolean idRegex = Pattern.matches(idPattern, getUserId);
    boolean pwRegex = Pattern.matches(pwPattern, getUserPw);

    try{
        if(!idRegex) throw new Exception();
        if(!pwRegex) throw new Exception();
        
    }
    catch(Exception e){
        out.println("<script>alert('올바르지 않은 값입니다'); history.back();</script>");
        return;
    } 

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

    String SQL = "SELECT idx FROM user WHERE id=? AND password=?";

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
    const isExists = <%=isExists%>;

    if(!isExists){
        alert("로그인 실패");
        history.back();
    }else{
        window.location.href='/stageus/pages/schedule.jsp';
    }
</script>
