*&---------------------------------------------------------------------*
*& Include MZBC410_SOLUTION_SS36TOP                          Module Pool      SAPMZBC410_SOLUTION_SS36
*&
*&---------------------------------------------------------------------*
PROGRAM sapmzbc410_solution_ss36.

TABLES: sdyn_conn, saplane, sdyn_book.
DATA wa_sflight TYPE sflight.
DATA io_command.
DATA ok_code TYPE sy-ucomm.

DATA: BEGIN OF gs_mode,

        view              VALUE 'X',
        maintain_flights,
        maintain_bookings,

      END OF gs_mode.

DATA gv_dynnr TYPE sy-dynnr.
CONTROLS my_tabstrip TYPE TABSTRIP.
CONTROLS my_table_control TYPE TABLEVIEW USING SCREEN '130'.

DATA it_sdyn_book TYPE TABLE OF sdyn_book.
DATA wa_sdyn_book LIKE LINE OF it_sdyn_book.

DATA not_cancelled VALUE space.
DATA smoker TYPE c LENGTH 1.

DATA wa_cols LIKE LINE OF my_table_control-cols.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
