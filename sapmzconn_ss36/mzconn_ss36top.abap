*&---------------------------------------------------------------------*
*& Include MZCONN_SS36TOP                                    Module Pool      SAPMZCONN_SS36
*&
*&---------------------------------------------------------------------*
PROGRAM sapmzconn_ss36.

* 100�� ȭ��� 200�� ȭ���� ���� ����
TABLES: spfli, sdyn_conn.

DATA io_command.
DATA ok_code TYPE sy-ucomm. "� ��ư�� Ŭ�� �ƴ����� �����ϱ� ���� ����

* ������ ���� / �� ����Ʈ�� ���� ������
DATA gv_int TYPE icons-text.
DATA gv_long TYPE icons-text.

DATA: BEGIN OF gs_mode,
        display,"TYPE c LENGTH 1.
        change  VALUE 'X', "���α׷��� ���ڸ��� CHANGE�� Default ��
      END OF gs_mode.

DATA: BEGIN OF gs_distance,
        short,
        medium,
        long,
      END OF gs_distance.

DATA gv_answer.

DATA gv_dynnr TYPE sy-dynnr. "210 or 220

* �ǽ�Ʈ�� ��Ʈ�Ѱ� ����� ����
CONTROLS: my_tabstrip TYPE TABSTRIP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
