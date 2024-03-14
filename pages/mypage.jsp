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
            <div class="mypage__container">
                <h3 class="mypage__title">마이페이지</h3>
                <ul class="mypage__list">
                    <li class="mypage__user-info">
                        아이디:<span id="id"></span>
                    </li>
                    <li class="mypage__user-info">
                        비밀번호:<span id="password"></span>
                    </li>
                    <li class="mypage__user-info">
                        이름:<span id="name"></span>
                    </li>
                    <li class="mypage__user-info">
                        이메일:<span id="email"></span>
                    </li>
                    <li class="mypage__user-info">
                        부서:<span id="tim"></span>
                    </li>
                    <li class="mypage__user-info">
                        직급:<span id="rank"></span>
                    </li>
                </ul>
            </div>
            <div class="mypage-button">
                <a class="base-button base-button--blue" href="/stageus/pages/profileSet.jsp">정보수정</a>
                <a class="base-button base-button--red" href="/stageus/pages/profileSet.jsp">회월탈퇴</a>
            </div>
        </div>
    </body>
    <script>
        // 임시데이터 -> 서버측에서 받을 
        const obj = {
            id: "userId",
            password: "userPassword",
            name: "userName",
            email: "userEmail",
            tim: "userTim",
            rank: "userRank",
        }
        window.addEventListener("load",()=>{
            const $id = document.getElementById("id");
            const $password = document.getElementById("password");
            const $name = document.getElementById("name");
            const $email = document.getElementById("email");
            const $tim = document.getElementById("tim");
            const $rank = document.getElementById("rank");

            $id.innerText = obj.id;
            $password.innerText = obj.password;
            $name.innerText = obj.name;
            $email.innerText = obj.email;
            $tim.innerText = obj.tim;
            $rank.innerText = obj.rank;

        })
    </script>
</html>