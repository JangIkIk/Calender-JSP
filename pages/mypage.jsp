<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList" %>

<%
    ArrayList<String> dayList = new ArrayList<String>();
    try{
        String sessionId = (String) session.getAttribute("session_id");
        if(sessionId == null){
            out.println("<script>alert('회원만 가능'); window.location.href='/stageus/pages/login.jsp';</script>");
            return;
        };

        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        
        String userInfoSQL = "SELECT account.id, account.password, account.name, account.email, groups.name AS tim, level.name AS rank FROM account INNER JOIN groups ON account.tim = groups.idx INNER JOIN level ON account.rank = level.idx WHERE account.idx=?";
        PreparedStatement userInfoQuery = connect.prepareStatement(userInfoSQL);
        userInfoQuery.setString(1,sessionId);
        ResultSet result = userInfoQuery.executeQuery();

        while(result.next()){
            String id = result.getString(1);
            String password = result.getString(2);
            String name = result.getString(3);
            String email = result.getString(4);
            String tim = result.getString(5);
            String rank = result.getString(6);
            dayList.add(String.format("{\"id\":\"%s\",\"password\":\"%s\",\"name\":\"%s\",\"email\":\"%s\",\"tim\":\"%s\",\"rank\":\"%s\"}", id,password,name,email,tim,rank));
        }

    }
    catch(Exception e){
        return;
    }
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
                <a class="base-button base-button--blue" href="/stageus/pages/mypageEdit.jsp">정보수정</a>
                <a class="base-button base-button--red" onclick="onClickDeleteUser(event)">회월탈퇴</a>
            </div>
        </div>
    </body>
    <script>
        const showUserOlddata = ()=>{
            const dayList = <%=dayList%>;
            const $id = document.getElementById("id");
            const $password = document.getElementById("password");
            const $name = document.getElementById("name");
            const $email = document.getElementById("email");
            const $tim = document.getElementById("tim");
            const $rank = document.getElementById("rank");

            $id.innerText = dayList[0].id;
            $password.innerText = dayList[0].password;
            $name.innerText = dayList[0].name;
            $email.innerText = dayList[0].email;
            $tim.innerText = dayList[0].tim;
            $rank.innerText = dayList[0].rank;
        };

        const onClickDeleteUser = (e)=>{
            const CONFIRM = confirm("회원탈퇴 하시겠습니까?");
            if(!CONFIRM) return;
            location.href="/stageus/actions/userDeleteAction.jsp";
        };
        
         window.addEventListener("load",()=>{
           showUserOlddata();
        })
    </script>
</html>