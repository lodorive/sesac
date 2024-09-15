*&---------------------------------------------------------------------*
*&  Include           ZFSCHEDULE_SS36E01
*&---------------------------------------------------------------------*

LOAD-OF-PROGRAM.
  "Nothing to do.

INITIALIZATION.
  "Nothing to do.

AT SELECTION-SCREEN OUTPUT.
  "Nothing to do.

AT SELECTION-SCREEN.

"이 Blokc에 대해서 메시지 처리 하겠다
AT SELECTION-SCREEN ON BLOCK blk.
  IF pa_int IS INITIAL AND pa_dom IS INITIAL.
    MESSAGE e017(zmessage_ss36).
  ENDIF.

START-OF-SELECTION.
  PERFORM get_data.

  IF it_fld IS NOT INITIAL.
    CALL SCREEN '0100'.
  ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
