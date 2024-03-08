<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/common.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/signup.css" rel="stylesheet" type="text/css">
        <title>회원가입</title>
    </head>
    <body>
        <main class="layout">
            <div class="layout-container">
                <h1 class="layout-container-title">회원가입</h1>
                <form id="signUpForm" class="layout-container-form" method="post" action="/stageus/actions/signUpAction.jsp">
                    <div class="signup-inbox">
                        <%-- 아이디 --%>
                        <div id="userIdContainer">
                            <label for="userId"><span>아이디</span><span class="signup-inbox-star">*</span></label>
                            <div class="signup-inbox-container">
                                <div class="signup-inbox-container-div"><input id="userId" class="signup-inbox-container-div__input" name="userId" type="text" placeholder="아이디를 입력해주세요"></div>
                                <div><button id="userIdCheck" class="signup-inbox-container-div__button--disabled" disabled>중복확인</button></div>
                            </div>
                            <p class="signup-inbox-validation"></p>
                        </div>

                        <%-- 비밀번호 --%>
                        <div>
                            <label for="userPw"><span>비밀번호</span><span class="signup-inbox-star">*</span></label>
                            <div class="signup-inbox-container signup-inbow-container--pw">
                                <div id="userPwContainer">
                                    <input class="signup-inbox-container-div__input" id="userPw" name="userPw" type="password" placeholder="비밀번호를 입력해주세요">
                                    <p class="signup-inbox-validation"></p>
                                </div>
                                <div id="userPwCheckContainer">
                                    <input class="signup-inbox-container-div__input" id="userPwCheck" name="userPwCheck" type="password" placeholder="입력하신 비밀번호를 입력해주세요">
                                    <p class="signup-inbox-validation"></p>
                                </div>
                            </div>
                        </div>

                        <%-- 이름 --%>
                        <div id="userNameContainer">
                            <label for="userName"><span>이름</span><span class="signup-inbox-star">*</span></label>
                            <div>
                                <input class="signup-inbox-container-div__input" id="userName" name="userName" type="text" placeholder="이름을 입력해주세요">
                            </div>
                            <p class="signup-inbox-validation"></p>
                        </div>
                        <%-- 이메일 --%>
                        <div id="userEmailContainer">
                            <label for="userEmail"><span>이메일</span><span class="signup-inbox-star">*</span></label>
                            <div class="signup-inbox-container">
                                <div class="signup-inbox-container-div"><input class="signup-inbox-container-div__input" id="userEmail" name="userEmail" type="text" placeholder="이메일을 입력해주세요"></div>
                                <div><button id="userEmailCheck" class="signup-inbox-container-div__button--disabled" disabled>중복확인</button></div>
                            </div>
                            <p class="signup-inbox-validation"></p>
                        </div>

                        <%-- 부서 / 직급 --%>
                        <div class="signup-inbox-double">
                            <%-- 부서 --%>
                            <div class="signup-inbox-double-container">
                                <label for="userTim"><span>부서</span><span class="signup-inbox-star">*</span></label>
                                <div>
                                    <select class="signup-inbox-double-container__select" id="userTim" name="userTim">
                                        <option value="">선택</option>
                                        <option value="디자인">디자인</option>
                                        <option value="기획">기획</option>
                                    </select>
                                </div>
                            </div>

                            <%-- 직급 --%>
                            <div class="signup-inbox-double-container">
                                <label for="userRank"><span>직급</span><span class="signup-inbox-star">*</span></label>
                                <div>
                                    <select class="signup-inbox-double-container__select" id="userRank" name="userRank">
                                        <option value="">선택</option>
                                        <option value="팀장">팀장</option>
                                        <option value="팀원">팀원</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                    </div>
                    <%-- submit --%>
                    <div>
                        <%-- <input id="submit" class="form-movebutton--disabled" type="submit" value="회원가입" disabled> --%>
                        <input id="submit" class="form-movebutton" type="submit" value="회원가입">
                    </div>

                    <%-- login 페이지 이동 --%>
                    <div><a class="form-movebutton" href="/stageus/pages/login.jsp">로그인 하러가기</a></div>
                </form>
            </div>
        </main>
    </body>
    <script>
            // 올바른 데이터 입력시 데이터 자장
            // 중복체크 필드는 사용하기 클릭시 데이터 저장
            let userInfo = {};

            const sigunButtonDisabled = ()=>{
                const $submit = document.getElementById("submit");
                const $userId = document.getElementById("userId");
                const $userEmail = document.getElementById("userEmail");

                if(Object.values(userInfo).length !== 6){
                    $submit.classList.replace("form-movebutton","form-movebutton--disabled");
                    $submit.disabled = true;
                    return;
                }
                if(userInfo.id && userInfo.id !== $userId.value){
                    $submit.classList.replace("form-movebutton","form-movebutton--disabled");
                    $submit.disabled = true;
                    return;
                }
                if(userInfo.email && userInfo.email !== $userEmail.value){
                    $submit.classList.replace("form-movebutton","form-movebutton--disabled");
                    $submit.disabled = true;
                    return;
                }
                
                $submit.classList.replace("form-movebutton--disabled","form-movebutton");
                $submit.disabled = false;                
            }

            // 자식 팝업창에서 userInfo에 id 값을 저장하기위한 함수
            function setUserId(uid){
                const $userIdCheck = document.getElementById("userIdCheck");
                $userIdCheck.disabled = true;
                $userIdCheck.classList.replace("signup-inbox-container-div__button","signup-inbox-container-div__button--disabled");
                userInfo.id = uid;
                sigunButtonDisabled();
            };

            // 자식 팝업창에서 userInfo에 email 값을 저장하기위한 함수
            function setUserEmail(uem){
                const $userEmailCheck = document.getElementById("userEmailCheck");
                $userEmailCheck.disabled = true;
                $userEmailCheck.classList.replace("signup-inbox-container-div__button","signup-inbox-container-div__button--disabled");
                userInfo.email = uem;
                sigunButtonDisabled();
            };



        window.addEventListener("load",()=>{
          

            // 아이디 (유효성검사, 안내문구텍스트 , 아이디중복체크버튼)
            const $userId = document.getElementById("userId");
            $userId.addEventListener("input", (e)=>{
                // 유효성 검사
                const idRegex = (id)=>{
                    const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$/;
                    return regex.test(id);
                };  

                const targetValue = e.target.value;
                const $idValidationText = document.querySelector("#userIdContainer p");
                if(!idRegex(targetValue)){
                    // 아이디 중복체크버튼 클래스 변경
                    $userIdCheck.classList.replace("signup-inbox-container-div__button", "signup-inbox-container-div__button--disabled")
                    // 아이디 중복체크버튼 disabled
                    $userIdCheck.disabled = true;
                    // 안내문구 텍스트 추가
                    return $idValidationText.innerText = "영문 숫자를 포함한 3자 ~ 20자";
                };
                // 안내문구 텍스트 삭제
                $idValidationText.innerText = "";
                // 아이디 중복체크버튼 클래스 변경
                $userIdCheck.classList.replace("signup-inbox-container-div__button--disabled", "signup-inbox-container-div__button");
                // 아이디 중복체크버튼 disabled
                $userIdCheck.disabled = false;
            });

              // 아이디 중복체크버튼 팝업창
            const $userIdCheck = document.getElementById("userIdCheck");
            $userIdCheck.addEventListener("click", (e)=>{
                const $userId = document.getElementById("userId");
                e.preventDefault();
                window.open("/stageus/actions/idCheckAction.jsp?userId=" + $userId.value, "_blank","popup=true");
            });


            // 비밀번호 (유효성검사, 안내문구 텍스트)
            const $userPw = document.getElementById("userPw");
            $userPw.addEventListener("input", (e)=>{
                const $userPwCheck = document.getElementById("userPwCheck");
                const $idValidation = document.querySelector("#userPwCheckContainer p");
                
                if($userPwCheck.value === userInfo.password){
                    $idValidation.innerText = "비밀번호가 일치하지 않습니다";
                }else{
                    $idValidation.innerText = "";
                }

                const targetValue = e.target.value;
                // 유효성 검사
                const pwRegex = (pw)=>{
                    const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$/;
                    return regex.test(pw);
                }
                const $pwValidationText = document.querySelector("#userPwContainer p");
                // 안내문구 텍스트 추가
                if(!pwRegex(targetValue)){
                    // userInfo.password 속성 삭제
                    delete userInfo.password;
                    return $pwValidationText.innerText = "5자 이상 ~ 20자 이하";
                }
                // userInfo.password 속성 추가
                userInfo.password = targetValue;
                // 안내문구 텍스트 삭제
                $pwValidationText.innerText = "";
            });

            /*
                비밀번호 입력칸의 값을 비밀번호 확인칸에서 참고하고 있어야함
            */


            // 비밀번호 확인 (비밀번호 비교, 안내문구 텍스트, userInfo object)
            // 원래 비밀번호를 바꿀경우 비빌번화 확인칸이 동작해야한다 @@@@@@@
            // 두개다 합쳐야 답이나옴
        
            const $userPwCheck = document.getElementById("userPwCheck");
            $userPwCheck.addEventListener("input", (e)=>{
                const $userPwCheck = document.getElementById("userPwCheck").value;
                const $idValidation = document.querySelector("#userPwCheckContainer p");

                // 비밀번호 비교
                if(userInfo.password !== $userPwCheck) {
                    // 안내문구 텍스트 추가
                    return $idValidation.innerText = "비밀번호가 일치하지 않습니다";
                }
                // 안내문구 텍스트 추가
                $idValidation.innerText = "";
            });


            
            

            // 이름 (유효성 검사, 안내문구 텍스트, userInfo object)
            const $userName = document.getElementById("userName");
            $userName.addEventListener("input", (e)=>{
                // 유효성 검사
                const nameRegex = (name)=>{
                    const regex = /^[가-힣a-zA-Z]{2,10}$/;
                    return regex.test(name);
                };
                const $idValidation = document.querySelector("#userNameContainer p");
                
                if(!nameRegex(e.target.value)){
                    // userInfo.name 속성 삭제
                    delete userInfo.name;
                    // 안내문구 텍스트 추가
                    return $idValidation.innerText = "2자 이상 ~ 10자 이하의 영어 or 한글";
                };
                // userInfo.name 속성 추가
                userInfo.name = e.target.value;
                // 안내문구 텍스트 삭제
                $idValidation.innerText = "";
            });

            // 이메일 (유효성검사, 안내문구 텍스트, 이메일 중복체크버튼)
            const $userEmail = document.getElementById("userEmail");
            $userEmail.addEventListener("input", (e)=>{
                // 유효성검사
                const emailRegex = (email)=>{
                    const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{1,30}$/;
                    return regex.test(email);
                };

                const $userEmailCheck = document.getElementById("userEmailCheck");
                const $idValidation = document.querySelector("#userEmailContainer p");
                if(!emailRegex(e.target.value)){
                    // 이메일 중복체크버튼 클래스변경
                    $userEmailCheck.classList.replace("signup-inbox-container-div__button", "signup-inbox-container-div__button--disabled")
                    // 이메일 중복체크버튼 disabled
                    $userEmailCheck.disabled = true;
                    // 안내문구 텍스트 추가
                    return $idValidation.innerText = "이메일 형식에 맞지 않습니다";
                };
                // 안내문구 텍스트 삭제
                $idValidation.innerText = "";
                // 이메일 중복체크버튼 클래스변경
                $userEmailCheck.classList.replace("signup-inbox-container-div__button--disabled", "signup-inbox-container-div__button");
                // 이메일 중복체크버튼 disabled
                $userEmailCheck.disabled = false;
            });

            // // 이메일 중복체크버튼 팝업창
            const $userEmailCheck = document.getElementById("userEmailCheck");
            $userEmailCheck.addEventListener("click", (e)=>{
                const $userEmail = document.getElementById("userEmail");
                e.preventDefault();
                window.open("/stageus/actions/emailCheckAction.jsp?userEmail="+ $userEmail.value, "_blank","popup=true");
            });

            // 부서 (userInfo object)
            const $userTim = document.getElementById("userTim");
            $userTim.addEventListener("input", (e)=>{
                const targetValue = e.target.value;
                // userInfo.tim 속성 삭제
                if(!targetValue) return delete userInfo.tim;
                // userInfo.tim 속성 추가
                userInfo.tim = targetValue;
            });

            //직급 (userInfo object)
            const $userRank = document.getElementById("userRank");
            $userRank.addEventListener("input", (e)=>{
                const targetValue = e.target.value;
                // userInfo.rank 속성 삭제
                if(!targetValue) return delete userInfo.rank;
                // userInfo.rank 속성 추가
                userInfo.rank = targetValue;
            });

            /*
                form 안의 각필드는 입력값에 따라 userInfo의 값을 변화시킨다.
                각 필드가 유효성에 맞지 않는다면 userInfo의 프로퍼티가 빠지게 되고,
                form자체에 input 이벤트를 걸어 userInfo의 length를 판단하여
                회원가입버튼을 disabled한다.
            */ 
            const $signUpForm = document.getElementById("signUpForm");
            $signUpForm.addEventListener("input", ()=>{
                sigunButtonDisabled();
            });

            // 중복확인 순서 다시확인
            $signUpForm.addEventListener("submit", (e)=>{
                const $userId = document.getElementById("userId");
                if(!userInfo.id || userInfo.id !== $userId.value){
                    e.preventDefault();
                    return alert("아이디중복체크");
                };
                if(!userInfo.email){
                    e.preventDefault();
                    return alert("아이디중복체크");
                }
            })
        })
    </script>
</html>


<%-- 
    확인필요
    not disabled: submit시 중복확인순서 재확인 

 --%>