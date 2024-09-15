*&---------------------------------------------------------------------*
*& Report ZBC100_S36_CALC_HOLS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC100_S36_CALC_HOLS.

PARAMETERS: pa_name TYPE string, " 사용자 이름
            pa_total TYPE i, " 일년 총 휴가 일수
            pa_used TYPE i, " 사용한 휴가 일수
            pa_roll TYPE i. " 이월할 휴가 일수

* 올해 남은 휴가 일수 계산
DATA gv_remaining TYPE i.

BREAK-POINT. " 디버깅 방법 중 하나

gv_remaining = pa_total - pa_used. " 총 휴가 일수 - 사용한 휴가 일수

WRITE: gv_remaining, 'vacation days remaining for'(REM), pa_name.

* 내년 휴가 일수 계산
DATA gv_next_year TYPE i.
gv_next_year = pa_total * pa_roll. " 총 휴가 일수 + 이월 휴가 일수

NEW-LINE.

WRITE: gv_next_year, 'days vacation will be available next year'(NXT).

*Text elements
*----------------------------------------------------------
* NXT 이월 휴가 일수
* REM 남은 휴가 일수


*Selection texts
*----------------------------------------------------------
* PA_NAME         이름
* PA_ROLL         이월된 휴가 일수
* PA_TOTAL         전체 휴가 일수
* PA_USED         사용한 휴가 일수

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
