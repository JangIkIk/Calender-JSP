<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 세션확인
    String sessionId = (String) session.getAttribute("session_id");
    if(sessionId == null){
        out.println("<script>alert('회원만 가능'); window.location.href='/stageus/pages/login.jsp';</script>");
    }

    // 기존 정보들을 입력해야 한다.

%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/common.css" rel="stylesheet" type="text/css">
        <title>정보수정</title>
    </head>
    <body>
        <main class="layout">
            <form class="form" id="form" method="post" action="/stageus/actions/updateUserInfo.jsp">
                    <h1 class="form__title">정보수정</h1>
                    <%-- 비밀번호 --%>
                    <div id="userPwContainer">
                        <label for="userPw"><span>비밀번호</span><span class="star">*</span></label>
                        <div class="form__container-simple">
                            <input class="form__input" id="userPw" name="userPw" type="password" placeholder="비밀번호를 입력해주세요">
                        </div>
                        <p class="form__regex-text"></p>
                    </div>

                    <%-- 비밀번호 확인--%>
                    <div id="userPwCheckContainer">
                        <label for="userPwCheck"><span>비밀번호 확인</span><span class="star">*</span></label>
                        <div class="form__container-simple">
                            <input class="form__input" id="userPwCheck" name="userPwCheck" type="password" placeholder="비밀번호를 다시 입력해주세요">
                        </div>
                        <p class="form__regex-text"></p>
                    </div>

                    <%-- 이름 --%>
                    <div id="userNameContainer">
                        <label for="userName"><span>이름</span><span class="star">*</span></label>
                        <div class="form__container-simple">
                            <input class="form__input" id="userName" name="userName" type="text" placeholder="이름을 입력해주세요">
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
                        <p class="signup-inbox-validation"></p>
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
                    <div class="form__container-simple__btns">
                        <input class="base-button base-button--gray" id="submit" type="submit" value="저장하기" disabled>
                        <a class="base-button" href="/stageus/pages/mypage.jsp">돌아가기</a>
                    </div>
                </div>
            </form>
        </main>
    </body>
    <script>
            let isEmail = null;
            
            function emailCheck(email){
                isEmail = email;
                // 이메일을 중복체크 했으면 버튼 비활성화
                emailBtnDisabled(true);
                // 이메일 중복체크 했으면 저장하기 버튼 활성화
                submitBtnDisabled();
            };

            const pwRegex = (pw)=>{
                const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$/;
                return regex.test(pw);
            };

            // 비밀번호 유효성검사 함수
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

            // 비밀번호 체크 유효성검사 함수 -> 비밀번호 확인 함수와 의존성을 가진다.
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

            // 이름 유효성 검사 함수
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

            // 이메일 유효성 검사 함수
            const onInputEmailText = (e)=>{
                const targetValue = e.target.value;
                const $alertText = document.querySelector("#userEmailContainer p");

                // 이메일이 존재하고, 유효성이 맞지않으면 버튼 비활성화 및 문구표시
                if(targetValue && !emailRegex(targetValue)){
                    emailBtnDisabled(true);
                    $alertText.innerText = "이메일 형식에 맞지 않습니다";
                    return;
                }                
                // 이메일 유효성이 맞다면 활성화
                emailBtnDisabled(false);
                $alertText.innerText = "";
            };

            // 이메일 중복체크버튼 활성화 / 비활성화
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

            // 이메일 중복체크 팝업
            const onClickPopup = (e)=>{
                e.preventDefault();
                const userEmailValue = document.getElementById("userEmail").value;
                if(!userEmailValue) return alert("이메일을  입력해주세요");
                if(!emailRegex(userEmailValue)) return alert("이메일 형식을 확인해주세요");
                window.open("/stageus/actions/emailCheckAction.jsp?userEmail="+ userEmailValue, "_blank","");
            };

            // 저장하기 버튼 활성화 / 비활성화
            const submitBtnDisabled = ()=>{
                const userPwValue = document.getElementById("userPw").value;
                const userPwCheckValue = document.getElementById("userPwCheck").value;
                const userNameValue = document.getElementById("userName").value;
                const userTimValue = document.getElementById("userTim").value;
                const userRankValue = document.getElementById("userRank").value;
                const $submit = document.getElementById("submit");
                
                // 비밀번호 유효성검사가 일치하지 않는다면
                if(!pwRegex(userPwValue)) return $submit.classList.add("base-button--gray"), $submit.disabled = true;

                // 비빌번호 / 비밀번호 확인 값이 일치하지 않는다면
                if(userPwValue !== userPwCheckValue) return $submit.classList.add("base-button--gray"), $submit.disabled = true;

                // 이메일 중복체크시 이메일이 입력되지 않았다면
                if(!isEmail) return $submit.classList.add("base-button--gray"), $submit.disabled = true;

                // 이름 유효성검사가 일치하지 않는다면
                if(!nameRegex(userNameValue)) return $submit.classList.add("base-button--gray"), $submit.disabled = true;

                // 부서를 선택하지 않았다면
                if(!userTimValue) return $submit.classList.add("base-button--gray"), $submit.disabled = true;

                // 직급을 선택하지 않았다면
                if(!userRankValue) return $submit.classList.add("base-button--gray"), $submit.disabled = true;

                $submit.classList.remove("base-button--gray");
                $submit.disabled = false;
            };

            const onSubmitErrorAlert = (e)=>{
                e.preventDefault();
                const userPwValue = document.getElementById("userPw").value;
                const userPwCheckValue = document.getElementById("userPwCheck").value;
                const userNameValue = document.getElementById("userName").value;
                const userEmailValue = document.getElementById("userEmail").value;
                const userTimValue = document.getElementById("userTim").value;
                const userRankValue = document.getElementById("userRank").value;
                

                // 비밀번호 유효성검사가 일치하지 않는다면
                if(!pwRegex(userPwValue)) return alert("비밀번호를 확인해주세요");

                // 비빌번호 / 비밀번호 확인 값이 일치하지 않는다면
                if(userPwValue !== userPwCheckValue) return alert("비밀번호가 일치하지 않습니다");

                // 이메일이 유효성검사가 일치하지 않는다면
                if(!emailRegex(userEmailValue)) return alert("이메일을 확인해주세요");

                // 이메일 중복체크시 이메일이 입력되지 않았다면
                if(!isEmail) return alert("이메일 중복체크를 해주세요");

                // 이름 유효성검사가 일치하지 않는다면
                if(!nameRegex(userNameValue)) return alert("이름을 확인해주세요");

                // 부서를 선택하지 않았다면
                if(!userTimValue) return alert("부서를 선택해주세요");

                // 직급을 선택하지 않았다면
                if(!userRankValue) return alert("직급을 선택해주세요");
            }

            window.addEventListener("load",()=>{
                const $userPw = document.getElementById("userPw");
                $userPw.addEventListener("input",onInputPwText);

                const $userPwCheck = document.getElementById("userPwCheck");
                $userPwCheck.addEventListener("input",onInputPwCheckText);

                const $userName = document.getElementById("userName");
                $userName.addEventListener("input",onInputNameText);

                const $userEmail = document.getElementById("userEmail");
                $userEmail.addEventListener("input", onInputEmailText);

                const $userEmailCheck = document.getElementById("userEmailCheck");
                userEmailCheck.addEventListener("click",onClickPopup);

                const $form = document.getElementById("form");
                $form.addEventListener("input",submitBtnDisabled);
                $form.addEventListener("submit",onSubmitErrorAlert);
            })
    </script>
</html>