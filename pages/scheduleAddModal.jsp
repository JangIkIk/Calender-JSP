<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <body>
        <form class="add-modal add-modal--none" id="addScheduleModal" method="post" action="/stageus/actions/createScheduleAction.jsp">
            <div class="add-modal__container">
                <h1 class="add-modal__title">일정 작성하기</h1>
                <div class="add-modal__info">
                    <div class="add-modal__info__date">
                        <div class="add-modal__info__date__select">
                            <label for="date">날짜<span class="star">*</span></label>
                            <input class="add-modal__info__date__select__input" name="modalDate" type="date" min="2000-01-01" max="2100-01-01"  value="현재날짜 기입" required>
                        </div>
                        <div class="add-modal__info__date__select">
                            <label for="time">시간<span class="star">*</span></label>
                            <%-- 브라우저별 표현하는 방식이 틀리며, 브라우저 설정에 따라도 다르다. 어떻게 처리할것인지 --%>
                            <%-- 현재시간타임도 00:00 형태로 넘어가기 때문에 "0000"형태로 바꿀 방법을 찾아야함  --%>
                            <input class="add-modal__info__date__select__input" name="modalTime" type="time" value="현재시간 기입" required>
                        </div>
                    </div>
                    <div class="add-modal__info__content">
                        <label for="content">내용<span class="star">*</span></label>
                        <textarea class="add-modal__info-content__text" name="modalContent" required></textarea>
                    </div>
                </div>
                <div class="add-modal__btns">
                    <input class="add-modal__btns__button" id="modalSubmit" type="submit" value="등록">
                    <button class="add-modal__btns__button" id="modalExit" type="button">닫기</button>
                </div>
            </div>
        </form>
    </body>
    <script>

            // 글쓰기 모달창
            const onClickModal = () =>{
                const $addScheduleModal = document.getElementById("addScheduleModal");
                $addScheduleModal.classList.toggle("add-modal--none");
            };
            // 모달창 닫기
            const $modalExit = document.getElementById("modalExit");
            $modalExit.addEventListener("click",onClickModal);

            // 모달 submit
            const $addScheduleModal = document.getElementById("addScheduleModal");
            $addScheduleModal.addEventListener("submit",(e)=>{
                if(!e.target.modalContent.value.trim()) {
                    e.preventDefault();
                    alert("내용을 입력해주세요!");
                    return;
                }
            })

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
            createScheduleButton();
    </script>
</html>


