*&---------------------------------------------------------------------*
*& Report ZOPENSQL_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOPENSQL_S36.

* ȭ�鿡�� �װ��� �ڵ带 �Է� ����
*PARAMETERS p_code TYPE c LENGTH 3. "�װ��� �ڵ带 ���� ����
PARAMETERS p_code TYPE scarr-carrid. "2��
*DATA gv_name TYPE c LENGTH 20. "�װ��� �̸��� ���� ����
DATA gv_name TYPE scarr-carrname. "2��

* OPEN SQL ����
SELECT SINGLE carrname "����� �÷� �̸�
  FROM scarr "�����͸� �����ϰ� �ִ� ���̺�
  INTO gv_name "����� �����͸� ���� ����
 WHERE carrid = p_code. "ȭ�鿡�� �Է��� �ڵ带 �˻� �������� ��

* ����ϱ�
WRITE: 'Airline Name :', gv_name.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
