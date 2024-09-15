*&---------------------------------------------------------------------*
*&  Include           MZCONN_SS36O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S0100'.
  SET TITLEBAR 'T0100'. "Ÿ��Ʋ ��
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  INIT  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init OUTPUT.

*  SET/GET���� ��ü
*  IF spfli-carrid IS INITIAL.
*    spfli-carrid = 'AA'.
*  ENDIF.

* Ŀ�� ��ġ�� io_command�� ��ġ ��Ŵ(������ �빮�ڷ�)
*  SET CURSOR FIELD 'IO_COMMAND'.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_screen OUTPUT.

  CASE io_command.
    WHEN 'D'. "��ȸ ���

      LOOP AT SCREEN. "Work Area �ʿ� ����
        "���� SCREEN���� 200�� ȭ���� ��� ��Ұ� �������
        IF screen-group1 = 'XYZ'.
          "�Է� �Ұ��� ������
          screen-input = 0. "1:�Է� ���� / 0:�Է� �Ұ�
        ENDIF.

        MODIFY SCREEN. "�������� ������
      ENDLOOP.

    WHEN 'U'. "���� ���
      "ȭ���� ����� �������� �����߱� ������ ���� ������ �ʿ� ����
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  DATA fcode TYPE TABLE OF sy-ucomm. "��Ȱ��ȭ ��ų ���(action)�� ���� ���ͳ� ���̺�

  CASE io_command.
    WHEN 'D'.
      "���� ��ư ��Ȱ��ȭ ��Ű��
      APPEND 'SAVE' TO fcode.
      SET PF-STATUS 'S0200' EXCLUDING fcode.
      SET TITLEBAR 'T0200' WITH TEXT-dis.
    WHEN 'U'.
      APPEND 'CHANGE' TO fcode.
      SET PF-STATUS 'S0200'.
      SET TITLEBAR 'T0200' WITH TEXT-upd.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0300  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0300 OUTPUT.
  SET PF-STATUS 'S0300'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CLEAR_OK_CODE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.

  CLEAR: ok_code.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SET_ICON  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_icon OUTPUT.

  "�������� ��� : ICON_CHECKED
  "�������� �ƴ� ��� : ICON_INCOMPLETE
  "�� ����Ʈ : "
  IF sdyn_conn-countryfr <> sdyn_conn-countryto. "��߱����� ���������� ���� �ʴٸ�(������)

    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name                        = 'ICON_CHECKED'
     IMPORTING
       RESULT                      = gv_int
     EXCEPTIONS
       ICON_NOT_FOUND              = 1
       OUTPUTFIELD_TOO_SHORT       = 2
       OTHERS                      = 3.

  ELSE.

    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name                        = 'ICON_INCOMPLETE'
     IMPORTING
       RESULT                      = gv_int
     EXCEPTIONS
       ICON_NOT_FOUND              = 1
       OUTPUTFIELD_TOO_SHORT       = 2
       OTHERS                      = 3.
  ENDIF.

*    "�� ���Ͻ��� ���
*    IF sdyn_conn-distance > 1000.
*
*    CALL FUNCTION 'ICON_CREATE'
*      EXPORTING
*        name                        = 'ICON_CHECKED'
*     IMPORTING
*       RESULT                      = gv_long
*     EXCEPTIONS
*       ICON_NOT_FOUND              = 1
*       OUTPUTFIELD_TOO_SHORT       = 2
*       OTHERS                      = 3.
*
*  ELSE.
*
*    CALL FUNCTION 'ICON_CREATE'
*      EXPORTING
*        name                        = 'ICON_INCOMPLETE'
*     IMPORTING
*       RESULT                      = gv_long
*     EXCEPTIONS
*       ICON_NOT_FOUND              = 1
*       OUTPUTFIELD_TOO_SHORT       = 2
*       OTHERS                      = 3.
*  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SET_DISTANCE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_distance OUTPUT.

  CLEAR gs_distance.

  IF sdyn_conn-distance <= 1000.
    gs_distance-short = 'X'.
  ELSEIF sdyn_conn-distance <= 3000.
    gs_distance-medium = 'X'.
  ELSE.
    gs_distance-long = 'X'.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SET_SUBSCR  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_subscr OUTPUT.

  CASE sdyn_conn-countryfr. "��� ������
    WHEN sdyn_conn-countryto. "���� ������ ���ٸ�(������)
      gv_dynnr = '0220'. "220�� ���꽺ũ��(���, ���� ���� ����)
    WHEN OTHERS.
      gv_dynnr = '0210'. "210�� ���꽺ũ��(���, ���� �ð� ����)
  ENDCASE.

ENDMODULE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
