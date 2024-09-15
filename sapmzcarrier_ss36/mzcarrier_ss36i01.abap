*&---------------------------------------------------------------------*
*&  Include           MZCARRIER_SS36I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  GET_CARRIER  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_carrier INPUT.

* 화면에서 입력한 항공사 코드(SCARR-CARRID)를 가지고
* SCARR 테이블을 검색 후, 화면과 연결된 변수(SCARR)에 값을 채운다

  SELECT SINGLE * "carrname currcode url
    FROM scarr
*    INTO CORRESPONDING FIELDS OF scarr
    WHERE carrid = SCARR-CARRID.

    CALL FUNCTION 'TCURT_SINGLE_READ'
      EXPORTING
        i_spras                  = sy-langu
        i_waers                  = scarr-currcode
     IMPORTING
       O_TCURT                  = tcurt.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
