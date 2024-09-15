*&---------------------------------------------------------------------*
*&  Include           ZFSCHEDULE_SS36E01
*&---------------------------------------------------------------------*

LOAD-OF-PROGRAM.

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.
  IF pa_int IS INITIAL AND pa_dom IS INITIAL.
    MESSAGE e017(zmessage_ss36).
  ENDIF.

START-OF-SELECTION.

  PERFORM get_data.

  IF gt_fld IS NOT INITIAL.
    CALL SCREEN '0100'.
  ELSE.
    MESSAGE e001(zmessage_ss36).
  ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
