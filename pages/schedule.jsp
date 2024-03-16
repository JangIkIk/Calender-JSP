<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Connector 파일을 찾는 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>
<%-- 데이터베이스에 연결하는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- sql을 전송하는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement"%>
<%-- Table 데이터 저장하는 라이브러리 --%>
<%@ page import="java.sql.ResultSet"%>
<%-- 리스트 불러옴 --%>
<%@ page import="java.util.ArrayList" %>
<%-- 캘린더 인스턴스 불러옴 --%>
<%@ page import="java.util.Calendar"%>

<%  
    // 세션확인
    String sessionId = (String) session.getAttribute("session_id");
    if(sessionId == null){
        out.println("<script>alert('회원만 가능'); window.location.href='/stageus/pages/login.jsp';</script>");
    }

    request.setCharacterEncoding("UTF-8");
    String getYears = request.getParameter("year");
    String getMonth = request.getParameter("month");
    // java 캘린더 인스턴스
    Calendar cal = Calendar.getInstance();
    // 현재 년도
    int currentYears = cal.get(cal.YEAR);
    // 현재 월
    int currntMonth = cal.get(cal.MONTH) + 1;
    // 일


    // 선택 년도
    int selectYears = currentYears;
    // 선택 월
    int selectMonth = currntMonth;

    // 년도 쿼리스트링이 있다면
    if(getYears != null) selectYears = Integer.parseInt(getYears);    
    // 월 쿼리스트링이 있다면
    if(getMonth != null) selectMonth = Integer.parseInt(getMonth);


