<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Connector 파일을 찾는 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>
<%-- 데이터베이스에 연결하는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- sql을 전송하는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement"%>
<%-- Table 데이터 저장하는 라이브러리 --%>
<%@ page import="java.sql.ResultSet"%>
<%-- 리스트 불러옴 --%>
<%@ page import="java.util.ArrayList" %>

<%
    // 세션확인
    String sessionId = (String) session.getAttribute("session_id");
    if(sessionId == null){
        out.println("<script>alert('회원만 가능'); window.location.href='/stageus/pages/login.jsp';</script>");
    }

    // Text 인코딩 UTF-8
    request.setCharacterEncoding("UTF-8");
    // Connectior 파일 찾아오는것
    Class.forName("com.mysql.jdbc.Driver");
    // 데이터베이스에 연결하는 것
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");
    
    // 유저 정보 전체조회
    String SQL = "SELECT * FROM user WHERE idx=?";
    // sql문을 가지고 전송할 준비
    PreparedStatement query = connect.prepareStatement(SQL);
    // (SELECT일때문 query를 씀)
    //ResultSet result = query.executeQuery();
    /*
        1. 세션유무 확인
        2. 쿼리요청
    */
   

%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/common.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/mypage.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div class="mypage">
            <div><%@ include file="/pages/header.jsp"%></div>
            <div class="mypage-info">
                <h3 class="mypage-info-title">마이페이지</h3>
                <ul id="mypageInfo">
                    <li class="mypage-info-content">아이디: ?</li>
                    <li class="mypage-info-content">비밀번호: ?</li>
                    <li class="mypage-info-content">이름: ?</li>
                    <li class="mypage-info-content">이메일: ?</li>
                    <li class="mypage-info-content">부서: ?</li>
                    <li class="mypage-info-content">직급: ?</li>
                </ul>
            </div>
            <div class="mypage-button"><a class="mypage-button__a" href="/stageus/pages/profileSet.jsp">정보수정</a></div>
            <div class="mypage-button"><a class="mypage-button__a" href="/stageus/pages/profileSet.jsp">회월탈퇴</a></div>
        </div>
    </body>
    <script>
        window.addEventListener("load",()=>{
            /*
                서버측에서 받은 Array[Object]형태를 순회하고,
                그에 맞는 리스트 개수를 동적으로 생성
            */
            const $mypageInfo = document.getElementById("mypageInfo");
            const liElement = document.createElement("li");
            liElement.classList.add("mypage-info-content");
            
        })
    </script>
</html>