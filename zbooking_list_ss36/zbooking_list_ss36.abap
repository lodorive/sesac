*&---------------------------------------------------------------------*
*& Report ZQUIZ_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbooking_list_ss36.

* �پ��� ������ �Է� �޾� �ش� ������ ���� ��Ȳ�� �����ϰ��� �Ѵ�
* �Է� ȭ�� : �װ��� �ڵ�(���ϰ�) �װ���(���ϰ�) ���� ����(������)
* �� �� ������ ZGET_CUSTOMER_SS36 �Լ� ���
* ���� Ŭ������ �ٱ��� ó��
* ��½� �װ��� �ڵ�(ASC) ����⵵(DESC)+��(DESC) ��ID(ASC)
* ��½� ��� ������� ����
* ���� ���̺� : SBOOK, SCUSTOM, SCARR

* ZQUIZ_SS36 ǽ��

* 1) TYPE ����
TYPES: BEGIN OF ts_book, "
         carrid    TYPE sbook-carrid,      " OR scarr-carrid �װ��� �ڵ�
         carrname  TYPE scarr-carrname,    " �װ��� �̸�
         fldate    TYPE sbook-fldate,      " ȭ�鿡 ����� ������ X
         fyear     TYPE n LENGTH 4,        " �⵵(��� ���̺� ����)
         fmonth    TYPE n LENGTH 2,        " ��(��� ���̺� ����)
         customid  TYPE sbook-customid,    " OR scustom-id �� ID
         name      TYPE scustom-name,      " �� �̸�
         telephone TYPE scustom-telephone, " �� ��ȭ��ȣ
         email     TYPE scustom-email,     " �� �̸���
         class     TYPE sbook-class,       " �¼� Ŭ����
         classt    TYPE c LENGTH 15,       " Ŭ������ �ؽ�Ʈ ����
       END OF ts_book.


* 2) ���� ����
DATA: gt_book       TYPE TABLE OF ts_book, "���� ���� ���� ���̺�
      gw_book       TYPE ts_book. "���� ���� ���� ����ü

* 3) �˻�ȭ�� �׸���
PARAMETERS: pa_car TYPE sbook-carrid, "�װ��� �ڵ�
            pa_con TYPE sbook-connid. "�װ���

SELECT-OPTIONS so_fld FOR gw_book-fldate. "���� ���� �ɼ�

INITIALIZATION.
  PERFORM init. "�ʱⰪ ���� �����ƾ ȣ��

AT SELECTION-SCREEN.
  "Nothing to do.

START-OF-SELECTION.
  PERFORM get_data. "������ �������� �����ƾ ȣ��
  " 5(������ ����) -> �⵵, ��, �� �� ����
  PERFORM get_additional_data.

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

FORM get_data .

  " 4) ������ ���
  " �Է� ���� �װ��� �ڵ�, �װ���, ���� ���� �������� ���� ���� ��ȸ
  SELECT * "carrid fldate customid class
     FROM sbook
     INTO CORRESPONDING FIELDS OF TABLE gt_book
     WHERE carrid = pa_car
     AND connid = pa_con
     AND fldate IN so_fld
     AND cancelled <> 'X'.

ENDFORM.

FORM get_additional_data .

  "�װ��� �̸� ����ϱ�
  "(������ carrid('aa')�� ���� �����͸� ������ ������ �̸��� �� ���� ��ȸ�ص� ��)
  DATA lv_carrname TYPE scarr-carrname.
  SELECT SINGLE carrname
    FROM scarr
    INTO lv_carrname
    WHERE carrid = pa_car.

  LOOP AT gt_book INTO gw_book.
    "0) �װ��� �̸� ���
    gw_book-carrname = lv_carrname.

    "1) �⵵, �� ����
    gw_book-fyear = gw_book-fldate+0(4).
    gw_book-fmonth = gw_book-fldate+4(2).

    "2) �� �� ���� ä���
    CALL FUNCTION 'ZGET_CUSTOMER_SS36'
      EXPORTING
        i_id        = gw_book-customid
      IMPORTING
        e_name      = gw_book-name
        e_telephone = gw_book-telephone
        e_email     = gw_book-email.

    "3) class Ŭ���� �ؽ�Ʈ ó��
    CASE gw_book-class.
      WHEN 'F'.
        gw_book-classt = TEXT-fir.
      WHEN 'Y'.
        gw_book-classt = TEXT-eco.
      WHEN 'C'.
        gw_book-classt = TEXT-bus.
    ENDCASE.

    MODIFY gt_book FROM gw_book. "���ͳ� ���̺� �ݿ�

  ENDLOOP.

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
