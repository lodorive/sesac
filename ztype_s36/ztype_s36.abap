*&---------------------------------------------------------------------*
*& Report ZTYPE_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTYPE_S36.

* 사용자의 생일을 입력 받음
PARAMETERS p_birth TYPE d.
* 오늘 수업 종료시간을 입력 받음
PARAMETERS P_end TYPE t.
* 사용자의 이름을 입력 받음 (단, 12자리 크기로)
PARAMETERS p_name TYPE c LENGTH 12.
PARAMETERS p_score TYPE p LENGTH 3 DECIMALS 2.

* 3.14라는 값을 갖는 상수를 정의, 상수 이름 c_pi
CONSTANTS c_pi TYPE p LENGTH 2 DECIMALS 2 VALUE '3.14'.

* c_pi 값을 3.15로 변경
*c_pi = '3.15'. "에러

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
