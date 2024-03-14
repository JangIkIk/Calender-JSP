<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
    // 세션확인
    String sessionId = (String) session.getAttribute("session_id");
    if(sessionId == null){
        out.println("<script>alert('회원만 가능'); window.location.href='/stageus/pages/login.jsp';</script>");
    }
   
    request.setCharacterEncoding("UTF-8");
    String getYears = request.getParameter("year");
    String getMonth = request.getParameter("month");
    String getDay = request.getParameter("day");

    // 클라이언트측에서는 데이터 정제를 해서 그대로 받아야한다.
    // 즉 정렬도 포함이라는 말
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
        const $close = document.getElementById("close");
        $close.addEventListener("click",()=>{
            // 보고있던 년,월,일 로 돌아가야함
            window.location.href = "/stageus/pages/schedule.jsp"
        });

        /*
            현재코드의 문제점
            수정 눌렀을시 -> 수정리스트
            취소 눌렀을시 -> 원본리스트

            이과정에서 이벤트를 다시 넣어줘야하는 경우가 발생,
            각 요소에 접근해서 클래스변경,태그변경만 해야할까 ?
        */

        // 임시데이터
            const myList = [
                {
                    idx: 1,
                    id: "test1",
                    date: "2024-03-14",
                    time: "21:00",
                    name: "10자까지",
                    content: "20자까지",
                },
                {
                    idx: 2,
                    date: "2024-03-14",
                    time: "22:00",
                    name: "10자까지",
                    content: "20자까지", 
                }
            ];

            // 리스트를 정렬해서 보여주기 위한 함수?
        // 리스트 보여줄때 정렬해서? => 서버측에서 해서주는게
        const showList = ()=>{
            console.log("정렬");
        }
        const onClickDelete = (idx)=>{
            const CONFIRM = confirm("삭제하시 겠습니까?");
            if(CONFIRM) return location.href = "/stageus/actions/deleteListAction.jsp?" + "idx=" + idx;
        }
        const onSubmit = (idx)=>{
            const dateValue = document.getElementById("date").value;
            const timeValue = document.getElementById("time").value;
            const contentValue = document.getElementById("content").value;
            const CONFIRM = confirm("내용을 변경 하시겠습니까?");
            if(CONFIRM) return location.href = "/stageus/actions/saveListAction.jsp?" + "date=" + dateValue + "&time=" + timeValue + "&content=" + contentValue;
        }

        // 모든 리스트 생성
        const createMyList = (list) => {
            for(const item of list){

                const time = document.createElement("span");
                time.innerText = item.time;

                const timeContainer = document.createElement("div");
                timeContainer.classList.add("info-modal__time");
                timeContainer.appendChild(time);

                const name = document.createElement("span");
                if(item.id){
                    name.innerText = "내가 쓴글";
                }else{
                    name.innerText = item.name;
                }

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
                // 수정버튼 클릭함수 이벤트
                editButton.addEventListener("click", ()=>{
                    createEditList(item);
                });

                const deleteButton = document.createElement("button");
                deleteButton.classList.add("base-button", "base-button--red");
                deleteButton.innerText = "삭제";
                deleteButton.addEventListener("click",()=>{
                    onClickDelete(item.idx);
                })

                // 자신의 리스트만 수정할수 있도록 해야한다.
                const buttonContainer = document.createElement("div");
                buttonContainer.classList.add("info-modal__select-btns");
                if(!item.id){
                    buttonContainer.appendChild(editButton);
                    buttonContainer.appendChild(deleteButton);
                }
                const listContainer = document.createElement("li");
                listContainer.classList.add("info-modal__item");
                listContainer.id = item.idx;

                listContainer.appendChild(timeContainer);
                listContainer.appendChild(nameContainer);
                listContainer.appendChild(contentContainer);
                listContainer.appendChild(buttonContainer);

                const $list = document.getElementById("list");
                $list.appendChild(listContainer);
            }
        };

        // 수정 리스트 생성
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
                // 이벤트 변경
                saveButton.addEventListener("click",()=>{
                    onSubmit(itemData.idx);
                });

                const cancelButton = document.createElement("button");
                cancelButton.classList.add("base-button", "base-button--red");
                cancelButton.innerText = "취소";
                cancelButton.addEventListener("click",()=>{
                    createOriginalList(itemData);
                })

                const buttonContainer = document.createElement("div");
                buttonContainer.classList.add("info-modal__select-btns");
                buttonContainer.appendChild(saveButton);
                buttonContainer.appendChild(cancelButton);

                $item.appendChild(dateContainer);   
                $item.appendChild(timeContainer);   
                $item.appendChild(contentContainer);   
                $item.appendChild(buttonContainer);   
        };

        // 기존 리스트 생성 
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
                // 수정버튼 클릭함수 이벤트
                editButton.addEventListener("click", ()=>{
                    createEditList(itemData);
                });
                const deleteButton = document.createElement("button");
                deleteButton.classList.add("base-button", "base-button--red");
                deleteButton.innerText = "삭제";
                deleteButton.addEventListener("click", ()=>{
                    onClickDelete(itemData);
                })

                const buttonContainer = document.createElement("div");
                buttonContainer.classList.add("info-modal__select-btns");
                buttonContainer.appendChild(editButton);
                buttonContainer.appendChild(deleteButton);

                $item.appendChild(timeContainer);
                $item.appendChild(nameContainer);
                $item.appendChild(contentContainer);
                $item.appendChild(buttonContainer);                
        }

        window.addEventListener("load",()=>{
            createMyList(myList);
        })

    </script>
</html>