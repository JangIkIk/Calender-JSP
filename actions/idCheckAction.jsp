<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.regex.Pattern"%>

<%
    String getUserId;
    String parseUserId;
    boolean isUserId;

    try{
        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        getUserId = request.getParameter("userId");
        parseUserId = "\"" + getUserId + "\"";
        
        String idPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$";
        boolean idRegex = Pattern.matches(idPattern, getUserId);
        if(!idRegex) throw new Exception();

        String accountSQL = "SELECT id FROM account WHERE id=?";
        PreparedStatement accountQuery = connect.prepareStatement(accountSQL);
        accountQuery.setString(1,getUserId);
        ResultSet result = accountQuery.executeQuery();
        isUserId = result.next();
    }
    catch(Exception e){
        out.println("<script>alert('올바르지 않은 값입니다'); self.close();</script>");
        return;
    }     
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

