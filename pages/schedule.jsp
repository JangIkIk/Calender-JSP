<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.ArrayList" %>
<%  
    int selectYears;
    int selectMonth;
    ArrayList<String> dayList = new ArrayList<String>();
    try{
        String sessionId = (String) session.getAttribute("session_id");
        if(sessionId == null){
            out.println("<script>alert('회원만 가능'); window.location.href='/stageus/pages/login.jsp';</script>");
            return;
        };
        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        String getYears = request.getParameter("year");
        String getMonth = request.getParameter("month");

        Calendar cal = Calendar.getInstance();
        int currentYears = cal.get(cal.YEAR);
        int currntMonth = cal.get(cal.MONTH) + 1;
        selectYears = currentYears;
        selectMonth = currntMonth;

        if(getYears != null) selectYears = Integer.parseInt(getYears);    
        if(getMonth != null) selectMonth = Integer.parseInt(getMonth);

        String isLevelSQL = "SELECT rank FROM account WHERE idx=?";
        PreparedStatement isLevelQuery = connect.prepareStatement(isLevelSQL);
        isLevelQuery.setString(1,sessionId);
        ResultSet isLevelResult = isLevelQuery.executeQuery();
        isLevelResult.next();

        String schedulerSQL;
        if(isLevelResult.getInt(1) == 2){
            schedulerSQL = "SELECT DAY(date), count(*) FROM scheduler WHERE account_idx = ? AND YEAR(date) = ? AND MONTH(date) = ? GROUP BY date";
        }else{
            schedulerSQL = "SELECT DAY(scheduler.date) as DAY, COUNT(*) as COUNT FROM scheduler INNER JOIN account  ON scheduler.account_idx = account.idx WHERE account.tim IN (SELECT tim FROM account WHERE idx=?) AND YEAR(scheduler.date)=? AND MONTH(scheduler.date)=? GROUP BY scheduler.date";
        }

        PreparedStatement schedulerQuery = connect.prepareStatement(schedulerSQL);
        schedulerQuery.setString(1,sessionId);
        schedulerQuery.setInt(2,selectYears);
        schedulerQuery.setInt(3,selectMonth);
        ResultSet result = schedulerQuery.executeQuery();
        while(result.next()){
            int day = result.getInt(1);
            int count = result.getInt(2);
            dayList.add(String.format("{\"day\":%s,\"count\":%s}", day,count));
        }
    }
    catch(Exception e){
        return;
    }
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
            <%@ include file="/pages/header.jsp"%>

            <div id="years" class="schedule__years">
                <button class="schedule__years__button" id="left">◀️</button>
                <h2 class="schedule__years__h2" id="currentYears"></h2>
                <button class="schedule__years__button" id="right">▶️</button>
            </div>

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

            <div class="schedule__days" id="day">
                <h3 class="schedule__days__title" id="dayMonth"></h3>
                <ul class="schedule__days__container" id="days"></ul>
            </div>

        </div>
        <%@ include file="/pages/scheduleAddModal.jsp"%>
    </body>
    <script>
        let selectYears = <%=selectYears%>;
        let selectMonth = <%=selectMonth%>;

         const showYears = ()=>{
            const $currentYears = document.getElementById("currentYears");
            $currentYears.innerText = selectYears;
            createDays(selectYears, selectMonth);
        };

         const showMonths = ()=>{
            const $months = document.querySelectorAll("#months button");
            for(let month of $months){
                month.addEventListener("click",onClickMonths);
                if(selectMonth === +month.id){
                    month.classList.add("schedule-months-container-li__button--current");
                }
            }
        };

        const onClickYears = (e)=>{
            const targetId = e.target.id;
            if(targetId === "currentYears") return;

            if(targetId === "left"){
                selectYears -= 1;
                window.location.href = "/stageus/pages/schedule.jsp?year=" + selectYears + "&month=" + selectMonth;
            };

            if(targetId === "right"){
                selectYears += 1;
                window.location.href = "/stageus/pages/schedule.jsp?year=" + selectYears + "&month=" + selectMonth;
            };

            showYears();
        }

        const onClickMonths = (e)=>{
            const targetId = +e.target.id;
            selectMonth = targetId;
            window.location.href = "/stageus/pages/schedule.jsp?year=" + selectYears + "&month=" + selectMonth;
            showMonths();
        };

        const createDays = (year,month)=>{

            const $days = document.getElementById("days");
            const YEAR = year;
            const MONTH = month;

            const currentYear = new Date().getFullYear();
            const currentMonth = new Date().getMonth() + 1;
            const currentDay = new Date().getDate();

            const lastDay = new Date(year, month, 0).getDate();
            const week = Math.ceil(lastDay / 7);

            let weekFirstDay = 1;
            let weekLastDay = 7;
            
            for(let i = 0 ; i < week ; i++){
                const liElement = document.createElement("li");
                liElement.classList.add("schedule-days-container-li");

                    for(let j = weekFirstDay ; j <= weekLastDay; j++){

                        const ContainerElement = document.createElement("div");
                        ContainerElement.classList.add("schedule-days-container-li-div");

                        const dayElement = document.createElement("p");
                        dayElement.classList.add("schedule-days-container-li-div__day");
                        dayElement.innerText = j;
                    
                        if("" + currentYear + currentMonth + currentDay === "" + YEAR + MONTH + j){
                            dayElement.classList.add("schedule-days-container-li-div__day--current");
                        }

                        const contentElement = document.createElement("p");
                        contentElement.classList.add("schedule-days-container-li-div__daycount");
                        contentElement.id = j + "D";
                        
                        ContainerElement.appendChild(dayElement);
                        ContainerElement.appendChild(contentElement);
                        liElement.appendChild(ContainerElement);
                    };

                weekFirstDay = weekFirstDay + 7;
                weekLastDay = Math.min(weekLastDay + 7, lastDay);
                $days.appendChild(liElement);
            };
            handelrDayInfoOpen(); 
        };

        const handelrDayInfoOpen= (YEAR,MONTH) => {
            const dayList = <%=dayList%>;
            console.log(dayList);
             for(let item of dayList){
                const dayId = document.getElementById(item.day + "D");
                dayId.addEventListener("click", (e)=>{
                    open("/stageus/pages/scheduleInfoModal.jsp?year=" + selectYears + "&month=" + selectMonth + "&day=" + item.day, "_self","");
                })
                dayId.style.cursor = "pointer";
                dayId.innerText = "일정:" + item.count;
            }
        }
        window.addEventListener("load", () => {
            const $years = document.getElementById("years");
            $years.addEventListener("click",onClickYears);

            const $months = document.getElementById("months");
            $months.addEventListener("click",onClickMonths);

            showYears();
            showMonths();
        })
    </script>
</html>


