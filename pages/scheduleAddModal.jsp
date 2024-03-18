<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <body>
        <form class="add-modal add-modal--none" id="addScheduleModal" method="post" action="/stageus/actions/scheduleAddAction.jsp">
            <div class="add-modal__container">
                <h1 class="add-modal__title">일정 작성하기</h1>
                <div class="add-modal__info">
                    <div class="add-modal__info__date">
                        <div class="add-modal__info__date__select">
                            <label for="modalDate">날짜<span class="star">*</span></label>
                            <input class="add-modal__info__date__select__input" id="modalDate" name="modalDate" type="date" min="2000-01-01" max="2100-01-01">
                        </div>
                        <div class="add-modal__info__date__select">
                            <label for="modalTime">시간<span class="star">*</span></label>
                            <input class="add-modal__info__date__select__input" id="modalTime" name="modalTime" type="time">
                        </div>
                    </div>
                    <div class="add-modal__info__content">
                        <label for="content">내용<span class="star">*</span></label>
                        <textarea class="add-modal__info-content__text" id="modalContent" name="modalContent" maxlength="20"></textarea>
                    </div>
                </div>
                <div class="add-modal__btns">
                    <input class="add-modal__btns__button" type="submit" value="등록">
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

            const onSubmit = (e)=>{
                
                const modalDate = document.getElementById("modalDate");
                const modalTime = document.getElementById("modalTime");
                const modalContent = document.getElementById("modalContent");
                const regex = /^.{1,20}$/;

                try{
                    if(!modalDate.value) throw "날짜가 입력해주세요";
                    if(!modalTime.value) throw "시간을 입력해주세요";
                    if(!modalContent.value.trim()) throw "내용을 입력해주세요";
                    if(!regex.test(modalContent.value)) throw "최대 20자까지 작성";
                }
                catch(error){
                    e.preventDefault();
                    alert(error)
                    return false;
                }

                return true;
            }
            
            // 모달창 닫기
            const $modalExit = document.getElementById("modalExit");
            $modalExit.addEventListener("click",onClickModal);

            // 모달 submit
            const $addScheduleModal = document.getElementById("addScheduleModal");
            $addScheduleModal.addEventListener("submit",onSubmit);

            createScheduleButton();
    </script>
</html>


