*&---------------------------------------------------------------------*
*& Report ZBC400_SS36_LOOP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_SS36_LOOP.

* Exercise14

DATA: gt_connections TYPE BC400_T_CONNECTIONS, "Table Type(���� ���� BC400_S_CONNECTION ����ü�� ����)
      gs_connection TYPE BC400_S_CONNECTION. "Structure Type

TRY.
CALL METHOD cl_bc400_flightmodel=>get_connections
  EXPORTING
    iv_carrid      = SPACE "�װ��� ID�� �� ������ ���� (��� �װ��� ������ ��û)
  IMPORTING
    et_connections = gt_connections "������ ������ gt_connections�� ����
    .
 CATCH cx_bc400_no_data .
   "�����Ͱ� ���� ��� ó��
   WRITE:/'No Data Found!'. "�����Ͱ� ������ ����ڿ��� �˸�
 CATCH cx_bc400_no_auth .
   "������ ���� ��� ó��
   WRITE:/'Authorization Error!'. "���� ������ ����ڿ��� �˸�
ENDTRY.

*DEPTIME(��� �ð�) �������� ������������ ����
SORT gt_connections BY DEPTIME ASCENDING.

LOOP AT gt_connections INTO gs_connection.
  WRITE:/ 'Airline Code:', gs_connection-carrid. "�װ��� �ڵ�
  WRITE:/ 'Flight Connection Number:', gs_connection-connid. "�װ��� ���� ��ȣ
  WRITE:/ 'Departure city:', gs_connection-cityfrom. "��� ����
  WRITE:/ 'Departure airport:', gs_connection-airpfrom. "��� ����
  WRITE:/ 'Arrival city:', gs_connection-cityto. "���� ����
  WRITE:/ 'Destination airport:', gs_connection-airpto. "���� ����
  WRITE:/ 'Flight time:', gs_connection-fltime. "���� �ð�
  WRITE:/ 'Departure time:', gs_connection-deptime. "��� �ð�
  WRITE:/ 'Arrival time:', gs_connection-arrtime. "���� �ð�
  ULINE. " �ϴܿ� ���� �׷��� ���ڵ� ����
ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
