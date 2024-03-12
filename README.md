### 코드컨벤션
변수 (형용사 + 명사 )

상수(대문자)
RESULT

이벤트 함수(접두사 + 동사 + 명사)
- event + 동사 + 명사

계산하는 함수(접두사 + 동사 + 명사)
- handler + 동사 + 명사

보여주는 함수(접두사 + 동사 + 명사)
- show + 동사 + 명사

### 파일구분
[actions]
1. 기능별액션: 기능 + Action.jsp
[css]
1. 페이지 css: pageName.css
2. 공통 css: common.css
3. 초기화 css: init.css

[pages]
1. 페이지: pageName.jsp


[의문점]
1. 페이지에 해당되는 css파일은 include와 상관없이 적용해주어야 하는지?


/*
    id
    $userId.addEventListener("input", (e)=>{

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
*/

/*
    // 비밀번호 (유효성검사, 안내문구 텍스트)
            $userPw.addEventListener("input", (e)=>{
                const $userPwCheck = document.getElementById("userPwCheck");
                const $idValidation = document.querySelector("#userPwCheckContainer p");
                
                if($userPwCheck.value === userInfo.password){
                    $idValidation.innerText = "비밀번호가 일치하지 않습니다";
                }else{
                    $idValidation.innerText = "";
                }

                const targetValue = e.target.value;
                
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
        
            // 위 코드와 합쳐야함@@ 중복 코드가 발생
            
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
*/
