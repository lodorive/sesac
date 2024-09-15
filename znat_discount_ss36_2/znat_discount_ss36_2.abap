*&---------------------------------------------------------------------*
*& Report ZNAT_DISCOUNT_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znat_discount_ss36_2.

* ȭ�鿡�� ���� �ڵ�(���� ��)�� ������(���� ��)�� �Է� �޾�
* �ش� ������ ���� ����ϴ� ���α׷��� �����Ͻÿ�
* (��½� �������� ���� ������ ����Ͻÿ�)

* + ������ ������ ���α׷��� ����
* �� Event Block�� ������ ���� �������� ���� �����ƾ���� ����
* �Ϻ�(JP) ������ ���� ��ȸ �� ��ȸ�� �� ���ٰ� �޽��� ó��
* ȭ���� ���ڸ��� ������ DE, �������� 20 ~ 25�� ����

* ������

* Ÿ�� ����
TYPES: BEGIN OF ts_cust,
         id           TYPE scustom-id,
         name         TYPE scustom-name,
         country      TYPE scustom-country,
         custtype     TYPE scustom-custtype,
         discount     TYPE scustom-discount,
         adj_discount TYPE scustom-discount,
       END OF ts_cust.

* ���� ����
DATA: gt_cust TYPE TABLE OF ts_cust,
      gw_cust LIKE LINE OF gt_cust.

* �Է� ��
PARAMETERS: pa_cou TYPE scustom-country.
SELECT-OPTIONS so_dis FOR gw_cust-discount.

INITIALIZATION.
  PERFORM init.

AT SELECTION-SCREEN.
  PERFORM check-cou.

START-OF-SELECTION.

  PERFORM get_data. "������ ���

  " ������ ����
  LOOP AT gt_cust INTO gw_cust.

  CASE gw_cust-custtype.
  WHEN 'B'.
      gw_cust-adj_discount = gw_cust-discount + 2.
  WHEN 'P'.
      gw_cust-adj_discount = gw_cust-discount.
  ENDCASE.
  MODIFY gt_cust FROM gw_cust.

  ENDLOOP.

END-OF-SELECTION.
SORT gt_cust BY adj_discount DESCENDING ID ASCENDING.

LOOP AT gt_cust INTO gw_cust.
  " ������ ���
  PERFORM write_cust.

ENDLOOP.

* �⺻ �� �����ƾ
FORM init .
  pa_cou = 'DE'.

  so_dis-sign = 'I'.
  so_dis-option = 'BT'.
  so_dis-low = 20.
  so_dis-high = 25.
  APPEND so_dis TO so_dis.

ENDFORM.

* JP ������ �� ��ȸ üũ(���� �޽��� ���)
FORM check-cou .

  IF pa_cou = 'JP'.
    MESSAGE E007(ZMESSAGE_SS36) WITH pa_cou.
  ENDIF.

ENDFORM.

FORM get_data .
  " ������ ���
  SELECT *
  FROM scustom
  INTO CORRESPONDING FIELDS OF TABLE gt_cust
  WHERE COUNTRY = pa_cou
  AND DISCOUNT IN so_dis.

ENDFORM.

FORM write_cust .
 WRITE:/ gw_cust-id,
  gw_cust-name,
  gw_cust-country,
  gw_cust-custtype,
  gw_cust-discount,
  gw_cust-adj_discount,'%'.
ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
