*&---------------------------------------------------------------------*
*&  Include           MZSCHEDULE_SS36F01
*&---------------------------------------------------------------------*

FORM ON_CTMENU_SORT USING p_menu TYPE REF TO cl_ctmenu.

  CALL METHOD cl_ctmenu=>load_gui_status
    EXPORTING
      program    = sy-cprog "현재 프로그램에 있는
      status     = 'S110' "Context Menu
      menu       = p_menu
    EXCEPTIONS
      read_error = 1
      OTHERS = 2.


ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
