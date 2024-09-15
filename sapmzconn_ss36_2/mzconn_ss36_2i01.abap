*&---------------------------------------------------------------------*
*&  Include           MZCONN_SS36_2I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  GET_DATA  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_data INPUT.

  SELECT SINGLE *
    FROM spfli
    INTO CORRESPONDING FIELDS OF sdyn_conn
    WHERE carrid = spfli-carrid
    AND connid = spfli-connid.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE TO SCREEN 0.
    WHEN 'MODE'.
      CASE 'X'.
        WHEN gs_mode-display.
          io_command = 'D'.
        WHEN gs_mode-change.
          io_command = 'U'.
      ENDCASE.
    LEAVE TO SCREEN 200.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 100.
    WHEN 'SAVE'.
      MESSAGE 'To be continue...' TYPE 'I'.
  ENDCASE.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
