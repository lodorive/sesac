*&---------------------------------------------------------------------*
*& Include ZFSCHEDULE_SS36TOP                                Report ZFSCHEDULE_SS36
*&
*&---------------------------------------------------------------------*
REPORT zfschedule_ss36.

PARAMETERS pa_car TYPE sflight-carrid MEMORY ID car OBLIGATORY.

SELECTION-SCREEN SKIP 1.

* 함께 처리 하기 위해서 block 단위로 묶음
SELECTION-SCREEN BEGIN OF BLOCK blk WITH FRAME.
PARAMETERS pa_int AS CHECKBOX DEFAULT 'X'.
PARAMETERS pa_dom AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK blk.

TABLES sflight.

DATA ok_code TYPE sy-ucomm.

DATA gt_flight TYPE TABLE OF sflight.
DATA gw_flight LIKE LINE OF gt_flight.


DATA:BEGIN OF gs_spfli.
  INCLUDE STRUCTURE spfli.
  DATA type(1).
DATA:END OF gs_spfli.

DATA gt_spfli LIKE TABLE OF gs_spfli.


DATA:BEGIN OF gs_fld.
  INCLUDE STRUCTURE sdyn_fld.
  DATA light(1).
DATA:END OF gs_fld.

DATA gt_fld LIKE TABLE OF gs_fld.

DATA go_cont TYPE REF TO cl_gui_custom_container.
DATA go_alv TYPE REF TO cl_gui_alv_grid.

DATA gt_sort TYPE lvc_t_sort.
DATA gw_sort TYPE lvc_s_sort.

DATA gs_layout TYPE lvc_s_layo.

DATA gv_name TYPE scarr-carrname.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
