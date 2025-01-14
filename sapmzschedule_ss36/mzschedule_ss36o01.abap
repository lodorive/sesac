*&---------------------------------------------------------------------*
*&  Include           MZSCHEDULE_SS36O01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  TRANSFER_DATA_TO  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE transfer_data_to OUTPUT.

  MOVE-CORRESPONDING gw_flight
       TO zssflight_ss36.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CLEAR_OK_CODE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.
  CLEAR ok_code.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_screen OUTPUT.

  IF gw_flight-fldate < sy-datum. "오늘 날짜보다 과거이면

    LOOP AT SCREEN.
      "무조건 입력 불가
      IF screen-name = 'ZSSFLIGHT_SS36-PLANETYPE'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.

  ENDIF.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
