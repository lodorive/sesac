*&---------------------------------------------------------------------*
*& Report ZSTRING_S36_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSTRING_S36_2.

* ȭ�鿡�� FULLNAME�� �Է� ����(��, ���� �̸��� �����̽��� �����ؼ� �Է���)
PARAMETERS pa_fname TYPE string. " Full name�� �Է� ����
DATA: gv_fname TYPE c LENGTH 32, " First name ����
      gv_lname TYPE c LENGTH 4. " Last name ����

* �߰� ����(SPLIT�� ���ڸ� �Է� �޾Ƽ� �ش� ���ڷ� SPLIT �ض�)
PARAMETERS pa_sep TYPE c LENGTH 1. " SPLIT ����(��ȣ)�� �Է� ����

* �����̽��� �����ؼ� �ڸ��ڴ�.
* space�� abap ���� ��� �� �ϳ��� ������ ����� �� ����
SPLIT pa_fname AT pa_sep INTO gv_fname
                              gv_lname.

WRITE:/ 'First name : ', gv_fname. " �̸� ���
WRITE:/ 'Last name : ', gv_lname. " �� ���

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
