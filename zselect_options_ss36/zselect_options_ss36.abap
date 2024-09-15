*&---------------------------------------------------------------------*
*& Report ZSELECT_OPTIONS_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_OPTIONS_SS36.

* 화면에서 항공사 코드를 입력 받음 = equal 검색
* 화면에서 항공편(범위)을 입력 받음 = 범위 + @ 검색

*DATA gs_con TYPE spfli.
*
*PARAMETERS pa_car TYPE scarr-carrid. "항공사 코드
*SELECT-OPTIONS so_con FOR gs_con-connid. "항공편(범위)

* 화면에서 항공사 코드를 범위로 입력 받아 해당 항공사 내역을
* 출력하는 프로그램을 구하시오.

DATA: gt_carrier TYPE TABLE OF scarr,
      gw_carrier LIKE LINE OF gt_carrier.

* 항공사 코드 범위 입력
SELECT-OPTIONS so_car FOR gw_carrier-carrid DEFAULT 'AA' TO 'LH'.

* Open Sql
SELECT *
  FROM scarr
  INTO table gt_carrier
  WHERE carrid IN so_car.

LOOP AT gt_carrier INTO gw_carrier.

  WRITE:/ gw_carrier-carrid, gw_carrier-carrname.

ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
