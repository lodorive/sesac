*&---------------------------------------------------------------------*
*& Include ZREPORT_SS36TOP                                   Report ZREPORT_SS36
*&
*&---------------------------------------------------------------------*
REPORT zalv_ss36top.

* �˻� ���ǿ��� �װ��� �ڵ�, �װ���, ��¥(����)�� �Է� �޾�
* �ش� ����� ALV�� ��ȸ�ϴ� ���α׷� ����

*DATA gt_book TYPE TABLE OF sbook. " <- ALV�� ����� ���ͳ� ���̺�
*DATA gw_book LIKE LINE OF gt_book.

CONSTANTS c_max_weight TYPE sbook-luggweight VALUE '25'.

DATA: BEGIN OF gw_book.
    INCLUDE STRUCTURE zalv_ss36.
DATA light(1). "��ȣ���� ���� �÷�
DATA lcolor(4). "���� �÷��� ���� �÷�

"���� �÷� ���(�� �̸�, �� ��ȭ��ȣ)
*  DATA name TYPE scustom-name.
*  DATA telephone TYPE scustom-telephone.
*  DATA cancelled_icon TYPE icons-text.
DATA: END OF gw_book.
DATA gt_book LIKE TABLE OF gw_book. "<- ALV�� ����� ���ͳ� ���̺�

DATA ok_code TYPE sy-ucomm.

* ALV�� ���� ���۷��� ���� 2�� ����
* go_xxx -> Global Object
DATA go_cont TYPE REF TO cl_gui_custom_container.
DATA go_alv TYPE REF TO cl_gui_alv_grid.

* ALV ��� ���� ����
DATA gs_stable TYPE lvc_s_stbl.
DATA gs_variant TYPE disvariant.
DATA gv_save TYPE char01.

DATA gs_layout TYPE lvc_s_layo.

DATA gt_sort TYPE lvc_t_sort. " ���� ���� ����(���� ���� ���� ������ ��ƾ� �ϹǷ� table Ÿ��)
DATA gw_sort TYPE lvc_s_sort.

DATA gt_hide TYPE ui_functions. "���� ��ư�� ����.

* ���� �÷��� ������ �ʵ�ī�޷α� ����
DATA gt_fcat TYPE lvc_t_fcat.
DATA gw_fcat TYPE lvc_s_fcat.

* �̺�Ʈ �ڵ鷯�� ���� Ŭ������ ����(��ġ �ٶ���)
* DEFINITION�� IMPLEMENTATION�� �׻� ��Ʈ
CLASS lcl_handler DEFINITION. " Ŭ������ ���� ����(������ Ÿ�� ����)
  PUBLIC SECTION.
    "�̺�Ʈ �ڵ鷯�� ���� on_<�̺�Ʈ �̸�>
    CLASS-METHODS on_double_click "�� �޼ҵ尡 �����Ұ���
      FOR EVENT double_click "���� Ŭ�� �̺�Ʈ�� ����
                  OF cl_gui_alv_grid "�ش� Ŭ��������
      IMPORTING es_row_no. "���� �� �Ķ���Ͱ� �ʿ���(����Ŭ���� ����)

    CLASS-METHODS on_toolbar "�� �޼ҵ尡 �����Ұ���
      FOR EVENT toolbar "���� �̺�Ʈ�� ����
                  OF cl_gui_alv_grid "�ش� Ŭ��������
      IMPORTING e_object. "�Ķ����(fcode)

    " toolbar�� user_command�� ��Ʈ�̴�
    CLASS-METHODS on_user_command "�� �޼ҵ尡 �����Ұ���
      FOR EVENT user_command "user_command �̺�Ʈ�� ����
                  OF cl_gui_alv_grid "�ش� Ŭ��������
      IMPORTING e_ucomm. "�Ķ����(fcode)

    " ��� ������ ��ܿ� ����ڰ� ���� �� �� �� �п� ����� �ߴ���
    " ��� �Ķ���Ͱ� �������� ����
    CLASS-METHODS on_print_top_of_page "�� �޼ҵ尡 �����Ұ���
        FOR EVENT print_top_of_page "print �̺�Ʈ�� ����
        OF cl_gui_alv_grid. "�ش� Ŭ��������

    " ���� ����ڰ� ���� ������ ��ư�� ����� �ٲٱ� ���� �޼ҵ�
    CLASS-METHODS on_before_user_command "�� �޼ҵ尡 �����Ұ���
      FOR EVENT before_user_command "before_user_command �̺�Ʈ�� ����
                  OF cl_gui_alv_grid "�ش� Ŭ��������
      IMPORTING e_ucomm. " ���Ĵٵ� ��ư�� ���� ��� �ڵ�

    CLASS-METHODS on_context_menu_request "�� �޼ҵ尡 �����Ұ���
      FOR EVENT context_menu_request "context_menu �̺�Ʈ�� ����
                  OF cl_gui_alv_grid "�ش� Ŭ��������
      IMPORTING e_object. " Context_menu�� �����ϱ� ���� ������Ʈ

ENDCLASS.

CLASS lcl_handler IMPLEMENTATION. " Ŭ������ ���� ����(���� ����)

  METHOD on_double_click.
    "��� �������� ����
