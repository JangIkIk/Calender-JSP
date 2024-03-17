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
    String getUserId = request.getParameter("userId");
    String parseUserId = "\"" + getUserId + "\"";

    String idPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$";
    boolean idRegex = Pattern.matches(idPattern, getUserId);

    try{
        if(!idRegex) throw new Exception();
    }
    catch(Exception e){
        out.println("<script>alert('올바르지 않은 값입니다'); self.close();</script>");
        return;
    } 

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

    String SQL = "SELECT id FROM user WHERE id=?";
    PreparedStatement query = connect.prepareStatement(SQL);
    query.setString(1,getUserId);
    ResultSet result = query.executeQuery();
    boolean isUserId = result.next();
%>
<script>
        const isUserId = <%=isUserId%>;
        const parseUserId = <%=parseUserId%>;

        try{
            if(isUserId) throw ("사용중인 아이디입니다");
            const CONFIRM = confirm("사용가능한 아이디입니다. 사용하시겠습니까?");
            if(!CONFIRM) throw ("");
            opener.idCheck(parseUserId);

        }catch(error){
            if(error)alert(error);

        }finally{
            self.close();
        }
</script>

