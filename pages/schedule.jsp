<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>스케줄</title>
    </head>
    <body>
        <div class="p-50 flex column items-center">
            <div>
                <%@ include file="/pages/header.jsp"%>
            </div>
            <div class="flex justify-center gap-10 p-10">
                <button id="left" class="font-smail">◀️</button>
                <h2 id="years" class="font-smail">2024</h2>
                <button id="right" class="font-smail">▶️</button>
            </div>
            <ul id="months" class="flex  justify-center gap-10">
            </ul>
            <h3 id="month" class="p-10">8월</h3>
            <jsp:include page="/pages/days.jsp">
                <jsp:param name="test" value="2"/>
            </jsp:include>
        </div>
    </body>
    <%--  파일 역할분리 해야함  --%>
    <script>
        window.addEventListener("load", () => {
            let YEARS = 0;
            let MONTHS = 0;


            // 현재 년,월,일 생성
            const date = new Date();
            // 메뉴 DOM
            const $menu = document.getElementById("menu");
            const liElement = document.createElement("li");
            liElement.classList.add("w-100");
            // 버튼 크기 안맞음
            const buttonElement = document.createElement("button");
            buttonElement.classList.add("p-10", "base-button", "w-full", "base-shadow");
            buttonElement.innerText = "글쓰기";
            buttonElement.addEventListener("click", ()=>{
                console.log("모달창 open");
            })
            liElement.appendChild(buttonElement);
            $menu.appendChild(liElement);
            
            // 왼쪽버튼 DOM
            const $left = document.getElementById("left");
            // 년도 DOM
            const $years = document.getElementById("years");
            // 오른쪽버튼 DOM
            const $right = document.getElementById("right");
            // 월 버튼 DOM
            const $months = document.getElementById("months");
            // 월
            const $month = document.getElementById("month");

            // 현재 년도 가져옴
            const years = date.getFullYear();
            // 전역변수 현재년도 할당
            YEARS = years;
            // dom에 현재년도 할당
            $years.innerText = YEARS;
            // 현재 년도 월 가져옴
            const months = date.getMonth() + 1;
            // 전역변수 현재 월 할당
            MONTHS = months;
            $month.innerText = MONTHS + "월";

            // 현재 일 가져옴
            const day = date.getDate();

            
            $left.addEventListener("click", () => {
                YEARS = YEARS - 1;
                $years.innerText = YEARS;
                dayCalc(YEARS, MONTHS);
            })
            // 년도 오른쪽넘기기
            $right.addEventListener("click", () => {
                YEARS = YEARS + 1;
                $years.innerText = YEARS;
                dayCalc(YEARS, MONTHS);
            })

            // 월 Element 생성
            for (let i = 1; i <= 12; i++) {
                const liElement = document.createElement("li");
                const buttonElement = document.createElement("button");
                buttonElement.classList.add("p-10", "base-border-color", "radius-5", "bg-white");
                buttonElement.addEventListener("click", (e) => {
                    MONTHS = i;
                    $month.innerText = MONTHS + "월";
                    dayCalc(YEARS, MONTHS);
                });
                buttonElement.innerText = i + "월";
                liElement.appendChild(buttonElement)
                $months.appendChild(liElement);
            }
            // 초기생성
            dayCalc(YEARS, MONTHS);
        })

        // 년,월을 받아 해당하는 day출력
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

    </script>
    
</html>

<%-- 
    지시어 방식(정적) : <%@ include file="경로"%>
    * 해당소스를 포함시킨후 컴파일 실행
    * 서버측에서 실행하는 코드

    액션 방식(동적) : <jsp:include page="경로">
    * 해당소스를 마주치면 해당 시점에 파일을 실행
    * 클라이언트 측에서 실행하는 코드
    * <jsp:param name="변수명" value="값"/>
 --%>