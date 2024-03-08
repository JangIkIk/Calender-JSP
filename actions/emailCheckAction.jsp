<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    String getUserEmail = request.getParameter("userEmail");
    String parseUserEmail = "\"" + getUserEmail + "\"";

    // Java에서 mySql 데이터베이스와의 연결을 위해 필요한 작업
    Class.forName("com.mysql.jdbc.Driver");
    // mySql 데이터 베이스와의 연결 (dbURL, sql 계정아이디, sql 계정비번)
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

    String SQL = "SELECT email FROM user WHERE email=?";
    PreparedStatement query = connect.prepareStatement(SQL);
    query.setString(1,getUserEmail);
    ResultSet result = query.executeQuery();
    boolean isUserEmail = result.next();
%>
<script>
        window.addEventListener("load",()=>{
            if(<%=isUserEmail%>) {
                alert("사용중인 이메일입니다");
                return self.close();
            }

            const CONFIRM = confirm("사용가능한 이메일입니다. 사용하시겠습니까?");
            if(!CONFIRM) return self.close();

            opener.setUserEmail(<%=parseUserEmail%>);
            self.close();
        })
</script>
