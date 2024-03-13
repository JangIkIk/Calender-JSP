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

            <ul id="months" class="schedule-months"></ul>

            <div id="day" class="schedule-days">
                <h3 id="dayMonth" class="schedule-days-title"></h3>
                <ul id="days" class="schedule-days-container">
                </ul>
            </div>

        </div>

        <form id="modal" class="modal modal--none" method="post" action="/stageus/actions/createSchedule.jsp">
            <div class="modal-container">

                <h1 class="modal-container-title">일정 작성하기</h1>

                <div class="modal-container-info">

                    <div class="modal-container-info-select">
                        <div class="modal-container-info-select-wrap">
                            <label for="date">날짜<span class="modal-container-star">*</span></label>
                            <input class="modal-container-info-select-wrap__input" name="modalDate" type="date" min="2000-01-01" max="2100-01-01"  value="현재날짜 기입" required>
                        </div>
                        <div class="modal-container-info-select-wrap">
                            <label for="time">시간<span class="modal-container-star">*</span></label>
                            <%-- 브라우저별 표현하는 방식이 틀리며, 브라우저 설정에 따라도 다르다. 어떻게 처리할것인지 --%>
                            <%-- 현재시간타임도 00:00 형태로 넘어가기 때문에 "0000"형태로 바꿀 방법을 찾아야함  --%>
                            <input class="modal-container-info-select-wrap__input" name="modalTime" type="time" value="현재시간 기입" required>
                        </div>
                    </div>

                    <div class="modal-container-info-content">
                        <label for="content">내용<span class="modal-container-star">*</span></label>
                        
                        <textarea class="modal-container-info-content-text" name="modalContent" required></textarea>
                    </div>

                </div>

                <div class="modal-container-btns">
                    <input id="modalSubmit" type="submit" class="modal-container-btns-button" value="등록">
                    <button id="modalExit" class="modal-container-btns-button" type="button">닫기</button>
                </div>

            </div>
        </form>

    </body>
    <%--  파일 역할분리 해야함  --%>
    <script>
        const dateState = ()=>{
            let years = <%=selectYears%>;
            let month = <%=selectMonth%>;
            return{
                getYears: () => years,
                setYears: (newYears) => years = newYears,
                getMonth: () => month,
                setMonth: (newMonth) => month = newMonth,
            }
        };
        const dateInfo = dateState();

        // header.jsp에 접근하여 글쓰기 버튼 생성
        const createScheduleButton = () => {
            const $menu = document.getElementById("menu");
            const liElement = document.createElement("li");
            liElement.classList.add("header-menu-li");

            const buttonElement = document.createElement("button");
            buttonElement.id = "createText";
            buttonElement.addEventListener("click", onClickModal);
            buttonElement.classList.add("header-menu-li__a");
            buttonElement.innerText = "글쓰기";
            liElement.appendChild(buttonElement);
            $menu.appendChild(liElement);
        };

        // 월 버튼 생성
        const createMonthsButton = () => {
            const $months = document.getElementById("months");
             for(let i = 1 ; i <= 12 ; i++){
                
                const buttonElement = document.createElement("button");
                buttonElement.id = i;
                buttonElement.addEventListener("click",onClickMonths);
                buttonElement.innerText = i + "월";
                buttonElement.classList.add("schedule-months-container-li__button");
                if(dateInfo.getMonth() === i){
                    buttonElement.classList.add("schedule-months-container-li__button--current");
                }
                const liElement = document.createElement("li");
                liElement.appendChild(buttonElement);
                $months.appendChild(liElement);
            }
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
                        if("" + currentYear + currentMonth + currentDay === key){
                            dayElement.classList.add("schedule-days-container-li-div__day--current");
                        }
    
                        // 각일에 대한 일정
                        const contentElement = document.createElement("p");
                        contentElement.classList.add("schedule-days-container-li-div__daycount");
                        // 현재 기준 일 표시하기
                        if(DAYS[key]){
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

        
        // 글쓰기 모달창 열기/닫기
        const onClickModal = () =>{
            const $modal = document.getElementById("modal");
            $modal.classList.toggle("modal--none");
        };

        // 글쓰기 모달창 서브밋
        const onSubmitModal = (e)=>{
            e.preventDefault();            
        };
        

        // 전년도 이동 이벤트
        const onClickBeforeYears = ()=>{
            dateInfo.setYears(<%=selectYears%> - 1);
            window.location.href = "/stageus/pages/schedule.jsp?year=" + dateInfo.getYears() + "&month=" + dateInfo.getMonth();
        };

        // 다음년도 이동 이벤트
        const onClickAfterYears = ()=>{
            dateInfo.setYears(<%=selectYears%> + 1);
            window.location.href = "/stageus/pages/schedule.jsp?year=" + dateInfo.getYears() + "&month=" + dateInfo.getMonth();
        };

        // 년도 보여주는 함수
        const showYears = (years)=>{
            const $years = document.getElementById("years");
            $years.innerText = dateInfo.getYears();
            
        };

        // 월 보여주는 함수
        const showMonth = (years)=>{
            const $month = document.getElementById("dayMonth");
            $month.innerText = dateInfo.getMonth() + "월";
        };

        // 저장된 월 렌더링, 년월에 따른 일 렌더링
        const onClickMonths = (e)=>{
            const targetId = Number(e.target.id);
            dateInfo.setMonth(targetId);
            window.location.href = "/stageus/pages/schedule.jsp?year=" + dateInfo.getYears() + "&month=" + dateInfo.getMonth();
        };

        // 모달 년, 월, 일 선택
        const onClickModalDate = (e)=>{
            //console.log(e.target.value);
        }

        // 모달 시간 선택
        const onClickModalTime = (e)=>{
            //console.log(e.target.value);
        }
        // 모달 내용
        const onChangeModalContent = (e)=>{
            //console.log(e.target.value)
        }

        window.addEventListener("load", () => {

            // 왼쪽버튼 이벤트
            const $left = document.getElementById("left");
            $left.addEventListener("click", onClickBeforeYears);

            // 오른쪽버튼 이벤트
            const $right = document.getElementById("right");
            $right.addEventListener("click", onClickAfterYears);

            // 모달창 닫기
            const $modalExit = document.getElementById("modalExit");
            $modalExit.addEventListener("click",onClickModal);

            // 모달창 서브밋
            const $modalSubmit = document.getElementById("modalSubmit");
            $modalSubmit.addEventListener("submit",onSubmitModal);

            // 모달 submit
            const $modal = document.getElementById("modal");
            $modal.addEventListener("submit",(e)=>{
                if(!e.target.modalContent.value.trim()) {
                    e.preventDefault();
                    alert("내용을 입력해주세요!");
                    return;
                }
            })

            // 글쓰기 버튼 생성 함수
            createScheduleButton();
            // 월 버튼 생성 함수
            createMonthsButton();
            // 년도 보여주는 함수
            showYears();
            // 월 보여주는 함수
            showMonth();
            // 년,월에 맞는 일 함수 호출
            createDays(dateInfo.getYears(), dateInfo.getMonth(),obj);
        })
    </script>
</html>


