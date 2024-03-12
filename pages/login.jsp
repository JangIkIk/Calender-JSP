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
        // 아이디 유효성 검사: 영문, 숫자를 포함한 3자 ~ 20자
        const idRegex = (id)=>{
            const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$/;
            return regex.test(id);
        }
        // 비밀번호 유효성 검사: 영문 숫자를 포함한 최소 5자 ~ 20자
        const pwRegex = (pw)=>{
            const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$/;
            return regex.test(pw);
        }  
         const isValidation = (e)=>{
            e.preventDefault();
            const form = e.target;
            const $userId = document.getElementById("userId").value;
            const $userPw = document.getElementById("userPw").value;
            // 공백일경우
            if(!$userId.trim() || !$userPw.trim()) return alert("회원정보를 입력해주세요");
            // 아이디, 비밀번호 형식이 맞지 않을경우
            if(!idRegex($userId) || !pwRegex($userPw)) return alert("회원정보를 확인해주세요");

            form.action = "/stageus/actions/loginAction.jsp";
            form.submit();
        }

        const $loginForm = document.getElementById("loginForm");
        $loginForm.addEventListener("submit",isValidation);

    </script>
</html>

