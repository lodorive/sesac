*----------------------------------------------------------------------*
***INCLUDE ZBC405_SS36_ALV_I01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK' or 'EXIT' or 'CANC'.
    LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750