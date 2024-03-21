<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList" %>

<%
    String getYears = request.getParameter("year");
    String getMonth = request.getParameter("month");
    String getDay = request.getParameter("day");
    ArrayList<String> dayList = new ArrayList<String>();
    String sessionId = (String) session.getAttribute("session_id");

    try{
        if(sessionId == null){
            out.println("<script>alert('회원만 가능'); window.location.href='/stageus/pages/login.jsp';</script>");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","dbaccount","1234");

        getYears = request.getParameter("year");
        getMonth = request.getParameter("month");
        getDay = request.getParameter("day");

        String isLevelSQL = "SELECT rank FROM account WHERE idx=?";
        PreparedStatement isLevelQuery = connect.prepareStatement(isLevelSQL);
        isLevelQuery.setString(1,sessionId);
        ResultSet isLevelResult = isLevelQuery.executeQuery();
        isLevelResult.next();

        String schedulerSQL;
        if(isLevelResult.getInt(1) == 2){
            schedulerSQL = "SELECT scheduler.idx, scheduler.date, TIME_FORMAT(scheduler.time, '%H:%i') AS time, scheduler.content, scheduler.account_idx, account.name AS account_name FROM scheduler INNER JOIN account ON scheduler.account_idx = account.idx WHERE scheduler.account_idx = ? AND YEAR(scheduler.date) = ? AND MONTH(scheduler.date) = ? AND DAY(scheduler.date) = ? ORDER BY scheduler.time ASC";
        }else{
            schedulerSQL = "SELECT scheduler.idx, scheduler.date, TIME_FORMAT(scheduler.time, '%H:%i') as time, scheduler.content, scheduler.account_idx, account.name FROM scheduler INNER JOIN account ON scheduler.account_idx = account.idx WHERE account.tim = (SELECT tim FROM account WHERE idx = ?) AND YEAR(scheduler.date)=? AND MONTH(scheduler.date)=? AND DAY(scheduler.date)=? ORDER BY scheduler.time ASC";
        }
        PreparedStatement schedulerQuery = connect.prepareStatement(schedulerSQL);
        schedulerQuery.setString(1,sessionId);
        schedulerQuery.setString(2,getYears);
        schedulerQuery.setString(3,getMonth);
        schedulerQuery.setString(4,getDay);
        ResultSet result = schedulerQuery.executeQuery();

        while(result.next()){
            int idx = result.getInt(1);
            String date = result.getString(2);
            String time = result.getString(3);
            String content = result.getString(4);
            int accountIdx = result.getInt(5);
            String name = result.getString(6);
            dayList.add(String.format("{\"idx\":%s,\"date\":\"%s\",\"time\":\"%s\",\"content\":\"%s\",\"accountIdx\":%s,\"name\":\"%s\"}", idx, date, time, content, accountIdx, name));
        }
    }
    catch(Exception e){
        out.println("<script>alert('일정을 볼수 없습니다'); history.back();</script>");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <link href="/stageus/css/init.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/scheduleInfoModal.css" rel="stylesheet" type="text/css">
        <link href="/stageus/css/common.css" rel="stylesheet" type="text/css">
        <title>일정 상세보기</title>
    </head>
    <body>
        <main>
            <div class="info-modal">
                <div class="info-modal__container">
                    <h1 class="info-modal__title">일정 상세보기</h1>

                    <ul id="list" class="info-modal__lists">

                    </ul>
                    <div class="info-modal__close">
                        <button id="close" class="base-button" type="button">닫기</button>
                    </div>
                </div>
            </div>
        </main>
    </body>
    <script>
        
        const getYears = <%=getYears%>;
        const getMonth = <%=getMonth%>;
        const getDay = <%=getDay%>;
        const dayList = <%=dayList%>;
        const userIdx = <%=sessionId%>;

        const onClickDelete = (idx)=>{
            const CONFIRM = confirm("삭제 하시겠습니까?");
            if(CONFIRM) return location.href = "/stageus/actions/scheduleDeleteAction.jsp?" + "idx=" + idx + "&years=" + getYears + "&month=" + getMonth + "&day=" + getDay;
        }
        const onSubmit = (idx)=>{
            const dateValue = document.getElementById("date").value;
            const timeValue = document.getElementById("time").value;
            const contentValue = document.getElementById("content").value;
            const CONFIRM = confirm("내용을 변경 하시겠습니까?");
            if(CONFIRM) return location.href = "/stageus/actions/scheduleUpdateAction.jsp?" + "date=" + dateValue + "&time=" + timeValue + "&content=" + contentValue + "&idx=" + idx + "&years=" + getYears + "&month=" + getMonth + "&day=" + getDay;
        }

        const createMyList = (list) => {

            for(const item of list){
                const time = document.createElement("span");
                time.innerText = item.time;

                const timeContainer = document.createElement("div");
                timeContainer.classList.add("info-modal__time");
                timeContainer.appendChild(time);

                const name = document.createElement("span");
                name.innerText = item.name;
                
                const nameContainer = document.createElement("div");
                nameContainer.classList.add("info-modal__name");
                nameContainer.appendChild(name);

                const content = document.createElement("span");
                content.innerText = item.content;

                const contentContainer = document.createElement("div");
                contentContainer.classList.add("info-modal__content");
                contentContainer.appendChild(content);

                const editButton = document.createElement("button");
                editButton.classList.add("base-button", "base-button--blue");
                editButton.innerText = "수정";
                editButton.addEventListener("click", ()=>{
                    createEditList(item);
                });

                const deleteButton = document.createElement("button");
                deleteButton.classList.add("base-button", "base-button--red");
                deleteButton.innerText = "삭제";
                deleteButton.addEventListener("click",()=>{
                    onClickDelete(item.idx);
                });

                const buttonContainer = document.createElement("div");
                buttonContainer.classList.add("info-modal__select-btns");
                if(item.accountIdx === userIdx){
                    buttonContainer.appendChild(editButton);
                    buttonContainer.appendChild(deleteButton);
                };

                const listContainer = document.createElement("li");
                listContainer.classList.add("info-modal__item");
                listContainer.id = item.idx;

                listContainer.appendChild(timeContainer);
                listContainer.appendChild(nameContainer);
                listContainer.appendChild(contentContainer);
                listContainer.appendChild(buttonContainer);

                const $list = document.getElementById("list");
                $list.appendChild(listContainer);
            };
        };

        const createEditList = (itemData)=>{
                const $item = document.getElementById(itemData.idx);
                $item.textContent = "";

                const date = document.createElement("input");
                date.setAttribute("type","date");
                date.value = itemData.date;
                date.id = "date";
                date.classList.add("info-modal__edit-select__input");

                const dateContainer = document.createElement("div");
                dateContainer.classList.add("info-modal__edit-select");
                dateContainer.appendChild(date);

                const time = document.createElement("input");
                time.setAttribute("type","time");
                time.value = itemData.time;
                time.id = "time";
                time.classList.add("info-modal__edit-select__input");

                const timeContainer = document.createElement("div");
                timeContainer.classList.add("info-modal__edit-select");
                timeContainer.appendChild(time);

                const content = document.createElement("input");
                content.setAttribute("type","text");
                content.value = itemData.content;
                content.id = "content";
                content.classList.add("info-modal__edit-content__input");


                const contentContainer = document.createElement("div");
                contentContainer.classList.add("info-modal__edit-content");
                contentContainer.appendChild(content);

                const saveButton = document.createElement("button");
                saveButton.classList.add("base-button", "base-button--blue");
                saveButton.innerText = "저장";
                saveButton.addEventListener("click",()=>{
                    onSubmit(itemData.idx);
                });

                const cancelButton = document.createElement("button");
                cancelButton.classList.add("base-button", "base-button--red");
                cancelButton.innerText = "취소";
                cancelButton.addEventListener("click",()=>{
                    createOriginalList(itemData);
                });

                const buttonContainer = document.createElement("div");
                buttonContainer.classList.add("info-modal__select-btns");
                buttonContainer.appendChild(saveButton);
                buttonContainer.appendChild(cancelButton);

                $item.appendChild(dateContainer);   
                $item.appendChild(timeContainer);   
                $item.appendChild(contentContainer);   
                $item.appendChild(buttonContainer);   
        };

        const createOriginalList = (itemData)=>{
                const $item = document.getElementById(itemData.idx);
                $item.textContent = "";

                const time = document.createElement("span");
                time.innerText = itemData.time;

                const timeContainer = document.createElement("div");
                timeContainer.classList.add("info-modal__time");
                timeContainer.appendChild(time);
                
                const name = document.createElement("span");
                name.innerText = itemData.name;

                const nameContainer = document.createElement("div");
                nameContainer.classList.add("info-modal__name");
                nameContainer.appendChild(name);

                const content = document.createElement("span");
                content.innerText = itemData.content;

                const contentContainer = document.createElement("div");
                contentContainer.classList.add("info-modal__content");
                contentContainer.appendChild(content);

                const editButton = document.createElement("button");
                editButton.classList.add("base-button", "base-button--blue");
                editButton.innerText = "수정";
                editButton.addEventListener("click", ()=>{
                    createEditList(itemData);
                });

                const deleteButton = document.createElement("button");
                deleteButton.classList.add("base-button", "base-button--red");
                deleteButton.innerText = "삭제";
                deleteButton.addEventListener("click", ()=>{
                    onClickDelete(itemData);
                });

                const buttonContainer = document.createElement("div");
                buttonContainer.classList.add("info-modal__select-btns");
                buttonContainer.appendChild(editButton);
                buttonContainer.appendChild(deleteButton);

                $item.appendChild(timeContainer);
                $item.appendChild(nameContainer);
                $item.appendChild(contentContainer);
                $item.appendChild(buttonContainer);                
        };

        window.addEventListener("load",()=>{
            const $close = document.getElementById("close");
            $close.addEventListener("click",()=>{ 
                window.location.href = "/stageus/pages/schedule.jsp?year=" + getYears + "&month=" + getMonth;
            });

            createMyList(dayList);
        });
    </script>
</html>