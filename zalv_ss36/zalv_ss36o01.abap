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

  IF go_cont IS INITIAL. " <- ������ �ʿ�(�� ���� �����ǵ���)

    "Container�� ALV �� ���� �θ�? Container
    CREATE OBJECT go_cont
      EXPORTING
        " �����̳ʰ� ��� ���� �̸�
        container_name              = 'CONTROL_AREA' " <- 100�� ȭ���� �ش� ����
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

    "ALV�� ȭ�鿡 �Ѹ��� ����
    PERFORM set_alv. "ALV ���� ���� ����

    "���ݺ��� go_alv�� �̺�Ʈ�� ���ؼ� �����Ұ�
    SET HANDLER lcl_handler=>on_double_click          FOR go_alv.
    SET HANDLER lcl_handler=>on_toolbar               FOR go_alv.
    SET HANDLER lcl_handler=>on_user_command          FOR go_alv.
    SET HANDLER lcl_handler=>on_print_top_of_page     FOR go_alv.
    SET HANDLER lcl_handler=>on_before_user_command   FOR go_alv.
    SET HANDLER lcl_handler=>on_context_menu_request  FOR go_alv.

    " ȭ�鿡 ALV �׸��� (set_table_for_first_display)
    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*       i_buffer_active               =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name              = 'ZALV_SS36' "'SBOOK' ���ͳ� ���̺��� ��� �������
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
        it_outtab                     = gt_book " ȭ�鿡 �׸� ������ ������ �ִ� IT.
*       it_fieldcatalog               = gt_fcat " ���� �÷��� ���
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
