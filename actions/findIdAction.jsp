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
    String getUserName = request.getParameter("userName");
    String getUserEmail = request.getParameter("userEmail");

    String namePattern = "^[가-힣a-zA-Z]{2,10}$";
    String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{1,30}$";
    boolean nameRegex = Pattern.matches(namePattern, getUserName);
    boolean emailRegex = Pattern.matches(emailPattern, getUserEmail);

    try{
        if(!nameRegex) throw new Exception();
        if(!emailRegex) throw new Exception();
    }
    catch(Exception e){
        out.println("<script>alert('올바르지 않은값입니다'); history.back();</script>");
        return;
    } 

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

    String SQL = "SELECT id FROM user WHERE name=? AND email=?";
    PreparedStatement query = connect.prepareStatement(SQL);
    query.setString(1,getUserName);
    query.setString(2,getUserEmail);
    ResultSet result = query.executeQuery();
    boolean isExists = result.next();
    String userId;
    if(!isExists){
        userId = null;
    }else{
        userId = "\"" + result.getString(1) + "\"";
    }
%>

<script>
    const userId = <%=userId%>;
     if(!userId){
            alert("존재하지 않은 회원");
            history.back();
        }else{
            alert("회원님의 아이디:" + userId);
            window.location.href='/stageus/pages/login.jsp';
        }
</script>
