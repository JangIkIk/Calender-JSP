<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%-- Connector 파일을 찾는 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>
<%-- 데이터베이스에 연결하는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- sql을 전송하는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement"%>
<%-- 정규 표현식 --%>
<%@ page import="java.util.regex.Pattern"%>


<%
    request.setCharacterEncoding("UTF-8");
    String getUserId = request.getParameter("userId");
    String getUserPw = request.getParameter("userPw");
    String getUserName = request.getParameter("userName");
    String getUserEmail = request.getParameter("userEmail");
    String getUserTim = request.getParameter("userTim");
    String getUserRank = request.getParameter("userRank");

    String idPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$";
    String pwPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$";
    String namePattern = "^[가-힣a-zA-Z]{2,10}$";
    String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{1,30}$";

    boolean idRegex = Pattern.matches(idPattern, getUserId);
    boolean pwRegex = Pattern.matches(pwPattern, getUserPw);
    boolean nameRegex = Pattern.matches(namePattern, getUserName);
    boolean emailRegex = Pattern.matches(emailPattern, getUserEmail);

    try{
        if(!idRegex) throw new Exception("아이디가 올바르지 않습니다");
        if(!pwRegex) throw new Exception();
        if(!nameRegex) throw new Exception();
        if(!emailRegex) throw new Exception();
        if(getUserTim == "") throw new Exception();
        if(getUserRank == "") throw new Exception();
        
    }
    catch(Exception e){
        //response.sendError(400,e.getMessage());
        //response.sendRedirect("/stageus/pages/error.jsp");
        out.println("<script>alert('가입실패'); history.back();</script>");
        return;
    } 
    
    // Java에서 mySql 데이터베이스와의 연결을 위해 필요한 작업
    Class.forName("com.mysql.jdbc.Driver");
    // mySql 데이터 베이스와의 연결 (dbURL, sql 계정아이디, sql 계정비번)
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");
    // 쿼리문정의
    String SQL = "INSERT INTO user (id, password, name, email, tim, rank) VALUES (?, ?, ?, ?, ?, ?)";
    // 미리 컴파일된 sql문 객체를 생성
    PreparedStatement query = connect.prepareStatement(SQL);
    query.setString(1,getUserId);
    query.setString(2,getUserPw);
    query.setString(3,getUserName);
    query.setString(4,getUserEmail);
    query.setString(5,getUserTim);
    query.setString(6,getUserRank);
    query.executeUpdate();
%>
<script>
    alert("회원가입 완료!");
    window.location.href='/stageus/pages/login.jsp';
</script>

