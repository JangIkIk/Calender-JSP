<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/common.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/schedule.css" rel="stylesheet" type="text/css">
        <title>스케줄</title>
    </head>
    <body>
        <div class="schedule">
            <%@ include file="/pages/header.jsp"%>
            <div class="schedule-years">
                <button id="left" class="schedule-years__button">◀️</button>
                <h2 id="years" class="schedule-years__h2"></h2>
                <button id="right" class="schedule-years__button">▶️</button>
            </div>
            <ul id="months" class="schedule-months">
            </ul>
            <%-- 
                days.jsp에서는 년,월을 받아 해당월의 일을 그려야한다.
                그렇다면 년월을 <jsp:param name="변수명" value="값"/>을 통해 전달해야하는데
                그전에 값을 어떻게 동적으로 전달할수 있냐 ?
             --%>
            <div id="day" class="schedule-day">
                <h3 id="month" class="schedule-day-title"></h3>
                <jsp:include page="/pages/days.jsp">
                    <jsp:param name="test" value="60"/>
                </jsp:include>
            </div>
        </div>
    </body>
    <%--  파일 역할분리 해야함  --%>
    <script>
        const dateState = ()=>{
            let years = new Date().getFullYear();
            let month = new Date().getMonth() + 1;
            return{
                getYears: () => years,
                setYears: (newYears) => years = newYears,
                getMonth: () => month,
                setMonth: (newMonth) => month = newMonth,
            }
        }
        const dateInfo = dateState();

        // header.jsp에 접근하여 글쓰기 버튼 생성
        const createButton = () => {
            const $menu = document.getElementById("menu");
            const liElement = document.createElement("li");
            liElement.classList.add("header-menu-li");

            const buttonElement = document.createElement("button");
            buttonElement.classList.add("header-menu-li__a");
            buttonElement.innerText = "글쓰기";
            liElement.appendChild(buttonElement);
            $menu.appendChild(liElement);
        }

        // 전년도 이동 이벤트
        const onClickBeforeYears = ()=>{
            const newYears = dateInfo.getYears() - 1;
            showYears(newYears);
            dateInfo.setYears(newYears);
            dayCalc(dateInfo.getYears(), dateInfo.getMonth());
        }

        // 다음년도 이동 이벤트
        const onClickAfterYears = ()=>{
            const newYears = dateInfo.getYears() + 1;
            showYears(newYears);
            dateInfo.setYears(newYears);
            dayCalc(dateInfo.getYears(), dateInfo.getMonth());
        }

        // 년도 계산하는 함수
        const handlerYears = (years)=>{
            if(!years) return showYears(dateInfo.getYears());
            showYears(years);
        }
        // 년도 보여주는 함수
        const showYears = (years)=>{
            const $years = document.getElementById("years");
            $years.innerText = years;
        }

        // 월 버튼 생성
        const createMonthsButton = () => {
            const $months = document.getElementById("months");
            for (let i = 1 ; i <= 12 ; i++){
                const buttonElement = document.createElement("button");
                buttonElement.classList.add("schedule-months-container__button");
                buttonElement.id = i;
                buttonElement.innerText = i + "월";

                const liElement = document.createElement("li");
                liElement.appendChild(buttonElement);
                $months.appendChild(liElement);
            }
        };

        // 저장된 월, 저장 및 화면 렌더링
        const onClickMonths = (e)=>{
            const targetId = Number(e.target.id);
            dateInfo.setMonth(targetId);
            dayCalc(dateInfo.getYears(), dateInfo.getMonth());
        }

        window.addEventListener("load", () => {            
            // 왼쪽버튼 이벤트
            const $left = document.getElementById("left");
            $left.addEventListener("click", onClickBeforeYears);

            // 오른쪽버튼 이벤트
            const $right = document.getElementById("right");
            $right.addEventListener("click", onClickAfterYears);

            // 월버튼 부모 이벤트
            const $months = document.getElementById("months");
            $months.addEventListener("click", onClickMonths);

            // 글쓰기 버튼 생성 함수
            createButton();
            // 월 버튼 생성 함수
            createMonthsButton();
            // 년도 핸들러
            handlerYears();
            // 초기 호출
            dayCalc(dateInfo.getYears(), dateInfo.getMonth());
        })
    </script>
    
</html>

<%-- 
    기능구조
    년,월,일에 따른 데이터 요청 action이 필요하다.


--%>

<%-- 
    지시어 방식(정적) : <%@ include file="경로"%>
    * 해당소스를 포함시킨후 컴파일 실행
    * 서버측에서 실행하는 코드

    액션 방식(동적) : <jsp:include page="경로">
    * 해당소스를 마주치면 해당 시점에 파일을 실행
    * 클라이언트 측에서 실행하는 코드
    * <jsp:param name="변수명" value="값"/>
 --%>
