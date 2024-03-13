<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/common.css" rel="stylesheet" type="text/css">
        <title>아이디 찾기</title>
    </head>
    <body>
        <main class="layout">
            <div class="layout-container">
                <h1 class="layout-container-title">아이디 찾기</h1>
                <form id="findIdForm" class="layout-container-form" method="post">
                    <div><input id="userName" class="form-input" name="userName" type="text" placeholder="가입시 이름을 입력해주세요" required></div>
                    <div><input id="userEmail" class="form-input" name="userEmail" type="text" placeholder="가입시 이메일을 입력해주세요" required></div>
                    <div><input class="form-movebutton" type="submit" value="찾기"></div>
                    <div><a class="form-movebutton" href="/stageus/pages/login.jsp">로그인하러 가기</a></div>
                </form>
            </div>
        </main>
    </body>
    <script>
        // 이름 유효성 검사: 2자 이상 ~ 10자이하, 영문, 한글
        const nameRegex = (name)=>{
            const regex = /^[가-힣a-zA-Z]{2,10}$/;
            return regex.test(name);
        };
        // 이메일 유효성 검사: 최대 30자, 이메일 정규식
        const emailRegex = (email)=>{
            const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{1,30}$/;
            return regex.test(email);
        };
         const isValidation = (e)=>{
            e.preventDefault();
            const form = e.target;
            const $userName = document.getElementById("userName").value;
            const $userEmail = document.getElementById("userEmail").value;
            // 공백일경우
            if(!$userName.trim() || !$userEmail.trim()) return alert("회원정보를 입력해주세요");
            // 아이디, 이메일 형식이 맞지 않을경우
            if(!nameRegex($userName) || !emailRegex($userEmail)) return alert("회원정보를 확인해주세요");
            
            form.action="/stageus/actions/findIdAction.jsp";
            form.submit();
        }

        const $findIdForm = document.getElementById("findIdForm");
        $findIdForm.addEventListener("submit",isValidation);

    </script>
</html>