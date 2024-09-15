*&---------------------------------------------------------------------*
*&  Include           MZSTUDENT_SS36O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_screen OUTPUT.

  CASE io_command.
    WHEN 'D'.

      LOOP AT SCREEN.
        IF screen-group1 = 'STU'.
        screen-input = 0.
        ENDIF.
        MODIFY SCREEN.
      ENDLOOP.

    WHEN 'U'.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S0100'.
  SET TITLEBAR 'T0100'.
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
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.

  CASE io_command.
    WHEN 'D'.
        SET PF-STATUS 'S0200' EXCLUDING 'SAVE'.
        SET TITLEBAR 'T0200' WITH TEXT-DIS.
    WHEN 'U'.
        SET PF-STATUS 'S0200'.
        SET TITLEBAR 'T0200' WITH TEXT-UPD.
  ENDCASE.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
