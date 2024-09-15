*&---------------------------------------------------------------------*
*& Report ZBC100_S36_LOOP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC100_S36_LOOP.

PARAMETERS: pa_name TYPE string, " �̸�
            pa_start TYPE i, " ��ü �ް� �ϼ�(1�� ����)
            pa_years TYPE i. " �ټ� �Ⱓ(�ִ� 5��)

DATA: gv_new_tot TYPE i.

gv_new_tot = pa_start.

DO pa_years TIMES. " �ټ� �Ⱓ��ŭ ������ ������

  gv_new_tot = gv_new_tot + sy-index.

  if sy-index = 5. " index�� 5�� �Ǹ� ������ ����������
    EXIT.
  ENDIF.

ENDDO.

WRITE:
'Total vacation allowance on joining the company is', pa_start,
'days for', pa_name,
'vacation allowance in', pa_years,
'will be', gv_new_tot.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
