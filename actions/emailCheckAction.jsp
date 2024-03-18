<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    String getUserEmail = request.getParameter("userEmail");
    String parseUserEmail = "\"" + getUserEmail + "\"";

    String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{1,30}$";
    boolean emailRegex = Pattern.matches(emailPattern, getUserEmail);

    try{
        if(!emailRegex) throw new Exception();        
    }
    catch(Exception e){
        out.println("<script>alert('올바르지 않은 값입니다'); self.close();</script>");
        return;
    } 

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

    String accountSQL = "SELECT email FROM account WHERE email=?";
    PreparedStatement accountQuery = connect.prepareStatement(accountSQL);
    accountQuery.setString(1,getUserEmail);
    ResultSet result = accountQuery.executeQuery();
    boolean isUserEmail = result.next();
%>
<script>
        const isUserEmail = <%=isUserEmail%>;
        const parseUserEmail = <%=parseUserEmail%>;

        try{
            if(isUserEmail) throw ("사용중인 이메일입니다");
            const CONFIRM = confirm("사용가능한 이메일입니다. 사용하시겠습니까?");
            if(!CONFIRM) throw ("");
            opener.emailCheck(parseUserEmail);

        }catch(error){
            if(error)alert(error);

        }finally{
            self.close();
        }
</script>
