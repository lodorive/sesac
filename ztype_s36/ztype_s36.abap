*&---------------------------------------------------------------------*
*& Report ZTYPE_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTYPE_S36.

* ������� ������ �Է� ����
PARAMETERS p_birth TYPE d.
* ���� ���� ����ð��� �Է� ����
PARAMETERS P_end TYPE t.
* ������� �̸��� �Է� ���� (��, 12�ڸ� ũ���)
PARAMETERS p_name TYPE c LENGTH 12.
PARAMETERS p_score TYPE p LENGTH 3 DECIMALS 2.

* 3.14��� ���� ���� ����� ����, ��� �̸� c_pi
CONSTANTS c_pi TYPE p LENGTH 2 DECIMALS 2 VALUE '3.14'.

* c_pi ���� 3.15�� ����
*c_pi = '3.15'. "����

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
