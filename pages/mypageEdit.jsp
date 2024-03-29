<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList" %>

<%
    ArrayList<String> dayList = new ArrayList<String>();
    try{
        String sessionId = (String) session.getAttribute("session_id");
        if(sessionId == null){
            out.println("<script>alert('회원만 가능'); window.location.href='/stageus/pages/login.jsp';</script>");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        String userInfoSQL = "SELECT account.password, account.name, account.email, groups.idx, level.idx FROM account INNER JOIN groups ON account.tim = groups.idx INNER JOIN level ON account.rank = level.idx WHERE account.idx=?";
        PreparedStatement userInfoQuery = connect.prepareStatement(userInfoSQL);
        userInfoQuery.setString(1,sessionId);
        ResultSet result = userInfoQuery.executeQuery();

        while(result.next()){
            String password = result.getString(1);
            String name = result.getString(2);
            String email = result.getString(3);
            String tim = result.getString(4);
            String rank = result.getString(5);
            dayList.add(String.format("{\"password\":\"%s\",\"name\":\"%s\",\"email\":\"%s\",\"tim\":\"%s\",\"rank\":\"%s\",}", password, name, email, tim, rank));
        }
    }
    catch(Exception e){
        out.println("<script>alert('정보를 불러올수가 없습니다'); history.back();</script>");
        return;
    } 
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
            <form class="form" id="form" method="post" action="/stageus/actions/mypageEditAction.jsp">
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
                                    <option value="1">디자인</option>
                                    <option value="2">기획</option>
                                </select>
                            </div>
                        </div>
                        <%-- 직급 --%>
                        <div class="form__container-between__wrap">
                            <label for="userRank"><span>직급</span><span class="star">*</span></label>
                            <div>
                                <select class="select" id="userRank" name="userRank">
                                    <option value="">선택</option>
                                    <option value="1">팀장</option>
                                    <option value="2">팀원</option>
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
            const dayList = <%=dayList%>[0];

            const pwRegex = (pw)=>{
                const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{5,20}$/;
                return regex.test(pw);
            };

            const nameRegex = (name)=>{
                const regex = /^[가-힣a-zA-Z]{2,10}$/;
                return regex.test(name);
            };

            const emailRegex = (email)=>{
                    const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{1,30}$/;
                    return regex.test(email);
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

            const onInputNameText = (e) => {
                const targetValue = e.target.value;
                const $alertText = document.querySelector("#userNameContainer p");

                if(targetValue && !nameRegex(targetValue)) return $alertText.innerText = "영문 또는 한글 2자 ~ 10자";
                $alertText.innerText = "";
            };

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

            const onClickPopup = (e)=>{
                e.preventDefault();
                const userEmailValue = document.getElementById("userEmail").value;
                if(!userEmailValue) return alert("이메일을  입력해주세요");
                if(!emailRegex(userEmailValue)) return alert("이메일 형식을 확인해주세요");
                window.open("/stageus/actions/checkEmailAction.jsp?userEmail="+ userEmailValue, "_blank","");
            };

            const onSubmit = (e)=>{
                const userPwValue = document.getElementById("userPw").value;
                const userPwCheckValue = document.getElementById("userPwCheck").value;
                const userNameValue = document.getElementById("userName").value;
                const userEmailValue = document.getElementById("userEmail").value;
                const userTimValue = document.getElementById("userTim").value;
                const userRankValue = document.getElementById("userRank").value;

                try{
                    if(!pwRegex(userPwValue)) throw "비밀번호를 확인해주세요";
                    if(userPwValue !== userPwCheckValue) throw "비밀번호가 일치하지 않습니다";
                    if(!nameRegex(userNameValue)) throw "이름을 확인해주세요";
                    if(!emailRegex(userEmailValue)) throw "이메일을 확인해주세요";
                    if(isEmail !== userEmailValue) throw "이메일 중복체크를 해주세요";
                    if(!userTimValue) throw "부서를 선택해주세요";
                    if(!userRankValue) throw "직급을 선택해주세요";
                    if(userPwValue === dayList.password && userNameValue === dayList.name && userEmailValue === dayList.email && userTimValue === dayList.tim && userRankValue === dayList.rank) throw "변경된 정보가 없습니다";
                    
                }
                catch(error){
                    e.preventDefault();
                    alert(error);
                    return false;
                }
                
                return true;
            };

            const showUserOldInfo = ()=>{
                const userPwValue = document.getElementById("userPw");
                const userPwCheckValue = document.getElementById("userPwCheck");
                const userNameValue = document.getElementById("userName");
                const userEmailValue = document.getElementById("userEmail");
                const userTimValue = document.getElementById("userTim");
                const userRankValue = document.getElementById("userRank");                

                isEmail = dayList.email;
                userPwValue.value = dayList.password;
                userPwCheckValue.value = dayList.password;
                userNameValue.value = dayList.name;
                userEmailValue.value = dayList.email;
                userTimValue.value=dayList.tim;
                userRankValue.value=dayList.rank;

                submitBtnDisabled();
            }

            function emailCheck(email){
                isEmail = email;
                emailBtnDisabled(true);
                submitBtnDisabled();
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

            const submitBtnDisabled = ()=>{
                const userPwValue = document.getElementById("userPw").value;
                const userPwCheckValue = document.getElementById("userPwCheck").value;
                const userNameValue = document.getElementById("userName").value;
                const userEmailValue = document.getElementById("userEmail").value;
                const userTimValue = document.getElementById("userTim").value;
                const userRankValue = document.getElementById("userRank").value;
                const $submit = document.getElementById("submit");

                try{   

                    if(!pwRegex(userPwValue)) throw true;
                    if(userPwValue !== userPwCheckValue) throw true;
                    if(!nameRegex(userNameValue)) throw true;
                    if(!emailRegex(userEmailValue)) throw true;
                    if(isEmail !== userEmailValue) throw true;
                    if(!userTimValue) throw true;
                    if(!userRankValue) throw true;                    
                    if(userPwValue === dayList.password && userNameValue === dayList.name && userEmailValue === dayList.email && userTimValue === dayList.tim && userRankValue === dayList.rank) throw true;
                } 
                catch(error){
                    $submit.classList.add("base-button--gray");
                    $submit.disabled = error;
                    return;
                }

                $submit.classList.remove("base-button--gray");
                $submit.disabled = false;
            };

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
                $form.addEventListener("submit",onSubmit);

                showUserOldInfo();
            })
    </script>
</html>