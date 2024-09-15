*&---------------------------------------------------------------------*
*& Report ZBC100_S36_CALC_HOLS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC100_S36_CALC_HOLS.

PARAMETERS: pa_name TYPE string, " ����� �̸�
            pa_total TYPE i, " �ϳ� �� �ް� �ϼ�
            pa_used TYPE i, " ����� �ް� �ϼ�
            pa_roll TYPE i. " �̿��� �ް� �ϼ�

* ���� ���� �ް� �ϼ� ���
DATA gv_remaining TYPE i.

BREAK-POINT. " ����� ��� �� �ϳ�

gv_remaining = pa_total - pa_used. " �� �ް� �ϼ� - ����� �ް� �ϼ�

WRITE: gv_remaining, 'vacation days remaining for'(REM), pa_name.

* ���� �ް� �ϼ� ���
DATA gv_next_year TYPE i.
gv_next_year = pa_total * pa_roll. " �� �ް� �ϼ� + �̿� �ް� �ϼ�

NEW-LINE.

WRITE: gv_next_year, 'days vacation will be available next year'(NXT).

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
