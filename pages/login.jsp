<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/common.css" rel="stylesheet" type="text/css">
        <title>로그인</title>
    </head>
    <body>
        <main class="layout">
            <div class="layout-container">
                <h1 class="layout-container-title">로그인하기</h1>
                <form id="loginForm" class="layout-container-form" method="post">
                    <div><input id="userId" class="form-input" name="userId" type="text" placeholder="아이디를 입력해주세요"></div>
                    <div><input id="userPw" class="form-input" name="userPw" type="password" placeholder="비밀번호를 입력해주세요"></div>
                    <div class="form-findbutton">
                        <a href="/stageus/pages/findId.jsp">아이디찾기</a>
                        <span>|</span>
                        <a href="/stageus/pages/findPw.jsp">비밀번호 찾기</a>
                    </div>
                    <div><input class="form-movebutton" type="submit" value="로그인"></div>
                    <div><a class="form-movebutton" href="/stageus/pages/signUp.jsp">회원가입</a></div>
                </form>
            </div>
        </main>
    </body>
    <script>
        const idRegex = (id)=>{
            const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$/;
            return regex.test(id);
        }

        const pwRegex = (pw)=>{
            const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$/;
            return regex.test(pw);
        }  

         const isValidation = (e)=>{
            e.preventDefault();
            const $userId = document.getElementById("userId").value;
            const $userPw = document.getElementById("userPw").value;
            if(!$userId.trim() || !$userPw.trim()) return alert("회원정보를 입력해주세요");
            if(!idRegex($userId) || !pwRegex($userPw)) return alert("회원정보를 확인해주세요");
            
            e.target.action = "/stageus/actions/loginAction.jsp";
            e.target.submit();
        }
        const $loginForm = document.getElementById("loginForm");
        $loginForm.addEventListener("submit",isValidation);
    </script>
</html>

<%--
    확인필요
    1. 클라이언트측의 유효성검사
    2. 애초부터 빈값, 아이디,비밀번호 양식이 아니라면 server로 넘길필요가 없다.
 --%>