*&---------------------------------------------------------------------*
*& Report ZCUSTDETAIL_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCUSTDETAIL_SS36.

* �Է� : �� ���̵�
* ��� : �ش� ���� �� ����
* - ID, NAME, TELE, EMAIL, LANG, LANGText

* �Է� ȭ�� ����
PARAMETERS p_id TYPE SCUSTOM-ID.

* �Լ��� ���� ���� �Լ�
DATA: gv_langt TYPE T002T-SPTXT,
      gs_customer TYPE SCUSTOM.

* �Լ� ȣ��
CALL FUNCTION 'ZGET_CUSTOMER_SS36_2'
  EXPORTING
    i_id             = p_id
 IMPORTING
   E_LANGUT         = gv_langt
   E_CUSTOMER       = gs_customer
 EXCEPTIONS
   INVALID_ID       = 1
   OTHERS           = 2
          .
 CASE sy-subrc.
   WHEN 0.
     WRITE:/ gs_customer-id,
             gs_customer-name,
             gs_customer-email,
             gs_customer-langu,
             gv_langt.
   WHEN 1.
     WRITE:/ 'Please, check customer id!'.
   WHEN OTHERS.
     WRITE:/ 'Unkown Error!'.
 ENDCASE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
