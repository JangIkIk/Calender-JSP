### 코드컨벤션
변수 (형용사 + 명사 )

상수(대문자)
RESULT

이벤트 함수(접두사 + 동사 + 명사)
- event + 동사 + 명사

계산하는 함수(접두사 + 동사 + 명사)
- handler + 동사 + 명사

보여주는 함수(접두사 + 동사 + 명사)
- show + 동사 + 명사

### 파일구분
[actions]
1. 기능별액션: 기능 + Action.jsp
[css]
1. 페이지 css: pageName.css
2. 공통 css: common.css
3. 초기화 css: init.css

[pages]
1. 페이지: pageName.jsp


[의문점]
1. 페이지에 해당되는 css파일은 include와 상관없이 적용해주어야 하는지?

[확인해야할 사항]
1. 모달창 css 구현
2. 모달창 이벤트 적용
3. 모달창 form 데이터 적용 -> action.jsp에서
4. 일정클릭시 탭으로 구현-> mac Chrome의 문제로 인해 popup창 불가
5. 넘어갔을 파일 구조 확인
6. 마이페이지 css 변경 및 예상데이터 코드 적용필요
7. 정보수정페이지 css 변경 및 예상데이터 코드 적용필요
8. 정보수정페이지는 클라이언트측 예외처리 필요

