*&---------------------------------------------------------------------*
*& Report ZEVENT_BLOCK_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zevent_block_ss36.

* �װ��� �ڵ�(���� �˻�) -> scarr
* �װ� ����(���� �˻�) -> sflight

DATA gs_flight TYPE sflight.

PARAMETERS pa_car TYPE scarr-carrid.
SELECT-OPTIONS so_fdt FOR gs_flight-fldate.

LOAD-OF-PROGRAM.
  " �ַ� ��� �׷쿡�� ��� ��(INITIALIZATION. �� ��ħ)
  " ������ LOAD-OF-PROGRAM ���� ���� ��

INITIALIZATION.

  PERFORM init. "�����ƾ ȣ��

AT SELECTION-SCREEN.
  " ����� �Է� �� (1000�� ȭ��) or ���� üũ
  " AA �װ��� ���� ��� ���ϰ� �ϰ��� ��
   IF pa_car = 'AA'.
    " ������ �޼��� E�� ����ؾ� �� = START-OF-SELECTION���� �̵��� ���ϰ� ��.
     MESSAGE E006(ZMESSAGE_SS36) WITH pa_car.
   ENDIF.

START-OF-SELECTION.
  " ������ ��� ��
  WRITE: 'Done.....'.

END-OF-SELECTION.
  " ������ ��� ��

*&---------------------------------------------------------------------*
*&      Form  INIT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM init .

  " �ʱ�ȭ ����(���� ���� or 1000�� ȭ�� �ʱ�ȭ)
  " 1) ȭ���� ���ڸ��� UA�� ����
    pa_car = 'UA'.

  " 2) ȭ���� ���ڸ��� �������� ����, �������� +30�Ϸ� ����
    so_fdt-sign = 'I'.
    so_fdt-option = 'BT'.
    so_fdt-low = sy-datum.
    so_fdt-high = sy-datum + 30.
*    APPEND so_fdt TO so_fdt.
    APPEND so_fdt. "�̸��� ������ ���� ����

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
