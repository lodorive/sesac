*&---------------------------------------------------------------------*
*& Report ZNESTED_STRUCTURE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZNESTED_STRUCTURE_SS36.

*DATA gs_student TYPE Zstudent_SS36_2. "Nested
*
** 1/홍길동/24/99.00/한국/서울/금천구 독산동
*gs_student-stdid = 1.
*gs_student-stdname = '홍길동'.
*gs_student-stdage = 24.
*gs_student-stdscore = '99.00'.
*
*gs_student-address-country = '한국'.
*gs_student-address-city = '서울'.
*gs_student-address-street = '금천구 독산동'.


DATA gs_student TYPE Zstudent_SS36_3. "Include

* 1/홍길동/24/99.00/한국/서울/금천구 독산동
gs_student-stdid = 1.
gs_student-stdname = '홍길동'.
gs_student-stdage = 24.
gs_student-stdscore = '99.00'.

gs_student-country = '한국'.
gs_student-city = '서울'.
gs_student-street = '금천구 독산동'.

WRITE:/ gs_student-stdid,
        gs_student-stdname,
        gs_student-stdage,
        gs_student-stdscore,
        gs_student-country,
        gs_student-city,
        gs_student-street.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
