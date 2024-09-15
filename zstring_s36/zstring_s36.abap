*&---------------------------------------------------------------------*
*& Report ZSTRING_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSTRING_S36.

* 화면에서 이름(C:32)과 성(C:4)을 입력 받음
PARAMETERS pa_first TYPE c LENGTH 32.
PARAMETERS pa_last TYPE c LENGTH 4.

CONSTANTS gc_comma TYPE c LENGTH 1 VALUE ','.

DATA gv_fullname TYPE c LENGTH 38. " 32 + 2 + 4 (쉼표까지 계산)

*CONCATENATE pa_first
*            pa_last
*            INTO gv_fullname " 두 개의 변수를 합쳐서 gv_fullname에 넣음

gv_fullname = pa_first && pa_last.

* SEPARATED BY ','. " ','를 중간에 넣어 합치고 싶음
*  SEPARATED BY gc_comma.

WRITE: gv_fullname.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
