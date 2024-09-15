*&---------------------------------------------------------------------*
*&  Include           ZREPORT_SS36E01
*&---------------------------------------------------------------------*
LOAD-OF-PROGRAM.

INITIALIZATION.
  tab1 = 'Carrier'.  "ù��° �� ���̺�.
  tab2 = 'Booking'.  "�ι�° �� ���̺�.

  "���α׷��� �������ڸ��� 2��° ���� Ȱ��ȭ ��Ű�� ���� �ʹ�.
  blk1-activetab = 'COMM2'.
  blk1-dynnr     = 120.

  "��ư ���̺� ����
  gv_btn1 = 'Display'.
  gv_btn2 = 'Change'.

AT SELECTION-SCREEN OUTPUT. " 1000�� ȭ���� PBO
  LOOP AT SCREEN.
    " ����ڰ� �ݾ� üũ�ڽ��� Ŭ���� ���
    " ������ư �׷� �����
    IF pa_curr = 'X'.
      IF screen-group1 = 'XYZ'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.

* ��� ��ü PAI(User_Command ���� ����)
AT SELECTION-SCREEN. " 1000�� ȭ���� PAI
  CASE sy-dynnr.
    WHEN '1000'.
      CASE sscrfields-ucomm. "����ڰ� � �ʵ带 ������?
        WHEN 'ON1'.
          "�ƹ� ��ųʸ� ȣ��
          CALL TRANSACTION 'SE11'.
        WHEN 'ON2'.
          "�ƹ� ������ ȣ��
          CALL TRANSACTION 'SE38'.
      ENDCASE.
    WHEN '110'.
      "Nothing To do.
    WHEN '120'.
      "Nothing To do.
  ENDCASE.

  AT SELECTION-SCREEN ON pa_name.
    "1100�� ȭ�� ����
    IF pa_name = 'X'.
      CALL SELECTION-SCREEN 1100
      STARTING AT 5 5.

        IF sy-subrc <> 0. "�˾�â���� ��� ��ư Ŭ�� ��
          LEAVE TO SCREEN 1000.
        ENDIF.

    ENDIF.

*   ����ڰ� pa_name���� f1�� ������ �� help�� ���� ����
  AT SELECTION-SCREEN ON HELP-REQUEST FOR pa_name.
    MESSAGE 'F1 Help...' TYPE 'I'.

  START-OF-SELECTION.
    WRITE: 'Processing...'.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
