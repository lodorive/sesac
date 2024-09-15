*&---------------------------------------------------------------------*
*& Report ZQUIZ_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zquiz_ss36.

* �پ��� ������ �Է� �޾� �ش� ������ ���� ��Ȳ�� �����ϰ��� �Ѵ�
* �Է� ȭ�� : �װ��� �ڵ�(���ϰ�) �װ���(���ϰ�) ���� ����(������)
* �� �� ������ ZGET_CUSTOMER_SS36 �Լ� ���
* ���� Ŭ������ �ٱ��� ó��
* ��½� �װ��� �ڵ�(ASC) ����⵵(DESC)+��(DESC) ��ID(ASC)
* ��½� ��� ������� ����
* ���� ���̺� : SBOOK, SCUSTOM, SCARR

* 1) TYPE ����
TYPES: BEGIN OF ts_flight, "
         carrid    TYPE scarr-carrid,      " �װ��� �ڵ�
         carrname  TYPE scarr-carrname,    " �װ��� �̸�
         fldate    TYPE sbook-fldate,      " ���� ����
         customid  TYPE scustom-id,        " �� ID
         name      TYPE scustom-name,      " �� �̸�
         telephone TYPE scustom-telephone, " �� ��ȭ��ȣ
         email     TYPE scustom-email,     " �� �̸���
         class     TYPE sbook-class,       " �¼� Ŭ����
         cancelled TYPE sbook-cancelled,   " ���� ��� ����
       END OF ts_flight.


* 2) ���� ����
DATA: gt_flight     TYPE TABLE OF ts_flight, "���� ���� ���� ���̺�
      gs_flight     TYPE ts_flight, "���� ���� ���� ����ü
      lv_datum_low  TYPE sy-datum, "���� ù ���� ���� ����
      lv_datum_high TYPE sy-datum. "���� ������ ���� ���� ����

* 3) �Է� ��
PARAMETERS: pa_car TYPE scarr-carrid, "�װ��� �ڵ�
            pa_con TYPE sbook-connid. "�װ���

SELECT-OPTIONS so_fld FOR gs_flight-fldate. "���� ���� ���� �ɼ�


INITIALIZATION.
  PERFORM init. "�ʱⰪ ���� �����ƾ ȣ��

START-OF-SELECTION.
  PERFORM get_data. "������ �������� �����ƾ ȣ��

END-OF-SELECTION.
  PERFORM wrtie_flight. "���� ���� ���� ��� �����ƾ ȣ��

FORM init .
  " ���� ��¥�� ������ ����
  lv_datum_high = sy-datum.

  " ���� ������ ���� ���ϱ� ���� �Լ� ȣ��
  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'
    EXPORTING
      day_in            = lv_datum_high   " ���� ��¥�� �Է����� ���
    IMPORTING
      last_day_of_month = lv_datum_high.   " �Լ����� ��ȯ�� ���� ������ ���� ������ ����

  " ���� ù ���� ���ϱ�
  " ���� ��¥�� �⵵�� ���� �����Ͽ� �ش� ���� ù ���� ����(ex:'202408' + '01')
  lv_datum_low = lv_datum_high+0(6) && '01'.

  so_fld-sign = 'I'.
  so_fld-option = 'BT'.
  so_fld-low = lv_datum_low. "���� ��¥
  so_fld-high = lv_datum_high. "���� ��¥

  APPEND so_fld TO so_fld. "���� ���� ���� �ɼǿ� �߰�

ENDFORM.

FORM get_data .

  " 4) ������ ���
  " �Է� ���� �װ��� �ڵ�, �װ���, ���� ���� �������� ���� ���� ��ȸ
  SELECT carrid fldate customid class cancelled
     FROM sbook
     INTO CORRESPONDING FIELDS OF gs_flight
     WHERE carrid = pa_car
     AND connid = pa_con
     AND fldate IN so_fld.

    " �װ��� �̸� ��ȸ
    SELECT carrname
      FROM scarr
      INTO CORRESPONDING FIELDS OF gs_flight
      WHERE carrid = gs_flight-carrid.

      " �� ������ ��ȸ�ϱ� ���� �Լ� ȣ��
      CALL FUNCTION 'ZGET_CUSTOMER_SS36'
        EXPORTING
          i_id        = gs_flight-customid
        IMPORTING
          e_name      = gs_flight-name
          e_telephone = gs_flight-telephone
          e_email     = gs_flight-email.

      " ���� ���� ���� ���̺� �߰�
      APPEND gs_flight TO gt_flight.

    ENDSELECT.
  ENDSELECT.

ENDFORM.

FORM wrtie_flight .

  " 5) ���� ���� ���� ���� �� ���
  SORT gt_flight BY carrid ASCENDING
                    fldate DESCENDING
                    customid ASCENDING.

  LOOP AT gt_flight INTO gs_flight.

    " ������ ��ҵ��� ���� ��쿡��
    IF gs_flight-cancelled <> 'X'.

      " ���� ���� ���� ���
     WRITE:/ gs_flight-carrid, " �װ��� �ڵ�
             gs_flight-carrname, " �װ��� �̸�
             gs_flight-fldate+0(4), " ��
             gs_flight-fldate+4(2), " ��
             gs_flight-customid, " �� ID
             gs_flight-name+0(15), " �� �̸�
             gs_flight-telephone+0(20), " ��ȭ��ȣ
             gs_flight-email. " �̸���

      " ���� Ŭ������ ���� ���(Text Symbol)
      CASE gs_flight-class.
        WHEN 'F'.
          WRITE: TEXT-001.
        WHEN 'Y'.
          WRITE: TEXT-002.
        WHEN 'C'.
          WRITE: TEXT-003.
      ENDCASE.

    ENDIF.

  ENDLOOP.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
