*&---------------------------------------------------------------------*
*& Report ZBC100_S36_LOOP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC100_S36_LOOP.

PARAMETERS: pa_name TYPE string, " 이름
            pa_start TYPE i, " 전체 휴가 일수(1년 기준)
            pa_years TYPE i. " 근속 기간(최대 5년)

DATA: gv_new_tot TYPE i.

gv_new_tot = pa_start.

DO pa_years TIMES. " 근속 기간만큼 루프를 돌린다

  gv_new_tot = gv_new_tot + sy-index.

  if sy-index = 5. " index가 5가 되면 루프를 빠져나간다
    EXIT.
  ENDIF.

ENDDO.

WRITE:
'Total vacation allowance on joining the company is', pa_start,
'days for', pa_name,
'vacation allowance in', pa_years,
'will be', gv_new_tot.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
