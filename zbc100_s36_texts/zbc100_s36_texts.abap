*&---------------------------------------------------------------------*
*& Report ZBC100_S36_SELSCREEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC100_S36_TEXTS.

PARAMETERS pa_name TYPE string.
PARAMETERS pa_age TYPE i.

WRITE: 'Hello'(HEL), pa_name.

NEW-LINE.

WRITE: 'Congratulations on reaching the age of'(age), pa_age, '!'.

*Text elements
*----------------------------------------------------------
* AGE ���̰� �� ���� ������
* HEL �ȳ�!


*Selection texts
*----------------------------------------------------------
* PA_AGE         ����
* PA_NAME         �̸�

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
