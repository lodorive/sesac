*&---------------------------------------------------------------------*
*& Report ZSTRING_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSTRING_S36.

* ȭ�鿡�� �̸�(C:32)�� ��(C:4)�� �Է� ����
PARAMETERS pa_first TYPE c LENGTH 32.
PARAMETERS pa_last TYPE c LENGTH 4.

CONSTANTS gc_comma TYPE c LENGTH 1 VALUE ','.

DATA gv_fullname TYPE c LENGTH 38. " 32 + 2 + 4 (��ǥ���� ���)

*CONCATENATE pa_first
*            pa_last
*            INTO gv_fullname " �� ���� ������ ���ļ� gv_fullname�� ����

gv_fullname = pa_first && pa_last.

* SEPARATED BY ','. " ','�� �߰��� �־� ��ġ�� ����
*  SEPARATED BY gc_comma.

WRITE: gv_fullname.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
