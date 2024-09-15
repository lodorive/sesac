*&---------------------------------------------------------------------*
*& Report ZOPENSQL_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOPENSQL_S36_2.

* 화면에서 항공사 코드를 입력받아
* 항공사 이름과 화폐단위를 출력하는 프로그램으로 개선하시오

PARAMETERS p_code TYPE scarr-carrid. "화면에서 항공사 코드를 입력받음
DATA gv_scarr TYPE scarr.

SELECT SINGLE carrname currcode
  FROM scarr
*  INTO (gv_scarr-carrname, gv_scarr-currcode)
  INTO CORRESPONDING FIELDS OF gv_scarr
 WHERE carrid = p_code.

WRITE:/ 'Airline Name:', gv_scarr-carrname.
WRITE:/ 'Airline Currency:', gv_scarr-currcode.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
