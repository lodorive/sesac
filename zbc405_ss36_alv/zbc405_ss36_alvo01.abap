*----------------------------------------------------------------------*
***INCLUDE ZBC405_SS36_ALVO01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S0100'.
  SET TITLEBAR 'T0100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CLEAR_OK_CODE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.
  CLEAR ok_code.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CREATE_AND_TRANSFER  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE create_and_transfer OUTPUT.

  IF go_cont IS INITIAL.

  CREATE OBJECT go_cont
    EXPORTING
*      parent                      =
      container_name              = 'MY_CONTROL_AREA'
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      others                      = 6.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent          = go_cont
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        others            = 5.

    PERFORM set_alv.
    SET HANDLER lcl_event_handler=>on_double_click FOR go_alv.
    SET HANDLER lcl_event_handler=>on_toolbar FOR go_alv.
    SET HANDLER lcl_event_handler=>on_user_command FOR go_alv.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*        i_buffer_active               =
*        i_bypassing_buffer            =
*        i_consistency_check           =
        i_structure_name              = 'SFLIGHT'
        is_variant                    = gs_variant
        i_save                        = gv_save
*        i_default                     = 'X'
        is_layout                     = gs_layout
*        is_print                      =
*        it_special_groups             =
*        it_toolbar_excluding          =
*        it_hyperlink                  =
*        it_alv_graphics               =
*        it_except_qinfo               =
*        ir_salv_adapter               =
      CHANGING
        it_outtab                     = gt_flight
        it_fieldcatalog               = gt_field_cat
*        it_sort                       =
*        it_filter                     =
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
            .
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.


  ENDIF.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
