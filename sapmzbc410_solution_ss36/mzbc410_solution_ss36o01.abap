*&---------------------------------------------------------------------*
*&  Include           MZBC410_SOLUTION_SS36O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  MOVE_TO_DYNP  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE move_to_dynp OUTPUT.
  MOVE-CORRESPONDING wa_sflight TO sdyn_conn.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S0100'.
  CASE 'X'.
    WHEN gs_mode-view.
      SET TITLEBAR 'T0100' WITH TEXT-dis.
    WHEN gs_mode-maintain_flights.
      SET TITLEBAR 'T0100' WITH TEXT-fli.
    WHEN gs_mode-maintain_bookings.
      SET TITLEBAR 'T0100' WITH TEXT-boo.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CLEAR_OK_CODE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.
  CLEAR: ok_code.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0150  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0150 OUTPUT.
  SET PF-STATUS 'S0150'.
  SET TITLEBAR 'T0150'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_screen OUTPUT.

  IF gs_mode-maintain_flights = 'X'.

    SET PF-STATUS 'S0100'.
    LOOP AT SCREEN.
      IF screen-name = 'SDYN_CONN-PLANETYPE'.
        screen-input = 1. "1:입력 가능 / 0:입력 불가
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.

  ELSE.

    SET PF-STATUS 'S0100' EXCLUDING 'SAVE'.

  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  FILL_DYNNR  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE fill_dynnr OUTPUT.

  CASE my_tabstrip-activetab.
    WHEN 'FC1'.
      gv_dynnr = '0110'.
    WHEN 'FC2'.
      gv_dynnr = '0120'.
    WHEN 'FC3'.
      gv_dynnr = '0130'.
    WHEN OTHERS.
      my_tabstrip-activetab = 'FC1'.
      gv_dynnr = '0110'.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GET_SPFLI  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_spfli OUTPUT.
  "해당 변수의 값이 변경된 경우에만 로직 실행
  ON CHANGE OF wa_sflight-carrid
            OR wa_sflight-connid.

    SELECT SINGLE *
      FROM spfli
      INTO CORRESPONDING FIELDS OF sdyn_conn
      WHERE carrid = wa_sflight-carrid
        AND connid = wa_sflight-connid.

  ENDON.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GET_SAPLANE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_saplane OUTPUT.
  "해당 변수의 값이 변경된 경우에만 로직 실행
  ON CHANGE OF wa_sflight-planetype.

    SELECT SINGLE *
      FROM saplane
      INTO CORRESPONDING FIELDS OF saplane
      WHERE planetype = wa_sflight-planetype.

  ENDON.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GET_SBOOK  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_sbook OUTPUT.

  ON CHANGE OF wa_sflight-carrid
            OR wa_sflight-connid
            OR wa_sflight-fldate.

    SELECT *
      FROM sbook
      INTO CORRESPONDING FIELDS OF TABLE it_sdyn_book
      WHERE carrid = wa_sflight-carrid
      AND connid = wa_sflight-connid
      AND fldate = wa_sflight-fldate
      AND cancelled = not_cancelled.

    my_table_control-lines = lines( it_sdyn_book ).

  ENDON.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  TRANS_TO_TC  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE trans_to_tc OUTPUT.

  MOVE-CORRESPONDING wa_sdyn_book
                  TO sdyn_book.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  MODIFY_TC_LINE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_tc_line OUTPUT.

  CHECK wa_sdyn_book-smoker = 'X'
  AND smoker = 'X'.

  LOOP AT SCREEN.
    screen-intensified = 1.
    MODIFY SCREEN.
  ENDLOOP.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0130  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0130 OUTPUT.
  SET PF-STATUS 'S0130'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
