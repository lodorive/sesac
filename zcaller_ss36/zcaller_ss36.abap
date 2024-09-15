*&---------------------------------------------------------------------*
*& Report ZCALLER_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcaller_ss36.

* 화면에서 항공사 코드를 입력 받아서 다른 프로그램 호출
* ZBC400_CARRIER_S36

PARAMETERS p_car TYPE scarr-carrid.

*동기 호출
SUBMIT zbc400_carrier_s36
  WITH pa_car = p_car. "해당 프로그램의 파라미터 = 내 프로그램 파라미터
*AND RETURN. "호출 후 나로 돌아오지 않겠다

*ABAP Dictionary
*CALL TRANSACTION 'SE11'.


WRITE: 'Done'.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
