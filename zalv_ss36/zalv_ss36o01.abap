*&---------------------------------------------------------------------*
*&  Include           ZREPORT_SS36O01
*&---------------------------------------------------------------------*
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
*&      Module  INIT_CONTROL_PROCESSING  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init_control_processing OUTPUT.

  IF go_cont IS INITIAL. " <- 무조건 필요(한 번만 생성되도록)

    "Container와 ALV 중 누가 부모? Container
    CREATE OBJECT go_cont
      EXPORTING
        " 컨테이너가 담긴 곳의 이름
        container_name              = 'CONTROL_AREA' " <- 100번 화면의 해당 영역
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.

    CREATE OBJECT go_alv
      EXPORTING
*       i_shellstyle      = 0
*       i_lifetime        =
        i_parent          = go_cont
*       i_appl_events     = space
*       i_parentdbg       =
*       i_applogparent    =
*       i_graphicsparent  =
*       i_name            =
*       i_fcat_complete   = SPACE
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    "ALV를 화면에 뿌리기 전에
    PERFORM set_alv. "ALV 관련 설정 제어

    "지금부터 go_alv의 이벤트에 대해서 동작할게
    SET HANDLER lcl_handler=>on_double_click          FOR go_alv.
    SET HANDLER lcl_handler=>on_toolbar               FOR go_alv.
    SET HANDLER lcl_handler=>on_user_command          FOR go_alv.
    SET HANDLER lcl_handler=>on_print_top_of_page     FOR go_alv.
    SET HANDLER lcl_handler=>on_before_user_command   FOR go_alv.
    SET HANDLER lcl_handler=>on_context_menu_request  FOR go_alv.

    " 화면에 ALV 그리기 (set_table_for_first_display)
    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*       i_buffer_active               =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name              = 'ZALV_SS36' "'SBOOK' 인터널 테이블이 어떻게 생겼는지
        is_variant                    = gs_variant
        i_save                        = gv_save
*       i_default                     = 'X'
        is_layout                     = gs_layout
*       is_print                      =
*       it_special_groups             =
        it_toolbar_excluding          = gt_hide
*       it_hyperlink                  =
*       it_alv_graphics               =
*       it_except_qinfo               =
*       ir_salv_adapter               =
      CHANGING
        it_outtab                     = gt_book " 화면에 그릴 내용을 가지고 있는 IT.
*       it_fieldcatalog               = gt_fcat " 예외 컬럼을 등록
        it_sort                       = gt_sort
*       it_filter                     =
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.

  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CLEAR_OK_CODE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.
  CLEAR ok_code.
ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
