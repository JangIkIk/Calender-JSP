<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <ul id="menu" class="header-menu">
            <li class="header-menu-li">
                <a class="header-menu-li__a" href="/stageus/pages/schedule.jsp">홈</a>
            </li>
            <li class="header-menu-li">
                <a class="header-menu-li__a" href="/stageus/pages/mypage.jsp">마이페이지</a>
            </li>
            <li id="logout" class="header-menu-li">
                <%-- 이벤트 따로 빼서 confirm 적용 --%>
                <a class="header-menu-li__a" href="/stageus/actions/logoutAction.jsp">로그아웃</a>
            </li>
        </ul>
    </body>
</html>