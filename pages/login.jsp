<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/utility.css" rel="stylesheet" type="text/css">
        <title>로그인</title>
    </head>
    <body>
        <main class="h-full flex justify-center items-center text-center">
            <div class="w-500">
                <h1 class="p-10 border-bt-1sb">로그인하기</h1>
                <form class="p-10 flex column gap-10" method="post" action="/stageus/actions/loginAction.jsp">
                    <div><input name="userId" class="w-full p-10 radius-5" type="text" placeholder="아이디를 입력해주세요"></div>
                    <div><input name="userPw" class="w-full p-10 radius-5" type="password" placeholder="비밀번호를 입력해주세요"></div>
                    <div class="text-right">
                        <a href="/stageus/pages/findId.jsp">아이디찾기</a>
                        <span>|</span>
                        <a href="/stageus/pages/findPw.jsp">비밀번호 찾기</a>
                    </div>
                    <div><input class="w-full p-10 base-button" type="submit" value="로그인"></div>
                    <div>
                        <input class="w-full p-10 base-button" type="button" value="회원가입" onClick="location.href='/stageus/pages/signUp.jsp'">
                    </div>
                </form>
            </div>
        </main>
    </body>
</html>