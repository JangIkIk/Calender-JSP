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
            <form class="form" id="findIdForm" method="post" action="/stageus/actions/findIdAction.jsp">
                <h1 class="form__title">아이디 찾기</h1>

                <div class="form__container-simple">
                    <input class="form__container-simple__input" id="userName" name="userName" type="text" placeholder="가입시 이름을 입력해주세요" required>
                    <input class="form__container-simple__input" id="userEmail" name="userEmail" type="text" placeholder="가입시 이메일을 입력해주세요" required>
                </div>

                <div class="form__container-simple">
                    <div class="form__container-simple__btns form__container-simple__btns--full">
                        <input class="base-button" type="submit" value="찾기">
                        <a class="base-button" href="/stageus/pages/login.jsp">로그인하러 가기</a>
                    </div>
                </div>
            </form>
        </main>
    </body>
    <script>
        const nameRegex = (name)=>{
            const regex = /^[가-힣a-zA-Z]{2,10}$/;
            return regex.test(name);
        };
        const emailRegex = (email)=>{
            const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{1,30}$/;
            return regex.test(email);
        };

        const onSubmit = (e)=>{
            const $userName = document.getElementById("userName").value;
            const $userEmail = document.getElementById("userEmail").value;

            try{
                if(!$userName.trim() || !$userEmail.trim()) throw "회원정보를 입력해주세요";
                if(!nameRegex($userName)) throw "이름을 올바르게 입력해주세요";
                if(!emailRegex($userEmail)) throw "이메일을 올바르게 입력해주세요";
            }
            catch(error){
                e.preventDefault();
                alert(error);
                return false;
            }
            return true;
        };

        window.addEventListener("load",()=>{
            const $findIdForm = document.getElementById("findIdForm");
            $findIdForm.addEventListener("submit",onSubmit);
        });
    </script>
</html>