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
                        <input id="submit" class="form-movebutton form-movebutton--disabled" type="submit" value="회원가입" disabled>
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

            // 아이디
            const idRegex = (id)=>{
                    const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{3,20}$/;
                    return regex.test(id);
            };  

            // 비밀번호
            const pwRegex = (pw)=>{
                const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$/;
                return regex.test(pw);
            }

            // 이메일
            const emailRegex = (email)=>{
                    const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{1,30}$/;
                    return regex.test(email);
            };

            // 이름 
            const nameRegex = (name)=>{
                const regex = /^[가-힣a-zA-Z]{2,10}$/;
                return regex.test(name);
            };

            // 아이디 Input 유효성 텍스트 
            const onInputIdValidationText = (e) => {
                const targetValue = e.target.value;
                const $idValidationText = document.querySelector("#userIdContainer p");

                if(!idRegex(targetValue)){
                    idCheckBtnDisabled(true);
                    // 안내문구 텍스트 추가
                    $idValidationText.innerText = "영문 숫자를 포함한 3자 ~ 20자";
                    return;
                };
                idCheckBtnDisabled(false);
                // 안내문구 텍스트 삭제
                $idValidationText.innerText = "";
                
            };
            // 아이디 중복체크 버튼
            const idCheckBtnDisabled = (isTrue) => {
                const $userIdCheck = document.getElementById("userIdCheck");
                if(isTrue){
                    // 아이디 중복체크버튼 클래스 변경
                    $userIdCheck.classList.replace("signup-inbox-container-div__button", "signup-inbox-container-div__button--disabled")
                    // 아이디 중복체크버튼 disabled
                    $userIdCheck.disabled = isTrue;
                    return;
                }
                // 아이디 중복체크버튼 클래스 변경
                $userIdCheck.classList.replace("signup-inbox-container-div__button--disabled", "signup-inbox-container-div__button");
                // 아이디 중복체크버튼 disabled
                $userIdCheck.disabled = isTrue;
            }

            // 아이디 중복체크 버튼 팝업창
            const onClickIdCheckPopup = (e)=>{
                e.preventDefault();
                const $userId = document.getElementById("userId");
                if(!$userId.value) return alert("아이디를 입력해주세요");
                if(!idRegex($userId.value))return alert("아이디 형식과 맞지 않습니다");
                window.open("/stageus/actions/idCheckAction.jsp?userId=" + $userId.value, "_blank","");
            }

            // 자식 팝업창에서 userInfo에 id 값을 저장하고, 중복확인 버튼 비활성화
            function setUserId(uid){
                const $userIdCheck = document.getElementById("userIdCheck");
                $userIdCheck.disabled = true;
                $userIdCheck.classList.replace("signup-inbox-container-div__button","signup-inbox-container-div__button--disabled");
                userInfo.id = uid;
                onInputSigunBtnDisabled();
            };

            // 비밀번호 Input 유효성 텍스트 및 값저장
            const onInputPwValidationText = (e)=>{
                const $pwText = document.querySelector("#userPwContainer p");
                const targetValue = e.target.value;

                // 안내문구 텍스트 추가
                if(!pwRegex(targetValue)){
                    // userInfo.password 속성 삭제
                    delete userInfo.password;
                    $pwText.innerText = "5자 이상 ~ 20자 이하";
                    onInputPwCheckValidationText();
                    return;
                }

                // userInfo.password 속성 추가
                userInfo.password = targetValue;
                // 안내문구 텍스트 삭제
                $pwText.innerText = "";
                onInputPwCheckValidationText();
            }

            // 비밀번호 확인 input 유효성 텍스트
            const onInputPwCheckValidationText = ()=>{
                const $pwCheckText = document.querySelector("#userPwCheckContainer p");
                const $pwValue = document.getElementById("userPw")
                const $pwCheckValue = document.getElementById("userPwCheck");
                // 비밀번호체크 텍스트
                if($pwCheckValue.value && $pwValue.value !== $pwCheckValue.value) return $pwCheckText.innerText = "비밀번호가 일치하지 않습니다";
                $pwCheckText.innerText = "";
            }

            // 이름 input 유효성 텍스트
            const onInputNameValidationText = (e) => {
                const $idValidation = document.querySelector("#userNameContainer p");
                const targetValue = e.target.value;
                
                if(!nameRegex(targetValue)){
                    // userInfo.name 속성 삭제
                    delete userInfo.name;
                    // 안내문구 텍스트 추가
                    $idValidation.innerText = "2자 이상 ~ 10자 이하의 영어 or 한글";
                    return;
                };
                // userInfo.name 속성 추가
                userInfo.name = targetValue;
                // 안내문구 텍스트 삭제
                $idValidation.innerText = "";
            }

            // 이메일 Input 유효성 텍스트
            const onInputEmailValidationText = (e)=> {
                const $EmailValidationText = document.querySelector("#userEmailContainer p");
                const targetValue = e.target.value

                if(!emailRegex(targetValue)){
                    emailCheckBtnDisabled(true);
                    $EmailValidationText.innerText = "이메일 형식에 맞지 않습니다";
                    return;
                };
                // 안내문구 텍스트 삭제
                $EmailValidationText.innerText = "";
                emailCheckBtnDisabled(false);
                

            }
            // 이메일 중복체크 버튼
            const emailCheckBtnDisabled = (isTrue) => {
                const $userEmailCheck = document.getElementById("userEmailCheck");
                if(isTrue){
                    // 이메일 중복체크버튼 클래스변경
                    $userEmailCheck.classList.replace("signup-inbox-container-div__button", "signup-inbox-container-div__button--disabled")
                    // 이메일 중복체크버튼 disabled
                    $userEmailCheck.disabled = isTrue;
                    return;
                }
                // 이메일 중복체크버튼 클래스변경
                $userEmailCheck.classList.replace("signup-inbox-container-div__button--disabled", "signup-inbox-container-div__button");
                // 이메일 중복체크버튼 disabled
                $userEmailCheck.disabled = isTrue;

            }

            // 이메일 중복체크 버튼 팝업창
            const onClickEmailCheckPopup = (e) => {
                e.preventDefault();
                const $userEmail = document.getElementById("userEmail");
                if(!$userEmail.value) return alert("이메일을 입력해주세요");
                if(!emailRegex($userEmail.value))return alert("이메일 형식과 맞지 않습니다");
                window.open("/stageus/actions/emailCheckAction.jsp?userEmail="+ $userEmail.value, "_blank","");
            }

            // 자식 팝업창에서 userInfo에 email 값을 저장하고, 중복확인 버튼 비활성화
            function setUserEmail(uem){
                const $userEmailCheck = document.getElementById("userEmailCheck");
                $userEmailCheck.disabled = true;
                $userEmailCheck.classList.replace("signup-inbox-container-div__button","signup-inbox-container-div__button--disabled");
                userInfo.email = uem;
                onInputSigunBtnDisabled();
            };


            // 회원가입 버튼 활성화/비활성화 => (아이디,비밀번호,비밀번호확인,이메일)
            const onInputSigunBtnDisabled = ()=>{
                const $submit = document.getElementById("submit");
                const $userId = document.getElementById("userId");
                const $userEmail = document.getElementById("userEmail");
                const $userPw = document.getElementById("userPw");
                const $userPwCheck = document.getElementById("userPwCheck");

                // 사용자가 입력한 모든 필드가 유효성을 통해 userInfo 객체에 저장되어 있지 않다면,
                if(Object.values(userInfo).length !== 6){
                    console.log("첫번째조건");
                    $submit.classList.replace("form-movebutton","form-movebutton--disabled");
                    $submit.disabled = true;
                    return;
                }
                // userInfo에 id가 존재하고, userInfo.id값과 현재 필드의 값이 일치하지 않는다면,
                if(userInfo.id && userInfo.id !== $userId.value){
                    console.log("두번째조건");
                    $submit.classList.replace("form-movebutton","form-movebutton--disabled");
                    $submit.disabled = true;
                    return;
                }
                // userInfo에 email이 존재하고, userInfo.email값과 현재 필드의 값이 일치하지 않는다면,
                if(userInfo.email && userInfo.email !== $userEmail.value){
                    console.log("세번째조건");
                    $submit.classList.replace("form-movebutton","form-movebutton--disabled");
                    $submit.disabled = true;
                    return;
                }
                // userInfo에 password이 존재하고, 비밀번호 & 비밀번호확인 값이 일치 하지 않는다면
                if(userInfo.password && $userPw.value !== $userPwCheck.value){
                    console.log("네번째조건");
                    $submit.classList.replace("form-movebutton","form-movebutton--disabled");
                    $submit.disabled = true;
                    return;
                }
                $submit.classList.replace("form-movebutton--disabled","form-movebutton");
                $submit.disabled = false;                
            };
            
        window.addEventListener("load",()=>{
            // 아이디 (안내문구 텍스트, 중복확인 버튼 활성화/비활성화)
            const $userId = document.getElementById("userId");
            $userId.addEventListener("input", onInputIdValidationText);

            // 아이디 중복체크버튼 팝업창
            const $userIdCheck = document.getElementById("userIdCheck");
            $userIdCheck.addEventListener("click", onClickIdCheckPopup);

            // 비밀번호 (안내문구 텍스트)
            const $userPw = document.getElementById("userPw");
            $userPw.addEventListener("input", onInputPwValidationText);

            // 비밀번호 확인 (안내문구 텍스트)
            const $userPwCheck = document.getElementById("userPwCheck");
            $userPwCheck.addEventListener("input",onInputPwCheckValidationText);

            // 이름 (안내문구 텍스트)
            const $userName = document.getElementById("userName");
            $userName.addEventListener("input", onInputNameValidationText);

            // 이메일 (유효성검사, 안내문구 텍스트, 이메일 중복체크버튼)
            const $userEmail = document.getElementById("userEmail");
            $userEmail.addEventListener("input",onInputEmailValidationText);

            // 이메일 중복체크버튼 팝업창
            const $userEmailCheck = document.getElementById("userEmailCheck");
            $userEmailCheck.addEventListener("click",onClickEmailCheckPopup);


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

            // 폼에 대해 이벤트가 발생할때마다 회원가입 활성화 비활성화 버튼 실행
            const $signUpForm = document.getElementById("signUpForm");
            $signUpForm.addEventListener("input", ()=>{
                onInputSigunBtnDisabled();
            });

            // submit 전에 필드값과 데이터 확인
            $signUpForm.addEventListener("submit", (e)=>{
                const $userId = document.getElementById("userId");
                const $userPw = document.getElementById("userPw");
                const $userPwCheck = document.getElementById("userPwCheck");
                const $userName = document.getElementById("userName");
                const $userEmail = document.getElementById("userEmail");
                const $userTim = document.getElementById("userTim");
                const $userRank = document.getElementById("userRank");

                if(!$userId.value){
                    e.preventDefault();
                    return alert("아이디를 입력해주세요");
                };

                if(!userInfo.id || userInfo.id !== $userId.value){
                    e.preventDefault();
                    return alert("아이디중복체크를 해주세요");
                };
                if(!userInfo.password || $userPw.value !== $userPwCheck.value){
                    e.preventDefault();
                    return alert("비밀번호를 확인해주세요");
                };
                if(!userInfo.name || userInfo.name !== $userName.value){
                    e.preventDefault();
                    return alert("이름을 확인해주세요");
                };

                if(!$userEmail.value){
                    e.preventDefault();
                    return alert("이메일을 입력해주세요");
                };
                if(!userInfo.email || userInfo.email !== $userEmail.value){
                    e.preventDefault();
                    return alert("이메일중복체크를 해주세요");
                };
                if(!userInfo.tim || userInfo.tim !== $userTim.value){
                    e.preventDefault();
                    return alert("부서를 선택해주세요");
                };
                if(!userInfo.rank || userInfo.rank !== $userRank.value){
                    e.preventDefault();
                    return alert("직급을 선택해주세요");
                };
            })
        })
    </script>
</html>