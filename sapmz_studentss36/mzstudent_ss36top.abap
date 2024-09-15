*&---------------------------------------------------------------------*
*& Include MZSTUDENT_SS36TOP                                 Module Pool      SAPMZ_STUDENTSS36
*&
*&---------------------------------------------------------------------*
PROGRAM sapmz_studentss36.

TABLES: zstd_ss36.

DATA: BEGIN OF gs_mode,
        display,
        change,
      END OF gs_mode.

DATA ok_code TYPE sy-ucomm.
DATA io_command.
DATA gv_total TYPE i.
DATA gv_gendert TYPE val_text.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
