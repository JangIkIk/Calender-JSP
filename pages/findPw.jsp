<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/utility.css" rel="stylesheet" type="text/css">
        <title>비밀번호 찾기</title>
    </head>
    <body>
        <main class="h-full flex justify-center items-center text-center">
            <div class="w-500">
                <h1 class="p-10 border-bt-1sb">비밀번호 찾기</h1>
                <form class="p-10 flex column gap-10" method="post" action="/stageus/actions/findPwAction.jsp">
                    <div><input name="userId" class="w-full p-10 radius-5" type="text" placeholder="가입시 아이디를 입력해주세요"></div>
                    <div><input name="userEmail" class="w-full p-10 radius-5" type="text" placeholder="가입시 이메일을 입력해주세요"></div>
                    <div><input class="w-full p-10 radius-5 pointer main-styles" type="submit" value="찾기"></div>
                    <div>
                        <button class="w-full flex radius-5"><a class="grow-1 p-10 main-styles" href="/stageus/pages/login.jsp">로그인하러 가기</a></button>
                    </div>
                </form>
            </div>
        </main>
    </body>
</html>