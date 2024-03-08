<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/common.css" rel="stylesheet" type="text/css">
        <title>비밀번호 찾기</title>
    </head>
    <body>
        <main class="layout">
            <div class="layout-container">
                <h1 class="layout-container-title">비밀번호 찾기</h1>
                <form class="layout-container-form" method="post" action="/stageus/actions/findPwAction.jsp">
                    <div><input class="form-input" name="userId" type="text" placeholder="가입시 아이디를 입력해주세요"></div>
                    <div><input class="form-input" name="userEmail" type="text" placeholder="가입시 이메일을 입력해주세요"></div>
                    <div><input class="form-movebutton" type="submit" value="찾기"></div>
                    <div><a class="form-movebutton" href="/stageus/pages/login.jsp">로그인하러 가기</a></div>
                </form>
            </div>
        </main>
    </body>
</html>

<%--
    확인필요
    클라이언트측의 유효성검사
 --%>