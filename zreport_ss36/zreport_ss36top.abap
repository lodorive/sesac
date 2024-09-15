*&---------------------------------------------------------------------*
*& Include ZREPORT_SS36TOP                                   Report ZREPORT_SS36
*&
*&---------------------------------------------------------------------*
REPORT zreport_ss36.

TABLES spfli.

TABLES sscrfields. "ȭ�鿡�� � ��ư�� Ŭ���ƴ����� �����ϱ� ���� ����

* ù ��° ���� ���� ȭ��
SELECTION-SCREEN BEGIN OF SCREEN 110 AS SUBSCREEN. "AS SUBSCREEN �� �̰� ���꽺ũ����
  PARAMETERS pa_car TYPE scarr-carrid MEMORY ID car. " �װ��� �Է�
  SELECT-OPTIONS so_con FOR spfli-connid NO-EXTENSION. " �װ���
SELECTION-SCREEN END OF SCREEN 110.

* �� ��° ���� ���� ȭ��
SELECTION-SCREEN BEGIN OF SCREEN 120 AS SUBSCREEN.
  PARAMETERS pa_bid TYPE sbook-bookid.
SELECTION-SCREEN END OF SCREEN 120.

* �� ��Ʈ�� �׸���
SELECTION-SCREEN BEGIN OF TABBED BLOCK blk1 FOR 3 LINES.
                  "�� ����    "���̺�             "ok_code
  SELECTION-SCREEN TAB (10) tab1 USER-COMMAND comm1 DEFAULT SCREEN 110.
  SELECTION-SCREEN TAB (10) tab2 USER-COMMAND comm2 DEFAULT SCREEN 120.
SELECTION-SCREEN END OF BLOCK blk1.

SELECTION-SCREEN SKIP 1. " ��ĭ ���ڴ�

SELECTION-SCREEN BEGIN OF BLOCK out
  WITH FRAME "with FRAME �ڽ����� ���� �߰ڴ�
  TITLE TEXT-t01. "box���� ������ �ްڴ�

* USER-COMMAND �긦 �޾ƾ߸� ����ڰ� üũ�ڽ��� �������� �� PAI �߻�
PARAMETERS pa_name AS CHECKBOX. "USER-COMMAND name, " üũ �ڽ�
PARAMETERS pa_curr AS CHECKBOX USER-COMMAND curr.

SELECTION-SCREEN SKIP 1. " ��ĭ ���ڴ�
* MODIF ID -> GROUPING(�� ���� ó���ϱ� ����)
PARAMETERS: pa_lim_1 RADIOBUTTON GROUP lim MODIF ID xyz, " ���� ��ư
            pa_lim_2 RADIOBUTTON GROUP lim MODIF ID xyz DEFAULT 'X', " ȭ���� ���ڸ��� ����
            pa_lim_3 RADIOBUTTON GROUP lim MODIF ID xyz.

SELECTION-SCREEN END OF BLOCK out.

SELECTION-SCREEN SKIP 1. " ��ĭ ���ڴ�

* �� �ٿ� �Ѹ��ڴ�
* COMMENT : ���̺� �׸��°� (��ũ�� ���α׷����� T ������ ������ �׸��� �Ͱ� ����)
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(20) TEXT-c01.

"pos_low(�����) �� ��ġ(selection option)���ٰ� 8ĭ Ȯ��
"FOR FIELD <pa_priv> �� ���̺��� �� �ʵ带 ���� ���̺��̾�
SELECTION-SCREEN COMMENT pos_low(8) TEXT-c02 FOR FIELD pa_priv.
PARAMETERS pa_priv AS CHECKBOX.

"pos_low(�����) �� ��ġ(selection option)���ٰ� 8ĭ Ȯ��
"FOR FIELD <pa_busi> �� ���̺��� �� �ʵ带 ���� ���̺��̾�
SELECTION-SCREEN COMMENT pos_high(8) TEXT-c03 FOR FIELD pa_busi.
PARAMETERS pa_busi AS CHECKBOX.

SELECTION-SCREEN END OF LINE.

                                       "��ư �ؽ�Ʈ
SELECTION-SCREEN PUSHBUTTON /pos_low(8) gv_btn1
USER-COMMAND on1.
SELECTION-SCREEN PUSHBUTTON pos_high(8) gv_btn2
USER-COMMAND on2.

* 1100�� ȭ�� (����ڰ� �̸� ���� �� �ΰ����� ���� �˾�(�� + �̸�)
SELECTION-SCREEN BEGIN OF SCREEN 1100.
  PARAMETERS pa_first AS CHECKBOX.
  PARAMETERS pa_last AS CHECKBOX.
SELECTION-SCREEN END OF SCREEN 1100.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
