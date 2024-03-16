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
                <form class="form" id="loginForm" method="post" action="/stageus/actions/loginAction.jsp">

                    <h1 class="form__title">로그인하기</h1>

                    <div class="form__container-simple">
                        <input class="form__container-simple__input" id="userId" name="userId" type="text" placeholder="아이디를 입력해주세요" required>
                        <input class="form__container-simple__input" id="userPw" name="userPw" type="password" placeholder="비밀번호를 입력해주세요" required>
                    </div>

                    <div class="form__container-double form__container-double--right">
                        <div>
                            <a href="/stageus/pages/findId.jsp">아이디찾기</a>
                            <span>|</span>
                            <a href="/stageus/pages/findPw.jsp">비밀번호 찾기</a>
                        </div>
                    </div>

                    <div class="form__container-simple">
                        <div class="form__container-simple__btns form__container-simple__btns--full">
                            <input class="base-button" type="submit" value="로그인">
                            <a class="base-button" href="/stageus/pages/signUp.jsp">회원가입</a>
                        </div>
                    </div>
                </form>
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
         const onSubmit = (e)=>{
            const $userId = document.getElementById("userId").value;
            const $userPw = document.getElementById("userPw").value;

            try{
                if(!$userId.trim() || !$userPw.trim()) throw "회원정보를 입력해주세요";
                if(!idRegex($userId) || !pwRegex($userPw)) throw "회원정보를 확인해주세요";
            }
            catch(error){
                e.preventDefault();
                alert(error);
                return false;
            }

            return true;
        }

        const $loginForm = document.getElementById("loginForm");
        $loginForm.addEventListener("submit",onSubmit);

    </script>
</html>

