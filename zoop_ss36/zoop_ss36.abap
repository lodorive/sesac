*&---------------------------------------------------------------------*
*& Report ZOOP_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zoop_ss36.

INCLUDE zoop_ss36top. " �θ� Ŭ���� / ���� Ŭ���� / Ʈ�� Ŭ����

  DATA gt_parking TYPE TABLE OF REF TO lcl_vehicle. " ���� / Ʈ�� ���� �� ����

  DATA go_bus TYPE REF TO lcl_bus.
  DATA go_truck TYPE REF TO lcl_truck.

START-OF-SELECTION.

  " ���� ����
  " �θ��� �����ڸ� �״�� ��������
  CREATE OBJECT go_bus
    EXPORTING
      i_maker = '����'
      i_model = 'Happy City'
      i_color = '1' .

  APPEND go_bus TO gt_parking. " Ÿ���� �ٸ����� ��ü ���� ���α׷��̱� ������ ����
                               " CASTING �� �߻�(�θ��� Ÿ������ �ٲ�)
                               " Generalization  = Up.Cast

  " Ʈ�� ����
  CREATE OBJECT go_truck
    EXPORTING
      i_maker = '����'
      i_model = 'T12'
      i_color = '5'.

  APPEND go_truck TO gt_parking. " Ÿ���� �ٸ����� ��ü ���� ���α׷��̱� ������ ����

*" �ڵ����� ���� (REF ����)
*DATA go_car01 TYPE REF TO lcl_vehicle.
*DATA go_car02 LIKE go_car01.
*
*" ���ͳ� ���̺� ����(�ڵ����� ������ �� �ִ� ���ͳ� ���̺�)
*DATA gt_parking TYPE TABLE OF REF TO lcl_vehicle.
*
*START-OF-SELECTION.
*
** �ڵ��� 2�� ����
*  CREATE OBJECT go_car01
*    EXPORTING i_maker = '����'
*              i_model = '���׽ý�'
*              i_color = '3'.
*
*  APPEND go_car01 TO gt_parking.
*
*  CREATE OBJECT go_car02
*    EXPORTING i_maker = '����'
*              i_model = 'SŬ����'
*              i_color = '1'.
*
*  APPEND go_car02 TO gt_parking.
*
*  CREATE OBJECT go_car02
*    EXPORTING i_maker = '�ƿ��'
*              i_model = 'A6'
*              i_color = '4'.
*
*  APPEND go_car02 TO gt_parking.
*
*** �����忡 ��� �ִ� 2��° �ڵ����� ������ Ȯ�� �ϰ� �;�
*  DATA gw_car TYPE REF TO lcl_vehicle.
**  READ TABLE gt_parking INTO gw_car INDEx 2. " 2��° �����͸� ����
**
**  gw_car->display_attrs( ).
*
** �츮 ȸ�� �����忡 �ִ� ��� �ڵ����� ������ Ȯ��
*  LOOP AT gt_parking INTO gw_car.
*    gw_car->display_attrs( ). " 1�� ����
**    CALL METHOD gw_car->display_attrs( ). " 2�� ����
*    NEW-LINE.
*  ENDLOOP.
*
** �� ����� �ڵ��� ������ ����ϰ��� ��(Print_total_cars ȣ��)
*  lcl_vehicle=>print_total_cars( ).

* �ڵ����� �ϳ� �����ϰ� go_car01�� ����Ű�� �Ǹ�
* ������ go_car01�� ����Ű�� �ִ� �����Ͱ� ��������
* �׷��Ƿ� �� ������Ʈ�� ������ �ݷ��Ͱ� �����ϰ� ��
*  CREATE OBJECT go_car01.
*
*  CLEAR: go_car01, go_car02. "�����͸� ����� -> ������ �ݷ��Ͱ� ������ �������� ����

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
