*&---------------------------------------------------------------------*
*& Report ZBC400_SECOND_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_SECOND_SS36.

*DATA xyz1 TYPE c LENGTH 3. "ABAP Standard Data Type
* xyz2 �� xyz3�� ����
*DATA xyz2 TYPE s_carr_id. "Data Element
*DATA xyz3 TYPE scarr_carrid. "���̺��� �÷��� ����

* S_CARR_ID : C:3 -> Data Element -> Global Data Type
*PARAMETERS p_id1 TYPE s_carr_id. "������� ���� + �ǹ����� ����
*PARAMETERS p_id2 TYPE c LENGTH 3. "���� ������� ����

** �̸��� ���� Ÿ�� ���� (C:32) -> Local Data Type
*TYPES ty_name TYPE c LENGTH 128.
*
*PARAMETERS p_today TYPE d. "��¥�� �Է�
*
** ����ڿ��� ���̸� �Է¹ް��� �Ѵ�. i, p(x), n(o)
*PARAMETERS p_age TYPE n LENGTH 3. "3�ڸ� ���ڸ� �Է� ����(������ X)
*
*PARAMETERS p_name TYPE ty_name.
*
** Ÿ�� N�� ���� ���
*WRITE: p_age.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
