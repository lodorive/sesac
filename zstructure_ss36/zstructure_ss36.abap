*&---------------------------------------------------------------------*
*& Report ZSTRUCTURE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zstructure_ss36.

* �ش� �Լ��� �����ϴ� ���� ��� ���� �� �� �ִ�
* Local Structure Type�� ����(�̸� : TS_RESULT)
* �Լ� : ZGET_CARRIER_SS00
* ���� Ÿ���� �̿��Ͽ� Structure ������ �Լ� ȣ���� ���� ���� �Ҵ�
* ��� ���� ȭ�鿡 ���

PARAMETERS p_carrid TYPE s_carr_id. "�װ��� �ڵ带 �Է� ����

TYPES: BEGIN OF ts_result, "Local Structure Type ����

         carrid   TYPE s_carr_id,
         carrname TYPE s_carrname,
         currcode TYPE s_currcode,
         url      TYPE s_carrurl,
         ltext    TYPE ltext,

       END OF ts_result.

DATA gs_carr TYPE ts_result. "���� ���� ����

* �Լ��� ȣ���Ͽ� ���� �Ҵ�
CALL FUNCTION 'ZGET_CARRIER_SS00'
  EXPORTING
    i_carrid   = p_carrid
  IMPORTING
    e_carrid   = gs_carr-carrid
    e_carrname = gs_carr-carrname
    e_currcode = gs_carr-currcode
    e_url      = gs_carr-url
    e_ltext    = gs_carr-ltext
  EXCEPTIONS
    not_found  = 1
    OTHERS     = 2.

* ��� �� ȭ�鿡 ���
WRITE:/'carrid : ', gs_carr-carrid.
WRITE:/'carrname : ', gs_carr-carrname.
WRITE:/'currcode : ', gs_carr-currcode.
WRITE:/'url : ', gs_carr-url+0(32).
WRITE:/'langu : ', gs_carr-ltext.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
