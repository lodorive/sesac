FUNCTION ZGET_BOOKLIST_SS36.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_CARRID) TYPE  SBOOK-CARRID
*"     REFERENCE(I_CONNID) TYPE  SBOOK-CONNID
*"     REFERENCE(I_FLDATE) TYPE  ZRFLDATE_SS36
*"  EXPORTING
*"     REFERENCE(E_BOOKLIST) TYPE  ZBOOKLIST_SS36T
*"----------------------------------------------------------------------

  " 4) ������ ���
  " �Է� ���� �װ��� �ڵ�, �װ���, ���� ���� �������� ���� ���� ��ȸ
  SELECT carrid fldate customid class
     FROM sbook
     INTO CORRESPONDING FIELDS OF TABLE e_booklist
     WHERE carrid = i_carrid
     AND connid = i_connid
     AND fldate IN i_fldate[]
     AND cancelled <> 'X'.

   "�װ��� �̸� ����ϱ�
  "(������ carrid('aa')�� ���� �����͸� ������ ������ �̸��� �� ���� ��ȸ�ص� ��)
  DATA lv_carrname TYPE scarr-carrname.
  SELECT SINGLE carrname
    FROM scarr
    INTO lv_carrname
    WHERE carrid = i_carrid.

  DATA gw_book LIKE LINE OF e_booklist.
  LOOP AT e_booklist INTO gw_book.
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

    MODIFY e_booklist FROM gw_book. "���ͳ� ���̺� �ݿ�

  ENDLOOP.


ENDFUNCTION.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
