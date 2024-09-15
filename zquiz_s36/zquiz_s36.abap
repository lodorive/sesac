*&---------------------------------------------------------------------*
*& Report ZQUIZ_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZQUIZ_S36.

* 화면에서 입사일과 현재년도, 사용자 이름을 입력 받아
* 해당 사원의 연차를 계산하는 프로그램을 구현하시오

PARAMETERS: p_year TYPE GRRM_YEAR, "입사년도
            p_crty TYPE GRRM_YEAR, "현재년도
            p_name TYPE c LENGTH 10. "이름

* 예: 입사년도 2020 / 이름 Jane
*DATA: gv_year TYPE c LENGTH 4.
*gv_year = sy-datum+0(4). "현재년도

DATA gv_cnt TYPE c LENGTH 2. "기본 연차
gv_cnt = 15. "기본 연차 15개

DATA gv_al TYPE c LENGTH 2. "근속연수 담을 변수
gv_al = p_crty - p_year - 1. "현재년도 - 입사년도 - 1

IF p_year > p_crty. "입사년도가 현재년도 이후라면
  MESSAGE i001(ZBC100_msg). "에러메시지 출력
ELSE.

DO gv_al TIMES.

  IF sy-index MOD 2 = 1. " 근속연수가 홀수라면
      gv_cnt = gv_cnt + 1. "연차를 추가

    IF gv_cnt > 30. "연차 일수가 30을 넘어간다면
      gv_cnt = 30. "연차 일수에 최대값인 30을 넣음
    ENDIF.

  ENDIF.

ENDDO.

WRITE:/ p_name,
'total vacation allowance on',
p_crty, 'is',
gv_cnt, 'days'.

ENDIF.


*Messages
*----------------------------------------------------------
*
* Message class: ZBC100_MSG
*001   0을 나누거나 0으로 나눌 수 없습니다.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
