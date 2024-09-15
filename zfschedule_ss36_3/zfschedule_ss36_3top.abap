*&---------------------------------------------------------------------*
*& Include ZFSCHEDULE_SS36_3TOP                              Module Pool      ZFSCHEDULE_SS36_3
*&
*&---------------------------------------------------------------------*
PROGRAM ZFSCHEDULE_SS36_3.

DATA gv_name TYPE scarr-carrname.

*DATA BEGIN OF gs_spfli.
*  INCLUDE STRUCTURE spfli.
*  DATA type(1).
*DATA END OF gs_spfli.

DATA gs_spfli TYPE spfli.
DATA gt_spfli LIKE TABLE OF gs_spfli.

DATA gt_flight TYPE TABLE OF sflight.
DATA gw_flight TYPE sflight.

DATA gt_fld TYPE TABLE OF SDYN_FLD.
DATA gw_fld TYPE SDYN_FLD.

PARAMETERS pa_car TYPE sflight-carrid MEMORY ID CAR OBLIGATORY.

SELECTION-SCREEN SKIP 1.

SELECTION-SCREEN BEGIN OF BLOCK blk.
   PARAMETERS pa_int AS CHECKBOX DEFAULT 'X'.
   PARAMETERS pa_dom AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK blk.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
