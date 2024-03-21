<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.regex.Pattern"%>

<%
    try{
        String sessionId = (String) session.getAttribute("session_id");
        if(sessionId == null){
            out.println("<script>alert('회원만 가능'); window.location.href='/stageus/pages/login.jsp';</script>");
            return;
        };

        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        String getUserPw = request.getParameter("userPw");
        String getUserName = request.getParameter("userName");
        String getUserEmail = request.getParameter("userEmail");
        String getUserTim = request.getParameter("userTim");
        String getUserRank = request.getParameter("userRank");

        String pwPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$";
        boolean pwRegex = Pattern.matches(pwPattern, getUserPw);
        if(!pwRegex) throw new Exception();

        String namePattern = "^[가-힣a-zA-Z]{2,10}$";
        boolean nameRegex = Pattern.matches(namePattern, getUserName);
        if(!nameRegex) throw new Exception();

        String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{1,30}$";
        boolean emailRegex = Pattern.matches(emailPattern, getUserEmail);
        if(!emailRegex) throw new Exception();

        if(getUserTim == "") throw new Exception();
        if(getUserRank == "") throw new Exception();

        String sessionIdCheckSQL = "SELECT id FROM account WHERE idx=?";
        PreparedStatement sessionIdCheckQuery = connect.prepareStatement(sessionIdCheckSQL);
        sessionIdCheckQuery.setString(1,sessionId);
        ResultSet idResult = sessionIdCheckQuery.executeQuery();
        if(!idResult.next()) throw new Exception();

        String accountEmailCheckSQL = "SELECT email FROM account WHERE email=?";
        PreparedStatement accountEmailCheckQuery = connect.prepareStatement(accountEmailCheckSQL);
        accountEmailCheckQuery.setString(1,getUserEmail);
        ResultSet emailResult = accountEmailCheckQuery.executeQuery();
        if(!emailResult.next()) throw new Exception();

        String accountSQL = "UPDATE account SET password=?, name=?, email=?, tim=(SELECT idx FROM groups WHERE idx=?), rank=(SELECT idx FROM level WHERE idx=?) WHERE idx=?";
        PreparedStatement accountQuery = connect.prepareStatement(accountSQL);
        // 기존정보와 비교해서 수정에 대한 여부를 체크 해야하나 ?
        accountQuery.setString(1,getUserPw);
        accountQuery.setString(2,getUserName);
        accountQuery.setString(3,getUserEmail);
        accountQuery.setString(4,getUserTim);
        accountQuery.setString(5,getUserRank);
        accountQuery.setString(6,sessionId);
        accountQuery.executeUpdate();
    }
    catch(Exception e){
        out.println("<script>alert('정보수정 실패'); history.back();</script>");
        return;
    } 
    
%>
<script>
    location.href = "/stageus/pages/mypageEdit.jsp";
</script>