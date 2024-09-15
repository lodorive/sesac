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
* AGE 나이가 된 것을 축하해
* HEL 안녕!


*Selection texts
*----------------------------------------------------------
* PA_AGE         나이
* PA_NAME         이름

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