*      MESSAGE 'I am clicked!' TYPE 'I'.
    "���� Ŭ���� ������ �� ID�� ���
    READ TABLE gt_book INTO gw_book INDEX es_row_no-row_id.
    IF sy-subrc <> 0.
      "�̷� ���� �߻��� ���� ����
    ELSE.
      "�� �� ȭ���� ����
      CALL FUNCTION 'DR_DISPLAY_CUSTOMER'
        EXPORTING
          id = gw_book-customid.
    ENDIF.

*    MESSAGE i016(bc408) WITH gw_book-customid. "����Ŭ���� ���� ����
  ENDMETHOD.

  METHOD on_toolbar.
    "�߰��� ��ư �����ϱ�(�� ���� ��ȸ ��ư)
    DATA lw_button TYPE stb_button.

    CLEAR lw_button.
    lw_button-function = 'CUST'. "ALV �ȿ� �ִ� ��ư(ok_code�� ���� X)
    lw_button-icon = icon_customer.
    lw_button-text = 'Customer'.

    "ȭ�鿡 �߰�
    INSERT lw_button INTO TABLE e_object->mt_toolbar.

  ENDMETHOD.

  METHOD on_user_command.
    DATA lt_selected TYPE lvc_t_row.
    DATA lw_selected TYPE lvc_s_row.

    CASE e_ucomm.
      WHEN 'CARR'. " �װ����� �� ������ ��ȸ �Ѵ�(DR_DISPLAY_CARRID)
        " ������ ALV�� �Ѿ�Դٴ°� �װ��� ��(only 1)�� ���Դ� ���̱� ������
        " ������ ������ �о�� �ʿ� ����
        READ TABLE gt_book INTO gw_book INDEX 1.

        CALL FUNCTION 'DR_DISPLAY_CARRID'
          EXPORTING
            carrid        = gw_book-carrid.

      WHEN 'CUST'. "����ڰ� �� ��ư�� Ŭ��
        " 1) ���� ����ڰ� ALV���� ���õ� ������ ������ ����
        CALL METHOD go_alv->get_selected_rows
          IMPORTING
            et_index_rows = lt_selected.
*            et_row_no     =.

        " 2) ���� : ���� ���� ���� �Ǵ� ���� ���� ���� ��� -> �޽��� ó��
        " lines -> ���ͳ� ���̺� �� �� ���� �ִ���
        IF lines( lt_selected ) <> 1. " 1���� ���� �̻� �����ߴٸ�
          MESSAGE i019(ZMESSAGE_SS36).
        ELSE.

        " ���� ���ͳ� ���̺� ��� ���� �� ��° ������
        " ������ ����ó�� ����� ������ ���̺��� �ϳ��� �����͹ۿ� ����
        READ TABLE lt_selected INTO lw_selected INDEX 1.
        " �ش� ���� �� ID ������ ���
        READ TABLE gt_book INTO gw_book INDEX lw_selected-index.

        " 3) �� �� ���� �Լ� ȣ��
        CALL FUNCTION 'DR_DISPLAY_CUSTOMER'
        EXPORTING
          id = gw_book-customid.
        ENDIF.

      ENDCASE.

    ENDMETHOD.

    METHOD on_print_top_of_page.

      WRITE:/ 'Who:', sy-uname COLOR COL_KEY.
      WRITE:/ 'When:', sy-datum, sy-uzeit.

    ENDMETHOD.

    METHOD on_before_user_command.

      "1) ����ڰ� ���Ĵ��� �� ��ȸ ��ư�� Ŭ���ϸ� �װ��� �� ��ȸ ������� ��ü
      CASE e_ucomm.
        WHEN cl_gui_alv_grid=>mc_fc_detail. "����ڰ� �긦 Ŭ���ϸ�
          CALL METHOD go_alv->set_user_command
            EXPORTING
              i_ucomm = 'CARR'. "����� ��� ��ü�ϰڴ�
      ENDCASE.

    ENDMETHOD.

    METHOD on_context_menu_request.

      " ALV���� ���콺 ��Ŭ�� �� Context Menu�� ����
      CALL METHOD cl_ctmenu=>load_gui_status
        EXPORTING
          program    = sy-cprog
          status     = 'S0100_ALV'
*          disable    =
          menu       = e_object
        EXCEPTIONS
          read_error = 1
          others     = 2.

    ENDMETHOD.

ENDCLASS.


PARAMETERS pa_car TYPE sbook-carrid MEMORY ID car OBLIGATORY. "�ʼ� ��
PARAMETERS pa_con TYPE sbook-connid MEMORY ID con OBLIGATORY. "�ʼ� ��
SELECT-OPTIONS so_fld FOR gw_book-fldate NO-EXTENSION.

* ȭ�鿡�� ���� ��ȸ�� ��Ұ��� �������� ���� check box�� ����
PARAMETERS pa_can AS CHECKBOX DEFAULT 'X'. " ��Ұ� ����

SELECTION-SCREEN SKIP 1.

* ALV ȭ���� ��� View ������ �Է� ����
PARAMETERS p_vari TYPE disvariant-variant. " ������ �ϴ� view�� ����..?

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
