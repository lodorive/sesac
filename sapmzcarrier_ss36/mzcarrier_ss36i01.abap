*&---------------------------------------------------------------------*
*&  Include           MZCARRIER_SS36I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  GET_CARRIER  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_carrier INPUT.

* ȭ�鿡�� �Է��� �װ��� �ڵ�(SCARR-CARRID)�� ������
* SCARR ���̺��� �˻� ��, ȭ��� ����� ����(SCARR)�� ���� ä���

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
