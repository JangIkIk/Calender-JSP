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

                        <%-- 내일정 리스트 --%>
                        <li id="1" class="info-modal__item">
                            <div id="time" class="info-modal__time"><span>21:00</span></div>
                            <div id="name" class="info-modal__name"><span>나</span></div>
                            <div id="content" class="info-modal__content"><span>일이삼사오육칠말구십일이삼사오육칠말구십</span></div>
                            <div id="btns" class="info-modal__select-btns">
                                <button class="base-button base-button--blue">수정</button>
                                <button class="base-button base-button--red">식제</button>
                            </div>
                        </li>

                        <%-- 팀장일정 리스트 --%>
                         <li class="info-modal__item">
                            <div class="info-modal__time"><span>21:00</span></div>
                            <div class="info-modal__name"><span>내이름은10글자이내다</span></div>
                            <div class="info-modal__content"><span>일이삼사오육칠말구십일이삼사오육칠말구십</span></div>
                            <div class="info-modal__select-btns"></div>
                        </li>
                        
                        <%-- 수정리스트 --%>
                        <li class="info-modal__item">
                            <div class="info-modal__edit-select"><input class="info-modal__edit-select__input" type="date"></div>
                            <div class="info-modal__edit-select"><input class="info-modal__edit-select__input" type="time"></div>
                            <%-- 정규표현식으로 글자수 제한 --%>
                            <div class="info-modal__edit-content"><input class="info-modal__edit-content__input" type="text" maxlength="20"></div>
                            <div class="info-modal__select-btns">
                                <button class="base-button base-button--blue">저장</button>
                                <button class="base-button base-button--red">취소</button>
                            </div>
                        </li>
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
            history.back();
        });

        // 내일정 리스트 생성 함수(수정, 삭제 버튼 포함)
        const createMyList = (list) => {
            for(const item of list){

                const editButton = document.createElement("button");
                editButton.classList.add("base-button", "base-button--blue");
                editButton.innerText = "수정";
                // 수정버튼 클릭함수 이벤트
                editButton.addEventListener("click", ()=>{
                    onClickEdit(item.idx);
                });

                const deleteButton = document.createElement("button");
                deleteButton.classList.add("base-button", "base-button--red");
                deleteButton.innerText = "삭제";

                const buttonContainer = document.createElement("div");
                buttonContainer.classList.add("info-modal__select-btns");
                buttonContainer.appendChild(editButton);
                buttonContainer.appendChild(deleteButton);

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

        const createEditList = (item)=>{

                const date = document.createElement("input");
                date.setAttribute("type","date");
                date.classList.add("info-modal__edit-select__input");


                const dateContainer = document.createElement("div");
                dateContainer.classList.add("info-modal__edit-select");
                dateContainer.appendChild(date);

                const time = document.createElement("input");
                time.setAttribute("type","time");
                time.classList.add("info-modal__edit-select__input");

                const timeContainer = document.createElement("div");
                timeContainer.classList.add("info-modal__edit-select");
                timeContainer.appendChild(time);

                const content = document.createElement("input");
                content.setAttribute("type","text");
                content.classList.add("info-modal__edit-content__input");


                const contentContainer = document.createElement("div");
                contentContainer.classList.add("info-modal__edit-content");
                contentContainer.appendChild(content);

                const listContainer = document.createElement("li");
                listContainer.classList.add("info-modal__item");

                const saveButton = document.createElement("button");
                saveButton.classList.add("base-button", "base-button--blue");
                saveButton.innerText = "저장";

                const cancelButton = document.createElement("button");
                cancelButton.classList.add("base-button", "base-button--red");
                cancelButton.innerText = "취소";

                const buttonContainer = document.createElement("div");
                buttonContainer.classList.add("info-modal__select-btns");
                buttonContainer.appendChild(saveButton);
                buttonContainer.appendChild(cancelButton);

                item.appendChild(dateContainer);   
                item.appendChild(timeContainer);   
                item.appendChild(contentContainer);   
                item.appendChild(buttonContainer);   
                
        }




        const createAllList = () => {

        }

        const showList = ()=>{
            // 리스트 보여줄때 정렬해서? => 서버측에서 해서주는게
        }

        /*
            현재상황
            수정버튼을 클릭했을시에, li태그의 아이디를 받는다.
            이후에는 li태그의 각 자식들에 접근하여 태그를 바꿔준다.

            문제는 팀장직급의 유저는 모든 일정에 대한 리스트를 볼수가 있다.
            그렇다면 어떤것으로 구분을 해줄것인가 ?
        */

        const onClickEdit = (e)=>{
            const $item = document.getElementById(e);
            $item.textContent = "";
            console.log($item);
            createEditList($item);
            //console.log($item.childNodes);
            //console.log($item.children);
            // 태그를 통째로 날리고 수정 리스트 태그를 한번에 넣어주는게 좋을것같다.
        }



        // 각 태그를 넣어주는 함수를 구현해야 할것 같다.
        

        const onClickDelete = ()=>{
            console.log("삭제");
        }

        const onSubmit = ()=>{
            //정제 해서 보내야 하나
            console.log("데이터 보내기");
        }

        const onClickCancel = ()=>{
            console.log("취소")
        }

        const onInputContent = ()=>{
            console.log("텍스트입력");
        }

        const onChangeDate = () =>{
            console.log("년,월,일 입력");
        }

        const onChangeTime = ()=>{
            console.log("시간 입력");
        }


        window.addEventListener("load",()=>{

        // 임시데이터
            const myList = [
                {
                    idx: 1,
                    time: "21:00",
                    name: "10자까지",
                    content: "20자까지",

                },
                {
                    idx: 2,
                    time: "22:00",
                    name: "10자까지",
                    content: "20자까지", 
                }
            ];
            createMyList(myList);

        })

    </script>
</html>