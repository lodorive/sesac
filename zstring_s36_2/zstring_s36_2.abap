*&---------------------------------------------------------------------*
*& Report ZSTRING_S36_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSTRING_S36_2.

* 화면에서 FULLNAME을 입력 받음(단, 성과 이름을 스페이스로 구별해서 입력함)
PARAMETERS pa_fname TYPE string. " Full name을 입력 받음
DATA: gv_fname TYPE c LENGTH 32, " First name 변수
      gv_lname TYPE c LENGTH 4. " Last name 변수

* 추가 문제(SPLIT할 문자를 입력 받아서 해당 문자로 SPLIT 해라)
PARAMETERS pa_sep TYPE c LENGTH 1. " SPLIT 문자(기호)를 입력 받음

* 스페이스로 구분해서 자르겠다.
* space는 abap 내부 상수 중 하나로 가져다 사용할 수 있음
SPLIT pa_fname AT pa_sep INTO gv_fname
                              gv_lname.

WRITE:/ 'First name : ', gv_fname. " 이름 출력
WRITE:/ 'Last name : ', gv_lname. " 성 출력

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
