*&---------------------------------------------------------------------*
*& Report ZDATA_ELEMENT_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDATA_ELEMENT_SS36.
* 항공사 코드를 입력 받고자 한다
PARAMETERS pa_car TYPE S_CARR_ID.

* 화면에서 학번과 이름을 입력 받고자 한다
PARAMETERS: pa_id TYPE ZSTDID_SS36,
            pa_name TYPE ZSTDNAME_SS36.

WRITE:/ 'Student ID:', pa_id.
WRITE:/ 'Student Name:', pa_name.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
