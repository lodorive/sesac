*&---------------------------------------------------------------------*
*& Report ZQUIZ_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbooking_list_ss36_2.

* �پ��� ������ �Է� �޾� �ش� ������ ���� ��Ȳ�� �����ϰ��� �Ѵ�
* �Է� ȭ�� : �װ��� �ڵ�(���ϰ�) �װ���(���ϰ�) ���� ����(������)
* �� �� ������ ZGET_CUSTOMER_SS36 �Լ� ���
* ���� Ŭ������ �ٱ��� ó��
* ��½� �װ��� �ڵ�(ASC) ����⵵(DESC)+��(DESC) ��ID(ASC)
* ��½� ��� ������� ����
* ���� ���̺� : SBOOK, SCUSTOM, SCARR

* 2) ���� ����
DATA: gt_book       TYPE TABLE OF ZBOOKLIST_SS36, "���� ���� ���� ���̺�
      gw_book       TYPE ZBOOKLIST_SS36. "���� ���� ���� ����ü

* 3) �˻�ȭ�� �׸���
PARAMETERS: pa_car TYPE sbook-carrid, "�װ��� �ڵ�
            pa_con TYPE sbook-connid. "�װ���

SELECT-OPTIONS so_fld FOR gw_book-fldate. "���� ���� �ɼ�

INITIALIZATION.
  PERFORM init. "�ʱⰪ ���� �����ƾ ȣ��

AT SELECTION-SCREEN.
  "Nothing to do.

START-OF-SELECTION.
* ������ �������� �Լ� ȣ��
CALL FUNCTION 'ZGET_BOOKLIST_SS36'
  EXPORTING
    i_carrid         = pa_car
    i_connid         = pa_con
    i_fldate         = so_fld[]
 IMPORTING
   E_BOOKLIST       = gt_book.

END-OF-SELECTION.
  PERFORM wrtie_data. "���� ���� ��� �����ƾ ȣ��

FORM init .

  so_fld-sign = 'I'.
  so_fld-option = 'BT'.
  " ���� ��¥�� �⵵�� ���� �����Ͽ� �ش� ���� ù ���� ����(ex:'202408' + '01')
  so_fld-low = sy-datum+0(6) && '01'. "���� ��¥

  " ���� ������ ���� ���ϱ� ���� �Լ� ȣ��
  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'
    EXPORTING
      day_in            = sy-datum   " ���� ��¥�� �Է����� ���
    IMPORTING
      last_day_of_month = so_fld-high.   " �Լ����� ��ȯ�� ���� ������ ���� ����

    APPEND so_fld TO so_fld.

ENDFORM.


FORM wrtie_data .

  " 5) ���� ���� ���� ���� �� ���
  SORT gt_book BY carrid ASCENDING
                    fyear DESCENDING
                    fmonth DESCENDING
                    customid ASCENDING.

  LOOP AT gt_book INTO gw_book.

    " ���� ���� ���� ���
    WRITE:/ gw_book-carrid, " �װ��� �ڵ�
            gw_book-carrname, " �װ��� �̸�
            gw_book-fyear, "���� ���� �⵵
            gw_book-fmonth, "���� ���� ��
            gw_book-customid, " �� ID
            gw_book-name+0(15), " �� �̸�
            gw_book-telephone+0(20), " ��ȭ��ȣ
            gw_book-email+0(32), " �̸���
            gw_book-classt. "class �ؽ�Ʈ
  ENDLOOP.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
