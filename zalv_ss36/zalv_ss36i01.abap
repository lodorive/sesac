*&---------------------------------------------------------------------*
*&  Include           ZREPORT_SS36I01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BCAN'. "ȭ���� ��� ������ ��� ó�� ��
      LOOP AT gt_book INTO gw_book WHERE cancelled = space.
        gw_book-cancelled = 'X'.
        MODIFY gt_book FROM gw_book TRANSPORTING cancelled.
      ENDLOOP.

      "ALV���� ȭ�� ���� ��û
      CALL METHOD go_alv->refresh_table_display
        EXPORTING
          is_stable      = gs_stable " ����/���� ��ũ�ѹٸ� ����
*          i_soft_refresh = " ���� or ������ �����ϰ� ȭ���� �ٽ� �׷�����
        EXCEPTIONS
          finished       = 1
          others         = 2.

      MESSAGE i016(zmessage_ss36).

    WHEN 'BACK' OR 'EXIT'.
      PERFORM free_control_resources. "�ڿ�(Container, ALV ��ü)�� �ݳ�
      "���� ȭ��(1000)���� �̵�
      LEAVE TO SCREEN 0.
    WHEN 'CANC'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Form  FREE_CONTROL_RESOURCES
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM free_control_resources .

* ���� : �θ� -> �ڽ�
* �ı� : �ڽ� -> �θ�

  CALL METHOD go_alv->free
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.

  CALL METHOD go_cont->free
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.

* ���۷��� ���� �ʱ�ȭ
  CLEAR: go_alv, go_cont.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
