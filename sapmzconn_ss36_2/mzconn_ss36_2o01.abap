*&---------------------------------------------------------------------*
*&  Include           MZCONN_SS36_2O01
*&---------------------------------------------------------------------*
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
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_screen OUTPUT.

  CASE io_command.
    WHEN 'D'.
       LOOP AT SCREEN.

         IF screen-group1 = 'XYZ'.
          screen-input = 0.
         ENDIF.

         MODIFY SCREEN.

       ENDLOOP.

    WHEN 'U'.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  clear_ok_code  OUTPUT
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
  DATA fcode TYPE TABLE OF sy-ucomm.
  CASE io_command.
    WHEN 'D'.
      APPEND 'SAVE' TO fcode.
      SET PF-STATUS 'S0200' EXCLUDING fcode.
    WHEN 'U'.
      APPEND 'CHANGE' TO fcode.
      SET PF-STATUS 'S0200'.
    WHEN OTHERS.
  ENDCASE.
*  SET TITLEBAR 'xxx'.
ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
