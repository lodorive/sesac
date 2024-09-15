*&---------------------------------------------------------------------*
*& Report ZFLIGHTMODEL_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zflightmodel_ss36.

* ȭ�鿡�� �װ��� �ڵ�� �װ����� �Է¹޾� �ش� �������� ����ϴ� ���α׷��� ����
* ����� �Լ� -> BC400_DDS_FLIGHTLIST_GET

*��� ���� ���ͳ� ���̺� �ʿ�(gt_flight ��� �÷� + FREE �÷�)
* 1)��Ʈ���� Ÿ�� ����
TYPES BEGIN OF ts_output.
"gt_flight�� line Ÿ���� ��� ����
    INCLUDE STRUCTURE bc400_s_flight.
TYPES: free TYPE bc400_s_flight-seatsmax.
TYPES END OF ts_output.

* �Է� �Ķ����
PARAMETERS: p_carrid TYPE bc400_s_flight-carrid, "�װ��� �ڵ�
            p_connid TYPE bc400_s_flight-connid. "�װ��� ���� ��ȣ

DATA gt_flights TYPE bc400_t_flights. "���� ������ ������ ���� ���� ���̺�
DATA gw_flight LIKE LINE OF gt_flights. "Work Area

* ��� ���� ���ͳ� ���̺�
DATA gt_outputs TYPE TABLE OF ts_output.
DATA gw_output LIKE LINE OF gt_outputs.

* ������ ����Ʈ�� �������� �Լ�
CALL FUNCTION 'BC400_DDS_FLIGHTLIST_GET'
  EXPORTING
    iv_carrid  = p_carrid "�Է� ���� �װ��� �ڵ�
    iv_connid  = p_connid "�Է� ���� �װ��� ���� ��ȣ
  IMPORTING
    et_flights = gt_flights "������ ������ ����Ʈ�� ����
  EXCEPTIONS
    no_data    = 1
    OTHERS     = 2.

IF sy-subrc <> 0.

  WRITE:/'Error occurred while fetching flight data!'.

ELSE.

MOVE-CORRESPONDING gt_flights TO gt_outputs. "�Լ��� ����� gt_outputs����

* �ܿ� �¼� �� ���
LOOP AT gt_outputs INTO gw_output.
  gw_output-free = gw_output-seatsmax - gw_output-seatsocc.
  MODIFY gt_outputs FROM gw_output.
ENDLOOP.

* �װ��� �ڵ�, �װ��� ���� ��ȣ, ���� ��¥ �������� ����(��������)
SORT gt_outputs BY carrid connid fldate DESCENDING.

LOOP AT gt_outputs INTO gw_output.

  "�� �������� ���� ������ ���
  WRITE:/
  gw_output-carrid,   "�װ��� �ڵ�
  gw_output-connid,   "�װ��� ���� ��ȣ
  gw_output-fldate,   "���� ��¥
  gw_output-seatsmax, "�ִ� �¼� ��
  gw_output-seatsocc, "������ �¼� ��
  gw_output-free,            "���� �¼� ��
  gw_output-percentage. "������ ������

ENDLOOP.

ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
