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
            <form class="form" id="findPwForm" method="post" action="/stageus/actions/findPwAction.jsp">
                <h1 class="form__title">비밀번호 찾기</h1>

                <div class="form__container-simple">
                    <input class="form__container-simple__input" id="userId" name="userId" type="text" placeholder="가입시 아이디를 입력해주세요" required>
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
         const onSubmit = (e)=>{
            const $userId = document.getElementById("userId").value;
            const $userEmail = document.getElementById("userEmail").value;

             try{
                if(!$userId.trim() || !$userEmail.trim()) throw "회원정보를 입력해주세요";
                if(!idRegex($userId) || !emailRegex($userEmail)) throw "회원정보를 확인해주세요";
            }
            catch(error){
                e.preventDefault();
                alert(error);
                return false;
            }
            
            return true;
        }

        const $findPwForm = document.getElementById("findPwForm");
        $findPwForm.addEventListener("submit",onSubmit);

    </script>
</html>