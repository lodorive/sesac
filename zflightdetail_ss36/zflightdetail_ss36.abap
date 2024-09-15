*&---------------------------------------------------------------------*
*& Report ZFLIGHTDETAIL_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zflightdetail_ss36.

* �Է� : �װ��� �ڵ�, �װ���
* ��� : ��� ����, ��� ����, ���� ����, ���� ����
*      + ������ or ������ ����
* �������� ��� : International, �������� ��� : Domestic ����
* ���� : �Է��� �װ��� �������� �ʴ� ��� INVALID_FLIGHT �߻�

PARAMETERS: p_code TYPE spfli-carrid, "�װ��� �ڵ�
            p_num  TYPE spfli-connid. "�װ���

* �Լ��� ���� ���� �Լ�
DATA: gs_spfli TYPE spfli,
      gv_data  TYPE text.

CALL FUNCTION 'ZGET_CONNECT_SS36'
  EXPORTING
    i_carrid       = p_code
    i_connid       = p_num
  IMPORTING
    e_spfli        = gs_spfli "spfli ������
    e_flighttype   = gv_data "������ or ������
  EXCEPTIONS
    invalid_flight = 1
    OTHERS         = 2.

IF gv_data = '������'. "gv_data�� �������̶��
  gv_data = 'Domestic'. "Domestic ���
ELSE. "�ƴ϶��
  gv_data = 'International'. "International ���
ENDIF.

CASE sy-subrc.
  WHEN 0.
    WRITE:/ 'From County:', gs_spfli-countryfr,
            'From City:', gs_spfli-cityfrom,
            'To County:', gs_spfli-countryto,
            'To City:', gs_spfli-cityto,
            '���� or ����:', gv_data.

  WHEN 1.
    WRITE:/ 'error'.
  WHEN OTHERS.
ENDCASE.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
