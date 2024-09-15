*&---------------------------------------------------------------------*
*& Report ZFUNCTION_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFUNCTION_S36.

* 잔여 연차를 계산하기 위한 함수 이름
* BC100_CALC_HOLS
* 입력 파라미터 : 2개 (총 휴가 일수, 사용 일수)
* 출력 파라미터 : 1개 (잔여 휴가 일수)

PARAMETERS: p_total TYPE i, "총 휴가 일수
            p_used TYPE i. "사용 일수

DATA gv_remaining TYPE i. "잔여 휴가 일수

* 함수 호출(복잡한 잔여 휴가 일수를 계산하는 함수)
 CALL FUNCTION 'BC100_CALC_HOLS'
   EXPORTING
     iv_total           = p_total "<----
     iv_used            = p_used "<----
  IMPORTING
    EV_REMAINING       = gv_remaining. "---->

WRITE:/ 'Remaining days vacation:', gv_remaining.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
