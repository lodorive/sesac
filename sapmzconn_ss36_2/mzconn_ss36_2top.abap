*&---------------------------------------------------------------------*
*& Include MZCONN_SS36_2TOP                                  Module Pool      SAPMZCONN_SS36_2
*&
*&---------------------------------------------------------------------*
PROGRAM sapmzconn_ss36_2.

TABLES: spfli, sdyn_conn.

DATA io_command.
DATA ok_code TYPE sy-ucomm.

DATA: BEGIN OF gs_mode,
  display,
  change VALUE 'X',
  END OF gs_mode.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
