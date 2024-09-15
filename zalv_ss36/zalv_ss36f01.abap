*&---------------------------------------------------------------------*
*&  Include           ZREPORT_SS36F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_DATE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .

* ȭ�鿡�� �Է��� ������ ���� ���� ���
  CASE pa_can. "��� ������
    WHEN 'X'. "���õǾ� �ִٸ�
      SELECT *
        FROM sbook
        LEFT OUTER JOIN scustom
        ON sbook~customid = scustom~id
        INTO CORRESPONDING FIELDS OF TABLE gt_book
        WHERE carrid = pa_car
        AND connid = pa_con
        AND fldate IN so_fld.

    WHEN OTHERS. "��� ���� ������
      SELECT *
        FROM sbook
        LEFT OUTER JOIN scustom
        ON sbook~customid = scustom~id
        INTO CORRESPONDING FIELDS OF TABLE gt_book
        WHERE carrid = pa_car
        AND connid = pa_con
        AND fldate IN so_fld
        AND cancelled <> 'X'.
  ENDCASE.

  "���Կ� ���� ��ȣ�� ó��( > 15kg ������)
  LOOP AT gt_book INTO gw_book." WHERE luggweight > c_max_weight.
    IF gw_book-luggweight > c_max_weight.
      gw_book-light = 1. "������ ��ȣ��.
    ENDIF.

    IF gw_book-cancelled = 'X'.
      gw_book-lcolor = 'C600'. "�帰 ������ ����(C�� ����, �÷�, ���� ��������, inverse ���� ����
      gw_book-cancelled_icon = icon_okay.
    ENDIF.

    MODIFY gt_book FROM gw_book
    TRANSPORTING light lcolor cancelled_icon.
  ENDLOOP.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_alv .

  "ȭ�� ���� �� ��ũ�ѹ� ���� ����
  gs_stable-row = 'X'. " ���� ��ũ�ѹ� ����
  gs_stable-col = 'X'. " ���� ��ũ�ѹ� ����

  "Layout Variant ���� ����
  gs_variant-report = sy-cprog. " ���� ���α׷��� �ִ�
  gs_variant-variant = p_vari. " ȭ�鿡�� �Է� ���� View ����

  gv_save = 'A'. "A or U or X
  " U(User Specific) -> ���� ���� Variant�� �ٸ� ����ڰ� �� �� ����
  " X(Cross User) -> �ٸ� ����ڰ� �� �� ����
  " A(All) -> (U or X)

  "ALV ȭ�� ����
  gs_layout-grid_title = TEXT-t01.
  gs_layout-zebra = 'X'. "ȭ���� �帮��.. �� �帮��..
*  gs_layout-no_headers = 'X'. "��� ����
  gs_layout-totals_bef = 'X'. "�հ踦 ù ��° �ٷ� �̵�
  gs_layout-sel_mode = 'A'. "���� �����ϰ� ���� ��(space/A/B/C/D)
  gs_layout-excp_fname = 'LIGHT'. "��ȣ�� �÷� �˷��ֱ�
  gs_layout-excp_led = 'X'. "1�� ��ȣ������ �����ϱ�
  gs_layout-info_fname  = 'LCOLOR'. "���� �÷�.

  "���� ���� ����(fldate DESC / customid ASC)
  CLEAR gw_sort.
  gw_sort-fieldname = 'FLDATE'. "������ �÷��� ����?
  gw_sort-down        = 'X'.
  APPEND gw_sort TO gt_sort.

  CLEAR gw_sort.
  gw_sort-fieldname = 'CUSTOMID'.
  gw_sort-up        = 'X'.
  APPEND gw_sort TO gt_sort.

  "����Ʈ ��ư �����..(MC_FC_PRINT)
*  APPEND cl_gui_alv_grid=>mc_fc_print
*      TO gt_hide.

  "���� �÷� ����ϱ�
*  CLEAR gw_fcat.
*  gw_fcat-fieldname = 'NAME'. "���ͳ� ���̺� �߰��� ���� �÷� �̸�
*  gw_fcat-ref_field = 'NAME'.  "��� �ʵ带 �����ϴ�?
*  gw_fcat-ref_table = 'SCUSTOM'. "��� ���̺��̴�?
*  gw_fcat-col_pos = 7. "������ �÷� ��ġ
*  APPEND gw_fcat TO gt_fcat.
*
*  CLEAR gw_fcat.
*  gw_fcat-fieldname = 'TELEPHONE'. "���ͳ� ���̺� �߰��� ���� �÷� �̸�
*  gw_fcat-ref_field = 'TELEPHONE'.  "��� �ʵ带 �����ϴ�?
*  gw_fcat-ref_table = 'SCUSTOM'. "��� ���̺��̴�?
*  gw_fcat-col_pos = 8. "������ �÷� ��ġ
*  APPEND gw_fcat TO gt_fcat.

*  CLEAR gw_fcat.
*  gw_fcat-fieldname = 'CANCELLED'. "���ͳ� ���̺� �߰��� ���� �÷� �̸�
*  gw_fcat-no_out = 'X'. "�� �ʵ带 ������
*  APPEND gw_fcat TO gt_fcat.
*
*  CLEAR gw_fcat.
*  gw_fcat-fieldname = 'CANCELLED_ICON'. "���ͳ� ���̺� �߰��� ���� �÷� �̸�
*  gw_fcat-icon = 'X'. "���������� ǥ���Ұ�
*  gw_fcat-coltext = 'Canelled'(h05).
*  gw_fcat-col_pos = 9. "������ �÷� ��ġ
**  gw_fcat-outputlen = 5.
*  APPEND gw_fcat TO gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F4_VARIANT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f4_variant .

  DATA ls_variant TYPE disvariant.
  DATA es_variant TYPE disvariant.

  ls_variant-report = sy-cprog.

  CALL FUNCTION 'REUSE_ALV_VARIANT_F4'
    EXPORTING
      is_variant    = ls_variant
*     I_TABNAME_HEADER          =
*     I_TABNAME_ITEM            =
*     IT_DEFAULT_FIELDCAT       =
*     I_SAVE        = ' '
*     I_DISPLAY_VIA_GRID        = ' '
    IMPORTING
*     E_EXIT        =
      es_variant    = es_variant
    EXCEPTIONS
      not_found     = 1
      program_error = 2
      OTHERS        = 3.

  p_vari = es_variant-variant.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
