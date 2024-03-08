<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    String test = request.getParameter("test");
    // 부모요소에서 파라미터를 전달받아 일에대한 개수와 데이터를 같이 넣어야한다
%>
<%-- 
    schedule.jsp 파일에서 년도를 클릭할때마다,
    days 파일에서는 년 , 월을 받아야한다.
 --%>
<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/utility.css" rel="stylesheet" type="text/css">
    </head>
    <body>
            <%-- 여기서 데이터 --%>
            <ul id="days">
            </ul>
            <p id="testText"></p>
    </body>
    <script>
        const dayCalc = (y, m) => {
            const currentDate = new Date();
            const $days = document.getElementById("days");
            $days.innerText = "";
            // 년,월을 받아 마지막일 계산
            const lastDay = new Date(y, m, 0).getDate();
            // 마지막일에 따른 주 계산
            const week = Math.ceil(lastDay / 7);
            const $testText = document.getElementById("testText");
            $testText.innerText = y + "년" + m + "월 마지막 일은 " + lastDay + "일 이며" + week + "주입니다";

            let weekFirstDay = 1;
            let weekLastDay = 7;
            for (let i = 0; i < week; i++) {
                const liElement = document.createElement("li");
                liElement.classList.add("flex", "w-full", "text-center");
                for (let j = weekFirstDay; j <= weekLastDay; j++) {
                    const divelement = document.createElement("div");
                    divelement.classList.add("day", "w-100", "h-100", "line", "radius-5", "m-2");

                    const dayElement = document.createElement("p");
                    dayElement.classList.add("bg-gray");
                    dayElement.innerText = j;
                    
                    const contentElement = document.createElement("p");
                    if( y + m === currentDate.getFullYear() + currentDate.getMonth() + 1 && currentDate.getDate() === j){
                        contentElement.classList.add("base-bg");
                    }
                    contentElement.innerText = "등록일정: N개"

                    divelement.appendChild(dayElement);
                    divelement.appendChild(contentElement);
                    liElement.appendChild(divelement);
                }
                weekFirstDay = weekFirstDay + 7;
                weekLastDay = Math.min(weekLastDay + 7, lastDay);
                $days.appendChild(liElement);
            }
        }

        window.addEventListener("load",()=>{
            dayCalc();
        })
    </script>
</html>