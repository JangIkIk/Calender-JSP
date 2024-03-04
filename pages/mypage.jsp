<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <div class="p-50 flex column items-center">
            <div><%@ include file="/pages/header.jsp"%></div>
            <div class="w-500">
                <h3 class="p-10 border-bt">마이페이지</h3>
                <ul>
                    <li class="p-10 border-bt">아이디: ?</li>
                    <li class="p-10 border-bt">비밀번호: ?</li>
                    <li class="p-10 border-bt">이름: ?</li>
                    <li class="p-10 border-bt">이메일: ?</li>
                    <li class="p-10 border-bt">부서: ?</li>
                    <li class="p-10 border-bt">직급: ?</li>
                </ul>
            </div>
            <div><a class="p-10 base-button w-full base-shadow" href="/stageus/pages/profileSet.jsp">정보수정</a></div>
            <div><a class="p-10 base-button w-full base-shadow" href="/stageus/pages/profileSet.jsp">회월탈퇴</a></div>
        </div>
    </body>
</html>