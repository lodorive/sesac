*&---------------------------------------------------------------------*
*& Report ZCUSTDETAIL_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCUSTDETAIL_STR_SS36.

* �Է� : �� ���̵�
* ��� : �ش� ���� �� ����
* - ID, NAME, TELE, EMAIL, LANG, LANGText

* �Է� ȭ�� ����
PARAMETERS pa_id TYPE SCUSTOM-ID.

* �Լ��� ���� ���� �Լ�
DATA gs_customer TYPE ZCUSTDETAIL_SS36.

* �Լ� ȣ��
CALL FUNCTION 'ZGET_CUSTOMER_SS36_2'
  EXPORTING
    i_id             = pa_id
 IMPORTING
   E_CUSTOMER       = gs_customer
 EXCEPTIONS
   INVALID_ID       = 1
   OTHERS           = 2
          .
 CASE sy-subrc.
   WHEN 0.
     WRITE:/ gs_customer-id.
     WRITE:/ gs_customer-name.
     WRITE:/ gs_customer-email.
     WRITE:/ gs_customer-langu.
     WRITE:/ gs_customer-langut.
   WHEN 1.
     WRITE:/ 'Please, check customer id!'.
   WHEN OTHERS.
     WRITE:/ 'Unkown Error!'.
 ENDCASE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