%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/common.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/scheduleAddModal.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/schedule.css" rel="stylesheet" type="text/css">
        <title>스케줄</title>
    </head>
    <body>
        <div class="schedule">
            <%-- header --%>
            <%@ include file="/pages/header.jsp"%>

            <%-- 년도 버튼 및 표시 --%>
            <div id="years" class="schedule__years">
                <button class="schedule__years__button" id="left">◀️</button>
                <h2 class="schedule__years__h2" id="currentYears"></h2>
                <button class="schedule__years__button" id="right">▶️</button>
            </div>

            <%-- 월 버튼 --%>
            <ul class="schedule__months" id="months">
                <li><button id="1" class="schedule-months-container-li__button">1월</button></li>
                <li><button id="2" class="schedule-months-container-li__button">2월</button></li>
                <li><button id="3" class="schedule-months-container-li__button">3월</button></li>
                <li><button id="4" class="schedule-months-container-li__button">4월</button></li>
                <li><button id="5" class="schedule-months-container-li__button">5월</button></li>
                <li><button id="6" class="schedule-months-container-li__button">6월</button></li>
                <li><button id="7" class="schedule-months-container-li__button">7월</button></li>
                <li><button id="8" class="schedule-months-container-li__button">8월</button></li>
                <li><button id="9" class="schedule-months-container-li__button">9월</button></li>
                <li><button id="10" class="schedule-months-container-li__button">10월</button></li>
                <li><button id="11" class="schedule-months-container-li__button">11월</button></li>
                <li><button id="12" class="schedule-months-container-li__button">12월</button></li>
            </ul>

            <%-- 년,월,일에 대한 표시 --%>
            <div class="schedule__days" id="day">
                <h3 class="schedule__days__title" id="dayMonth"></h3>
                <ul class="schedule__days__container" id="days"></ul>
            </div>

        </div>

        <%--  글쓰기 모달창 --%>
        <%@ include file="/pages/scheduleAddModal.jsp"%>

    </body>
    <script>
        let selectYears = <%=selectYears%>;
        let selectMonth = <%=selectMonth%>

        // 년도 렌더링*
        const showYears = ()=>{
            const $currentYears = document.getElementById("currentYears");
            $currentYears.innerText = selectYears;
            createDays(selectYears, selectMonth, obj);
        }

        // 년도 이동*
        const onClickYears = (e)=>{
            const targetId = e.target.id;
            if(targetId === "currentYears") return;

            if(targetId === "left"){
                selectYears -= 1;
                window.location.href = "/stageus/pages/schedule.jsp?year=" + selectYears + "&month=" + selectMonth;
            }

            if(targetId === "right"){
                selectYears += 1;
                window.location.href = "/stageus/pages/schedule.jsp?year=" + selectYears + "&month=" + selectMonth;
            }
            showYears();
        }

        // 월 렌더링*
        const showMonths = ()=>{
            const $months = document.querySelectorAll("#months button");
            for(let month of $months){
                month.addEventListener("click",onClickMonths);
                if(selectMonth === +month.id){
                    month.classList.add("schedule-months-container-li__button--current");
                }
            }
        };

        // 월 이동*
        const onClickMonths = (e)=>{
            const targetId = +e.target.id;
            selectMonth = targetId;
            window.location.href = "/stageus/pages/schedule.jsp?year=" + selectYears + "&month=" + selectMonth;
            showMonths();
        };



        // 임시데이터
        let obj = {
            "202431":1,
            "202432":2,
            "202434":5,
            "2024310":2,
            "2024312": 10,
        };

        // 일 생성
        const createDays = (year,month,days)=>{
            /*
                사실상 제일 간단한건 클라이언트측에서 년,월에 따라 일을 그려준다
                이후에 서버에서는 list형태로 [null,1,null,3] 형태로 일에 순수대로 돌려주면된다?
                서버측에서는 어떤식으로 저장하냐에 따라 틀려질것 같다.
            */
            const $days = document.getElementById("days");
            const YEAR = year;
            const MONTH = month;
            const DAYS = days; // 서버껄로            

            // 현재 년도
            const currentYear = new Date().getFullYear();
            // 현재 월
            const currentMonth = new Date().getMonth() + 1;
            // 현재 년,월 에 대한 일가져옴 -> 현재일정 표시하기 위함
            const currentDay = new Date().getDate();

            // 년,월을 받아 마지막일 계산
            const lastDay = new Date(year, month, 0).getDate();
            
            // 마지막일에 따른 주 계산
            const week = Math.ceil(lastDay / 7);

            let weekFirstDay = 1;
            let weekLastDay = 7;
            
            for(let i = 0 ; i < week ; i++){
                // 한주를 표시할 li
                const liElement = document.createElement("li");
                liElement.classList.add("schedule-days-container-li");

                    for(let j = weekFirstDay ; j <= weekLastDay; j++){
                        // 해당 방법은 조금 복잡한 감이있다.
                        // 현재는 보류하고 좀더 좋은 방법으로~
                        const key = "" + YEAR + MONTH + j;

                        //각 날짜의 부모
                        const ContainerElement = document.createElement("div");
                        ContainerElement.classList.add("schedule-days-container-li-div");
    
                        // 각 일
                        const dayElement = document.createElement("p");
                        dayElement.classList.add("schedule-days-container-li-div__day");
                        // 각 일표시
                        dayElement.innerText = j;
                        // 현재 기준 일 표시하기
                        if("" + currentYear + currentMonth + currentDay === key){
                            dayElement.classList.add("schedule-days-container-li-div__day--current");
                        }
    
                        // 각일에 대한 일정
                        const contentElement = document.createElement("p");
                        contentElement.classList.add("schedule-days-container-li-div__daycount");
                        // 일정이 있다면
                        if(DAYS[key]){
                            contentElement.addEventListener("click", ()=>{
                                // 여기서 쿼리스트링으로 년,월,일 넘긴다
                                // 직급에 대한 문제는 세션으로 확인해야 하나?
                                open("/stageus/pages/scheduleInfoModal.jsp?year=" + YEAR + "&month=" + MONTH + "&day=" + DAYS[key], "_self","");
                            })
                            contentElement.style.cursor = "pointer";
                            contentElement.innerText = "일정:" + DAYS[key];
                        }
        
                        ContainerElement.appendChild(dayElement);
                        ContainerElement.appendChild(contentElement);
                        liElement.appendChild(ContainerElement);
                    }

                weekFirstDay = weekFirstDay + 7;
                weekLastDay = Math.min(weekLastDay + 7, lastDay);
                $days.appendChild(liElement);
            }
        };

        window.addEventListener("load", () => {
            // 년도 이동
            const $years = document.getElementById("years");
            $years.addEventListener("click",onClickYears);

            // 월이동
            const $months = document.getElementById("months");
            $months.addEventListener("click",onClickMonths);

            // 현재월 표시, 및 이벤트
            showMonths();
            // 년도 표시
            showYears();
        })
    </script>
</html>


