<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/common.css" rel="stylesheet" type="text/css">
        <title>회원가입</title>
    </head>
    <body>
        <main class="layout">
            <form class="form" id="form" method="post" action="/stageus/actions/signUpAction.jsp">
            <%-- <form class="form" id="form" method="post"> --%>
                <h1 class="form__title">회원가입</h1>
                <%-- 아이디 --%>
                <div id="userIdContainer">
                    <label for="userId"><span>아이디</span><span class="star">*</span></label>
                    <div class="form__container-double">
                        <input class="form__container-double__input" id="userId" name="userId" type="text" placeholder="아이디를 입력해주세요" required>
                        <button class="form__container-double__button form__container-double__button--disabled" id="userIdCheck"  disabled>중복확인</button>
                    </div>
                    <p class="form__regex-text"></p>
                </div>
                <%-- 비밀번호 --%>
                <div id="userPwContainer">
                    <label for="userPw"><span>비밀번호</span><span class="star">*</span></label>
                    <div class="form__container-simple">
                        <input class="form__input" id="userPw" name="userPw" type="password" placeholder="비밀번호를 입력해주세요" required>
                    </div>
                    <p class="form__regex-text"></p>
                </div>
                <%-- 비밀번호 확인 --%>
                 <div id="userPwCheckContainer">
                    <label for="userPwCheck"><span>비밀번호 확인</span><span class="star">*</span></label>
                    <div class="form__container-simple">
                        <input class="form__input" id="userPwCheck" name="userPwCheck" type="password" placeholder="비밀번호를 다시 입력해주세요" required>
                    </div>
                    <p class="form__regex-text"></p>
                </div>
                <%-- 이름 --%>
                <div id="userNameContainer">
                    <label for="userName"><span>이름</span><span class="star">*</span></label>
                    <div class="form__container-simple">
                        <input class="form__input" id="userName" name="userName" type="text" placeholder="이름을 입력해주세요" required>
                    </div>
                    <p class="form__regex-text"></p>
                </div>
                
                <%-- 이메일 --%>
                <div id="userEmailContainer">
                    <label for="userEmail"><span>이메일</span><span class="star">*</span></label>
                    <div class="form__container-double">
                        <input class="form__container-double__input" id="userEmail" name="userEmail" type="text" placeholder="이메일을 입력해주세요" required>
                        <button class="form__container-double__button form__container-double__button--disabled" id="userEmailCheck" disabled>중복확인</button>
                    </div>
                    <p class="form__regex-text"></p>
                </div>
                <%-- 부서 / 직급 --%>
                <div class="form__container-between">
                    <%-- 부서 --%>
                    <div class="form__container-between__wrap">
                        <label for="userTim"><span>부서</span><span class="star">*</span></label>
                        <div>
                            <select class="select" id="userTim" name="userTim">
                                <option value="">선택</option>
                                <option value="디자인">디자인</option>
                                <option value="기획">기획</option>
                            </select>
                        </div>
                    </div>
                    <%-- 직급 --%>
                    <div class="form__container-between__wrap">
                        <label for="userRank"><span>직급</span><span class="star">*</span></label>
                        <div>
                            <select class="select" id="userRank" name="userRank">
                                <option value="">선택</option>
                                <option value="팀장">팀장</option>
                                <option value="팀원">팀원</option>
                            </select>
                        </div>
                    </div>
                </div>
                <%-- submit --%>
                <div class="form__container-simple">
                    <div class="form__container-simple__btns form__container-simple__btns--full">
                        <input class="base-button base-button--gray" id="submit" type="submit" value="회원가입" disabled>
                        <a class="base-button" href="/stageus/pages/login.jsp">로그인 하러가기</a>
                    </div>
                </div>
            </form>
        </main>
    </body>
    <script>
            let isEmail = null;
            
            function emailCheck(email){
                isEmail = email;
                emailBtnDisabled(true);
                submitBtnDisabled();
            };

            let isId = null;

            function idCheck(id){
                isId = id;
                idBtnDisabled(true);
                submitBtnDisabled();
            };

            const idRegex = (id)=>{
                    const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$/;
                    return regex.test(id);
            };  

            const onInputIdText = (e)=>{
                const targetValue = e.target.value;
                const $alertText = document.querySelector("#userIdContainer p");
                
                if(!targetValue) return $alertText.innerText = "" , idBtnDisabled(true);
                if(targetValue && !idRegex(targetValue)) return idBtnDisabled(true), $alertText.innerText = "영문 숫자를 포함한 3자 ~ 20자";
                
                idBtnDisabled(false);
                $alertText.innerText = "";       
            };

            const idBtnDisabled = (disabled)=>{
                const $userIdCheck = document.getElementById("userIdCheck");

                if(disabled){
                    $userIdCheck.disabled = disabled;
                    $userIdCheck.classList.add("form__container-double__button--disabled");
                    return;
                }
                
                $userIdCheck.disabled = disabled;
                $userIdCheck.classList.remove("form__container-double__button--disabled");
            };

            const onClickIdPopup = (e)=>{
                e.preventDefault();
                const userIdValue = document.getElementById("userId").value;
                if(!userIdValue) return alert("아이디를 입력해주세요");
                if(!idRegex(userIdValue)) return alert("아이디 형식과 맞지 않습니다");
                window.open("/stageus/actions/idCheckAction.jsp?userId="+ userIdValue, "_blank","");
            };

            const pwRegex = (pw)=>{
                const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$/;
                return regex.test(pw);
            };

            const onInputPwText = (e)=>{
                const targetValue = e.target.value;
                const $alertText = document.querySelector("#userPwContainer p");
                if(targetValue && !pwRegex(targetValue)){
                    onInputPwCheckText();
                    $alertText.innerText = "5자 이상 ~ 20자 이하";
                    return;
                }
                $alertText.innerText = "";
                onInputPwCheckText();
            };

            const onInputPwCheckText = (e)=>{
                const userPwValue = document.getElementById("userPw").value;
                const userPwCheckValue = document.getElementById("userPwCheck").value;
                const $alertText = document.querySelector("#userPwCheckContainer p");
                if(userPwCheckValue && userPwValue !== userPwCheckValue) return $alertText.innerText = "비밀번호가 일치하지 않습니다";
                $alertText.innerText = "";
            };

            const nameRegex = (name)=>{
                const regex = /^[가-힣a-zA-Z]{2,10}$/;
                return regex.test(name);
            };

            const onInputNameText = (e) => {
                const targetValue = e.target.value;
                const $alertText = document.querySelector("#userNameContainer p");

                if(targetValue && !nameRegex(targetValue)) return $alertText.innerText = "영문 또는 한글 2자 ~ 10자";
                $alertText.innerText = "";
            };

            const emailRegex = (email)=>{
                    const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{1,30}$/;
                    return regex.test(email);
            };

            const onInputEmailText = (e)=>{
                const targetValue = e.target.value;
                const $alertText = document.querySelector("#userEmailContainer p");

                if(!targetValue) return $alertText.innerText = "" , emailBtnDisabled(true);
                if(targetValue && !emailRegex(targetValue)) return emailBtnDisabled(true), $alertText.innerText = "이메일 형식에 맞지 않습니다";
             
                emailBtnDisabled(false);
                $alertText.innerText = "";
            };

            const emailBtnDisabled = (disabled)=>{
                const $userEmailCheck = document.getElementById("userEmailCheck");
                if(disabled){
                    $userEmailCheck.disabled = disabled;
                    $userEmailCheck.classList.add("form__container-double__button--disabled");
                    return;
                }
                
                $userEmailCheck.disabled = disabled;
                $userEmailCheck.classList.remove("form__container-double__button--disabled");
            };

            const onClickEmailPopup = (e)=>{
                e.preventDefault();
                const userEmailValue = document.getElementById("userEmail").value;
                if(!userEmailValue) return alert("이메일을  입력해주세요");
                if(!emailRegex(userEmailValue)) return alert("이메일 형식을 확인해주세요");
                window.open("/stageus/actions/emailCheckAction.jsp?userEmail="+ userEmailValue, "_blank","");
            };

            const submitBtnDisabled = ()=>{
                const userId = document.getElementById("userId").value;
                const userPwValue = document.getElementById("userPw").value;
                const userPwCheckValue = document.getElementById("userPwCheck").value;
                const userNameValue = document.getElementById("userName").value;
                const userEmailValue = document.getElementById("userEmail").value;
                const userTimValue = document.getElementById("userTim").value;
                const userRankValue = document.getElementById("userRank").value;
                const $submit = document.getElementById("submit");

                try{   
                    if(!isId) throw true;
                    if(isId !== userId) throw true;
                    if(!pwRegex(userPwValue)) throw true;
                    if(userPwValue !== userPwCheckValue) throw true;
                    if(!nameRegex(userNameValue)) throw true;
                    if(!isEmail) throw true;
                    if(isEmail !== userEmailValue) throw true;
                    if(!userTimValue) throw true;
                    if(!userRankValue) throw true;
                } 
                catch(error){
                    $submit.classList.add("base-button--gray");
                    $submit.disabled = error;
                    return;
                }

                $submit.classList.remove("base-button--gray");
                $submit.disabled = false;
            };


            const onSubmit = (e)=>{
                const userIdValue = document.getElementById("userId").value;
                const userPwValue = document.getElementById("userPw").value;
                const userPwCheckValue = document.getElementById("userPwCheck").value;
                const userNameValue = document.getElementById("userName").value;
                const userEmailValue = document.getElementById("userEmail").value;
                const userTimValue = document.getElementById("userTim").value;
                const userRankValue = document.getElementById("userRank").value;

                try{
                    
                    if(!idRegex(userIdValue)) throw "아이디를 확인해주세요";
                    if(isId !== userIdValue) throw "아이디 중복체크를 해주세요";
                    if(!pwRegex(userPwValue)) throw "비밀번호를 확인해주세요";
                    if(userPwValue !== userPwCheckValue) throw "비밀번호가 일치하지 않습니다";
                    if(!nameRegex(userNameValue)) throw "이름을 확인해주세요";
                    if(!emailRegex(userEmailValue)) throw "이메일을 확인해주세요";
                    if(isEmail !== userEmailValue) throw "이메일 중복체크를 해주세요";
                    if(!userTimValue) throw "부서를 선택해주세요";
                    if(!userRankValue) throw "직급을 선택해주세요";
                    
                } 
                catch(error){

                    e.preventDefault();
                    alert(error);
                    return false;
                }

                return true;
            }

            window.addEventListener("load",()=>{
                const $userId = document.getElementById("userId");
                $userId.addEventListener("input",onInputIdText);

                const $userIdCheck = document.getElementById("userIdCheck");
                $userIdCheck.addEventListener("click",onClickIdPopup);

                const $userPw = document.getElementById("userPw");
                $userPw.addEventListener("input",onInputPwText);

                const $userPwCheck = document.getElementById("userPwCheck");
                $userPwCheck.addEventListener("input",onInputPwCheckText);

                const $userName = document.getElementById("userName");
                $userName.addEventListener("input",onInputNameText);

                const $userEmail = document.getElementById("userEmail");
                $userEmail.addEventListener("input", onInputEmailText);

                const $userEmailCheck = document.getElementById("userEmailCheck");
                userEmailCheck.addEventListener("click",onClickEmailPopup);

                const $form = document.getElementById("form");
                $form.addEventListener("input",submitBtnDisabled);
                $form.addEventListener("submit",onSubmit);
            })
    </script>
</html>