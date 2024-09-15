*&---------------------------------------------------------------------*
*& Report ZOPENSQL_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOPENSQL_S36.

* 화면에서 항공사 코드를 입력 받음
*PARAMETERS p_code TYPE c LENGTH 3. "항공사 코드를 담을 변수
PARAMETERS p_code TYPE scarr-carrid. "2안
*DATA gv_name TYPE c LENGTH 20. "항공사 이름을 담을 변수
DATA gv_name TYPE scarr-carrname. "2안

* OPEN SQL 구성
SELECT SINGLE carrname "취득할 컬럼 이름
  FROM scarr "데이터를 보관하고 있는 테이블
  INTO gv_name "취득한 데이터를 담을 변수
 WHERE carrid = p_code. "화면에서 입력한 코드를 검색 조건으로 함

* 출력하기
WRITE: 'Airline Name :', gv_name.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
