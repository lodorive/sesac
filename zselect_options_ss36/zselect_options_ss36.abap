*&---------------------------------------------------------------------*
*& Report ZSELECT_OPTIONS_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_OPTIONS_SS36.

* ȭ�鿡�� �װ��� �ڵ带 �Է� ���� = equal �˻�
* ȭ�鿡�� �װ���(����)�� �Է� ���� = ���� + @ �˻�

*DATA gs_con TYPE spfli.
*
*PARAMETERS pa_car TYPE scarr-carrid. "�װ��� �ڵ�
*SELECT-OPTIONS so_con FOR gs_con-connid. "�װ���(����)

* ȭ�鿡�� �װ��� �ڵ带 ������ �Է� �޾� �ش� �װ��� ������
* ����ϴ� ���α׷��� ���Ͻÿ�.

DATA: gt_carrier TYPE TABLE OF scarr,
      gw_carrier LIKE LINE OF gt_carrier.

* �װ��� �ڵ� ���� �Է�
SELECT-OPTIONS so_car FOR gw_carrier-carrid DEFAULT 'AA' TO 'LH'.

* Open Sql
SELECT *
  FROM scarr
  INTO table gt_carrier
  WHERE carrid IN so_car.

LOOP AT gt_carrier INTO gw_carrier.

  WRITE:/ gw_carrier-carrid, gw_carrier-carrname.

ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
