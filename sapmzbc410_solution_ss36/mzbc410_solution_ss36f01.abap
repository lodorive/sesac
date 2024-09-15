*&---------------------------------------------------------------------*
*&  Include           MZBC410_SOLUTION_SS36F01
*&---------------------------------------------------------------------*

FORM on_ctmenu_sub0130 USING p_menu
                       TYPE REF TO cl_ctmenu.

  CALL METHOD cl_ctmenu=>load_gui_status
    EXPORTING
      program = sy-cprog
      status  = 'S0130'
      menu    = p_menu.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
