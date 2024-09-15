*&---------------------------------------------------------------------*
*&  Include           ZFSCHEDULE_SS36O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  INIT_CONTROL_PROCESSING  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init_control_processing OUTPUT.

  IF go_cont IS INITIAL.

    CREATE OBJECT go_cont
      EXPORTING
*        parent                      =
        container_name              = 'CONTROL_AREA'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
        .

    CREATE OBJECT go_alv
      EXPORTING
*        i_shellstyle      = 0
*        i_lifetime        =
        i_parent          = go_cont
*        i_appl_events     = space
*        i_parentdbg       =
*        i_applogparent    =
*        i_graphicsparent  =
*        i_name            =
*        i_fcat_complete   = SPACE
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        others            = 5
        .

    PERFORM set_alv.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*        i_buffer_active               =
*        i_bypassing_buffer            =
*        i_consistency_check           =
        i_structure_name              = 'SDYN_FLD'
*        is_variant                    =
*        i_save                        =
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
        it_outtab                     = it_fld
*        it_fieldcatalog               =
        it_sort                       = gt_sort
*        it_filter                     =
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
            .

  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S0100'.
  SET TITLEBAR 'T0100' WITH gv_name.
ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
