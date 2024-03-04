<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/utility.css" rel="stylesheet" type="text/css">
        <title>회원가입</title>
    </head>
    <body>
        <main class="h-full flex justify-center items-center">
            <div class="w-500">
                <h1 class="p-10 border-bt-1sb">회원가입</h1>
                <form class="p-10 flex column gap-10" method="post" action="/stageus/actions/signUpAction.jsp">
                    <div class="flex column gap-10">
                        <%-- 아이디 --%>
                        <div>
                            <label for="userId"><span>아이디</span><span class="font-red">*</span></label>
                            <div class="w-full flex gap-10">
                                <div class="grow-1"><input class="w-full p-10 radius-5" id="userId" name="userId" type="text" placeholder="아이디를 입력해주세요"></div>
                                <div><button class="p-10 simple-button">중복확인</button></div>
                            </div>
                            <p class="font-red py-5">영문,숫자를 포함한 3자 ~ 20자</p>
                        </div>
                        <%-- 비밀번호 --%>
                        <div>
                            <label for="userPw"><span>비밀번호</span><span class="font-red">*</span></label>
                            <div class="flex column gap-10">
                                <div>
                                    <input class="w-full p-10 radius-5" id="userPw" name="userPw" type="password" placeholder="비밀번호를 입력해주세요">
                                    <p class="font-red py-5">5자 이상 ~ 20자 이하</p>
                                </div>
                                <div>
                                    <input class="w-full p-10 radius-5" id="userPwCheck" name="userPwCheck" type="password" placeholder="입력하신 비밀번호를 입력해주세요">
                                    <p class="font-red py-5">비밀번호가 일치하지 않습니다</p>
                                </div>
                            </div>
                        </div>
                        <%-- 이름 --%>
                        <div>
                            <label for="userName"><span>이름</span><span class="font-red">*</span></label>
                            <div>
                                <input class="w-full p-10 radius-5" id="userName" name="userName" type="text" placeholder="이름을 입력해주세요">
                            </div>
                            <p class="font-red py-5">영문 또는 한글 2자 이상 ~ 10자 이하</p>
                        </div>
                        <%-- 이메일 --%>
                        <div>
                            <label for="userEmail"><span>이메일</span><span class="font-red">*</span></label>
                            <div>
                                <input class="w-full p-10 radius-5" id="userEmail" name="userEmail" type="text" placeholder="이메일을 입력해주세요">
                            </div>
                            <p class="font-red py-5">이메일형식에 맞지않습니다</p>
                        </div>
                        <%-- 부서 / 직급 --%>
                        <div class="flex justify-between gap-10">

                            <%-- 부서 --%>
                            <div class="grow-1">
                                <label for="userTim"><span>부서</span><span class="font-red">*</span></label>
                                <div>
                                    <select class="w-full" id="userTim" name="userTim">
                                        <option>선택</option>
                                        <option>디자인</option>
                                        <option>기획</option>
                                    </select>
                                </div>
                            </div>

                            <%-- 직급 --%>
                            <div class="grow-1">
                                <label for="userRank"><span>직급</span><span class="font-red">*</span></label>
                                <div>
                                    <select class="w-full" id="userRank" name="userRank">
                                        <option>선택</option>
                                        <option>팀장</option>
                                        <option>팀원</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                    </div>
                    <%-- submit --%>
                    <div>
                        <input class="w-full p-10 base-button" type="submit" value="회원가입">
                    </div>

                    <%-- login 페이지 이동 --%>
                    <div>
                        <input class="w-full p-10 base-button" type="button" value="로그인 하러가기" onClick="location.href='/stageus/pages/login.jsp'">
                    </div>
                </form>
            </div>
        </main>
    </body>
</html>