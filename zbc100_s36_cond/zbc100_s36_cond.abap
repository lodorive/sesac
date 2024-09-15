*&---------------------------------------------------------------------*
*& Report ZBC100_S36_CALC_HOLS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC100_S36_COND.

PARAMETERS: pa_name TYPE string, " ����� �̸�
            pa_total TYPE i, " �ϳ� �� �ް� �ϼ�
            pa_used TYPE i, " ����� �ް� �ϼ�
            pa_roll TYPE i. " �̿��� �ް� �ϼ�

DATA: gv_first_name TYPE string," ���� �̸��� ���� ���� ����
      gv_last_name TYPE string.

SPLIT pa_name AT space " space�� �������� ���� �̸��� ������ ������ ��ƶ�
      INTO gv_first_name
      gv_last_name.

* ���� ���� �ް� �ϼ� ���
DATA gv_remaining TYPE i.

*BREAK-POINT. " ����� ��� �� �ϳ�

gv_remaining = pa_total - pa_used. " �� �ް� �ϼ� - ����� �ް� �ϼ�

WRITE: icon_flight AS ICON, " ������ �߰�
gv_remaining COLOR COL_POSITIVE, " ���� �߰�
'vacation days remaining for'(REM), gv_first_name. " first name ���


IF pa_roll => gv_remaining. " �̿��� �ް� �ϼ��� ���� ���� �ް� �ϼ����� ũ�ų� ���ٸ�
  WRITE 'You cannot roll over more days than you have remaining'.
ELSE. " �ƴ϶�� ���� �ް� �ϼ��� ���
  DATA gv_next_year TYPE i.
  gv_next_year = pa_total + pa_roll. " �� �ް� �ϼ� + �̿� �ް� �ϼ� = ���� �ް� �ϼ�

  NEW-LINE.

  WRITE: icon_holiday AS ICON, " ������ �߰�
  gv_next_year COLOR COL_TOTAL, " ���� �߰�
  'days vacation will be available next year'(NXT).
ENDIF.

*Text elements
*----------------------------------------------------------
* NXT �̿� �ް� �ϼ�
* REM ���� �ް� �ϼ�


*Selection texts
*----------------------------------------------------------
* PA_NAME         �̸�
* PA_ROLL         �̿��� �ް� �ϼ�
* PA_TOTAL         ��ü �ް� �ϼ�
* PA_USED         ����� �ް� �ϼ�

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
