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
                <form id="findPwForm" class="layout-container-form" method="post" action="/stageus/actions/findPwAction.jsp">
                    <div><input id="userId" class="form-input" name="userId" type="text" placeholder="가입시 아이디를 입력해주세요"></div>
                    <div><input id="userEmail" class="form-input" name="userEmail" type="text" placeholder="가입시 이메일을 입력해주세요"></div>
                    <div><input class="form-movebutton" type="submit" value="찾기"></div>
                    <div><a class="form-movebutton" href="/stageus/pages/login.jsp">로그인하러 가기</a></div>
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
        // 이메일 유효성 검사: 최대 30자, 이메일 정규식
        const emailRegex = (email)=>{
            const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{1,30}$/;
            return regex.test(email);
        };
         const isValidation = (e)=>{
            e.preventDefault();
            const form = e.target;
            const $userId = document.getElementById("userId").value;
            const $userEmail = document.getElementById("userEmail").value;
            // 공백일경우
            if(!$userId.trim() || !$userEmail.trim()) return alert("회원정보를 입력해주세요");
            // 아이디, 이메일 형식이 맞지 않을경우
            if(!idRegex($userId) || !emailRegex($userEmail)) return alert("회원정보를 확인해주세요");

            form.action="/stageus/actions/findIdAction.jsp";
            form.submit();
        }

        const $findPwForm = document.getElementById("findPwForm");
        $findPwForm.addEventListener("submit",isValidation);

    </script>
</html>

<%--
    확인필요
    클라이언트측의 유효성검사
 --%>